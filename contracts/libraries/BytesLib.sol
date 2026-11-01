// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * @title Solidity 字节数组工具库
 * @author Gonçalo Sá <goncalo.sa@consensys.net>
 *
 * @dev 用 Solidity 编写、面向以太坊合约的紧密打包字节数组工具库。
 *      该库可在内存和存储中对字节数组进行拼接、切片和类型转换。
 */
pragma solidity >=0.5.0 <0.8.0;

library BytesLib {
    function slice(
        bytes memory _bytes,
        uint256 _start,
        uint256 _length
    ) internal pure returns (bytes memory) {
        require(_length + 31 >= _length, 'slice_overflow');
        require(_start + _length >= _start, 'slice_overflow');
        require(_bytes.length >= _start + _length, 'slice_outOfBounds');

        bytes memory tempBytes;

        assembly {
            switch iszero(_length)
                case 0 {
                    // 获取一块空闲内存的位置并将其存入 tempBytes，
                    // 与 Solidity 处理内存变量的方式相同。
                    tempBytes := mload(0x40)

                    // 切片结果的第一个字（word）可能是从原数组中读取的
                    // 一个不完整的字。为了读取它，我们先计算
                    // 该不完整字的长度，然后开始将这么多
                    // 字节复制到数组中。我们复制的第一个字开头是
                    // 我们不关心的数据，但其最后 `lengthmod` 个字节将
                    // 落在新数组内容的起始处。
                    // 复制完成后，我们用切片的实际长度覆盖
                    // 整个第一个字。
                    let lengthmod := and(_length, 31)

                    // 下一行中的乘法是必要的，
                    // 因为当切片长度为 32 字节的整数倍时（lengthmod == 0），
                    // 下面的复制循环会复制原数组的长度，
                    // 然后过早结束，没有复制所有应复制的内容。
                    let mc := add(add(tempBytes, lengthmod), mul(0x20, iszero(lengthmod)))
                    let end := add(mc, _length)

                    for {
                        // 下一行中的乘法与上面那个乘法的
                        // 用途完全相同。
                        let cc := add(add(add(_bytes, lengthmod), mul(0x20, iszero(lengthmod))), _start)
                    } lt(mc, end) {
                        mc := add(mc, 0x20)
                        cc := add(cc, 0x20)
                    } {
                        mstore(mc, mload(cc))
                    }

                    mstore(tempBytes, _length)

                    //更新空闲内存指针
                    //像现在的编译器那样，分配按 32 字节填充的数组
                    mstore(0x40, and(add(mc, 31), not(31)))
                }
                //如果需要零长度切片，直接返回一个零长度数组
                default {
                    tempBytes := mload(0x40)
                    //将即将返回的 32 字节切片清零
                    //之所以需要这样做，是因为 Solidity 不会进行垃圾回收
                    mstore(tempBytes, 0)

                    mstore(0x40, add(tempBytes, 0x20))
                }
        }

        return tempBytes;
    }

    function toAddress(bytes memory _bytes, uint256 _start) internal pure returns (address) {
        require(_start + 20 >= _start, 'toAddress_overflow');
        require(_bytes.length >= _start + 20, 'toAddress_outOfBounds');
        address tempAddress;

        assembly {
            tempAddress := div(mload(add(add(_bytes, 0x20), _start)), 0x1000000000000000000000000)
        }

        return tempAddress;
    }

    function toUint24(bytes memory _bytes, uint256 _start) internal pure returns (uint24) {
        require(_start + 3 >= _start, 'toUint24_overflow');
        require(_bytes.length >= _start + 3, 'toUint24_outOfBounds');
        uint24 tempUint;

        assembly {
            tempUint := mload(add(add(_bytes, 0x3), _start))
        }

        return tempUint;
    }
}
