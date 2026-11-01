// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;

/// @title permit 接口
/// @notice DAI/CHAI 所使用的 permit 接口
interface IERC20PermitAllowed {
    /// @notice 通过持有者的签名，授权被授权方（spender）花费一定数量的代币
    /// @dev 这是 DAI 和 CHAI 所使用的 permit 接口
    /// @param holder 代币持有者（即代币所有者）的地址
    /// @param spender 代币被授权方（spender）的地址
    /// @param nonce 持有者的 nonce，每次调用 permit 时递增
    /// @param expiry permit 失效的时间戳
    /// @param allowed 设置授权数量的布尔值，true 表示 type(uint256).max，false 表示 0
    /// @param v 必须与 `r` 和 `s` 一起构成持有者的有效 secp256k1 签名
    /// @param r 必须与 `v` 和 `s` 一起构成持有者的有效 secp256k1 签名
    /// @param s 必须与 `r` 和 `v` 一起构成持有者的有效 secp256k1 签名
    function permit(
        address holder,
        address spender,
        uint256 nonce,
        uint256 expiry,
        bool allowed,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;
}
