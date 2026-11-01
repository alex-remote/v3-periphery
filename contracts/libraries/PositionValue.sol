// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.6.8 <0.8.0;

import '@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol';
import '@uniswap/v3-core/contracts/libraries/FixedPoint128.sol';
import '@uniswap/v3-core/contracts/libraries/TickMath.sol';
import '@uniswap/v3-core/contracts/libraries/Tick.sol';
import '../interfaces/INonfungiblePositionManager.sol';
import './LiquidityAmounts.sol';
import './PoolAddress.sol';
import './PositionKey.sol';

/// @title 返回 Uniswap V3 NFT 中所持代币价值的相关信息
library PositionValue {
    /// @notice 返回 token0 和 token1 的总数量，即给定的非同质化头寸管理器代币
    /// 所值的手续费与本金之和
    /// @param positionManager Uniswap V3 的 NonfungiblePositionManager
    /// @param tokenId 要获取其总价值的代币的 tokenId
    /// @param sqrtRatioX96 用于计算本金数量的平方根价格 X96
    /// @return amount0 包含本金和手续费在内的 token0 总数量
    /// @return amount1 包含本金和手续费在内的 token1 总数量
    function total(
        INonfungiblePositionManager positionManager,
        uint256 tokenId,
        uint160 sqrtRatioX96
    ) internal view returns (uint256 amount0, uint256 amount1) {
        (uint256 amount0Principal, uint256 amount1Principal) = principal(positionManager, tokenId, sqrtRatioX96);
        (uint256 amount0Fee, uint256 amount1Fee) = fees(positionManager, tokenId);
        return (amount0Principal + amount0Fee, amount1Principal + amount1Fee);
    }

    /// @notice 计算若头寸被销毁，应付给代币所有者的
    /// 本金（当前以流动性形式存在）
    /// @param positionManager Uniswap V3 的 NonfungiblePositionManager
    /// @param tokenId 要获取其应得本金总额的代币的 tokenId
    /// @param sqrtRatioX96 用于计算本金数量的平方根价格 X96
    /// @return amount0 token0 的本金数量
    /// @return amount1 token1 的本金数量
    function principal(
        INonfungiblePositionManager positionManager,
        uint256 tokenId,
        uint160 sqrtRatioX96
    ) internal view returns (uint256 amount0, uint256 amount1) {
        (, , , , , int24 tickLower, int24 tickUpper, uint128 liquidity, , , , ) = positionManager.positions(tokenId);

        return
            LiquidityAmounts.getAmountsForLiquidity(
                sqrtRatioX96,
                TickMath.getSqrtRatioAtTick(tickLower),
                TickMath.getSqrtRatioAtTick(tickUpper),
                liquidity
            );
    }

    struct FeeParams {
        address token0;
        address token1;
        uint24 fee;
        int24 tickLower;
        int24 tickUpper;
        uint128 liquidity;
        uint256 positionFeeGrowthInside0LastX128;
        uint256 positionFeeGrowthInside1LastX128;
        uint256 tokensOwed0;
        uint256 tokensOwed1;
    }

    /// @notice 计算应付给代币所有者的手续费总额
    /// @param positionManager Uniswap V3 的 NonfungiblePositionManager
    /// @param tokenId 要获取其应得手续费总额的代币的 tokenId
    /// @return amount0 以 token0 计的应得手续费数量
    /// @return amount1 以 token1 计的应得手续费数量
    function fees(INonfungiblePositionManager positionManager, uint256 tokenId)
        internal
        view
        returns (uint256 amount0, uint256 amount1)
    {
        (
            ,
            ,
            address token0,
            address token1,
            uint24 fee,
            int24 tickLower,
            int24 tickUpper,
            uint128 liquidity,
            uint256 positionFeeGrowthInside0LastX128,
            uint256 positionFeeGrowthInside1LastX128,
            uint256 tokensOwed0,
            uint256 tokensOwed1
        ) = positionManager.positions(tokenId);

        return
            _fees(
                positionManager,
                FeeParams({
                    token0: token0,
                    token1: token1,
                    fee: fee,
                    tickLower: tickLower,
                    tickUpper: tickUpper,
                    liquidity: liquidity,
                    positionFeeGrowthInside0LastX128: positionFeeGrowthInside0LastX128,
                    positionFeeGrowthInside1LastX128: positionFeeGrowthInside1LastX128,
                    tokensOwed0: tokensOwed0,
                    tokensOwed1: tokensOwed1
                })
            );
    }

    function _fees(INonfungiblePositionManager positionManager, FeeParams memory feeParams)
        private
        view
        returns (uint256 amount0, uint256 amount1)
    {
        (uint256 poolFeeGrowthInside0LastX128, uint256 poolFeeGrowthInside1LastX128) =
            _getFeeGrowthInside(
                IUniswapV3Pool(
                    PoolAddress.computeAddress(
                        positionManager.factory(),
                        PoolAddress.PoolKey({token0: feeParams.token0, token1: feeParams.token1, fee: feeParams.fee})
                    )
                ),
                feeParams.tickLower,
                feeParams.tickUpper
            );

        amount0 =
            FullMath.mulDiv(
                poolFeeGrowthInside0LastX128 - feeParams.positionFeeGrowthInside0LastX128,
                feeParams.liquidity,
                FixedPoint128.Q128
            ) +
            feeParams.tokensOwed0;

        amount1 =
            FullMath.mulDiv(
                poolFeeGrowthInside1LastX128 - feeParams.positionFeeGrowthInside1LastX128,
                feeParams.liquidity,
                FixedPoint128.Q128
            ) +
            feeParams.tokensOwed1;
    }

    function _getFeeGrowthInside(
        IUniswapV3Pool pool,
        int24 tickLower,
        int24 tickUpper
    ) private view returns (uint256 feeGrowthInside0X128, uint256 feeGrowthInside1X128) {
        (, int24 tickCurrent, , , , , ) = pool.slot0();
        (, , uint256 lowerFeeGrowthOutside0X128, uint256 lowerFeeGrowthOutside1X128, , , , ) = pool.ticks(tickLower);
        (, , uint256 upperFeeGrowthOutside0X128, uint256 upperFeeGrowthOutside1X128, , , , ) = pool.ticks(tickUpper);

        if (tickCurrent < tickLower) {
            feeGrowthInside0X128 = lowerFeeGrowthOutside0X128 - upperFeeGrowthOutside0X128;
            feeGrowthInside1X128 = lowerFeeGrowthOutside1X128 - upperFeeGrowthOutside1X128;
        } else if (tickCurrent < tickUpper) {
            uint256 feeGrowthGlobal0X128 = pool.feeGrowthGlobal0X128();
            uint256 feeGrowthGlobal1X128 = pool.feeGrowthGlobal1X128();
            feeGrowthInside0X128 = feeGrowthGlobal0X128 - lowerFeeGrowthOutside0X128 - upperFeeGrowthOutside0X128;
            feeGrowthInside1X128 = feeGrowthGlobal1X128 - lowerFeeGrowthOutside1X128 - upperFeeGrowthOutside1X128;
        } else {
            feeGrowthInside0X128 = upperFeeGrowthOutside0X128 - lowerFeeGrowthOutside0X128;
            feeGrowthInside1X128 = upperFeeGrowthOutside1X128 - lowerFeeGrowthOutside1X128;
        }
    }
}
