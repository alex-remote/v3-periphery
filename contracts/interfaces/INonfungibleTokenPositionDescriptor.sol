// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;

import './INonfungiblePositionManager.sol';

/// @title 通过 URI 描述头寸 NFT 代币
interface INonfungibleTokenPositionDescriptor {
    /// @notice 为某个头寸管理器生成描述特定代币 ID 的 URI
    /// @dev 注意，此 URI 可能是直接内联 JSON 内容的 data: URI
    /// @param positionManager 要为其描述代币的头寸管理器
    /// @param tokenId 要为其生成描述的代币 ID，该 ID 可能无效
    /// @return 符合 ERC721 标准的元数据的 URI
    function tokenURI(INonfungiblePositionManager positionManager, uint256 tokenId)
        external
        view
        returns (string memory);
}
