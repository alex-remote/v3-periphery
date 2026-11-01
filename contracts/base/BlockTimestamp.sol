// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;

/// @title 用于获取区块时间戳的函数
/// @dev 在测试中会被重写（override）的基础合约
abstract contract BlockTimestamp {
    /// @dev 仅为在测试中被重写而存在的方法
    /// @return 当前区块时间戳
    function _blockTimestamp() internal view virtual returns (uint256) {
        return block.timestamp;
    }
}
