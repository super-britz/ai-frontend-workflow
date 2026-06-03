---
name: frontend-change-tasks
description: Use when 根据已批准的前端 OpenSpec change 和 Ready for tasks 的 design.md 维护 tasks.md；在 Implementation Gate Approved 后，把架构契约拆成实现、验证、review 和 OpenSpec validate 清单；不补事实、不改决策、不重新设计、不写代码。
---

# 前端 Change 任务清单

## 定位

维护当前 OpenSpec change 的 `tasks.md`，把已批准的前端架构契约拆成可执行清单。

`tasks.md` 是执行清单，不是第二份 `design.md`，也不是需求事实补丁。

本 skill 只回答：

- 实现阶段要按什么顺序做。
- 哪些任务交给 `frontend-code-implementation`。
- 哪些验证、review 和 OpenSpec validate 必须记录。
- 哪些任务仍被 Gate 或决策阻塞。
- 每个实现任务对应 `design.md` 的哪个边界、状态、集成契约或 handoff unit。

它不做需求事实沉淀、owner 决策、架构设计或代码实现。

## 硬性边界

- `Implementation Gate` 未 `Approved` 时，不生成具体实现任务；只保留阻塞项和准备项。
- `design.md` 未标记 `Ready for tasks` 时，不生成具体实现任务；只记录阻塞项。
- 不修改 `decisions.md` 的 Gate 状态。
- 不新增产品、UI、API 或 alignment 事实。
- 不重新设计 module boundary、state strategy、integration contract 或文件边界。
- 不写业务代码、types、service、mock、fixtures 或测试。
- 不把不明确问题写成可执行任务。
- 不跳过 required handoff；涉及前端页面或组件实现时，第一项实现任务必须调用 `frontend-code-implementation`。
- 不在任务里加入 `design.md` 未允许的文件、模块或公共组件改动。

## 准入条件

只有同时满足以下条件，才生成具体实现任务：

- `decisions.md` 明确 `Implementation Gate: Approved`。
- `design.md` 明确 `Architecture status: Ready for tasks`。
- `design.md` 已提供 `Implementation Boundaries`、`State Strategy / Coverage Matrix`、`Integration Contract`、`Do Not Implement` 和 `Handoff To Tasks`。
- 实现任务能引用 `design.md` 的 section、表格行或 handoff unit。

如果任一条件不满足，`tasks.md` 只记录准备项和阻塞项，不把缺口补成任务。

## 输入

优先读取 active OpenSpec change 中的：

- `proposal.md`
- `design.md`
- `decisions.md`
- `docs/product-requirements.md`
- `docs/ui-requirements.md`
- `docs/api-requirements.md`
- `docs/alignment-requirements.md`
- 现有 `tasks.md`

只有当 `decisions.md` 明确 `Implementation Gate: Approved`，且 `design.md` 明确 `Architecture status: Ready for tasks`，才生成实现任务。

## 输出

使用 `assets/templates/tasks.md` 作为基础模板，输出或更新：

```text
openspec/changes/<change-id>/tasks.md
```

任务清单应包含：

- Gate 和来源确认。
- `design.md` readiness 和 handoff unit 引用。
- `frontend-code-implementation` handoff，必须携带允许边界、禁止项和验证关注点。
- 代码实现任务。
- 视觉验收任务。
- 前端 Review 任务。
- OpenSpec validate 任务。

## 任务拆分原则

- 按可验证的工程增量拆，不按聊天步骤拆。
- 每个任务都应能被完成、验证或标记 blocked。
- 每个实现任务引用 `design.md`，不要从 requirements 或聊天上下文重新推理架构。
- 任务只写做什么、验证什么、产物写哪里；不写为什么这样设计。
- 发现事实变化时，任务应指向回写来源文件，而不是在 `tasks.md` 内修正事实。
- 任务不得越过 `Do Not Implement`，不得触碰 `Implementation Boundaries` 禁止区域。
- 验证任务必须引用 `design.md` 的状态矩阵和测试验收关注点。

## 最终回复

说明：

- `tasks.md` 路径。
- 是否已生成实现任务。
- 仍被 Gate 阻塞的事项。
- 下一步 handoff。

## 资源

- `assets/templates/tasks.md`
