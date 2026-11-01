// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;

import '@uniswap/v3-core/contracts/libraries/FullMath.sol';
import '@uniswap/v3-core/contracts/libraries/UnsafeMath.sol';
import '@uniswap/v3-core/contracts/libraries/FixedPoint96.sol';

/// @title 基于 Q64.96 平方根价格和流动性的函数
/// @notice 暴露 @uniswap/v3-core SqrtPriceMath 中的两个函数，
/// 它们使用 Q64.96 格式的价格平方根和流动性来计算变化量（delta）
library SqrtPriceMathPartial {
    /// @notice 获取两个价格之间的 amount0 变化量
    /// @dev 计算 liquidity / sqrt(lower) - liquidity / sqrt(upper)，
    /// 即 liquidity * (sqrt(upper) - sqrt(lower)) / (sqrt(upper) * sqrt(lower))
    /// @param sqrtRatioAX96 一个平方根价格
    /// @param sqrtRatioBX96 另一个平方根价格
    /// @param liquidity 可用流动性的数量
    /// @param roundUp 数量是向上取整还是向下取整
    /// @return amount0 在传入的两个价格之间覆盖规模为 liquidity 的头寸所需的 token0 数量
    function getAmount0Delta(
        uint160 sqrtRatioAX96,
        uint160 sqrtRatioBX96,
        uint128 liquidity,
        bool roundUp
    ) internal pure returns (uint256 amount0) {
        if (sqrtRatioAX96 > sqrtRatioBX96) (sqrtRatioAX96, sqrtRatioBX96) = (sqrtRatioBX96, sqrtRatioAX96);

        uint256 numerator1 = uint256(liquidity) << FixedPoint96.RESOLUTION;
        uint256 numerator2 = sqrtRatioBX96 - sqrtRatioAX96;

        require(sqrtRatioAX96 > 0);

        return
            roundUp
                ? UnsafeMath.divRoundingUp(
                    FullMath.mulDivRoundingUp(numerator1, numerator2, sqrtRatioBX96),
                    sqrtRatioAX96
                )
                : FullMath.mulDiv(numerator1, numerator2, sqrtRatioBX96) / sqrtRatioAX96;
    }

    /// @notice 获取两个价格之间的 amount1 变化量
    /// @dev 计算 liquidity * (sqrt(upper) - sqrt(lower))
    /// @param sqrtRatioAX96 一个平方根价格
    /// @param sqrtRatioBX96 另一个平方根价格
    /// @param liquidity 可用流动性的数量
    /// @param roundUp 数量是向上取整还是向下取整
    /// @return amount1 在传入的两个价格之间覆盖规模为 liquidity 的头寸所需的 token1 数量
    function getAmount1Delta(
        uint160 sqrtRatioAX96,
        uint160 sqrtRatioBX96,
        uint128 liquidity,
        bool roundUp
    ) internal pure returns (uint256 amount1) {
        if (sqrtRatioAX96 > sqrtRatioBX96) (sqrtRatioAX96, sqrtRatioBX96) = (sqrtRatioBX96, sqrtRatioAX96);

        return
            roundUp
                ? FullMath.mulDivRoundingUp(liquidity, sqrtRatioBX96 - sqrtRatioAX96, FixedPoint96.Q96)
                : FullMath.mulDiv(liquidity, sqrtRatioBX96 - sqrtRatioAX96, FixedPoint96.Q96);
    }
}
