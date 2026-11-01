// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;

/// @title 用于验证基于合约的账户签名的接口
/// @notice 针对数据验证所提供签名的接口
/// @dev 由 EIP-1271 定义的接口
interface IERC1271 {
    /// @notice 返回所提供的签名对于所提供的数据是否有效
    /// @dev 函数验证通过时必须返回 bytes4 魔数 0x1626ba7e。
    /// 不得修改状态（solc < 0.5 时使用 STATICCALL，solc > 0.5 时使用 view 修饰符）。
    /// 必须允许外部调用。
    /// @param hash 待签名数据的哈希
    /// @param signature 与 _data 关联的签名字节数组
    /// @return magicValue bytes4 魔数 0x1626ba7e
    function isValidSignature(bytes32 hash, bytes memory signature) external view returns (bytes4 magicValue);
}
