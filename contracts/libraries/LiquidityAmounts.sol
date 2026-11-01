// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;

import '@uniswap/v3-core/contracts/libraries/FullMath.sol';
import '@uniswap/v3-core/contracts/libraries/FixedPoint96.sol';

/// @title 流动性数量相关函数
/// @notice 提供根据代币数量和价格计算流动性数量的函数
library LiquidityAmounts {
    /// @notice 将 uint256 向下转换为 uint128
    /// @param x 待向下转换的 uint258
    /// @return y 传入的值，已向下转换为 uint128
    function toUint128(uint256 x) private pure returns (uint128 y) {
        require((y = uint128(x)) == x);
    }

    /// @notice 计算给定 token0 数量和价格区间下可获得的流动性数量
    /// @dev 计算 amount0 * (sqrt(upper) * sqrt(lower)) / (sqrt(upper) - sqrt(lower))
    /// @param sqrtRatioAX96 表示第一个 tick 边界的平方根价格
    /// @param sqrtRatioBX96 表示第二个 tick 边界的平方根价格
    /// @param amount0 转入的 amount0 数量
    /// @return liquidity 返回的流动性数量
    function getLiquidityForAmount0(
        uint160 sqrtRatioAX96,
        uint160 sqrtRatioBX96,
        uint256 amount0
    ) internal pure returns (uint128 liquidity) {
        if (sqrtRatioAX96 > sqrtRatioBX96) (sqrtRatioAX96, sqrtRatioBX96) = (sqrtRatioBX96, sqrtRatioAX96);
        uint256 intermediate = FullMath.mulDiv(sqrtRatioAX96, sqrtRatioBX96, FixedPoint96.Q96);
        return toUint128(FullMath.mulDiv(amount0, intermediate, sqrtRatioBX96 - sqrtRatioAX96));
    }

    /// @notice 计算给定 token1 数量和价格区间下可获得的流动性数量
    /// @dev 计算 amount1 / (sqrt(upper) - sqrt(lower))。
    /// @param sqrtRatioAX96 表示第一个 tick 边界的平方根价格
    /// @param sqrtRatioBX96 表示第二个 tick 边界的平方根价格
    /// @param amount1 转入的 amount1 数量
    /// @return liquidity 返回的流动性数量
    function getLiquidityForAmount1(
        uint160 sqrtRatioAX96,
        uint160 sqrtRatioBX96,
        uint256 amount1
    ) internal pure returns (uint128 liquidity) {
        if (sqrtRatioAX96 > sqrtRatioBX96) (sqrtRatioAX96, sqrtRatioBX96) = (sqrtRatioBX96, sqrtRatioAX96);
        return toUint128(FullMath.mulDiv(amount1, FixedPoint96.Q96, sqrtRatioBX96 - sqrtRatioAX96));
    }

    /// @notice 根据给定的 token0 数量、token1 数量、当前
    /// 池价格以及 tick 边界处的价格，计算可获得的最大流动性数量
    /// @param sqrtRatioX96 表示当前池价格的平方根价格
    /// @param sqrtRatioAX96 表示第一个 tick 边界的平方根价格
    /// @param sqrtRatioBX96 表示第二个 tick 边界的平方根价格
    /// @param amount0 转入的 token0 数量
    /// @param amount1 转入的 token1 数量
    /// @return liquidity 可获得的最大流动性数量
    function getLiquidityForAmounts(
        uint160 sqrtRatioX96,
        uint160 sqrtRatioAX96,
        uint160 sqrtRatioBX96,
        uint256 amount0,
        uint256 amount1
    ) internal pure returns (uint128 liquidity) {
        if (sqrtRatioAX96 > sqrtRatioBX96) (sqrtRatioAX96, sqrtRatioBX96) = (sqrtRatioBX96, sqrtRatioAX96);

        if (sqrtRatioX96 <= sqrtRatioAX96) {
            liquidity = getLiquidityForAmount0(sqrtRatioAX96, sqrtRatioBX96, amount0);
        } else if (sqrtRatioX96 < sqrtRatioBX96) {
            uint128 liquidity0 = getLiquidityForAmount0(sqrtRatioX96, sqrtRatioBX96, amount0);
            uint128 liquidity1 = getLiquidityForAmount1(sqrtRatioAX96, sqrtRatioX96, amount1);

            liquidity = liquidity0 < liquidity1 ? liquidity0 : liquidity1;
        } else {
            liquidity = getLiquidityForAmount1(sqrtRatioAX96, sqrtRatioBX96, amount1);
        }
    }

    /// @notice 计算给定流动性数量和价格区间对应的 token0 数量
    /// @param sqrtRatioAX96 表示第一个 tick 边界的平方根价格
    /// @param sqrtRatioBX96 表示第二个 tick 边界的平方根价格
    /// @param liquidity 被估值的流动性
    /// @return amount0 token0 的数量
    function getAmount0ForLiquidity(
        uint160 sqrtRatioAX96,
        uint160 sqrtRatioBX96,
        uint128 liquidity
    ) internal pure returns (uint256 amount0) {
        if (sqrtRatioAX96 > sqrtRatioBX96) (sqrtRatioAX96, sqrtRatioBX96) = (sqrtRatioBX96, sqrtRatioAX96);

        return
            FullMath.mulDiv(
                uint256(liquidity) << FixedPoint96.RESOLUTION,
                sqrtRatioBX96 - sqrtRatioAX96,
                sqrtRatioBX96
            ) / sqrtRatioAX96;
    }

    /// @notice 计算给定流动性数量和价格区间对应的 token1 数量
    /// @param sqrtRatioAX96 表示第一个 tick 边界的平方根价格
    /// @param sqrtRatioBX96 表示第二个 tick 边界的平方根价格
    /// @param liquidity 被估值的流动性
    /// @return amount1 token1 的数量
    function getAmount1ForLiquidity(
        uint160 sqrtRatioAX96,
        uint160 sqrtRatioBX96,
        uint128 liquidity
    ) internal pure returns (uint256 amount1) {
        if (sqrtRatioAX96 > sqrtRatioBX96) (sqrtRatioAX96, sqrtRatioBX96) = (sqrtRatioBX96, sqrtRatioAX96);

        return FullMath.mulDiv(liquidity, sqrtRatioBX96 - sqrtRatioAX96, FixedPoint96.Q96);
    }

    /// @notice 根据给定的流动性数量、当前
    /// 池价格以及 tick 边界处的价格，计算对应的 token0 和 token1 价值
    /// @param sqrtRatioX96 表示当前池价格的平方根价格
    /// @param sqrtRatioAX96 表示第一个 tick 边界的平方根价格
    /// @param sqrtRatioBX96 表示第二个 tick 边界的平方根价格
    /// @param liquidity 被估值的流动性
    /// @return amount0 token0 的数量
    /// @return amount1 token1 的数量
    function getAmountsForLiquidity(
        uint160 sqrtRatioX96,
        uint160 sqrtRatioAX96,
        uint160 sqrtRatioBX96,
        uint128 liquidity
    ) internal pure returns (uint256 amount0, uint256 amount1) {
        if (sqrtRatioAX96 > sqrtRatioBX96) (sqrtRatioAX96, sqrtRatioBX96) = (sqrtRatioBX96, sqrtRatioAX96);

        if (sqrtRatioX96 <= sqrtRatioAX96) {
            amount0 = getAmount0ForLiquidity(sqrtRatioAX96, sqrtRatioBX96, liquidity);
        } else if (sqrtRatioX96 < sqrtRatioBX96) {
            amount0 = getAmount0ForLiquidity(sqrtRatioX96, sqrtRatioBX96, liquidity);
            amount1 = getAmount1ForLiquidity(sqrtRatioAX96, sqrtRatioX96, liquidity);
        } else {
            amount1 = getAmount1ForLiquidity(sqrtRatioAX96, sqrtRatioBX96, liquidity);
        }
    }
}
