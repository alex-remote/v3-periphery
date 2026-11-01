// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.5;
pragma abicoder v2;

/// @title 创建并初始化 V3 池
/// @notice 提供一个在必要时创建并初始化池的方法，以便与其他
/// 要求池已存在的方法打包调用。
interface IPoolInitializer {
    /// @notice 若池不存在则创建新池，若池未初始化则进行初始化
    /// @dev 对池执行首个操作（例如 mint）时，可通过 IMulticall 将此方法与其他方法打包调用
    /// @param token0 池中 token0 的合约地址
    /// @param token1 池中 token1 的合约地址
    /// @param fee 指定代币对所对应的 v3 池的手续费数额
    /// @param sqrtPriceX96 池的初始平方根价格，以 Q64.96 值表示
    /// @return pool 返回根据代币对和手续费确定的池地址，必要时返回新创建的池地址
    function createAndInitializePoolIfNecessary(
        address token0,
        address token1,
        uint24 fee,
        uint160 sqrtPriceX96
    ) external payable returns (address pool);
}
