// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.5;

/// @title 自签名授权（Self Permit）
/// @notice 对任何兼容 EIP-2612 的代币调用 permit 的功能，供路由中使用
interface ISelfPermit {
    /// @notice 允许本合约花费 `msg.sender` 的指定代币
    /// @dev `owner` 始终为 msg.sender，`spender` 始终为 address(this)。
    /// @param token 被花费代币的地址
    /// @param value 可花费的代币数量
    /// @param deadline 一个时间戳，当前区块时间必须小于或等于该时间戳
    /// @param v 必须与 `r` 和 `s` 一起构成持有者的有效 secp256k1 签名
    /// @param r 必须与 `v` 和 `s` 一起构成持有者的有效 secp256k1 签名
    /// @param s 必须与 `r` 和 `v` 一起构成持有者的有效 secp256k1 签名
    function selfPermit(
        address token,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external payable;

    /// @notice 允许本合约花费 `msg.sender` 的指定代币
    /// @dev `owner` 始终为 msg.sender，`spender` 始终为 address(this)。
    /// 可替代 #selfPermit 使用，以防止因对 #selfPermit 的调用被抢跑（frontrun）而导致调用失败
    /// @param token 被花费代币的地址
    /// @param value 可花费的代币数量
    /// @param deadline 一个时间戳，当前区块时间必须小于或等于该时间戳
    /// @param v 必须与 `r` 和 `s` 一起构成持有者的有效 secp256k1 签名
    /// @param r 必须与 `v` 和 `s` 一起构成持有者的有效 secp256k1 签名
    /// @param s 必须与 `r` 和 `v` 一起构成持有者的有效 secp256k1 签名
    function selfPermitIfNecessary(
        address token,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external payable;

    /// @notice 针对带有 `allowed` 参数的 permit 签名，允许本合约花费发送者的代币
    /// @dev `owner` 始终为 msg.sender，`spender` 始终为 address(this)
    /// @param token 被花费代币的地址
    /// @param nonce 所有者当前的 nonce
    /// @param expiry permit 失效的时间戳
    /// @param v 必须与 `r` 和 `s` 一起构成持有者的有效 secp256k1 签名
    /// @param r 必须与 `v` 和 `s` 一起构成持有者的有效 secp256k1 签名
    /// @param s 必须与 `r` 和 `v` 一起构成持有者的有效 secp256k1 签名
    function selfPermitAllowed(
        address token,
        uint256 nonce,
        uint256 expiry,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external payable;

    /// @notice 针对带有 `allowed` 参数的 permit 签名，允许本合约花费发送者的代币
    /// @dev `owner` 始终为 msg.sender，`spender` 始终为 address(this)
    /// 可替代 #selfPermitAllowed 使用，以防止因对 #selfPermitAllowed 的调用被抢跑（frontrun）而导致调用失败。
    /// @param token 被花费代币的地址
    /// @param nonce 所有者当前的 nonce
    /// @param expiry permit 失效的时间戳
    /// @param v 必须与 `r` 和 `s` 一起构成持有者的有效 secp256k1 签名
    /// @param r 必须与 `v` 和 `s` 一起构成持有者的有效 secp256k1 签名
    /// @param s 必须与 `r` 和 `v` 一起构成持有者的有效 secp256k1 签名
    function selfPermitAllowedIfNecessary(
        address token,
        uint256 nonce,
        uint256 expiry,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external payable;
}
