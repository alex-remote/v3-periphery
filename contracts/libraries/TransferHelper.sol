// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.6.0;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

library TransferHelper {
    /// @notice 将代币从目标地址转移到指定的目的地址
    /// @notice 若转账失败，则以 'STF' 报错
    /// @param token 待转移代币的合约地址
    /// @param from 代币转出的源地址
    /// @param to 转账的目的地址
    /// @param value 要转移的数量
    function safeTransferFrom(
        address token,
        address from,
        address to,
        uint256 value
    ) internal {
        (bool success, bytes memory data) =
            token.call(abi.encodeWithSelector(IERC20.transferFrom.selector, from, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'STF');
    }

    /// @notice 将代币从 msg.sender 转移给接收者
    /// @dev 若转账失败，则以 ST 报错
    /// @param token 将被转移的代币的合约地址
    /// @param to 转账的接收者
    /// @param value 转账的数额
    function safeTransfer(
        address token,
        address to,
        uint256 value
    ) internal {
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(IERC20.transfer.selector, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'ST');
    }

    /// @notice 授权指定合约花费给定代币中给定的授权额度
    /// @dev 若转账失败，则以 'SA' 报错
    /// @param token 待授权代币的合约地址
    /// @param to 授权的对象
    /// @param value 授权对象被允许花费的给定代币数量
    function safeApprove(
        address token,
        address to,
        uint256 value
    ) internal {
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(IERC20.approve.selector, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'SA');
    }

    /// @notice 将 ETH 转给接收者地址
    /// @dev 失败时以 `STE` 报错
    /// @param to 转账的目的地址
    /// @param value 要转移的数额
    function safeTransferETH(address to, uint256 value) internal {
        (bool success, ) = to.call{value: value}(new bytes(0));
        require(success, 'STE');
    }
}
