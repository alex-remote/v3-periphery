// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.5;
pragma abicoder v2;

import '@openzeppelin/contracts/token/ERC721/IERC721Metadata.sol';
import '@openzeppelin/contracts/token/ERC721/IERC721Enumerable.sol';

import './IPoolInitializer.sol';
import './IERC721Permit.sol';
import './IPeripheryPayments.sol';
import './IPeripheryImmutableState.sol';

/// @title 头寸的非同质化代币
/// @notice 将 Uniswap V3 头寸封装在非同质化代币接口中，使其可以被转移
/// 和授权。
interface INonfungiblePositionManager is
    IPoolInitializer,
    IPeripheryPayments,
    IPeripheryImmutableState,
    IERC721Metadata,
    IERC721Enumerable,
    IERC721Permit
{
    /// @notice 当某个头寸 NFT 的流动性增加时触发
    /// @dev 铸造代币时也会触发
    /// @param tokenId 流动性被增加的代币的 ID
    /// @param liquidity 该 NFT 头寸流动性的增加量
    /// @param amount0 为增加流动性而支付的 token0 数量
    /// @param amount1 为增加流动性而支付的 token1 数量
    event IncreaseLiquidity(uint256 indexed tokenId, uint128 liquidity, uint256 amount0, uint256 amount1);
    /// @notice 当某个头寸 NFT 的流动性减少时触发
    /// @param tokenId 流动性被减少的代币的 ID
    /// @param liquidity 该 NFT 头寸流动性的减少量
    /// @param amount0 因流动性减少而记账的 token0 数量
    /// @param amount1 因流动性减少而记账的 token1 数量
    event DecreaseLiquidity(uint256 indexed tokenId, uint128 liquidity, uint256 amount0, uint256 amount1);
    /// @notice 当为某个头寸 NFT 收取代币时触发
    /// @dev 由于取整行为，报告的数量可能与实际转账的数量不完全相等
    /// @param tokenId 底层代币被收取的代币的 ID
    /// @param recipient 接收所收取代币的账户地址
    /// @param amount0 被收取的、该头寸应得的 token0 数量
    /// @param amount1 被收取的、该头寸应得的 token1 数量
    event Collect(uint256 indexed tokenId, address recipient, uint256 amount0, uint256 amount1);

    /// @notice 返回与给定代币 ID 关联的头寸信息。
    /// @dev 若代币 ID 无效则抛出异常。
    /// @param tokenId 代表该头寸的代币的 ID
    /// @return nonce 用于 permit 的 nonce
    /// @return operator 被授权可支配（spending）的地址
    /// @return token0 特定池的 token0 地址
    /// @return token1 特定池的 token1 地址
    /// @return fee 与该池关联的手续费
    /// @return tickLower 该头寸 tick 区间的下端
    /// @return tickUpper 该头寸 tick 区间的上端
    /// @return liquidity 该头寸的流动性
    /// @return feeGrowthInside0LastX128 截至该单个头寸最近一次操作时 token0 的手续费增长
    /// @return feeGrowthInside1LastX128 截至该单个头寸最近一次操作时 token1 的手续费增长
    /// @return tokensOwed0 截至最近一次计算时，该头寸应得但尚未收取的 token0 数量
    /// @return tokensOwed1 截至最近一次计算时，该头寸应得但尚未收取的 token1 数量
    function positions(uint256 tokenId)
        external
        view
        returns (
            uint96 nonce,
            address operator,
            address token0,
            address token1,
            uint24 fee,
            int24 tickLower,
            int24 tickUpper,
            uint128 liquidity,
            uint256 feeGrowthInside0LastX128,
            uint256 feeGrowthInside1LastX128,
            uint128 tokensOwed0,
            uint128 tokensOwed1
        );

    struct MintParams {
        address token0;
        address token1;
        uint24 fee;
        int24 tickLower;
        int24 tickUpper;
        uint256 amount0Desired;
        uint256 amount1Desired;
        uint256 amount0Min;
        uint256 amount1Min;
        address recipient;
        uint256 deadline;
    }

    /// @notice 创建一个封装在 NFT 中的新头寸
    /// @dev 在池已存在且已初始化时调用。注意，如果池已创建但尚未初始化，
    /// 则不存在（对应的）方法，即假定池已被初始化。
    /// @param params 铸造头寸所需的参数，在 calldata 中编码为 `MintParams`
    /// @return tokenId 代表所铸造头寸的代币的 ID
    /// @return liquidity 该头寸的流动性数量
    /// @return amount0 token0 的数量
    /// @return amount1 token1 的数量
    function mint(MintParams calldata params)
        external
        payable
        returns (
            uint256 tokenId,
            uint128 liquidity,
            uint256 amount0,
            uint256 amount1
        );

    struct IncreaseLiquidityParams {
        uint256 tokenId;
        uint256 amount0Desired;
        uint256 amount1Desired;
        uint256 amount0Min;
        uint256 amount1Min;
        uint256 deadline;
    }

    /// @notice 增加头寸中的流动性数量，代币由 `msg.sender` 支付
    /// @param params tokenId 要增加流动性的代币的 ID，
    /// amount0Desired 期望花费的 token0 数量，
    /// amount1Desired 期望花费的 token1 数量，
    /// amount0Min 最少花费的 token0 数量，用作滑点检查，
    /// amount1Min 最少花费的 token1 数量，用作滑点检查，
    /// deadline 交易必须在此时间之前被打包，变更才会生效
    /// @return liquidity 此次增加所产生的新流动性数量
    /// @return amount0 达到最终流动性所需的 token0 数量
    /// @return amount1 达到最终流动性所需的 token1 数量
    function increaseLiquidity(IncreaseLiquidityParams calldata params)
        external
        payable
        returns (
            uint128 liquidity,
            uint256 amount0,
            uint256 amount1
        );

    struct DecreaseLiquidityParams {
        uint256 tokenId;
        uint128 liquidity;
        uint256 amount0Min;
        uint256 amount1Min;
        uint256 deadline;
    }

    /// @notice 减少头寸中的流动性数量，并将其记账到该头寸
    /// @param params tokenId 要减少流动性的代币的 ID，
    /// amount 流动性将被减少的数量，
    /// amount0Min 就被销毁的流动性而言，应记账的 token0 最小数量，
    /// amount1Min 就被销毁的流动性而言，应记账的 token1 最小数量，
    /// deadline 交易必须在此时间之前被打包，变更才会生效
    /// @return amount0 记入该头寸应得代币（tokens owed）的 token0 数量
    /// @return amount1 记入该头寸应得代币（tokens owed）的 token1 数量
    function decreaseLiquidity(DecreaseLiquidityParams calldata params)
        external
        payable
        returns (uint256 amount0, uint256 amount1);

    struct CollectParams {
        uint256 tokenId;
        address recipient;
        uint128 amount0Max;
        uint128 amount1Max;
    }

    /// @notice 将特定头寸的应得手续费收取给接收者，最多不超过指定的最大数量
    /// @param params tokenId 要收取代币的 NFT 的 ID，
    /// recipient 应接收这些代币的账户，
    /// amount0Max 要收取的 token0 最大数量，
    /// amount1Max 要收取的 token1 最大数量
    /// @return amount0 以 token0 计的已收取手续费数量
    /// @return amount1 以 token1 计的已收取手续费数量
    function collect(CollectParams calldata params) external payable returns (uint256 amount0, uint256 amount1);

    /// @notice 销毁一个代币 ID，将其从 NFT 合约中删除。该代币的流动性必须为 0，且所有代币
    /// 必须事先被收取。
    /// @param tokenId 被销毁的代币的 ID
    function burn(uint256 tokenId) external payable;
}
