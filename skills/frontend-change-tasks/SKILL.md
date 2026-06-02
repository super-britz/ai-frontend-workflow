---
name: frontend-change-tasks
description: Use when 根据已批准的前端 OpenSpec change、decisions.md 和 design.md 维护 tasks.md；在 Implementation Gate Approved 后生成实现任务、验证任务和 handoff；不补需求事实、不改决策、不写代码。
---

# 前端 Change 任务清单

## 定位

维护当前 OpenSpec change 的 `tasks.md`，把已批准的前端架构设计拆成可执行清单。

本 skill 只回答：

- 实现阶段要按什么顺序做。
- 哪些任务交给 `frontend-code-implementation`。
- 哪些验证、review 和 OpenSpec validate 必须记录。
- 哪些任务仍被 Gate 或决策阻塞。

它不做需求事实沉淀、owner 决策、架构设计或代码实现。

## 硬性边界

- `Implementation Gate` 未 `Approved` 时，不生成具体实现任务；只保留阻塞项和准备项。
- 不修改 `decisions.md` 的 Gate 状态。
- 不新增产品、UI、API 或 alignment 事实。
- 不写业务代码、types、service、mock、fixtures 或测试。
- 不把不明确问题写成可执行任务。
- 不跳过 required handoff；涉及前端页面或组件实现时，第一项实现任务必须调用 `frontend-code-implementation`。

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

只有当 `decisions.md` 明确 `Implementation Gate: Approved`，才生成实现任务。

## 输出

使用 `assets/templates/tasks.md` 作为基础模板，输出或更新：

```text
openspec/changes/<change-id>/tasks.md
```

任务清单应包含：

- Gate 和来源确认。
- `frontend-code-implementation` handoff。
- 代码实现任务。
- 视觉验收任务。
- 前端 Review 任务。
- OpenSpec validate 任务。

## 任务拆分原则

- 按可验证的工程增量拆，不按聊天步骤拆。
- 每个任务都应能被完成、验证或标记 blocked。
- 任务引用事实文件或 `design.md`，不要复制大段事实。
- 发现事实变化时，任务应指向回写来源文件，而不是在 `tasks.md` 内修正事实。

## 最终回复

说明：

- `tasks.md` 路径。
- 是否已生成实现任务。
- 仍被 Gate 阻塞的事项。
- 下一步 handoff。

## 资源

- `assets/templates/tasks.md`
