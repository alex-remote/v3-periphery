// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.5;

import '@openzeppelin/contracts/token/ERC721/IERC721.sol';

/// @title 支持 permit 的 ERC721
/// @notice ERC721 的扩展，包含一个用于基于签名进行授权的 permit 函数
interface IERC721Permit is IERC721 {
    /// @notice permit 签名中使用的 permit 类型哈希（typehash）
    /// @return permit 的类型哈希（typehash）
    function PERMIT_TYPEHASH() external pure returns (bytes32);

    /// @notice permit 签名中使用的域分隔符（domain separator）
    /// @return 编码 permit 签名时使用的域分隔符
    function DOMAIN_SEPARATOR() external view returns (bytes32);

    /// @notice 通过签名授权 spender 花费某个特定的代币 ID
    /// @param spender 被授权的账户
    /// @param tokenId 被授权花费的代币 ID
    /// @param deadline 截止时间戳，调用必须在此之前被打包上链，授权才能生效
    /// @param v 必须与 `r` 和 `s` 一起构成持有者的有效 secp256k1 签名
    /// @param r 必须与 `v` 和 `s` 一起构成持有者的有效 secp256k1 签名
    /// @param s 必须与 `r` 和 `v` 一起构成持有者的有效 secp256k1 签名
    function permit(
        address spender,
        uint256 tokenId,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external payable;
}
