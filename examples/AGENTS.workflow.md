# 前端 AI 工作流编排规则

## 总入口

- 新项目或老项目首次接入 AI：先运行 `Use $frontend-project-bootstrap 初始化这个前端仓库的 Codex/Superpowers 协作规则、组件边界和验收护栏。`
- 需要按需求沉淀上下文或人工审核时，先运行 `Use $frontend-openspec-workflow 为这个前端需求创建或选择 OpenSpec change，并规划文档落点和人工 Gate。`
- 后续所有前端任务，先读取本文件、`AGENTS.md`、`docs/ai/` 和 active OpenSpec change 下的项目规则。
- 复杂需求先走 Superpowers 的 `brainstorming` 和 `writing-plans`，再进入实现。

## Skill 调用顺序

| 场景 | 必用 skill | 产物 |
| --- | --- | --- |
| 项目初始化 | `frontend-project-bootstrap` | `AGENTS.md`、`docs/ai/*` |
| 需求级文档编排 | `frontend-openspec-workflow` | `openspec/changes/<change-id>/`、人工 Gate、文档落点 |
| Figma 设计拆解 | `frontend-design-breakdown` | `docs/design-breakdown.md` 或 `docs/ai/design-breakdown.md` |
| 接口文档/联调 | `frontend-api-contract` | `docs/api-contract.md` 或 `docs/ai/api-contract.md` |
| 设计接口对齐 | `frontend-design-api-alignment` | `docs/design-api-alignment.md` 或 `docs/ai/design-api-alignment.md` |
| 设计确认后实现 | `frontend-titan-implementation` | 页面代码、状态覆盖、组件实现 |
| 页面完成验收 | `frontend-visual-verification` | `verification.md`、截图或问题清单 |
| 合并前审查 | `frontend-code-review` | `review.md`、Review findings、未验证风险 |

## 标准开发链路

1. 明确需求、设计来源、接口来源和验收标准。
2. 若启用 OpenSpec，先用 `frontend-openspec-workflow` 创建或选择 active change。
3. 有 Figma 时先用 `frontend-design-breakdown` 做设计拆解，不直接写页面。
4. 有接口时先用 `frontend-api-contract` 生成接口契约，不根据 UI 猜字段。
5. 用 `frontend-design-api-alignment` 对照设计拆解和接口契约，列出字段、状态、筛选、分页、权限、错误态差异；不明确项标记 `Needs decision`。
6. 人工审核 `decisions.md`，只有 `Implementation Gate: Approved` 才允许实现。
7. 对齐结果允许进入实现后，再用 `frontend-titan-implementation` 实现页面。
8. 实现时优先复用现有组件、service、types 和样式系统。
9. 完成后运行 lint、typecheck、test、build 等项目可用命令。
10. UI 改动必须做真实浏览器或截图验收。
11. 合并前做前端专项 Review。

## 禁止事项

- 不绕过组件库自造基础 UI。
- 不根据 mock 或 UI 猜真实接口结构。
- 不在设计拆解和接口契约对齐前直接写业务页面。
- 不在 `Implementation Gate` 未通过时进入页面实现。
- 不用 build 通过代替视觉验收。
- 不把未验证的页面改动标记为完成。
- 不把项目特定临时规则写回公共 skill。

## 复盘沉淀

- 可复用规则沉淀到公共 skill 仓库。
- 项目特定规则沉淀到本项目 `AGENTS.md` 或 `docs/ai/`。
- 发现重复问题时，优先更新模板、检查清单或 CI，而不是只靠口头提醒。
