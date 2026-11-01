// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0;

/// @title 提供根据工厂（factory）、代币和手续费推导池地址的函数
library PoolAddress {
    bytes32 internal constant POOL_INIT_CODE_HASH = 0xe34f199b19b2b4f47f68442619d555527d244f78a3297ea89325f843f87b8b54;

    /// @notice 池的标识键
    struct PoolKey {
        address token0;
        address token1;
        uint24 fee;
    }

    /// @notice 返回 PoolKey：排好序的代币及其对应的费率档位
    /// @param tokenA 池的第一个代币，未排序
    /// @param tokenB 池的第二个代币，未排序
    /// @param fee 池的费率档位
    /// @return Poolkey 池的详细信息，其中 token0 和 token1 已按顺序赋值
    function getPoolKey(
        address tokenA,
        address tokenB,
        uint24 fee
    ) internal pure returns (PoolKey memory) {
        if (tokenA > tokenB) (tokenA, tokenB) = (tokenB, tokenA);
        return PoolKey({token0: tokenA, token1: tokenB, fee: fee});
    }

    /// @notice 根据给定的工厂和 PoolKey 确定性地计算池地址
    /// @param factory Uniswap V3 工厂合约地址
    /// @param key 该 PoolKey
    /// @return pool V3 池的合约地址
    function computeAddress(address factory, PoolKey memory key) internal pure returns (address pool) {
        require(key.token0 < key.token1);
        pool = address(
            uint256(
                keccak256(
                    abi.encodePacked(
                        hex'ff',
                        factory,
                        keccak256(abi.encode(key.token0, key.token1, key.fee)),
                        POOL_INIT_CODE_HASH
                    )
                )
            )
        );
    }
}
