# 注释翻译任务进度跟踪

> 任务：将仓库中的英文注释翻译为中文（原位替换、行数不变、保留专有名词与代码标识符）；英文 `.md` 文件另存为同目录下的 `*_zh.md`。

- 基线提交：`24ccf01`
- 统计日期：2026-11-01
- 勾选规则：`[ ]` 未翻译；`[x]` 子代理已完成翻译并通过校验（行数不变、去注释后代码与基线一致）

## 一、统计概览

| 项目 | 文件数 | 行数 |
| --- | ---: | ---: |
| 仓库受控文件（`git ls-files`） | 154 | 27399 |
| 需翻译文件合计 | 82 | 12180 |
| └ 源码/配置注释原位翻译（.sol / .ts / .yml） | 77 | 12016 |
| └ Markdown 文档另存 `_zh.md` | 5 | 164 |
| 无需翻译文件 | 72 | 15219 |

需翻译的英文注释行合计约 **880** 行（不含 Markdown）。

## 二、子代理分工与进度

| 子代理 | 文件数 | 待译注释行 | 状态 |
| --- | ---: | ---: | --- |
| A01 | 1 | 71 | 已完成 |
| A02 | 6 | 70 | 已完成 |
| A03 | 3 | 68 | 已完成 |
| A04 | 4 | 68 | 已完成 |
| A05 | 3 | 72 | 已完成 |
| A06 | 9 | 61 + MD 4 行 | 已完成 |
| A07 | 6 | 60 | 已完成 |
| A08 | 2 | 56 | 已完成 |
| A09 | 5 | 70 | 已完成 |
| A10 | 6 | 45 | 已完成 |
| A11 | 3 | 63 | 已完成 |
| A12 | 8 | 68 | 已完成 |
| A13 | 12 | 66 | 已完成 |
| A14 | 10 | 42 | 已完成 |
| A15 | 3 | MD 80 行 | 已完成 |
| A16 | 1 | MD 80 行 | 已完成 |

## 三、需翻译文件清单

格式：`文件路径` — 总行数 ｜ 待译注释行 ｜ 负责子代理

### 3.1 Solidity 合约（contracts/，原位翻译）

- [x] `contracts/NonfungiblePositionManager.sol` — 400 行 ｜ 待译注释 29 行 ｜ A02
- [x] `contracts/NonfungibleTokenPositionDescriptor.sol` — 124 行 ｜ 待译注释 4 行 ｜ A02
- [x] `contracts/SwapRouter.sol` — 244 行 ｜ 待译注释 25 行 ｜ A09
- [x] `contracts/V3Migrator.sol` — 99 行 ｜ 待译注释 6 行 ｜ A14
- [x] `contracts/base/BlockTimestamp.sol` — 12 行 ｜ 待译注释 4 行 ｜ A13
- [x] `contracts/base/ERC721Permit.sol` — 86 行 ｜ 待译注释 8 行 ｜ A02
- [x] `contracts/base/LiquidityManagement.sol` — 90 行 ｜ 待译注释 4 行 ｜ A04
- [x] `contracts/base/Multicall.sol` — 28 行 ｜ 待译注释 3 行 ｜ A13
- [x] `contracts/base/PeripheryImmutableState.sol` — 18 行 ｜ 待译注释 2 行 ｜ A13
- [x] `contracts/base/PeripheryPayments.sol` — 70 行 ｜ 待译注释 8 行 ｜ A13
- [x] `contracts/base/PoolInitializer.sol` — 32 行 ｜ 待译注释 1 行 ｜ A13
- [x] `contracts/base/SelfPermit.sol` — 63 行 ｜ 待译注释 4 行 ｜ A07
- [x] `contracts/examples/PairFlash.sol` — 149 行 ｜ 待译注释 24 行 ｜ A12
- [x] `contracts/interfaces/IERC20Metadata.sol` — 18 行 ｜ 待译注释 6 行 ｜ A07
- [x] `contracts/interfaces/IERC721Permit.sol` — 32 行 ｜ 待译注释 13 行 ｜ A02
- [x] `contracts/interfaces/IMulticall.sol` — 13 行 ｜ 待译注释 6 行 ｜ A13
- [x] `contracts/interfaces/INonfungiblePositionManager.sol` — 179 行 ｜ 待译注释 71 行 ｜ A01
- [x] `contracts/interfaces/INonfungibleTokenPositionDescriptor.sol` — 17 行 ｜ 待译注释 6 行 ｜ A02
- [x] `contracts/interfaces/IPeripheryImmutableState.sol` — 12 行 ｜ 待译注释 4 行 ｜ A13
- [x] `contracts/interfaces/IPeripheryPayments.sol` — 28 行 ｜ 待译注释 14 行 ｜ A13
- [x] `contracts/interfaces/IPeripheryPaymentsWithFee.sol` — 29 行 ｜ 待译注释 8 行 ｜ A13
- [x] `contracts/interfaces/IPoolInitializer.sol` — 22 行 ｜ 待译注释 10 行 ｜ A13
- [x] `contracts/interfaces/IQuoter.sol` — 51 行 ｜ 待译注释 26 行 ｜ A06
- [x] `contracts/interfaces/IQuoterV2.sol` — 98 行 ｜ 待译注释 41 行 ｜ A05
- [x] `contracts/interfaces/ISelfPermit.sol` — 76 行 ｜ 待译注释 36 行 ｜ A07
- [x] `contracts/interfaces/ISwapRouter.sol` — 67 行 ｜ 待译注释 14 行 ｜ A09
- [x] `contracts/interfaces/ITickLens.sol` — 25 行 ｜ 待译注释 9 行 ｜ A06
- [x] `contracts/interfaces/IV3Migrator.sol` — 34 行 ｜ 待译注释 12 行 ｜ A14
- [x] `contracts/interfaces/external/IERC1271.sol` — 16 行 ｜ 待译注释 10 行 ｜ A02
- [x] `contracts/interfaces/external/IERC20PermitAllowed.sol` — 27 行 ｜ 待译注释 12 行 ｜ A07
- [x] `contracts/interfaces/external/IWETH9.sol` — 13 行 ｜ 待译注释 3 行 ｜ A13
- [x] `contracts/lens/Quoter.sol` — 170 行 ｜ 待译注释 16 行 ｜ A06
- [x] `contracts/lens/QuoterV2.sol` — 273 行 ｜ 待译注释 16 行 ｜ A05
- [x] `contracts/lens/TickLens.sol` — 42 行 ｜ 待译注释 4 行 ｜ A06
- [x] `contracts/lens/UniswapInterfaceMulticall.sol` — 39 行 ｜ 待译注释 1 行 ｜ A06
- [x] `contracts/libraries/BytesLib.sol` — 101 行 ｜ 待译注释 25 行 ｜ A11
- [x] `contracts/libraries/CallbackValidation.sol` — 36 行 ｜ 待译注释 11 行 ｜ A12
- [x] `contracts/libraries/ChainId.sol` — 13 行 ｜ 待译注释 3 行 ｜ A13
- [x] `contracts/libraries/HexStrings.sol` — 29 行 ｜ 待译注释 2 行 ｜ A10
- [x] `contracts/libraries/LiquidityAmounts.sol` — 137 行 ｜ 待译注释 43 行 ｜ A04
- [x] `contracts/libraries/NFTDescriptor.sol` — 477 行 ｜ 待译注释 26 行 ｜ A10
- [x] `contracts/libraries/NFTSVG.sol` — 406 行 ｜ 待译注释 6 行 ｜ A10
- [x] `contracts/libraries/OracleLibrary.sol` — 180 行 ｜ 待译注释 47 行 ｜ A03
- [x] `contracts/libraries/Path.sol` — 69 行 ｜ 待译注释 24 行 ｜ A09
- [x] `contracts/libraries/PoolAddress.sol` — 48 行 ｜ 待译注释 11 行 ｜ A12
- [x] `contracts/libraries/PoolTicksCounter.sol` — 96 行 ｜ 待译注释 16 行 ｜ A12
- [x] `contracts/libraries/PositionKey.sol` — 13 行 ｜ 待译注释 1 行 ｜ A04
- [x] `contracts/libraries/PositionValue.sol` — 167 行 ｜ 待译注释 20 行 ｜ A04
- [x] `contracts/libraries/SqrtPriceMathPartial.sol` — 62 行 ｜ 待译注释 18 行 ｜ A11
- [x] `contracts/libraries/TransferHelper.sol` — 60 行 ｜ 待译注释 20 行 ｜ A11
- [x] `contracts/test/OracleTest.sol` — 67 行 ｜ 待译注释 1 行 ｜ A03
- [x] `contracts/test/PathTest.sol` — 37 行 ｜ 待译注释 1 行 ｜ A09
- [x] `contracts/test/SelfPermitTest.sol` — 9 行 ｜ 待译注释 1 行 ｜ A07
- [x] `contracts/test/TestERC20PermitAllowed.sol` — 24 行 ｜ 待译注释 1 行 ｜ A07
- [x] `contracts/test/TickLensTest.sol` — 15 行 ｜ 待译注释 1 行 ｜ A06

### 3.2 TypeScript 测试与配置（原位翻译）

- [x] `hardhat.config.ts` — 104 行 ｜ 待译注释 2 行 ｜ A14
- [x] `test/CallbackValidation.spec.ts` — 56 行 ｜ 待译注释 1 行 ｜ A12
- [x] `test/NFTDescriptor.spec.ts` — 907 行 ｜ 待译注释 5 行 ｜ A10
- [x] `test/NonfungiblePositionManager.spec.ts` — 1304 行 ｜ 待译注释 4 行 ｜ A10
- [x] `test/NonfungibleTokenPositionDescriptor.spec.ts` — 217 行 ｜ 待译注释 2 行 ｜ A10
- [x] `test/OracleLibrary.spec.ts` — 675 行 ｜ 待译注释 20 行 ｜ A03
- [x] `test/PairFlash.spec.ts` — 168 行 ｜ 待译注释 2 行 ｜ A12
- [x] `test/PoolTicksCounter.spec.ts` — 280 行 ｜ 待译注释 1 行 ｜ A12
- [x] `test/PositionValue.spec.ts` — 490 行 ｜ 待译注释 9 行 ｜ A14
- [x] `test/Quoter.spec.ts` — 201 行 ｜ 待译注释 2 行 ｜ A06
- [x] `test/QuoterV2.spec.ts` — 578 行 ｜ 待译注释 15 行 ｜ A05
- [x] `test/SwapRouter.gas.spec.ts` — 453 行 ｜ 待译注释 11 行 ｜ A08
- [x] `test/SwapRouter.spec.ts` — 916 行 ｜ 待译注释 45 行 ｜ A08
- [x] `test/TickLens.spec.ts` — 223 行 ｜ 待译注释 2 行 ｜ A06
- [x] `test/V3Migrator.spec.ts` — 446 行 ｜ 待译注释 1 行 ｜ A14
- [x] `test/shared/completeFixture.ts` — 63 行 ｜ 待译注释 2 行 ｜ A14
- [x] `test/shared/computePoolAddress.ts` — 22 行 ｜ 待译注释 2 行 ｜ A12
- [x] `test/shared/encodePriceSqrt.ts` — 16 行 ｜ 待译注释 1 行 ｜ A14
- [x] `test/shared/formatSqrtRatioX96.ts` — 30 行 ｜ 待译注释 1 行 ｜ A14
- [x] `test/shared/path.ts` — 61 行 ｜ 待译注释 6 行 ｜ A09

### 3.3 YAML 配置（原位翻译）

- [x] `.github/stale.yml` — 25 行 ｜ 待译注释 7 行 ｜ A14
- [x] `.github/workflows/tests.yml` — 39 行 ｜ 待译注释 1 行 ｜ A14

### 3.4 Markdown 文档（另存 `_zh.md`）

- [x] `README.md` — 52 行 ｜ 译文 → `README_zh.md` ｜ A15
- [x] `bug-bounty.md` — 80 行 ｜ 译文 → `bug-bounty_zh.md` ｜ A16
- [x] `contracts/lens/README.md` — 4 行 ｜ 译文 → `contracts/lens/README_zh.md` ｜ A06
- [x] `deploys.md` — 25 行 ｜ 译文 → `deploys_zh.md` ｜ A15
- [x] `testnet-deploys.md` — 3 行 ｜ 译文 → `testnet-deploys_zh.md` ｜ A15

## 四、无需翻译的文件（仅作统计）

| 文件 | 行数 | 原因 |
| --- | ---: | --- |
| `.gitattributes` | 0 | 配置文件，无注释 |
| `.github/workflows/lint.yml` | 37 | 配置文件，无注释 |
| `.gitignore` | 4 | 配置文件，无注释 |
| `.prettierignore` | 0 | 配置文件，无注释 |
| `.prettierrc` | 5 | 依赖锁 / JSON 配置，无注释 |
| `.solhint.json` | 6 | 依赖锁 / JSON 配置，无注释 |
| `.yarnrc` | 1 | 配置文件，无注释 |
| `LICENSE` | 338 | 许可证法律文本，保持原文 |
| `audits/abdk/audit.pdf` | 4241 | 二进制 PDF 审计报告 |
| `contracts/base/PeripheryPaymentsWithFee.sol` | 55 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/base/PeripheryValidation.sol` | 11 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/libraries/TokenRatioSortOrder.sol` | 12 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/Base64Test.sol` | 16 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/LiquidityAmountsTest.sol` | 120 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/MockObservable.sol` | 48 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/MockObservations.sol` | 82 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/MockTimeNonfungiblePositionManager.sol` | 23 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/MockTimeSwapRouter.sol` | 19 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/NFTDescriptorTest.sol` | 75 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/NonfungiblePositionManagerPositionsGasTest.sol` | 18 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/PeripheryImmutableStateTest.sol` | 8 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/PoolAddressTest.sol` | 30 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/PoolTicksCounterTest.sol` | 18 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/PositionValueTest.sol` | 57 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/TestCallbackValidation.sol` | 15 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/TestERC20.sol` | 10 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/TestERC20Metadata.sol` | 14 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/TestMulticall.sol` | 30 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/TestPositionNFTOwner.sol` | 28 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `contracts/test/TestUniswapV3Callee.sol` | 62 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `package.json` | 68 | 依赖锁 / JSON 配置，无注释 |
| `test/Base64.spec.ts` | 81 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/LiquidityAmounts.spec.ts` | 241 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/Multicall.spec.ts` | 65 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/Path.spec.ts` | 90 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/PeripheryImmutableState.spec.ts` | 56 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/PoolAddress.spec.ts` | 72 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/SelfPermit.spec.ts` | 198 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/__snapshots__/Base64.spec.ts.snap` | 32 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/__snapshots__/LiquidityAmounts.spec.ts.snap` | 21 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/__snapshots__/Multicall.spec.ts.snap` | 5 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/__snapshots__/NFTDescriptor.spec.ts.snap` | 7 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/__snapshots__/NFTDescriptor.svg` | 0 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/__snapshots__/NonfungiblePositionManager.spec.ts.snap` | 41 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/__snapshots__/OracleLibrary.spec.ts.snap` | 3 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/__snapshots__/PairFlash.spec.ts.snap` | 3 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/__snapshots__/Path.spec.ts.snap` | 3 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/__snapshots__/PeripheryImmutableState.spec.ts.snap` | 3 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/__snapshots__/PoolAddress.spec.ts.snap` | 5 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/__snapshots__/PositionValue.spec.ts.snap` | 11 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/__snapshots__/QuoterV2.spec.ts.snap` | 51 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/__snapshots__/SwapRouter.gas.spec.ts.snap` | 37 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/__snapshots__/SwapRouter.spec.ts.snap` | 3 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/__snapshots__/TickLens.spec.ts.snap` | 5 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/__snapshots__/V3Migrator.spec.ts.snap` | 3 | Jest 测试快照（自动生成，改动会导致测试失败） |
| `test/contracts/WETH9.json` | 156 | 依赖锁 / JSON 配置，无注释 |
| `test/shared/base64.ts` | 7 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/shared/constants.ts` | 15 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/shared/expandTo18Decimals.ts` | 5 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/shared/expect.ts` | 8 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/shared/externalFixtures.ts` | 57 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/shared/extractJSONFromURI.ts` | 5 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/shared/formatSqrtRatioX96.spec.ts` | 30 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/shared/getPermitNFTSignature.ts` | 57 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/shared/permit.ts` | 61 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/shared/poolAtAddress.ts` | 7 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/shared/quoter.ts` | 153 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/shared/snapshotGasCost.ts` | 27 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/shared/ticks.ts` | 9 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `test/shared/tokenSort.ts` | 10 | 无英文注释（仅 SPDX 许可证标识 / @inheritdoc 等无需翻译的注释，或无注释） |
| `tsconfig.json` | 14 | 依赖锁 / JSON 配置，无注释 |
| `yarn.lock` | 8111 | 依赖锁 / JSON 配置，无注释 |

## 五、保留原文的注释（按规则不译）

除 `SPDX-License-Identifier`、`pragma`、整行 `@inheritdoc` 外，以下注释刻意保留英文原样：

| 文件 | 行 | 原因 |
| --- | ---: | --- |
| `contracts/base/ERC721Permit.sol` | 39 | `keccak256('EIP712Domain(...)')` 为代码表达式 |
| `contracts/interfaces/IERC20Metadata.sol` | 6 | `@title IERC20Metadata` 仅为接口名 |
| `contracts/libraries/NFTSVG.sol` | 8 | `@title NFTSVG` 仅为库名 |
| `contracts/libraries/NFTSVG.sol` | 48–51 | 带签名的署名数据（address / msg / sig / version），改动会破坏签名原文 |
| `contracts/libraries/BytesLib.sol` | 4 | `@author` 作者名与邮箱 |
| `test/OracleLibrary.spec.ts` | 364–370、427–434 | 纯数学推导表达式 |
| `test/PoolTicksCounter.spec.ts`、`test/Quoter.spec.ts`、`test/QuoterV2.spec.ts` | — | `// 1100`、`// -2%` 等纯数字注释 |
| `README_zh.md` | 代码块内 | 代码块内容（含其中注释）按规则保持原样 |

## 六、原文疑似笔误（译文忠实原文，未作纠正，精读时请留意）

| 文件 | 位置 | 说明 |
| --- | --- | --- |
| `contracts/libraries/LiquidityAmounts.sol` | 第 11 行 | 原文写作 `uint258`，应为 `uint256` |
| `contracts/interfaces/INonfungiblePositionManager.sol` | 第 148 行 | 原文写 `amount`，对应结构体字段实为 `liquidity` |
| `contracts/libraries/TransferHelper.sol` | `safeApprove` 的 `@dev` | 原文写 “if transfer fails”，语义上应为授权失败 |
| `test/shared/path.ts` | 第 32 行 | 原文称读取 2 字节手续费，代码实际读取 3 字节（`FEE_SIZE`） |
| `test/PositionValue.spec.ts` | 注释 | 原文拼写 `accmuluate`，按 `accumulate` 理解翻译 |

## 七、校验结果

- 校验脚本：逐行比对基线 `24ccf01`，要求行数不变，且剥离注释后的代码逐行完全一致。
- 77 个原位翻译文件：全部 `[OK]`，0 ERROR；剩余 10 条“注释未改动”提示均属第五节所列保留项。
- 5 个 `_zh.md`：与原文行数一致、逐行对应；原 `.md` 均未改动。
- 范围外文件改动：无。

## 八、变更日志

- 2026-11-01：完成文件统计，创建本跟踪文档，分派 16 个子代理并行翻译。
- 2026-11-01：16 个子代理全部完成并汇报；主代理逐组复核通过，82 / 82 文件已勾选。
