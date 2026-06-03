---
name: frontend-code-implementation
description: Use when 根据已确认产品、UI、接口、对齐结果、Ready for tasks 的 design.md 和 tasks.md 实现页面或组件代码；适用于 Figma URL、设计稿截图、组件库优先、Vue/React/Vite/Next/Nuxt 页面实现；不补事实、不改决策、不重新设计、不越界实现。
---

# 前端代码实现

## 定位

把已确认的前端事实和架构设计翻译成当前仓库可维护、可联调、可验收的生产代码。

实现时优先使用项目已有组件、业务模式和样式 token，而不是照搬 Figma 导出的 React/Tailwind/绝对定位结构。

如果当前项目有单独维护的组件体系 skill 或约定，先读取那个 skill，再按它的规则实现；本 skill 不内嵌具体组件体系映射。

本 skill 是执行器：只在事实、Gate、`design.md` 和 `tasks.md` 都允许时写代码。发现缺口时回到对应 source of truth，不在实现中补决策。

## 硬性边界

- 不在缺少 source of truth 时直接写代码。
- 不替产品、UI、接口或决策文件补事实。
- 不跳过 `design.md`、`decisions.md`、`tasks.md` 直接实现。
- 不把聊天摘要、历史分析或临场判断当成最终依据。
- 不把项目外的组件体系规则内嵌进本 skill。
- 不重做 `frontend-change-design` 的模块边界、状态策略或集成策略。
- 不生成 `tasks.md` 未授权、`design.md` 未允许的文件或模块改动。
- 不越过 `Do Not Implement`；需要越界时先回到 `design.md` 或 `decisions.md`。
- 不用 mock、历史页面或 UI 猜接口字段、枚举、权限和错误码。

## Source of Truth

按这个顺序确认实现依据：

1. 当前任务是否有 active OpenSpec change。
2. `decisions.md` 是否明确 `Implementation Gate: Approved`。
3. `design.md` 是否明确 `Architecture status: Ready for tasks`，并包含 `Implementation Boundaries`、`State Strategy / Coverage Matrix`、`Integration Contract`、`Do Not Implement`。
4. `tasks.md` 是否包含 `frontend-code-implementation` handoff，并引用 `design.md`。
5. 产品、UI、接口和对齐事实是否已经稳定。
6. 仓库约定是否有额外限制，例如 `AGENTS.md`、`CLAUDE.md`、README、`docs/ai/`。
7. 如果项目有单独维护的组件体系 skill，先读取那个 skill。

OpenSpec 场景下优先读取：

- `openspec/changes/<change-id>/proposal.md`
- `openspec/changes/<change-id>/docs/product-requirements.md`
- `openspec/changes/<change-id>/docs/ui-requirements.md`
- `openspec/changes/<change-id>/docs/api-requirements.md`，除非已明确 `api-not-required`
- `openspec/changes/<change-id>/docs/alignment-requirements.md`
- `openspec/changes/<change-id>/decisions.md`
- `openspec/changes/<change-id>/design.md`
- `openspec/changes/<change-id>/tasks.md`

非 OpenSpec 场景优先读取：

- `docs/ai/product-requirements.md`
- `docs/ai/ui-requirements.md`
- `docs/ai/api-requirements.md`
- `docs/ai/alignment-requirements.md`
- 项目约定路径下的 `design.md` 或等价架构设计文档
- 用户明确提供的产品、UI、接口和对齐结论

## 工作流

1. 定位当前任务属于 OpenSpec 还是非 OpenSpec。
2. 读取对应的事实文件、`decisions.md`、`design.md`、`tasks.md` 和仓库约定。
3. 做实现准入检查：Gate approved、design ready、tasks handoff、source of truth 齐全。
4. 从 `design.md` 提取允许边界、禁止项、状态矩阵、集成契约和验证关注点。
5. 如果任务涉及 Figma，读取 `ui-requirements.md` 或等价材料中的 UI 节点索引，再对照节点截图和结构化上下文。
6. 读取相邻页面、组件、service、store、route、hook/composable 和测试，确认仓库既有模式。
7. 按 `tasks.md` 的 handoff 顺序，在 `design.md` 允许边界内实现页面、组件、数据接入和状态。
8. 用 `design.md` 的状态矩阵检查 loading、empty、error、permission、disabled、submitting、success、long text、responsive 等相关状态。
9. 用真实浏览器对照 Figma 或等价设计来源验证桌面端和移动端表现。
10. 运行项目中与改动相关的最小验证命令，并把结果写回对应产物文件。
11. 如果实现过程中发现事实变化、边界不够或契约冲突，先回写 active change 或对应文档，再继续写代码。

## 实现规则

- 先找相邻实现，再写新代码。优先读取同模块、同页面类型、同交互模式的现有页面、组件、service、store、route、hook/composable 和测试。
- `design.md` 决定模块边界、状态归属、数据流和不做范围；`tasks.md` 决定执行顺序和验收命令。
- 优先在既有模块边界内改动；新增组件、hook/composable、service、store 或 adapter 必须有明确复用、隔离或架构理由。
- 不新增平行模式。请求封装、错误处理、权限、分页、筛选、表单提交、loading/empty/error 状态应贴近相邻代码。
- 组件选择遵守项目组件体系和已启用的组件体系 skill；不要根据设计稿外观猜 props、事件或 slot。
- 接口字段、枚举、错误码、权限和分页结构只来自 API 契约或明确决策，不从 UI、mock 或历史页面反推。
- UI 实现保留设计意图，但间距、颜色、字体、圆角和控件尺寸应归一到项目 token 或相邻页面模式。
- 完成后把验证结果写入 `verification.md` 或项目约定位置；无法验证的事项要明确记录。

## Blocked 处理

遇到以下情况停止实现，说明阻塞来源，并指向应更新的文件：

- `Implementation Gate` 不是 `Approved`：回到 `decisions.md`。
- `design.md` 不是 `Ready for tasks` 或缺少边界、状态、集成契约：回到 `design.md`。
- `tasks.md` 缺少 handoff 或任务越过设计边界：回到 `tasks.md`。
- 产品、UI、API 或 alignment 缺事实：回到对应 `docs/*-requirements.md`。
- 实现必须修改 `Do Not Implement` 或禁止边界中的内容：回到 `design.md` 和 `decisions.md`。

## 验收前检查

- 事实文件齐了。
- `design.md` 齐了。
- `design.md` 是 `Ready for tasks`。
- `decisions.md` 里的阻塞项关掉了。
- `Implementation Gate` 是 `Approved`。
- `tasks.md` 的范围和验收方式清楚。
- `tasks.md` 的 handoff 引用了 `design.md`。
- 已读取并遵守 `Implementation Boundaries` 和 `Do Not Implement`。
- 已按 `State Strategy / Coverage Matrix` 覆盖本次相关状态。
- 组件选择遵守仓库约定。
- 实现贴近相邻代码，没有新增并行模式。
- 改动只覆盖本次实现所需文件。

## 参考文件

- [repo-conventions.md](references/repo-conventions.md)
- [validation-checklist.md](references/validation-checklist.md)
