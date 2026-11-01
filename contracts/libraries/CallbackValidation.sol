// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;

import '@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol';
import './PoolAddress.sol';

/// @notice 为来自 Uniswap V3 池的回调提供校验
library CallbackValidation {
    /// @notice 返回一个有效 Uniswap V3 池的地址
    /// @param factory Uniswap V3 工厂的合约地址
    /// @param tokenA token0 或 token1 之一的合约地址
    /// @param tokenB 另一个代币的合约地址
    /// @param fee 池中每次兑换（swap）收取的手续费，以百分之一 bip 为单位
    /// @return pool V3 池的合约地址
    function verifyCallback(
        address factory,
        address tokenA,
        address tokenB,
        uint24 fee
    ) internal view returns (IUniswapV3Pool pool) {
        return verifyCallback(factory, PoolAddress.getPoolKey(tokenA, tokenB, fee));
    }

    /// @notice 返回一个有效 Uniswap V3 池的地址
    /// @param factory Uniswap V3 工厂的合约地址
    /// @param poolKey V3 池的标识键
    /// @return pool V3 池的合约地址
    function verifyCallback(address factory, PoolAddress.PoolKey memory poolKey)
        internal
        view
        returns (IUniswapV3Pool pool)
    {
        pool = IUniswapV3Pool(PoolAddress.computeAddress(factory, poolKey));
        require(msg.sender == address(pool));
    }
}
