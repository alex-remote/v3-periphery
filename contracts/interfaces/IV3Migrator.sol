// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.5;
pragma abicoder v2;

import './IMulticall.sol';
import './ISelfPermit.sol';
import './IPoolInitializer.sol';

/// @title V3 迁移器
/// @notice 支持将流动性从兼容 Uniswap v2 的交易对迁移到 Uniswap v3 池
interface IV3Migrator is IMulticall, ISelfPermit, IPoolInitializer {
    struct MigrateParams {
        address pair; // 兼容 Uniswap v2 的交易对
        uint256 liquidityToMigrate; // 预期等于 balanceOf(msg.sender)
        uint8 percentageToMigrate; // 表示为分母为 100 的分子
        address token0;
        address token1;
        uint24 fee;
        int24 tickLower;
        int24 tickUpper;
        uint256 amount0Min; // 必须已按 percentageToMigrate 折算
        uint256 amount1Min; // 必须已按 percentageToMigrate 折算
        address recipient;
        uint256 deadline;
        bool refundAsETH;
    }

    /// @notice 通过销毁 v2 流动性并在 v3 中铸造新头寸，将流动性迁移到 v3
    /// @dev 滑点保护通过 `amount{0,1}Min` 实现，其值应为 v2 流动性所能换得的 v3 流动性最大数量
    /// 对应预期值的折扣值。对于迁移到区间外（out-of-range）头寸的特殊情况，
    /// `amount{0,1}Min` 可设为 0，以此确保该头寸保持在区间之外
    /// @param params 迁移 v2 流动性所需的参数，以 `MigrateParams` 形式编码在 calldata 中
    function migrate(MigrateParams calldata params) external;
}
