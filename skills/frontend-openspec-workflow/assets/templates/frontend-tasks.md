# Tasks

## Editing Rules

- 本文件只记录执行清单，不承载产品、设计、接口或字段映射事实。
- 事实变化先更新 `docs/*-requirements.md` 或 `decisions.md`，再更新任务。
- `Implementation Gate` 通过前，不生成具体实现任务。

## Required Handoff

如果本 change 涉及前端页面或组件实现，第一项实现任务使用：

```text
Use $frontend-code-implementation 根据 active OpenSpec change 中已确认的事实和 tasks.md 执行前端实现。
```

实现准入、设计来源读取、组件体系、视觉验收和 Review 细节由后续专项流程处理。

## Task List

- [ ] Confirm active change id and source-of-truth files.
- [ ] Complete or update required facts in `docs/*-requirements.md`.
- [ ] Record blocking decisions in `decisions.md`.
- [ ] Approve or block `Implementation Gate`.
- [ ] Add implementation handoff task after `Implementation Gate: Approved`.
- [ ] Record verification evidence in `verification.md`.
- [ ] Record review findings in `review.md`.
- [ ] Run `openspec validate <change-id> --strict`.

## Progress Notes

-
