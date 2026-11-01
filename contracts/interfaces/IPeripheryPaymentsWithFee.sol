// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.5;

import './IPeripheryPayments.sol';

/// @title 外围支付
/// @notice 简化 ETH 存入与提取的函数
interface IPeripheryPaymentsWithFee is IPeripheryPayments {
    /// @notice 将本合约持有的 WETH9 余额解包，并以 ETH 形式发送给 recipient，其中比例介于
    /// 0（不含）与 1（含）之间的一部分转给 feeRecipient
    /// @dev amountMinimum 参数用于防止恶意合约窃取用户的 WETH9。
    function unwrapWETH9WithFee(
        uint256 amountMinimum,
        address recipient,
        uint256 feeBips,
        address feeRecipient
    ) external payable;

    /// @notice 将本合约持有的某种代币的全部数量转给 recipient，其中比例介于
    /// 0（不含）与 1（含）之间的一部分转给 feeRecipient
    /// @dev amountMinimum 参数用于防止恶意合约窃取用户的代币
    function sweepTokenWithFee(
        address token,
        uint256 amountMinimum,
        address recipient,
        uint256 feeBips,
        address feeRecipient
    ) external payable;
}
