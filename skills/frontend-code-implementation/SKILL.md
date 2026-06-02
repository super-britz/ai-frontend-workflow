---
name: frontend-code-implementation
description: Use when 根据已确认的产品需求、UI 需求、接口需求、对齐结果和前端架构设计实现页面或组件代码；适用于 Figma URL、Figma node、设计稿截图、组件库优先、Vue/React/Vite/Next/Nuxt 页面实现。
---

# 前端代码实现

## 定位

把已确认的前端事实和架构设计翻译成当前仓库可维护、可联调、可验收的生产代码。

实现时优先使用项目已有组件、业务模式和样式 token，而不是照搬 Figma 导出的 React/Tailwind/绝对定位结构。

如果当前项目有单独维护的组件体系 skill 或约定，先读取那个 skill，再按它的规则实现；本 skill 不内嵌具体组件体系映射。

## 硬性边界

- 不在缺少 source of truth 时直接写代码。
- 不替产品、UI、接口或决策文件补事实。
- 不跳过 `design.md`、`decisions.md`、`tasks.md` 直接实现。
- 不把聊天摘要、历史分析或临场判断当成最终依据。
- 不把项目外的组件体系规则内嵌进本 skill。

## Source of Truth

按这个顺序确认实现依据：

1. 当前任务是否有 active OpenSpec change。
2. 是否存在对应的 `decisions.md`、`design.md`、`tasks.md`。
3. 产品、UI、接口和对齐事实是否已经稳定。
4. 仓库约定是否有额外限制，例如 `AGENTS.md`、`CLAUDE.md`、README、`docs/ai/`。
5. 如果项目有单独维护的组件体系 skill，先读取那个 skill。

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
2. 读取对应的事实文件、`design.md`、`decisions.md`、`tasks.md` 和仓库约定。
3. 如果任务涉及 Figma，读取 `ui-requirements.md` 或等价材料中的 UI 节点索引，再对照节点截图和结构化上下文。
4. 确认实现范围、文件边界、不做范围、架构边界和待确认问题都已经明确。
5. 按项目已有组件体系和仓库约定实现页面、组件和状态。
6. 接入真实数据、mock、loading、empty、error、disabled 和其他必要状态。
7. 用真实浏览器对照 Figma 或等价设计来源验证桌面端和移动端表现。
8. 运行项目中与改动相关的最小验证命令，并把结果写回对应产物文件。
9. 如果实现过程中发现事实变化，先回写 active change 或对应文档，再继续写代码。

## 实现规则

- 先找相邻实现，再写新代码。优先读取同模块、同页面类型、同交互模式的现有页面、组件、service、store、route、hook/composable 和测试。
- `design.md` 决定模块边界、状态归属、数据流和不做范围；`tasks.md` 决定执行顺序和验收命令。
- 优先在既有模块边界内改动；新增组件、hook/composable、service、store 或 adapter 必须有明确复用、隔离或架构理由。
- 不新增平行模式。请求封装、错误处理、权限、分页、筛选、表单提交、loading/empty/error 状态应贴近相邻代码。
- 组件选择遵守项目组件体系和已启用的组件体系 skill；不要根据设计稿外观猜 props、事件或 slot。
- 接口字段、枚举、错误码、权限和分页结构只来自 API 契约或明确决策，不从 UI、mock 或历史页面反推。
- UI 实现保留设计意图，但间距、颜色、字体、圆角和控件尺寸应归一到项目 token 或相邻页面模式。
- 完成后把验证结果写入 `verification.md` 或项目约定位置；无法验证的事项要明确记录。

## 验收前检查

- 事实文件齐了。
- `design.md` 齐了。
- `decisions.md` 里的阻塞项关掉了。
- `tasks.md` 的范围和验收方式清楚。
- 组件选择遵守仓库约定。
- 实现贴近相邻代码，没有新增并行模式。
- 改动只覆盖本次实现所需文件。

## 参考文件

- [repo-conventions.md](references/repo-conventions.md)
- [validation-checklist.md](references/validation-checklist.md)
