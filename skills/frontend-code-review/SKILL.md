---
name: frontend-code-review
description: Use when review 前端 diff、commit、PR 或指定文件；对照 product/design/api/alignment、decisions.md、design.md、tasks.md 和 verification.md 查找回归、契约漂移、组件体系偏离、状态缺失和验收缺口；只输出风险 findings，不写代码。
---

# 前端代码 Review

## 定位

对前端改动做风险导向审查，优先发现会导致线上问题、契约漂移、UI 行为回归、组件体系失控或验收不足的缺陷。

本 skill 只输出 review findings。它不实现代码、不补需求、不重新做视觉验收、不重写架构设计。

## 硬性边界

- 不审查无关历史问题。
- 不把个人风格、命名偏好或格式噪音放进主要 findings。
- 不用“应该更好”替代可触发、可定位、可修复的问题。
- 不直接改代码，除非用户明确要求修复。
- 不替代 `frontend-visual-verification`、`frontend-change-design` 或 `frontend-change-tasks`。
- 每个 finding 必须有文件/行号或明确 diff 位置；否则放入 residual risk。

## 输入

先确定 review 范围：

- 当前工作区 diff。
- 指定 commit。
- 指定 PR。
- 用户给出的文件或补丁。

再按需读取项目约束。项目约束指本仓库或 active change 中已经明确存在的 source of truth，包括：

- `openspec/changes/<change-id>/docs/*-requirements.md`
- `openspec/changes/<change-id>/decisions.md`
- `openspec/changes/<change-id>/design.md`
- `openspec/changes/<change-id>/tasks.md`
- `openspec/changes/<change-id>/verification.md`
- `docs/ai/*`
- `AGENTS.md`
- README 和开发文档
- 相邻页面、公共组件、service、store、route、hooks/composables
- `package.json`、TS/ESLint/Prettier、Vite/Next/Nuxt/Vue/React、路由、权限和 i18n 配置
- 已启用的组件体系 skill 或团队外部规则，例如 `frontend-titan-implementation`

如果没有这些文件，按当前代码库惯例审查，并在 residual risk 里说明依据不足。

## Review 顺序

1. 读取 diff，确认本次实际改了什么。
2. 读取相关 source of truth，确认改动应该实现什么。
3. 对照 `design.md`、requirements、decisions 和 tasks，检查代码有没有漂移。
4. 搜索相邻页面、组件、service、store、route 和测试，判断是否破坏既有模式。
5. 只输出本次改动引入或暴露的具体风险。

## 重点风险

- Source of truth drift：代码和 `design.md`、requirements、decisions 或 tasks 不一致。
- Contract drift：接口路径、请求参数、响应结构、错误码、权限、分页或类型和 API 契约不一致。
- UI behavior regression：loading、empty、error、permission、disabled、submitting、success、响应式或可访问性出现明显缺口。
- Component/system drift：绕过已有组件体系、重复造组件、破坏公共组件调用契约或引入平行模式。
- Verification gap：没有足够测试、build、typecheck、浏览器截图或 `verification.md` evidence 支撑改动安全。

## 输出格式

有问题时，按严重程度排序：

- P0：崩溃、数据错误、安全风险、关键流程不可用。
- P1：主要功能错误、接口契约错误、明显设计/交互回归。
- P2：边界状态缺失、响应式问题、可维护性明显退化。
- P3：低风险一致性问题或测试缺口。

每个 finding 包含：

- 标题。
- 文件和行号。
- 影响。
- 触发条件。
- 修复方向。

没有发现问题时，明确说明“未发现阻塞性问题”，并列出仍未验证的风险。

如果存在 active OpenSpec change，把 review 摘要写入：

```text
openspec/changes/<change-id>/review.md
```

## 常见失败

- 只看 build 是否通过，不看事实漂移。
- 把视觉验收重新做一遍，而不是检查已有 verification evidence。
- 把架构重新设计一遍，而不是检查代码是否遵守 `design.md`。
- 把无关历史问题混入本次 diff。
- 没有文件行号，导致反馈无法落地。

## 资源

- `assets/templates/frontend-review-report.md`
