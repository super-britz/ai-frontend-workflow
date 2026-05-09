---
name: frontend-openspec-workflow
description: Use when 将 OpenSpec/OPSX 接入前端 AI 开发工作流、创建或选择 openspec change、规划 proposal/specs/design/tasks/docs/decisions、记录人工审核 Gate、串联 frontend-design-breakdown、frontend-api-contract、frontend-design-api-alignment、frontend-titan-implementation、验收和 Review。
---

# 前端 OpenSpec 工作流

## 概览

把 OpenSpec 作为“需求级上下文容器”，让前端 AI 工作流围绕一个可审查、可归档的 change 运行。OpenSpec 管变更生命周期和文档位置，前端 skills 管专业内容。

这个 skill 不替代 `frontend-design-breakdown`、`frontend-api-contract` 或 `frontend-design-api-alignment`，也不直接实现业务代码。

## 核心原则

- 一个需求对应一个 OpenSpec change。
- 设计拆解和接口契约继续分开，禁止把设计稿当接口来源。
- 人工审核只审核文档和决策，不打断单个 skill 的分析过程。
- 没有明确 active change 时，不把产物散落到多个路径。
- 没有 `Implementation Gate: Approved` 时，不进入页面实现。
- 完成后把长期有效规则沉淀回 `openspec/specs/` 或项目文档，临时讨论留在 change 里。

## 何时使用

- 用户提到 OpenSpec、OPSX、spec-driven、change、proposal、archive。
- 前端需求需要同时处理设计稿、接口文档、人工审核和实现。
- 希望把 `docs/ai/*` 产物改为按需求归档。
- 需要给已有前端 AI 工作流增加人工 Gate 和可追踪上下文。

不需要 OpenSpec 时，继续使用 `docs/ai/` 作为默认产物目录。

## Change 目录约定

如果仓库启用 OpenSpec，优先使用：

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

说明：

- `proposal.md`、`specs/`、`design.md`、`tasks.md` 保持 OpenSpec 原生语义。
- `docs/` 放前端专项分析产物，避免把细节塞进核心 specs。
- `decisions.md` 记录人工审核 Gate 和 owner 决策。
- `verification.md` 记录视觉、浏览器、测试和构建验收。
- `review.md` 记录前端专项 Review 结论。

可用 `assets/templates/frontend-change-index.md` 和 `assets/templates/frontend-decisions.md` 初始化缺失文档。

## 工作流程

### 1. 选择或创建 change

先确认 active change：

- 用户是否给了 `<change-id>`。
- 仓库是否已有 `openspec/changes/<change-id>/`。
- OpenSpec/OPSX 命令是否已经创建 proposal。

如果没有 active change，先建议或创建一个稳定的 kebab-case 名称，例如 `order-list-page`。不要在多个 change 之间混写文档。

### 2. 建立文档落点

启用 OpenSpec 时，各 skill 的默认输出改为：

| 内容 | 路径 |
| --- | --- |
| 设计拆解 | `openspec/changes/<change-id>/docs/design-breakdown.md` |
| 接口契约 | `openspec/changes/<change-id>/docs/api-contract.md` |
| 设计接口对齐 | `openspec/changes/<change-id>/docs/design-api-alignment.md` |
| 人工决策 | `openspec/changes/<change-id>/decisions.md` |
| 实现计划 | `openspec/changes/<change-id>/tasks.md` |
| 视觉验收 | `openspec/changes/<change-id>/verification.md` |
| 前端 Review | `openspec/changes/<change-id>/review.md` |

没有 OpenSpec change 时，保留现有 `docs/ai/*.md` 路径。

### 3. 运行前端专项 skills

推荐顺序：

```text
frontend-openspec-workflow
→ frontend-design-breakdown
→ frontend-api-contract
→ frontend-design-api-alignment
→ writing-plans
→ frontend-titan-implementation
→ frontend-visual-verification
→ frontend-code-review
```

其中：

- `frontend-design-breakdown` 只回答设计要求，不写代码。
- `frontend-api-contract` 只回答接口事实，不写页面。
- `frontend-design-api-alignment` 对齐设计和接口，并输出是否允许实现。
- `frontend-titan-implementation` 只能在 Gate 通过后读取文档实现。

### 4. 人工审核 Gate

人工审核写入 `decisions.md`，不要只留在聊天里。

建议三道 Gate：

| Gate | 前置产物 | 允许继续的条件 |
| --- | --- | --- |
| Design Review | `docs/design-breakdown.md` | 页面结构、组件映射、状态和交互已确认 |
| Contract Review | `docs/api-contract.md` | 字段、枚举、分页、错误码、权限已确认，或明确不涉及接口 |
| Implementation Gate | `docs/design-api-alignment.md` | 冲突已有决策，状态为 `Approved` |

状态只使用：

- `Pending`
- `Approved`
- `Changes Required`
- `Blocked`

只要存在未解决的 `Needs design/product/backend/component decision`，Implementation Gate 就不能是 `Approved`。纯静态页面必须在 `decisions.md` 记录 `api-not-required` 的原因。

### 5. 实现和验收

实现前必须读取：

- `proposal.md`
- `docs/design-breakdown.md`
- `docs/api-contract.md`，若有接口
- `docs/design-api-alignment.md`
- `decisions.md`
- `tasks.md`，若已有计划

实现后写入或更新：

- `verification.md`：命令、视口、状态、截图、未验证项。
- `review.md`：前端专项 Review 结论和阻塞问题。

### 6. 归档

完成后再归档 change。归档前确认：

- `verification.md` 没有阻塞项。
- `review.md` 没有 P0/P1 阻塞项。
- 长期有效的产品规则、接口规则、组件映射或验收规则已同步到 `openspec/specs/` 或项目 `docs/ai/`。
- 临时方案、讨论过程和历史截图保留在 archived change 中。

## 与其他 skill 的关系

- 项目初始化：`frontend-project-bootstrap`
- 设计拆解：`frontend-design-breakdown`
- 接口契约：`frontend-api-contract`
- 设计接口对齐：`frontend-design-api-alignment`
- 实现：`frontend-titan-implementation`
- 验收：`frontend-visual-verification`
- Review：`frontend-code-review`

## 常见失败

- 把 `frontend-design-breakdown` 和 `frontend-api-contract` 合并，导致 AI 根据 UI 猜接口。
- 只创建 proposal，不记录人工 Gate，后续实现仍然靠聊天上下文。
- 有多个 active change，产物路径混乱。
- `Needs decision` 没解决就进入实现。
- 实现完成后没有把长期规则从 change 归档回稳定规格。

## 资源

- `assets/templates/frontend-change-index.md`
- `assets/templates/frontend-decisions.md`
- `assets/templates/frontend-verification.md`
