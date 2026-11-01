// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.6.0;

import '@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol';

library PoolTicksCounter {
    /// @dev 该函数统计 tickBefore 与 tickAfter 之间会产生 gas 开销的已初始化 tick 的数量。
    /// 当 tickBefore 和/或 tickAfter 本身已初始化时，是否应将它们计入取决于
    /// 兑换（swap）的方向。若向上兑换（tickAfter > tickBefore），我们不计入 tickBefore，但
    /// 要计入 tickAfter。若向下兑换则正好相反。
    function countInitializedTicksCrossed(
        IUniswapV3Pool self,
        int24 tickBefore,
        int24 tickAfter
    ) internal view returns (uint32 initializedTicksCrossed) {
        int16 wordPosLower;
        int16 wordPosHigher;
        uint8 bitPosLower;
        uint8 bitPosHigher;
        bool tickBeforeInitialized;
        bool tickAfterInitialized;

        {
            // 获取兑换前后活跃 tick 在 tick 位图中的键（key）和偏移量。
            int16 wordPos = int16((tickBefore / self.tickSpacing()) >> 8);
            uint8 bitPos = uint8((tickBefore / self.tickSpacing()) % 256);

            int16 wordPosAfter = int16((tickAfter / self.tickSpacing()) >> 8);
            uint8 bitPosAfter = uint8((tickAfter / self.tickSpacing()) % 256);

            // 在 tickAfter 已初始化的情况下，我们只在向下兑换时才计入它。
            // 如果兑换后可初始化的 tick 已初始化、我们原始的 tickAfter 是
            // tick 间距的整数倍，并且我们正在向下兑换，那么可知 tickAfter 已初始化，
            // 我们不应计入它。
            tickAfterInitialized =
                ((self.tickBitmap(wordPosAfter) & (1 << bitPosAfter)) > 0) &&
                ((tickAfter % self.tickSpacing()) == 0) &&
                (tickBefore > tickAfter);

            // 在 tickBefore 已初始化的情况下，我们只在向上兑换时才计入它。
            // 使用与上面相同的逻辑来决定是否应计入 tickBefore。
            tickBeforeInitialized =
                ((self.tickBitmap(wordPos) & (1 << bitPos)) > 0) &&
                ((tickBefore % self.tickSpacing()) == 0) &&
                (tickBefore < tickAfter);

            if (wordPos < wordPosAfter || (wordPos == wordPosAfter && bitPos <= bitPosAfter)) {
                wordPosLower = wordPos;
                bitPosLower = bitPos;
                wordPosHigher = wordPosAfter;
                bitPosHigher = bitPosAfter;
            } else {
                wordPosLower = wordPosAfter;
                bitPosLower = bitPosAfter;
                wordPosHigher = wordPos;
                bitPosHigher = bitPos;
            }
        }

        // 通过遍历 tick 位图来统计跨越的已初始化 tick 的数量。
        // 第一个掩码应包含较低的 tick 及其左侧的所有位。
        uint256 mask = type(uint256).max << bitPosLower;
        while (wordPosLower <= wordPosHigher) {
            // 如果处于最后一页 tick 位图，确保只统计到
            // 结束 tick 为止。
            if (wordPosLower == wordPosHigher) {
                mask = mask & (type(uint256).max >> (255 - bitPosHigher));
            }

            uint256 masked = self.tickBitmap(wordPosLower) & mask;
            initializedTicksCrossed += countOneBits(masked);
            wordPosLower++;
            // 重置掩码，以便在下一次迭代中考虑所有位。
            mask = type(uint256).max;
        }

        if (tickAfterInitialized) {
            initializedTicksCrossed -= 1;
        }

        if (tickBeforeInitialized) {
            initializedTicksCrossed -= 1;
        }

        return initializedTicksCrossed;
    }

    function countOneBits(uint256 x) private pure returns (uint16) {
        uint16 bits = 0;
        while (x != 0) {
            bits++;
            x &= (x - 1);
        }
        return bits;
    }
}
