// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0 <0.8.0;

import '@uniswap/v3-core/contracts/libraries/FullMath.sol';
import '@uniswap/v3-core/contracts/libraries/TickMath.sol';
import '@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol';

/// @title 预言机库
/// @notice 提供与 V3 池预言机集成的函数
library OracleLibrary {
    /// @notice 计算给定 Uniswap V3 池的 tick 与流动性的时间加权平均值
    /// @param pool 要观测的池的地址
    /// @param secondsAgo 计算时间加权平均值的起点距今的秒数
    /// @return arithmeticMeanTick 从 (block.timestamp - secondsAgo) 到 block.timestamp 的算术平均 tick
    /// @return harmonicMeanLiquidity 从 (block.timestamp - secondsAgo) 到 block.timestamp 的调和平均流动性
    function consult(address pool, uint32 secondsAgo)
        internal
        view
        returns (int24 arithmeticMeanTick, uint128 harmonicMeanLiquidity)
    {
        require(secondsAgo != 0, 'BP');

        uint32[] memory secondsAgos = new uint32[](2);
        secondsAgos[0] = secondsAgo;
        secondsAgos[1] = 0;

        (int56[] memory tickCumulatives, uint160[] memory secondsPerLiquidityCumulativeX128s) =
            IUniswapV3Pool(pool).observe(secondsAgos);

        int56 tickCumulativesDelta = tickCumulatives[1] - tickCumulatives[0];
        uint160 secondsPerLiquidityCumulativesDelta =
            secondsPerLiquidityCumulativeX128s[1] - secondsPerLiquidityCumulativeX128s[0];

        arithmeticMeanTick = int24(tickCumulativesDelta / secondsAgo);
        // 始终向负无穷取整
        if (tickCumulativesDelta < 0 && (tickCumulativesDelta % secondsAgo != 0)) arithmeticMeanTick--;

        // 这里使用乘法而非移位，以确保 harmonicMeanLiquidity 不会溢出 uint128
        uint192 secondsAgoX160 = uint192(secondsAgo) * type(uint160).max;
        harmonicMeanLiquidity = uint128(secondsAgoX160 / (uint192(secondsPerLiquidityCumulativesDelta) << 32));
    }

    /// @notice 给定一个 tick 和一定数量的代币，计算兑换可得的代币数量
    /// @param tick 用于计算报价的 tick 值
    /// @param baseAmount 待换算的代币数量
    /// @param baseToken 作为 baseAmount 计价单位的 ERC20 代币合约地址
    /// @param quoteToken 作为 quoteAmount 计价单位的 ERC20 代币合约地址
    /// @return quoteAmount 以 baseAmount 数量的 baseToken 可换得的 quoteToken 数量
    function getQuoteAtTick(
        int24 tick,
        uint128 baseAmount,
        address baseToken,
        address quoteToken
    ) internal pure returns (uint256 quoteAmount) {
        uint160 sqrtRatioX96 = TickMath.getSqrtRatioAtTick(tick);

        // 若其自乘不会溢出，则以更高的精度计算 quoteAmount
        if (sqrtRatioX96 <= type(uint128).max) {
            uint256 ratioX192 = uint256(sqrtRatioX96) * sqrtRatioX96;
            quoteAmount = baseToken < quoteToken
                ? FullMath.mulDiv(ratioX192, baseAmount, 1 << 192)
                : FullMath.mulDiv(1 << 192, baseAmount, ratioX192);
        } else {
            uint256 ratioX128 = FullMath.mulDiv(sqrtRatioX96, sqrtRatioX96, 1 << 64);
            quoteAmount = baseToken < quoteToken
                ? FullMath.mulDiv(ratioX128, baseAmount, 1 << 128)
                : FullMath.mulDiv(1 << 128, baseAmount, ratioX128);
        }
    }

    /// @notice 给定一个池，返回其最早存储的观测值距今的秒数
    /// @param pool 要观测的 Uniswap V3 池的地址
    /// @return secondsAgo 该池最早存储的观测值距今的秒数
    function getOldestObservationSecondsAgo(address pool) internal view returns (uint32 secondsAgo) {
        (, , uint16 observationIndex, uint16 observationCardinality, , , ) = IUniswapV3Pool(pool).slot0();
        require(observationCardinality > 0, 'NI');

        (uint32 observationTimestamp, , , bool initialized) =
            IUniswapV3Pool(pool).observations((observationIndex + 1) % observationCardinality);

        // 如果 cardinality 正处于增长过程中，下一个索引可能尚未初始化
        // 这种情况下，最早的观测值总是位于索引 0
        if (!initialized) {
            (observationTimestamp, , , ) = IUniswapV3Pool(pool).observations(0);
        }

        secondsAgo = uint32(block.timestamp) - observationTimestamp;
    }

    /// @notice 给定一个池，返回当前区块开始时的 tick 值
    /// @param pool Uniswap V3 池的地址
    /// @return 当前区块开始时池所处的 tick
    function getBlockStartingTickAndLiquidity(address pool) internal view returns (int24, uint128) {
        (, int24 tick, uint16 observationIndex, uint16 observationCardinality, , , ) = IUniswapV3Pool(pool).slot0();

        // 需要 2 个观测值才能可靠地计算区块起始 tick
        require(observationCardinality > 1, 'NEO');

        // 如果最新的观测值发生在过去，则本区块内没有发生过改变 tick 的交易，
        // 因此 `slot0` 中的 tick 与当前区块开始时的 tick 相同。
        // 我们无需检查该观测值是否已初始化——它必定已初始化。
        (uint32 observationTimestamp, int56 tickCumulative, uint160 secondsPerLiquidityCumulativeX128, ) =
            IUniswapV3Pool(pool).observations(observationIndex);
        if (observationTimestamp != uint32(block.timestamp)) {
            return (tick, IUniswapV3Pool(pool).liquidity());
        }

        uint256 prevIndex = (uint256(observationIndex) + observationCardinality - 1) % observationCardinality;
        (
            uint32 prevObservationTimestamp,
            int56 prevTickCumulative,
            uint160 prevSecondsPerLiquidityCumulativeX128,
            bool prevInitialized
        ) = IUniswapV3Pool(pool).observations(prevIndex);

        require(prevInitialized, 'ONI');

        uint32 delta = observationTimestamp - prevObservationTimestamp;
        tick = int24((tickCumulative - prevTickCumulative) / delta);
        uint128 liquidity =
            uint128(
                (uint192(delta) * type(uint160).max) /
                    (uint192(secondsPerLiquidityCumulativeX128 - prevSecondsPerLiquidityCumulativeX128) << 32)
            );
        return (tick, liquidity);
    }

    /// @notice 用于计算加权算术平均 tick 的信息
    struct WeightedTickData {
        int24 tick;
        uint128 weight;
    }

    /// @notice 给定由 tick 和权重组成的数组，计算加权算术平均 tick
    /// @param weightedTickData 由 tick 和权重组成的数组
    /// @return weightedArithmeticMeanTick 加权算术平均 tick
    /// @dev `weightedTickData` 中的每个条目所表示的 tick 应来自底层代币相同的池。如果不是，
    /// 则必须格外小心，确保这些 tick 具有可比性（包括小数位数的差异）。
    /// @dev 注意，加权算术平均 tick 对应于加权几何平均价格。
    function getWeightedArithmeticMeanTick(WeightedTickData[] memory weightedTickData)
        internal
        pure
        returns (int24 weightedArithmeticMeanTick)
    {
        // 累加每个 tick 与其权重的乘积之和
        int256 numerator;

        // 累加权重之和
        uint256 denominator;

        // 乘积可容纳在 152 位内，因此需要长度约为 2**104 的数组才会使该逻辑溢出
        for (uint256 i; i < weightedTickData.length; i++) {
            numerator += weightedTickData[i].tick * int256(weightedTickData[i].weight);
            denominator += weightedTickData[i].weight;
        }

        weightedArithmeticMeanTick = int24(numerator / int256(denominator));
        // 始终向负无穷取整
        if (numerator < 0 && (numerator % int256(denominator) != 0)) weightedArithmeticMeanTick--;
    }

    /// @notice 返回“合成”tick，它表示 `tokens` 中第一个代币以最后一个代币计价的价格
    /// @dev 可用于计算沿路由的相对价格。
    /// @dev 每一对相邻代币都必须对应一个 tick。
    /// @param tokens 代币合约地址
    /// @param ticks tick 数组，表示 `tokens` 中每个代币对的价格
    /// @return syntheticTick 合成 tick，表示 `tokens` 中最外侧两个代币之间的相对价格
    function getChainedPrice(address[] memory tokens, int24[] memory ticks)
        internal
        pure
        returns (int256 syntheticTick)
    {
        require(tokens.length - 1 == ticks.length, 'DL');
        for (uint256 i = 1; i <= ticks.length; i++) {
            // 检查代币的地址排序顺序，然后将
            // tick 累加到当前的合成 tick 中，确保中间代币“相互抵消”
            tokens[i - 1] < tokens[i] ? syntheticTick += ticks[i - 1] : syntheticTick -= ticks[i - 1];
        }
    }
}
