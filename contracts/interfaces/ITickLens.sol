// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.5;
pragma abicoder v2;

/// @title Tick Lens（tick 只读查询合约）
/// @notice 提供用于分块获取某个池的 tick 数据的函数
/// @dev 这样可以避免瀑布式的串行请求：先获取 tick 位图，再解析位图以确定需要获取哪些 tick，
/// 然后再发送额外的 multicall 来获取 tick 数据
interface ITickLens {
    struct PopulatedTick {
        int24 tick;
        int128 liquidityNet;
        uint128 liquidityGross;
    }

    /// @notice 从某个池 tick 位图的一个字（word）中，获取所有已初始化（populated）tick 的 tick 数据
    /// @param pool 要获取其已初始化 tick 数据的池地址
    /// @param tickBitmapIndex tick 位图中字（word）的索引，将针对该字解析位图并
    /// 获取其中所有已初始化的 tick
    /// @return populatedTicks tick 位图中给定字对应的 tick 数据数组
    function getPopulatedTicksInWord(address pool, int16 tickBitmapIndex)
        external
        view
        returns (PopulatedTick[] memory populatedTicks);
}
