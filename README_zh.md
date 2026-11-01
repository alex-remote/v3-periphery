# Uniswap V3 Periphery（外围合约）

[![Tests](https://github.com/Uniswap/uniswap-v3-periphery/workflows/Tests/badge.svg)](https://github.com/Uniswap/uniswap-v3-periphery/actions?query=workflow%3ATests)
[![Lint](https://github.com/Uniswap/uniswap-v3-periphery/workflows/Lint/badge.svg)](https://github.com/Uniswap/uniswap-v3-periphery/actions?query=workflow%3ALint)

本仓库包含 Uniswap V3 协议的外围智能合约。
如需了解更底层的核心合约，请参阅 [uniswap-v3-core](https://github.com/Uniswap/uniswap-v3-core)
仓库。

## 漏洞赏金

本仓库适用 Uniswap V3 漏洞赏金计划，
具体条款见[此处](./bug-bounty_zh.md)。

## 本地部署

要将此代码部署到本地测试网，你应当安装 npm 包
`@uniswap/v3-periphery`
并从位于以下路径的构建产物（artifacts）中导入字节码：
`@uniswap/v3-periphery/artifacts/contracts/*/*.json`。
例如：

```typescript
import {
  abi as SWAP_ROUTER_ABI,
  bytecode as SWAP_ROUTER_BYTECODE,
} from '@uniswap/v3-periphery/artifacts/contracts/SwapRouter.sol/SwapRouter.json'

// deploy the bytecode
```

这样可以确保你测试所用的字节码与已部署到
主网和公共测试网的字节码完全相同，并且所有 Uniswap 代码都能与
你的本地部署正确地互操作。

## 使用 Solidity 接口

Uniswap v3 外围接口可以导入到 Solidity 智能合约中，
通过 npm 构建产物 `@uniswap/v3-periphery` 获取，例如：

```solidity
import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';

contract MyContract {
  ISwapRouter router;

  function doSomethingWithSwapRouter() {
    // router.exactInput(...);
  }
}

```
