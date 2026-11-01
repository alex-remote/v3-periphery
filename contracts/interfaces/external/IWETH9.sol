// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

/// @title WETH9 接口
interface IWETH9 is IERC20 {
    /// @notice 存入 ether 以获得包装后的 ether
    function deposit() external payable;

    /// @notice 提取包装后的 ether 以换回 ether
    function withdraw(uint256) external;
}
