# 前端 AI 工作流编排规则

## 总入口

- 新项目或老项目首次接入 AI：先运行 `Use $frontend-project-bootstrap 检查这个前端仓库，并生成或更新项目根目录 AGENTS.md。`
- 需求较大或边界不清时，先运行 `Use $frontend-change-planning 分析这个较大的前端需求，并输出 OpenSpec change 拆分规划。`
- 需要整理前端 OpenSpec change 的前端模板时，运行 `./scripts/init-frontend-openspec-change.sh <change-id>` 复制 `decisions.md`、`design.md`、`tasks.md`、`verification.md`、`review.md` 和 `frontend-change-index.md`。
- 后续所有前端任务，先读取本文件、`AGENTS.md`、`docs/ai/` 和 active OpenSpec change 下的项目规则。
- OpenSpec 负责项目事实和需求变更，Superpowers 负责执行过程和工程质量，frontend skills 负责前端专业判断。
- 重要分析结果必须写入文件；聊天上下文不能替代 `docs/*.md`、`decisions.md` 或 `tasks.md`。

## 流程护栏

- 完整 OpenSpec 链路用于新页面、复杂需求、接口联动、跨模块改造和需要 owner 决策的 change。
- 小范围文案、样式或单点 bugfix 可以走轻量路径：读取项目约定、必要事实和验证要求，记录关键结论，不强制创建完整 change。
- `docs/ui-requirements.md` 是 UI 事实；`design.md` 是前端架构设计和技术方案，不能混写。
- 事实变化回写 `docs/*-requirements.md`，取舍和 Gate 回写 `decisions.md`，执行顺序写 `tasks.md`，代码实现不补事实。
- 不确定项标记为 `Needs product/ui/backend decision`、`Blocked` 或 open question，不用实现假设填平缺口。
- 如果项目有外部组件体系 skill，在项目 `AGENTS.md` 中声明 skill 名称或本机安装方式；公共 workflow 不硬编码团队组件库路径。

## Skill 调用顺序

| 场景 | 必用 skill | 产物 |
| --- | --- | --- |
| 项目初始化 | `frontend-project-bootstrap` | `AGENTS.md` |
| 大需求拆分 | `frontend-change-planning` | `openspec/changes/change-plan.md` 或 `docs/ai/frontend-change-plan.md` |
| 需求事实和变更边界 | OpenSpec / 前端模板 | `openspec/changes/<change-id>/`、proposal、specs、Gate、decisions、tasks |
| 产品说明/PRD/Wiki | `frontend-requirements-product` | `docs/product-requirements.md` 或 `docs/ai/product-requirements.md` |
| Figma UI 拆解 | `frontend-requirements-ui` | `docs/ui-requirements.md` 或 `docs/ai/ui-requirements.md` |
| 接口文档/联调 | `frontend-requirements-api` | `docs/api-requirements.md` 或 `docs/ai/api-requirements.md` |
| 产品/UI/API 对齐 | `frontend-requirements-alignment` | `docs/alignment-requirements.md` 或 `docs/ai/alignment-requirements.md` |
| 决策与 Gate | `frontend-change-decisions` | `decisions.md` |
| 前端架构设计 | `frontend-change-design` | `design.md` |
| 执行任务清单 | `frontend-change-tasks` | `tasks.md` |
| 工程执行 | Superpowers | plan、tests、worktree、review、verification evidence |
| 需求确认后实现 | `frontend-code-implementation` | 页面代码、状态覆盖、组件实现 |
| 页面完成验收 | `frontend-visual-verification` | `verification.md`、截图或问题清单 |
| 合并前审查 | `frontend-code-review` | `review.md`、Review findings、未验证风险 |

## OpenSpec 文件职责

| 文件 | 职责 |
| --- | --- |
| `proposal.md` | 为什么做、做什么、不做什么 |
| `docs/product-requirements.md` | 产品事实 |
| `docs/ui-requirements.md` | UI 事实 |
| `docs/api-requirements.md` | 接口事实 |
| `docs/alignment-requirements.md` | 产品 / UI / API 对齐结果 |
| `decisions.md` | 已拍板和待拍板问题 |
| `design.md` | 前端架构设计 / 技术方案 |
| `tasks.md` | 执行清单 |
| `specs/**/spec.md` | 最终系统能力契约 |

## 标准开发链路

1. 明确需求、设计来源、接口来源和验收标准。
2. 需求较大或边界不清时，先用 `frontend-change-planning` 拆成多个 change 候选。
3. 若启用 OpenSpec，先创建或选择 active change，明确 scope、non-goals、验收标准。
4. 有 PRD、Wiki 或产品说明时先用 `frontend-requirements-product` 做产品事实拆解。
5. 有 Figma 时先用 `frontend-requirements-ui` 做 UI 拆解，不直接写页面。
6. 有接口时先用 `frontend-requirements-api` 沉淀接口契约摘录与缺口清单，不根据 UI 猜字段。
7. 人工审核事实文件；拆解或契约不准时直接修改 `docs/product-requirements.md`、`docs/ui-requirements.md`、`docs/api-requirements.md` 或 `docs/alignment-requirements.md`。
8. 用 `frontend-requirements-alignment` 对照产品、UI 和 API 事实，列出缺失与冲突差异；不明确项标记 `Needs product/ui/backend decision`。
9. 有取舍、争议或 owner 的内容用 `frontend-change-decisions` 写入 `decisions.md`，不要只留在聊天里。
10. Gate 阻塞项处理后，用 `frontend-change-design` 编写 `design.md` 前端架构设计。
11. 只有 `Implementation Gate: Approved` 才用 `frontend-change-tasks` 生成或更新 `tasks.md`。
12. 生成 `tasks.md` 时，涉及前端页面实现的任务必须把 `frontend-code-implementation` handoff 作为第一项实现任务。
13. 进入实现后由 Superpowers 主导 `writing-plans`、worktree、TDD、review 和完成前验证；页面代码修改前先调用 `frontend-code-implementation` 重新读取 active OpenSpec change、Figma 上下文和项目组件体系。
14. 开发中发现事实变化，先更新 OpenSpec change 和 `decisions.md`，再继续实现。
15. UI 改动必须做真实浏览器或截图验收，并把结论写入 `verification.md`。
16. 合并前做前端专项 Review，并把阻塞风险写入 `review.md`。
17. 验收后运行 OpenSpec validate/archive，把长期事实沉淀回 specs。

## 禁止事项

- 不绕过组件库自造基础 UI。
- 不根据 mock 或 UI 猜真实接口结构。
- 不在产品、UI 和接口对齐前直接写业务页面。
- 不在 `Implementation Gate` 未通过时进入页面实现。
- 不在事实文件稳定、`decisions.md` 明确、`design.md` 完成和 `Implementation Gate` 通过前生成 `tasks.md`。
- 不跳过 `frontend-code-implementation` 直接根据 `tasks.md` 写页面代码。
- 不用聊天记录代替 OpenSpec change 文件。
- 不用 build 通过代替视觉验收。
- 不把未验证的页面改动标记为完成。
- 不把项目特定临时规则写回公共 skill。

## 复盘沉淀

- 可复用规则沉淀到公共 skill 仓库。
- 项目特定规则沉淀到本项目 `AGENTS.md` 或 `docs/ai/`。
- 发现重复问题时，优先更新模板、检查清单或 CI，而不是只靠口头提醒。
