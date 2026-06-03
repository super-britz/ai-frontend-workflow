# Tasks

## Editing Rules

- 本文件只记录执行清单，不承载产品、UI、接口或字段映射事实。
- 事实变化先更新 `docs/*-requirements.md`、`design.md` 或 `decisions.md`，再更新任务。
- `Implementation Gate` 通过前，不生成具体实现任务。
- `design.md` 未标记 `Ready for tasks` 前，不生成具体实现任务。
- Gate 批准必须来自用户、owner 或已有文档的明确指令。
- 每个实现任务必须引用 `design.md` 的边界、状态、集成契约或 handoff unit。
- 不在任务里新增 `design.md` 未允许的文件、模块、组件体系或接口策略。

## Readiness Check

| Check | Status | Evidence |
| --- | --- | --- |
| Active change id confirmed |  |  |
| `Implementation Gate: Approved` in `decisions.md` |  |  |
| `design.md` status is `Ready for tasks` |  |  |
| `Implementation Boundaries` present |  |  |
| `State Strategy / Coverage Matrix` present |  |  |
| `Integration Contract` present |  |  |
| `Do Not Implement` reviewed |  |  |
| `Handoff To Tasks` present |  |  |

## Required Handoff

如果本 change 涉及前端页面或组件实现，第一项实现任务使用：

```text
Use $frontend-code-implementation 根据 active OpenSpec change 中已确认的事实、Ready for tasks 的 design.md 和 tasks.md 执行前端实现；严格遵守 design.md 的 Implementation Boundaries、State Strategy / Coverage Matrix、Integration Contract 和 Do Not Implement。
```

实现准入、设计来源读取、组件体系、视觉验收和 Review 细节由后续专项流程处理。

## Design Handoff Index

| Task group | `design.md` reference | Boundary / state / contract | Verification focus |
| --- | --- | --- | --- |
|  |  |  |  |

## Task List

- [ ] Confirm active change id and source-of-truth files. Evidence: `proposal.md`, `docs/*-requirements.md`, `decisions.md`, `design.md`.
- [ ] Confirm `Implementation Gate: Approved` in `decisions.md`.
- [ ] Confirm `design.md` is `Ready for tasks` and review `Do Not Implement`.
- [ ] Run `frontend-code-implementation` handoff for page or component implementation.
- [ ] Implement approved frontend changes from the referenced design handoff units only.
- [ ] Run `frontend-visual-verification` against the states and viewports required by `design.md`; record evidence in `verification.md`.
- [ ] Run `frontend-code-review` against requirements, decisions, design, tasks, and verification evidence; record findings in `review.md`.
- [ ] Run `openspec validate <change-id> --strict`.

## Progress Notes

-
