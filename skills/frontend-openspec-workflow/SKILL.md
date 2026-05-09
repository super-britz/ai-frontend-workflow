---
name: frontend-openspec-workflow
description: Use when 将 OpenSpec/OPSX、Superpowers 和前端专项 skills 组合到同一个前端需求流程；处理 openspec change、specs、proposal、tasks、decisions、validate、archive、人工 Gate、需求事实沉淀、执行纪律和前端设计接口实现边界。
---

# 前端 OpenSpec 工作流

## 概览

最推荐的组合方式：

```text
OpenSpec = 项目事实和需求变更账本
Superpowers = 开发执行和工程质量引擎
frontend skills = 前端专业判断和产物生成插件
```

OpenSpec 不负责替你写完整流程，Superpowers 不负责长期沉淀项目事实，frontend skills 不负责管理需求生命周期。三者是分层协作，不是互相替代。

## 职责边界

| 层 | 主职责 | 典型产物 | 不做什么 |
| --- | --- | --- | --- |
| OpenSpec | 需求边界、项目事实、变更生命周期 | `openspec/specs/`、`openspec/changes/<change>/`、proposal、design、tasks | 不替代工程执行纪律 |
| Superpowers | 计划、TDD、worktree、review、verification、finish branch | plan、测试、代码、验证证据、PR/合并决策 | 不当长期事实库 |
| frontend skills | 设计拆解、接口契约、设计接口对齐、Titan 实现、视觉验收、前端 Review | `docs/design-breakdown.md`、`docs/api-contract.md`、`verification.md`、`review.md` | 不跨越人工 Gate |

判断原则：**OpenSpec 说清楚做什么，Superpowers 管怎么可靠地做完，frontend skills 补齐前端领域专业性。**

## 推荐主流程

### 0. 项目初始化

新项目或老项目首次接入时：

```bash
openspec init
```

然后用 `frontend-project-bootstrap` 写清项目级 AI 规则、组件边界、命令和验收要求。

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
    design-breakdown.md
    api-contract.md
    design-api-alignment.md
  decisions.md
  verification.md
  review.md
```

对应关系：

| 文档 | 由谁产出 |
| --- | --- |
| `docs/design-breakdown.md` | `frontend-design-breakdown` |
| `docs/api-contract.md` | `frontend-api-contract` |
| `docs/design-api-alignment.md` | `frontend-design-api-alignment` |
| `decisions.md` | 人工审核和 owner 决策 |
| `verification.md` | `frontend-visual-verification` |
| `review.md` | `frontend-code-review` |

如果需求不需要 OpenSpec，继续使用 `docs/ai/*.md`，不要强行建 change。

### 3. 人工 Gate

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

### 4. Superpowers 执行开发

Gate 通过后，执行由 Superpowers 主导：

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

前端实现阶段再按需调用：

```text
frontend-titan-implementation
frontend-visual-verification
frontend-code-review
```

如果开发中发现设计、接口或需求变化，先更新 OpenSpec change 和 `decisions.md`，再继续实现。

### 5. 验证后回到 OpenSpec

实现完成后先用 Superpowers 做证据式验证，再回到 OpenSpec 做一致性检查和归档：

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
| 怎么拆任务和写代码 | Superpowers |
| 怎么证明完成 | Superpowers verification + frontend visual verification |
| 完成后沉淀事实 | OpenSpec archive |

## 常见失败

- 让 OpenSpec `/opsx:apply` 和 Superpowers 同时主导实现，导致执行规则打架。
- 把设计拆解和接口契约合并，导致 AI 根据 UI 猜接口。
- Gate 只在聊天里说通过，没有写入 `decisions.md`。
- 开发中发现事实变化，只改代码，不更新 change 文档。
- 验收完成后不 archive，长期 specs 没沉淀，下次 AI 仍然不知道项目事实。

## 资源

- `assets/templates/frontend-change-index.md`
- `assets/templates/frontend-decisions.md`
- `assets/templates/frontend-verification.md`
