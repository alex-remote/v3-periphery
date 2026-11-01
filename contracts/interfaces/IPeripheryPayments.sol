// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.5;

/// @title 外围支付
/// @notice 简化 ETH 存入与提取的函数
interface IPeripheryPayments {
    /// @notice 将本合约持有的 WETH9 余额解包，并以 ETH 形式发送给 recipient。
    /// @dev amountMinimum 参数用于防止恶意合约窃取用户的 WETH9。
    /// @param amountMinimum 要解包的 WETH9 的最小数量
    /// @param recipient 接收 ETH 的地址
    function unwrapWETH9(uint256 amountMinimum, address recipient) external payable;

    /// @notice 将本合约持有的全部 ETH 余额退还给 `msg.sender`
    /// @dev 适合与使用 ether 的铸造或增加流动性操作打包调用，也适合与
    /// 以 ether 作为输入数量的精确输出兑换打包调用
    function refundETH() external payable;

    /// @notice 将本合约持有的某种代币的全部数量转给 recipient
    /// @dev amountMinimum 参数用于防止恶意合约窃取用户的代币
    /// @param token 将被转给 `recipient` 的代币的合约地址
    /// @param amountMinimum 进行转账所需的代币最小数量
    /// @param recipient 代币的目标地址
    function sweepToken(
        address token,
        uint256 amountMinimum,
        address recipient
    ) external payable;
}
