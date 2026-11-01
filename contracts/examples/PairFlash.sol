// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;
pragma abicoder v2;

import '@uniswap/v3-core/contracts/interfaces/callback/IUniswapV3FlashCallback.sol';
import '@uniswap/v3-core/contracts/libraries/LowGasSafeMath.sol';

import '../base/PeripheryPayments.sol';
import '../base/PeripheryImmutableState.sol';
import '../libraries/PoolAddress.sol';
import '../libraries/CallbackValidation.sol';
import '../libraries/TransferHelper.sol';
import '../interfaces/ISwapRouter.sol';

/// @title 闪电合约实现
/// @notice 一个使用 Uniswap V3 flash 函数的示例合约
contract PairFlash is IUniswapV3FlashCallback, PeripheryPayments {
    using LowGasSafeMath for uint256;
    using LowGasSafeMath for int256;

    ISwapRouter public immutable swapRouter;

    constructor(
        ISwapRouter _swapRouter,
        address _factory,
        address _WETH9
    ) PeripheryImmutableState(_factory, _WETH9) {
        swapRouter = _swapRouter;
    }

    // fee2 和 fee3 是 token0 与 token1 另外两个池所对应的另外两个手续费
    struct FlashCallbackData {
        uint256 amount0;
        uint256 amount1;
        address payer;
        PoolAddress.PoolKey poolKey;
        uint24 poolFee2;
        uint24 poolFee3;
    }

    /// @param fee0 调用 flash 时 token0 的手续费
    /// @param fee1 调用 flash 时 token1 的手续费
    /// @param data 回调所需的数据，由 `initFlash` 以 FlashCallbackData 形式传入
    /// @notice 实现由 flash 调用的回调
    /// @dev 若闪电操作无利可图则失败，即闪电操作得到的 amountOut 小于借入的数量
    function uniswapV3FlashCallback(
        uint256 fee0,
        uint256 fee1,
        bytes calldata data
    ) external override {
        FlashCallbackData memory decoded = abi.decode(data, (FlashCallbackData));
        CallbackValidation.verifyCallback(factory, decoded.poolKey);

        address token0 = decoded.poolKey.token0;
        address token1 = decoded.poolKey.token1;

        // 盈利参数 —— 我们从套利兑换（swap）中收到的数量至少要等于需要偿还的数量
        // 若未达到该数量，exactInputSingle 将失败
        uint256 amount0Min = LowGasSafeMath.add(decoded.amount0, fee0);
        uint256 amount1Min = LowGasSafeMath.add(decoded.amount1, fee1);

        // 调用 exactInputSingle，在手续费为 fee2 的池中用 token1 兑换 token0
        TransferHelper.safeApprove(token1, address(swapRouter), decoded.amount1);
        uint256 amountOut0 =
            swapRouter.exactInputSingle(
                ISwapRouter.ExactInputSingleParams({
                    tokenIn: token1,
                    tokenOut: token0,
                    fee: decoded.poolFee2,
                    recipient: address(this),
                    deadline: block.timestamp,
                    amountIn: decoded.amount1,
                    amountOutMinimum: amount0Min,
                    sqrtPriceLimitX96: 0
                })
            );

        // 调用 exactInputSingle，在手续费为 fee3 的池中用 token0 兑换 token1
        TransferHelper.safeApprove(token0, address(swapRouter), decoded.amount0);
        uint256 amountOut1 =
            swapRouter.exactInputSingle(
                ISwapRouter.ExactInputSingleParams({
                    tokenIn: token0,
                    tokenOut: token1,
                    fee: decoded.poolFee3,
                    recipient: address(this),
                    deadline: block.timestamp,
                    amountIn: decoded.amount0,
                    amountOutMinimum: amount1Min,
                    sqrtPriceLimitX96: 0
                })
            );

        // 向交易对偿还所需的数量
        if (amount0Min > 0) pay(token0, address(this), msg.sender, amount0Min);
        if (amount1Min > 0) pay(token1, address(this), msg.sender, amount1Min);

        // 若有盈利，则将利润支付给付款方
        if (amountOut0 > amount0Min) {
            uint256 profit0 = amountOut0 - amount0Min;
            pay(token0, address(this), decoded.payer, profit0);
        }
        if (amountOut1 > amount1Min) {
            uint256 profit1 = amountOut1 - amount1Min;
            pay(token1, address(this), decoded.payer, profit1);
        }
    }

    //fee1 是初始借款所在池的手续费
    //fee2 是用于套利的第一个池的手续费
    //fee3 是用于套利的第二个池的手续费
    struct FlashParams {
        address token0;
        address token1;
        uint24 fee1;
        uint256 amount0;
        uint256 amount1;
        uint24 fee2;
        uint24 fee3;
    }

    /// @param params flash 及回调所需的参数，以 FlashParams 形式传入
    /// @notice 调用池的 flash 函数，并传入 `uniswapV3FlashCallback` 所需的数据
    function initFlash(FlashParams memory params) external {
        PoolAddress.PoolKey memory poolKey =
            PoolAddress.PoolKey({token0: params.token0, token1: params.token1, fee: params.fee1});
        IUniswapV3Pool pool = IUniswapV3Pool(PoolAddress.computeAddress(factory, poolKey));
        // 借入数量的接收者
        // 请求借入的 token0 数量
        // 请求借入的 token1 数量
        // 回调中需要 amount0 和 amount1 以偿还池
        // flash 的接收者应为本合约（THIS contract）
        pool.flash(
            address(this),
            params.amount0,
            params.amount1,
            abi.encode(
                FlashCallbackData({
                    amount0: params.amount0,
                    amount1: params.amount1,
                    payer: msg.sender,
                    poolKey: poolKey,
                    poolFee2: params.fee2,
                    poolFee3: params.fee3
                })
            )
        );
    }
}
