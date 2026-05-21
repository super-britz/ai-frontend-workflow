---
name: frontend-openspec-workflow
description: Use when 将 OpenSpec/OPSX、前端专项 skills 和任意 AI 辅助开发执行工具组合到同一个前端需求流程；处理 openspec change、specs、proposal、tasks、decisions、validate、archive、人工 Gate、需求事实沉淀、执行纪律和前端设计接口实现边界。
---

# 前端 OpenSpec 工作流

## 概览

最推荐的组合方式：

```text
OpenSpec = 项目事实和需求变更账本
执行工作流 = 计划、实现、测试、验证和交付纪律
frontend skills = 前端专业判断和产物生成模块
```

OpenSpec 不负责替你写完整流程，执行工作流不负责长期沉淀项目事实，frontend skills 不负责管理需求生命周期。三者是分层协作，不是互相替代。执行工作流可以来自当前环境中可用的任意 AI 助手或自动化工具，但不能绕过事实文件和 Gate。

## 职责边界

| 层 | 主职责 | 典型产物 | 不做什么 |
| --- | --- | --- | --- |
| OpenSpec | 需求边界、项目事实、变更生命周期 | `openspec/specs/`、`openspec/changes/<change>/`、proposal、design、tasks | 不替代工程执行纪律 |
| 执行工作流 | 计划、实现、测试、review、verification、finish branch | plan、测试、代码、验证证据、PR/合并决策 | 不当长期事实库 |
| frontend skills | 产品需求、设计需求、接口需求、对齐需求、代码实现准入、视觉验收、前端 Review | `docs/product-requirements.md`、`docs/design-requirements.md`、`docs/api-requirements.md`、`verification.md`、`review.md` | 不跨越人工 Gate |

判断原则：**OpenSpec 说清楚做什么，执行工作流管怎么可靠地做完，frontend skills 补齐前端领域专业性。**

## 硬性规则

- 重要分析结果必须落到文件，聊天摘要不能作为 source of truth。
- `docs/product-requirements.md`、`docs/design-requirements.md`、`docs/api-requirements.md`、`docs/alignment-requirements.md` 是事实文件；拆解不准时直接改这些文件。
- `decisions.md` 是决策文件；记录为什么这么改、谁确认、状态是什么，不替代事实文件。
- `tasks.md` 是执行文件；必须在事实文件稳定、决策完成、Implementation Gate 通过后再生成或更新。
- 如果聊天结论和 OpenSpec change 文件冲突，以文件为准；需要改变结论时先改文件。

## 文件职责

OpenSpec change 中的文件应按“变更推进”和“事实沉淀”分层使用，避免一个文件同时承担产品、设计、接口、任务和决策职责。

### 文件职责速查

| 文件 | 职责 |
| --- | --- |
| `proposal.md` | 为什么做、做什么、不做什么 |
| `docs/product-requirements.md` | 产品事实 |
| `docs/design-requirements.md` | 设计事实 |
| `docs/api-requirements.md` | 接口事实 |
| `docs/alignment-requirements.md` | 产品 / 设计 / API 对齐结果 |
| `decisions.md` | 已拍板和待拍板问题 |
| `tasks.md` | 执行清单 |
| `specs/**/spec.md` | 最终系统能力契约 |

### 变更推进文件

- `proposal.md`：回答“为什么做、做什么、不做什么”，只写变更背景、范围、非目标和主要风险，不写字段级接口或 Figma 细节。
- `design.md`：回答“工程上准备怎么做”，只写实现策略、模块拆分、数据流、风险控制和推进顺序，不重复产品正文、设计需求正文或接口字段表。
- `specs/**/spec.md`：回答“最终必须满足什么”，只写验收级 requirement / scenario，不写实现细节。
- `tasks.md`：回答“现在做到哪一步”，只写执行清单和进度，不承担需求分析职责；涉及前端页面实现时，必须把 `frontend-code-implementation` handoff 作为代码修改前的第一项执行任务。
- `decisions.md`：回答“有争议的地方最后怎么定”，只记录取舍、原因、owner、状态和 Gate 结果，不重复事实正文。
- `verification.md`：记录验证动作、结果和阻塞项。
- `review.md`：记录 review 发现、风险和结论。

### 事实文件

- `docs/product-requirements.md`：产品需求事实，沉淀业务目标、功能范围、业务规则、校验、权限、异常和验收口径。
- `docs/design-requirements.md`：设计需求事实，沉淀 Figma 页面结构、组件形态、交互、状态和视觉验收点。
- `docs/api-requirements.md`：接口需求事实，沉淀接口路径、参数、响应、枚举、错误码、权限码和 mock 约定。
- `docs/alignment-requirements.md`：对齐事实，沉淀产品、设计、API 三者的字段映射、状态映射、adapter 决策和待确认问题。

### 推荐顺序

当一个前端需求进入 OpenSpec change 时，默认按下面顺序推进：

1. `proposal.md`
2. `docs/product-requirements.md`
3. `docs/design-requirements.md`
4. `docs/api-requirements.md`
5. `docs/alignment-requirements.md`
6. `decisions.md`
7. `design.md`
8. `specs/**/spec.md`
9. `tasks.md`
10. 实现、验证、review、归档

### 使用约束

- 产品规则不要只写在 `design-requirements.md`。
- Figma 结构不要写进 `proposal.md` 或 `spec.md`。
- 接口字段和错误码不要散落在 `design.md`。
- 未拍板的问题写进 `decisions.md`，不要只留在聊天里。
- 在 `docs/*-requirements.md` 仍不稳定时，不要提前细化 `tasks.md`。
- 不要把 `tasks.md` 当成可以直接写代码的许可；实现任务必须重新读取事实文件，并通过 `frontend-code-implementation` 完成实现准入。

## 推荐主流程

### 0. 项目初始化

新项目或老项目首次接入时：

```bash
openspec init
```

然后用 `frontend-project-bootstrap` 写清项目级 AI 辅助开发规则、组件使用机制、命令和验收要求。

### 1. 需求进入 OpenSpec

模糊需求先探索，明确需求再建 change。可用 OpenSpec CLI 或 OPSX slash commands：

```bash
openspec new change <change-id>
openspec list
openspec show <change-id>
openspec validate <change-id> --strict
```

如果在支持 OPSX 的环境里，也可以使用：

```text
/opsx:explore
/opsx:propose <change-id>
```

这一阶段只回答：

- 这个需求为什么做。
- 做什么、不做什么。
- 涉及哪些能力或现有 specs。
- 验收标准和风险是什么。

### 2. 前端事实进入 change

在 active change 下放前端专项文档：

```text
openspec/changes/<change-id>/
  proposal.md
  specs/
  design.md
  tasks.md
  docs/
    product-requirements.md
    design-requirements.md
    api-requirements.md
    alignment-requirements.md
  decisions.md
  verification.md
  review.md
```

对应关系：

| 文档 | 由谁产出 |
| --- | --- |
| `docs/product-requirements.md` | 从 PRD/Wiki/产品说明提炼，可由 `frontend-openspec-workflow` 协助沉淀 |
| `docs/design-requirements.md` | `frontend-design-requirements` |
| `docs/api-requirements.md` | `frontend-api-requirements` |
| `docs/alignment-requirements.md` | `frontend-design-api-alignment` |
| `decisions.md` | 人工审核和 owner 决策 |
| `verification.md` | `frontend-visual-verification` |
| `review.md` | `frontend-code-review` |

如果需求不需要 OpenSpec，继续使用 `docs/ai/*.md`，不要强行建 change。

同一页面来自多个 Figma 文件、frame 或 node 时，优先把它们作为同一份 `docs/design-requirements.md` 的“设计来源索引”和“状态变体”管理；不要因为默认态、弹窗态、空态、错误态在不同 Figma 节点里就拆多个设计需求文件。只有不同完整页面、独立流程或可复用视觉规范才拆独立文件。

### 3. 审核和修正事实文件

人工或团队可以直接编辑 change 里的事实文件：

| 发现的问题 | 修改位置 |
| --- | --- |
| 产品目标、范围、业务规则、校验或验收口径不准 | `docs/product-requirements.md` |
| 页面结构、组件映射、状态或视觉验收点不准 | `docs/design-requirements.md` |
| 接口字段、类型、分页、错误码或权限不准 | `docs/api-requirements.md` |
| 字段映射、adapter、差异分类不准 | `docs/alignment-requirements.md` |

有取舍、有争议、有 owner 的内容写入 `decisions.md`，例如：

- 组件体系破例。
- 设计和接口语义冲突。
- 后端暂不支持某个筛选项。
- 静态页面标记 `api-not-required`。
- 接受某个视觉差异或交互简化。

### 4. 人工 Gate

人工审核只改文档，不在聊天里做隐式批准。

| Gate | 通过条件 |
| --- | --- |
| Scope Gate | proposal/specs 明确范围、非目标、验收标准 |
| Design Gate | 设计结构、组件映射、状态和交互已确认 |
| Contract Gate | 字段、枚举、分页、错误码、权限已确认，或明确 `api-not-required` |
| Implementation Gate | 设计接口冲突已有决策，`decisions.md` 标记 `Approved` |
| Merge Gate | verification 和 review 没有阻塞项 |

状态只用：

- `Pending`
- `Approved`
- `Changes Required`
- `Blocked`

只要有未解决的 `Needs design/product/backend/component decision`，Implementation Gate 就不能是 `Approved`。

### 5. 生成 tasks.md

只有满足这些条件，才生成或更新 `tasks.md`：

- `proposal.md` / `specs/` 的范围和验收标准清楚。
- `docs/product-requirements.md` 已审核。
- `docs/design-requirements.md` 已审核。
- 涉及接口时，`docs/api-requirements.md` 已审核。
- `docs/alignment-requirements.md` 已审核。
- `decisions.md` 中 `Implementation Gate` 为 `Approved`。

不要在设计需求或接口需求还在变的时候提前生成任务清单。

生成 `tasks.md` 时必须使用 `assets/templates/frontend-tasks.md` 作为基础模板。只要任务涉及前端页面或组件实现，`tasks.md` 必须包含：

- 第一项任务：调用 `frontend-code-implementation` 并完成实现准入检查。
- 重新读取 active OpenSpec change 的事实文件、`decisions.md` 和 `tasks.md`。
- 重新读取精确 Figma node 的结构化上下文和截图。
- 明确 adapter/service/type、页面组件、状态覆盖、视觉验收和前端 Review 的执行项。

这样处理的原因是：`alignment-requirements.md` 是事实和决策输入，不是实现上下文缓存；写代码时必须二次读取 source of truth，避免 Agent 只凭聊天记忆或过期任务列表实现。

### 6. 执行开发

Gate 通过后，执行由当前环境可用的开发工具或 AI 助手主导。若环境支持下列能力，可按类似顺序使用；若不支持，也必须保留同等的计划、测试、review 和验证证据：

```text
brainstorming
→ writing-plans
→ using-git-worktrees
→ test-driven-development
→ requesting-code-review
→ receiving-code-review
→ verification-before-completion
→ finishing-a-development-branch
```

前端实现阶段的强制规则：

- 只要任务涉及前端页面或组件实现，实现计划必须把 `frontend-code-implementation` 作为第一个页面实现 checkpoint，不能直接进入页面代码编写。
- `frontend-code-implementation` 必须完成准入检查：读取 active OpenSpec change 的 `docs/product-requirements.md`、`docs/design-requirements.md`、`docs/api-requirements.md`、`docs/alignment-requirements.md`、`decisions.md` 和 `tasks.md`。
- 实现前必须读取精确 Figma node 的结构化设计上下文和截图；如果 Figma MCP 当前不可用，只能记录“待读取”或拆任务，不能开始声称按设计还原。
- `frontend-code-implementation` 必须先识别项目组件体系；仓库使用 Titan 时，才读取并遵守 `frontend-code-implementation/references/titan-component-map.md`。
- 验证必须包含真实浏览器截图或快照，并对照 Figma 关键区域；构建通过只算代码验证，不算视觉验收。

前端实现阶段技能顺序：

```text
frontend-code-implementation
frontend-visual-verification
frontend-code-review
```

如果开发中发现设计、接口或需求变化，先更新 OpenSpec change 和 `decisions.md`，再继续实现。

### 7. 验证后回到 OpenSpec

实现完成后先做证据式验证，再回到 OpenSpec 做一致性检查和归档：

```bash
openspec validate <change-id> --strict
openspec archive <change-id>
```

如果这次变更只是工具、流程或文档，不需要更新长期 specs，可以按需使用：

```bash
openspec archive <change-id> --skip-specs
```

归档前必须确认：

- `verification.md` 没有阻塞项。
- `review.md` 没有 P0/P1 阻塞项。
- 长期有效规则已经进入 `openspec/specs/` 或项目稳定文档。
- 临时讨论、截图、过程细节保留在 archived change，不污染长期 facts。

## 快速判断

| 场景 | 用什么主导 |
| --- | --- |
| 需求还不清楚 | OpenSpec explore/propose |
| 需求边界和验收标准 | OpenSpec |
| 页面怎么拆、接口怎么接 | frontend skills |
| 怎么拆任务和写代码 | 当前开发执行工具 / AI 助手 |
| 怎么证明完成 | 执行工具验证证据 + frontend visual verification |
| 完成后沉淀事实 | OpenSpec archive |

## 常见失败

- 让 OpenSpec `/opsx:apply` 和其他执行工具同时主导实现，导致执行规则打架。
- 把设计需求和接口需求合并，导致 AI 根据 UI 猜接口。
- 设计需求、接口需求或对齐结果只留在聊天里，没有写入 change 文件。
- 拆解不准时只在聊天里纠正，没有直接修改事实文件。
- 在事实文件和决策还没稳定前就生成 `tasks.md`。
- Gate 只在聊天里说通过，没有写入 `decisions.md`。
- 开发中发现事实变化，只改代码，不更新 change 文档。
- 验收完成后不 archive，长期 specs 没沉淀，下次 AI 仍然不知道项目事实。

## 资源

- `assets/templates/frontend-change-index.md`
- `assets/templates/frontend-decisions.md`
- `assets/templates/frontend-tasks.md`
- `assets/templates/frontend-verification.md`
