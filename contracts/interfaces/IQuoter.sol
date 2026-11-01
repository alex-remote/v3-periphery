// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.5;
pragma abicoder v2;

/// @title Quoter 接口
/// @notice 支持对精确输入或精确输出兑换（swap）计算出的数量进行报价
/// @dev 这些函数未标记为 view，因为它们依赖于调用非 view 函数并回滚（revert）
/// 来计算结果。它们的 gas 效率也不高，不应在链上调用。
interface IQuoter {
    /// @notice 在不执行兑换的情况下，返回给定精确输入兑换所能收到的输出数量
    /// @param path 兑换的路径，即每个代币对及池手续费
    /// @param amountIn 要兑换的第一个代币的数量
    /// @return amountOut 将会收到的最后一个代币的数量
    function quoteExactInput(bytes memory path, uint256 amountIn) external returns (uint256 amountOut);

    /// @notice 返回给定精确输入在单个池兑换中所能收到的输出数量
    /// @param tokenIn 被换入的代币
    /// @param tokenOut 被换出的代币
    /// @param fee 该代币对所考虑的代币池的手续费
    /// @param amountIn 期望的输入数量
    /// @param sqrtPriceLimitX96 兑换不能超过的池价格限制
    /// @return amountOut 将会收到的 `tokenOut` 数量
    function quoteExactInputSingle(
        address tokenIn,
        address tokenOut,
        uint24 fee,
        uint256 amountIn,
        uint160 sqrtPriceLimitX96
    ) external returns (uint256 amountOut);

    /// @notice 在不执行兑换的情况下，返回给定精确输出兑换所需的输入数量
    /// @param path 兑换的路径，即每个代币对及池手续费。路径必须按逆序提供
    /// @param amountOut 要收到的最后一个代币的数量
    /// @return amountIn 需要支付的第一个代币的数量
    function quoteExactOutput(bytes memory path, uint256 amountOut) external returns (uint256 amountIn);

    /// @notice 返回在单个池兑换中收到给定精确输出数量所需的输入数量
    /// @param tokenIn 被换入的代币
    /// @param tokenOut 被换出的代币
    /// @param fee 该代币对所考虑的代币池的手续费
    /// @param amountOut 期望的输出数量
    /// @param sqrtPriceLimitX96 兑换不能超过的池价格限制
    /// @return amountIn 为收到 `amountOut` 而需要作为兑换输入的数量
    function quoteExactOutputSingle(
        address tokenIn,
        address tokenOut,
        uint24 fee,
        uint256 amountOut,
        uint160 sqrtPriceLimitX96
    ) external returns (uint256 amountIn);
}
