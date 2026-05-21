# Tasks

## Editing Rules

- 本文件只记录执行任务，不承载产品、设计、接口或字段映射事实。
- 只有事实文件稳定、`decisions.md` 中 `Implementation Gate: Approved` 后，才生成或更新本文件。
- 如果任务涉及前端页面或组件实现，第一组实现任务必须先调用 `frontend-code-implementation`。
- 实现时必须重新读取 active OpenSpec change，不依赖聊天摘要或上一次分析记忆。

## Required Implementation Handoff

在开始任何页面代码修改前，执行：

```text
Use $frontend-code-implementation 根据 active OpenSpec change 中已确认的产品需求、设计需求、接口需求、设计接口对齐结果和 tasks.md，实现前端页面。
```

`frontend-code-implementation` 必须重新读取：

- `proposal.md`
- `specs/**/spec.md`
- `docs/product-requirements.md`
- `docs/design-requirements.md`
- `docs/api-requirements.md`
- `docs/alignment-requirements.md`
- `decisions.md`
- `tasks.md`
- 精确 Figma node 的结构化上下文和截图
- 项目组件体系；若仓库使用 Titan，再读取 Titan 映射规则

如果上述输入缺失或 `Implementation Gate` 不是 `Approved`，停止实现并回到事实文件或决策文件补齐。

## Task List

- [ ] Implementation handoff: invoke `frontend-code-implementation` and complete its admission checks.
- [ ] Re-read active OpenSpec change files and confirm source of truth.
- [ ] Re-read exact Figma node context and screenshot before page code changes.
- [ ] Map page structure to existing project routes, components, services, stores and style tokens.
- [ ] Implement service/adapter/type changes required by `docs/alignment-requirements.md`.
- [ ] Implement page/component changes using the project component system first; if the repo uses Titan, apply Titan mapping rules.
- [ ] Cover default, loading, empty, error, permission, disabled and success states.
- [ ] Run available code checks.
- [ ] Run `frontend-visual-verification` and write results to `verification.md`.
- [ ] Run `frontend-code-review` and write findings to `review.md`.
- [ ] Run `openspec validate <change-id> --strict`.

## Progress Notes

-
