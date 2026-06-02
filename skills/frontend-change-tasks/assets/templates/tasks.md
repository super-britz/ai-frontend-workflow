# Tasks

## Editing Rules

- 本文件只记录执行清单，不承载产品、UI、接口或字段映射事实。
- 事实变化先更新 `docs/*-requirements.md`、`design.md` 或 `decisions.md`，再更新任务。
- `Implementation Gate` 通过前，不生成具体实现任务。
- Gate 批准必须来自用户、owner 或已有文档的明确指令。

## Required Handoff

如果本 change 涉及前端页面或组件实现，第一项实现任务使用：

```text
Use $frontend-code-implementation 根据 active OpenSpec change 中已确认的事实、design.md 和 tasks.md 执行前端实现。
```

实现准入、设计来源读取、组件体系、视觉验收和 Review 细节由后续专项流程处理。

## Task List

- [ ] Confirm active change id and source-of-truth files.
- [ ] Confirm `Implementation Gate: Approved` in `decisions.md`.
- [ ] Confirm `design.md` is ready for implementation.
- [ ] Run `frontend-code-implementation` handoff for page or component implementation.
- [ ] Implement approved frontend changes.
- [ ] Run `frontend-visual-verification` and record evidence in `verification.md`.
- [ ] Run `frontend-code-review` and record findings in `review.md`.
- [ ] Run `openspec validate <change-id> --strict`.

## Progress Notes

-
