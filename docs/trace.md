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
| A01 | 1 | 71 | 进行中 |
| A02 | 6 | 70 | 进行中 |
| A03 | 3 | 68 | 进行中 |
| A04 | 4 | 68 | 进行中 |
| A05 | 3 | 72 | 进行中 |
| A06 | 9 | 61 + MD 4 行 | 进行中 |
| A07 | 6 | 60 | 进行中 |
| A08 | 2 | 56 | 已完成 |
| A09 | 5 | 70 | 进行中 |
| A10 | 6 | 45 | 进行中 |
| A11 | 3 | 63 | 进行中 |
| A12 | 8 | 68 | 进行中 |
| A13 | 12 | 66 | 进行中 |
| A14 | 10 | 42 | 进行中 |
| A15 | 3 | MD 80 行 | 进行中 |
| A16 | 1 | MD 80 行 | 已完成 |

## 三、需翻译文件清单

格式：`文件路径` — 总行数 ｜ 待译注释行 ｜ 负责子代理

### 3.1 Solidity 合约（contracts/，原位翻译）

- [ ] `contracts/NonfungiblePositionManager.sol` — 400 行 ｜ 待译注释 29 行 ｜ A02
- [ ] `contracts/NonfungibleTokenPositionDescriptor.sol` — 124 行 ｜ 待译注释 4 行 ｜ A02
- [ ] `contracts/SwapRouter.sol` — 244 行 ｜ 待译注释 25 行 ｜ A09
- [ ] `contracts/V3Migrator.sol` — 99 行 ｜ 待译注释 6 行 ｜ A14
- [ ] `contracts/base/BlockTimestamp.sol` — 12 行 ｜ 待译注释 4 行 ｜ A13
- [ ] `contracts/base/ERC721Permit.sol` — 86 行 ｜ 待译注释 8 行 ｜ A02
- [ ] `contracts/base/LiquidityManagement.sol` — 90 行 ｜ 待译注释 4 行 ｜ A04
- [ ] `contracts/base/Multicall.sol` — 28 行 ｜ 待译注释 3 行 ｜ A13
- [ ] `contracts/base/PeripheryImmutableState.sol` — 18 行 ｜ 待译注释 2 行 ｜ A13
- [ ] `contracts/base/PeripheryPayments.sol` — 70 行 ｜ 待译注释 8 行 ｜ A13
- [ ] `contracts/base/PoolInitializer.sol` — 32 行 ｜ 待译注释 1 行 ｜ A13
- [ ] `contracts/base/SelfPermit.sol` — 63 行 ｜ 待译注释 4 行 ｜ A07
- [ ] `contracts/examples/PairFlash.sol` — 149 行 ｜ 待译注释 24 行 ｜ A12
- [ ] `contracts/interfaces/IERC20Metadata.sol` — 18 行 ｜ 待译注释 6 行 ｜ A07
- [ ] `contracts/interfaces/IERC721Permit.sol` — 32 行 ｜ 待译注释 13 行 ｜ A02
- [ ] `contracts/interfaces/IMulticall.sol` — 13 行 ｜ 待译注释 6 行 ｜ A13
- [ ] `contracts/interfaces/INonfungiblePositionManager.sol` — 179 行 ｜ 待译注释 71 行 ｜ A01
- [ ] `contracts/interfaces/INonfungibleTokenPositionDescriptor.sol` — 17 行 ｜ 待译注释 6 行 ｜ A02
- [ ] `contracts/interfaces/IPeripheryImmutableState.sol` — 12 行 ｜ 待译注释 4 行 ｜ A13
- [ ] `contracts/interfaces/IPeripheryPayments.sol` — 28 行 ｜ 待译注释 14 行 ｜ A13
- [ ] `contracts/interfaces/IPeripheryPaymentsWithFee.sol` — 29 行 ｜ 待译注释 8 行 ｜ A13
- [ ] `contracts/interfaces/IPoolInitializer.sol` — 22 行 ｜ 待译注释 10 行 ｜ A13
- [ ] `contracts/interfaces/IQuoter.sol` — 51 行 ｜ 待译注释 26 行 ｜ A06
- [ ] `contracts/interfaces/IQuoterV2.sol` — 98 行 ｜ 待译注释 41 行 ｜ A05
- [ ] `contracts/interfaces/ISelfPermit.sol` — 76 行 ｜ 待译注释 36 行 ｜ A07
- [ ] `contracts/interfaces/ISwapRouter.sol` — 67 行 ｜ 待译注释 14 行 ｜ A09
- [ ] `contracts/interfaces/ITickLens.sol` — 25 行 ｜ 待译注释 9 行 ｜ A06
- [ ] `contracts/interfaces/IV3Migrator.sol` — 34 行 ｜ 待译注释 12 行 ｜ A14
- [ ] `contracts/interfaces/external/IERC1271.sol` — 16 行 ｜ 待译注释 10 行 ｜ A02
- [ ] `contracts/interfaces/external/IERC20PermitAllowed.sol` — 27 行 ｜ 待译注释 12 行 ｜ A07
- [ ] `contracts/interfaces/external/IWETH9.sol` — 13 行 ｜ 待译注释 3 行 ｜ A13
- [ ] `contracts/lens/Quoter.sol` — 170 行 ｜ 待译注释 16 行 ｜ A06
- [ ] `contracts/lens/QuoterV2.sol` — 273 行 ｜ 待译注释 16 行 ｜ A05
- [ ] `contracts/lens/TickLens.sol` — 42 行 ｜ 待译注释 4 行 ｜ A06
- [ ] `contracts/lens/UniswapInterfaceMulticall.sol` — 39 行 ｜ 待译注释 1 行 ｜ A06
- [ ] `contracts/libraries/BytesLib.sol` — 101 行 ｜ 待译注释 25 行 ｜ A11
- [ ] `contracts/libraries/CallbackValidation.sol` — 36 行 ｜ 待译注释 11 行 ｜ A12
- [ ] `contracts/libraries/ChainId.sol` — 13 行 ｜ 待译注释 3 行 ｜ A13
- [ ] `contracts/libraries/HexStrings.sol` — 29 行 ｜ 待译注释 2 行 ｜ A10
- [ ] `contracts/libraries/LiquidityAmounts.sol` — 137 行 ｜ 待译注释 43 行 ｜ A04
- [ ] `contracts/libraries/NFTDescriptor.sol` — 477 行 ｜ 待译注释 26 行 ｜ A10
- [ ] `contracts/libraries/NFTSVG.sol` — 406 行 ｜ 待译注释 6 行 ｜ A10
- [ ] `contracts/libraries/OracleLibrary.sol` — 180 行 ｜ 待译注释 47 行 ｜ A03
- [ ] `contracts/libraries/Path.sol` — 69 行 ｜ 待译注释 24 行 ｜ A09
- [ ] `contracts/libraries/PoolAddress.sol` — 48 行 ｜ 待译注释 11 行 ｜ A12
- [ ] `contracts/libraries/PoolTicksCounter.sol` — 96 行 ｜ 待译注释 16 行 ｜ A12
- [ ] `contracts/libraries/PositionKey.sol` — 13 行 ｜ 待译注释 1 行 ｜ A04
- [ ] `contracts/libraries/PositionValue.sol` — 167 行 ｜ 待译注释 20 行 ｜ A04
- [ ] `contracts/libraries/SqrtPriceMathPartial.sol` — 62 行 ｜ 待译注释 18 行 ｜ A11
- [ ] `contracts/libraries/TransferHelper.sol` — 60 行 ｜ 待译注释 20 行 ｜ A11
- [ ] `contracts/test/OracleTest.sol` — 67 行 ｜ 待译注释 1 行 ｜ A03
- [ ] `contracts/test/PathTest.sol` — 37 行 ｜ 待译注释 1 行 ｜ A09
- [ ] `contracts/test/SelfPermitTest.sol` — 9 行 ｜ 待译注释 1 行 ｜ A07
- [ ] `contracts/test/TestERC20PermitAllowed.sol` — 24 行 ｜ 待译注释 1 行 ｜ A07
- [ ] `contracts/test/TickLensTest.sol` — 15 行 ｜ 待译注释 1 行 ｜ A06

### 3.2 TypeScript 测试与配置（原位翻译）

- [ ] `hardhat.config.ts` — 104 行 ｜ 待译注释 2 行 ｜ A14
- [ ] `test/CallbackValidation.spec.ts` — 56 行 ｜ 待译注释 1 行 ｜ A12
- [ ] `test/NFTDescriptor.spec.ts` — 907 行 ｜ 待译注释 5 行 ｜ A10
- [ ] `test/NonfungiblePositionManager.spec.ts` — 1304 行 ｜ 待译注释 4 行 ｜ A10
- [ ] `test/NonfungibleTokenPositionDescriptor.spec.ts` — 217 行 ｜ 待译注释 2 行 ｜ A10
- [ ] `test/OracleLibrary.spec.ts` — 675 行 ｜ 待译注释 20 行 ｜ A03
- [ ] `test/PairFlash.spec.ts` — 168 行 ｜ 待译注释 2 行 ｜ A12
- [ ] `test/PoolTicksCounter.spec.ts` — 280 行 ｜ 待译注释 1 行 ｜ A12
- [ ] `test/PositionValue.spec.ts` — 490 行 ｜ 待译注释 9 行 ｜ A14
- [ ] `test/Quoter.spec.ts` — 201 行 ｜ 待译注释 2 行 ｜ A06
- [ ] `test/QuoterV2.spec.ts` — 578 行 ｜ 待译注释 15 行 ｜ A05
- [x] `test/SwapRouter.gas.spec.ts` — 453 行 ｜ 待译注释 11 行 ｜ A08
- [x] `test/SwapRouter.spec.ts` — 916 行 ｜ 待译注释 45 行 ｜ A08
- [ ] `test/TickLens.spec.ts` — 223 行 ｜ 待译注释 2 行 ｜ A06
- [ ] `test/V3Migrator.spec.ts` — 446 行 ｜ 待译注释 1 行 ｜ A14
- [ ] `test/shared/completeFixture.ts` — 63 行 ｜ 待译注释 2 行 ｜ A14
- [ ] `test/shared/computePoolAddress.ts` — 22 行 ｜ 待译注释 2 行 ｜ A12
- [ ] `test/shared/encodePriceSqrt.ts` — 16 行 ｜ 待译注释 1 行 ｜ A14
- [ ] `test/shared/formatSqrtRatioX96.ts` — 30 行 ｜ 待译注释 1 行 ｜ A14
- [ ] `test/shared/path.ts` — 61 行 ｜ 待译注释 6 行 ｜ A09

### 3.3 YAML 配置（原位翻译）

- [ ] `.github/stale.yml` — 25 行 ｜ 待译注释 7 行 ｜ A14
- [ ] `.github/workflows/tests.yml` — 39 行 ｜ 待译注释 1 行 ｜ A14

### 3.4 Markdown 文档（另存 `_zh.md`）

- [ ] `README.md` — 52 行 ｜ 译文 → `README_zh.md` ｜ A15
- [x] `bug-bounty.md` — 80 行 ｜ 译文 → `bug-bounty_zh.md` ｜ A16
- [ ] `contracts/lens/README.md` — 4 行 ｜ 译文 → `contracts/lens/README_zh.md` ｜ A06
- [ ] `deploys.md` — 25 行 ｜ 译文 → `deploys_zh.md` ｜ A15
- [ ] `testnet-deploys.md` — 3 行 ｜ 译文 → `testnet-deploys_zh.md` ｜ A15

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

## 五、变更日志

- 2026-11-01：完成文件统计，创建本跟踪文档，分派 16 个子代理并行翻译。
