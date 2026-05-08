# 前端 AI 工作流编排规则

## 总入口

- 新项目或老项目首次接入 AI：先运行 `Use $frontend-project-bootstrap 初始化这个前端仓库的 Codex/Superpowers 协作规则、组件边界和验收护栏。`
- 后续所有前端任务，先读取本文件、`AGENTS.md` 和 `docs/ai/` 下的项目规则。
- 复杂需求先走 Superpowers 的 `brainstorming` 和 `writing-plans`，再进入实现。

## Skill 调用顺序

| 场景 | 必用 skill | 产物 |
| --- | --- | --- |
| 项目初始化 | `frontend-project-bootstrap` | `AGENTS.md`、`docs/ai/*` |
| Figma 页面实现 | `figma-titan-to-code` | 页面代码、组件映射、状态覆盖 |
| 接口文档/联调 | `frontend-api-contract` | `docs/ai/api-contract.md`、types、service、mock 规则 |
| 页面完成验收 | `frontend-visual-verification` | 视觉验收结论、截图或问题清单 |
| 合并前审查 | `codex-review-frontend` | Review findings、未验证风险 |

## 标准开发链路

1. 明确需求、设计来源、接口来源和验收标准。
2. 有 Figma 时先做组件映射，不直接写页面。
3. 有接口时先生成接口契约，不根据 UI 猜字段。
4. 实现时优先复用现有组件、service、types 和样式系统。
5. 完成后运行 lint、typecheck、test、build 等项目可用命令。
6. UI 改动必须做真实浏览器或截图验收。
7. 合并前做前端专项 Review。

## 禁止事项

- 不绕过组件库自造基础 UI。
- 不根据 mock 或 UI 猜真实接口结构。
- 不用 build 通过代替视觉验收。
- 不把未验证的页面改动标记为完成。
- 不把项目特定临时规则写回公共 skill。

## 复盘沉淀

- 可复用规则沉淀到公共 skill 仓库。
- 项目特定规则沉淀到本项目 `AGENTS.md` 或 `docs/ai/`。
- 发现重复问题时，优先更新模板、检查清单或 CI，而不是只靠口头提醒。
