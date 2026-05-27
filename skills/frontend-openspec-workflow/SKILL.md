---
name: frontend-openspec-workflow
description: Use when 一个前端需求需要进入 OpenSpec 管理；创建或整理 active change 的文件结构、事实文档落点、decisions、tasks、Gate 状态和 validate/archive 检查。
---

# 前端 OpenSpec 编排

## 目标

把一个前端需求放进清晰的 OpenSpec change 中，明确哪些文件负责范围、事实、决策、任务和验证。

本 skill 只编排 OpenSpec change。产品拆解、设计拆解、接口拆解、字段对齐、代码实现、视觉验收和前端 Review 由对应专项流程处理。

## 何时使用

- 用户要求用 OpenSpec、OPSX、change、proposal、spec、tasks 或 archive 管理前端需求。
- 一个需求涉及产品、设计、接口、权限、状态或验收，需要留下可审查的事实文件。
- 现有 change 文件散乱，需要整理文件职责、Gate 状态或任务入口。

如果只是很小的代码修复，且不需要沉淀需求事实，可以不创建 OpenSpec change。

## Change 文件结构

推荐结构：

```text
openspec/changes/<change-id>/
  proposal.md
  design.md
  tasks.md
  decisions.md
  verification.md
  review.md
  docs/
    product-requirements.md
    design-requirements.md
    api-requirements.md
    alignment-requirements.md
  specs/
```

文件职责：

- `proposal.md`：为什么做、做什么、不做什么、验收口径。
- `design.md`：工程实现策略，不放产品正文、Figma 细节或接口字段表。
- `specs/**/spec.md`：最终能力契约和验收级 scenario。
- `docs/product-requirements.md`：产品事实。
- `docs/design-requirements.md`：设计事实和设计来源索引。
- `docs/api-requirements.md`：接口事实。
- `docs/alignment-requirements.md`：产品 / UI / API 对齐结果。
- `decisions.md`：取舍、owner、Gate 状态和决策记录。
- `tasks.md`：执行清单，只在事实和决策稳定后生成或更新。
- `verification.md` / `review.md`：验证和 Review 结论。

## 工作流程

### 1. 定位 change

- 如果用户给了 change id，使用该 change。
- 如果仓库已有相关 active change，先读取并复用。
- 如果没有合适 change，建议创建新的 `<verb>-<short-topic>` change id。
- 如果需求还不清楚，先停在 proposal / explore 阶段，不生成执行任务。

### 2. 建立文件骨架

按实际需要创建或补齐：

- `docs/` 下的事实文件落点。
- `decisions.md`，使用 `assets/templates/frontend-decisions.md`。
- `tasks.md`，使用 `assets/templates/frontend-tasks.md`。
- `verification.md`，使用 `assets/templates/frontend-verification.md`。
- 可选索引文件，使用 `assets/templates/frontend-change-index.md`。

不要把专项 skill 的完整产物复制进本 skill。这里只建立位置、状态和入口。

### 3. 更新 Gate

Gate 状态只使用：

- `Pending`
- `Approved`
- `Changes Required`
- `Blocked`

推荐 Gate：

- Scope Gate：范围、非目标和验收口径已确认。
- Product Gate：产品事实已确认，或不需要产品拆解。
- Design Gate：设计来源和设计事实已确认，或不涉及设计。
- Contract Gate：接口事实已确认，或明确 `api-not-required`。
- Alignment Gate：产品 / UI / API 差异已有处理结论。
- Implementation Gate：允许生成或更新实现任务。
- Merge Gate：验证和 Review 没有阻塞项。

未确认的问题写入 `decisions.md`，不要只留在聊天里。

### 4. 管理 tasks

`tasks.md` 只记录执行清单，不承载需求事实。

只有在事实文件稳定、必要 Gate 通过后，才生成或更新实现任务。涉及前端页面或组件实现时，第一项任务只保留 handoff：

```text
Use $frontend-code-implementation 根据 active OpenSpec change 中已确认的事实和 tasks.md 执行前端实现。
```

具体实现准入、Figma 读取、组件体系、浏览器验证和 Review 细节由后续专项流程处理。

### 5. Validate / Archive

在阶段结束时提醒运行：

```bash
openspec validate <change-id> --strict
```

需求完成并确认长期事实后，再归档：

```bash
openspec archive <change-id>
```

如果只是流程或文档调整，且不更新长期 specs，可按项目规则使用 `--skip-specs`。

## 最终回复

说明：

- active change id 和路径。
- 创建或更新了哪些 OpenSpec 文件。
- 当前 Gate 状态。
- 仍需 owner 确认的问题。
- 下一步应该调用哪个专项流程或执行哪条 OpenSpec 命令。

## 资源

- `assets/templates/frontend-change-index.md`
- `assets/templates/frontend-decisions.md`
- `assets/templates/frontend-tasks.md`
- `assets/templates/frontend-verification.md`
