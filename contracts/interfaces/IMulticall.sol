// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.5;
pragma abicoder v2;

/// @title Multicall 接口
/// @notice 支持在对合约的单次调用中调用多个方法
interface IMulticall {
    /// @notice 调用当前合约中的多个函数，若全部成功则返回所有调用的数据
    /// @dev 对于任何可通过 multicall 调用的方法，都不应信任 `msg.value`。
    /// @param data 对本合约发起的每次调用的已编码函数数据
    /// @return results 通过 data 传入的每次调用的结果
    function multicall(bytes[] calldata data) external payable returns (bytes[] memory results);
}
