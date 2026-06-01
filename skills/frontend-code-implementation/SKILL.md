---
name: frontend-code-implementation
description: Use when 根据已确认的产品需求、设计需求、接口需求和对齐需求结果，实现前端页面或组件代码；适用于 Figma URL、Figma node、设计稿截图、组件库优先、Vue/React/Vite/Next/Nuxt 页面实现。
---

# 前端代码实现

## 目标

把 Figma 中的精确设计节点，或已确认的前端需求，翻译成当前仓库可维护、可联调、可验收的生产代码。实现时优先使用项目已有组件体系、业务模式和样式 token，而不是照搬 Figma 导出的 React/Tailwind/绝对定位结构。

Titan 只是组件体系分支之一：当仓库使用 `@ninebot/pc-titan-components`、已有 `Ti*` 组件注册，或项目规则明确要求 Titan 时，才启用 Titan 映射表。其他项目按当前仓库的默认组件库和已有页面模式实现。

## 实现准入

当本 skill 被 `AGENTS.md`、`tasks.md` 或用户明确要求为强制步骤时，它不是可选优化，而是前端页面实现的前置 Gate。未完成本节检查前，不得新增或修改页面实现代码。

先判断当前任务是否启用 OpenSpec。判断依据包括：

- 用户明确指定 active OpenSpec change。
- 仓库 `AGENTS.md`、`docs/ai/` 或任务文件要求使用 OpenSpec。
- 存在与本任务对应的 `openspec/changes/<change-id>/`，且 `tasks.md` 或 `decisions.md` 已把本页面列入执行范围。

如果无法唯一确认 active change，先从 `openspec list`、`openspec/changes/`、用户描述和当前分支名中定位；仍不明确时，停止实现并让用户确认 change。

### 使用 OpenSpec 时

实现前必须读取 active change 中的 source of truth：

- `openspec/changes/<change-id>/proposal.md`
- `openspec/changes/<change-id>/docs/product-requirements.md`
- `openspec/changes/<change-id>/docs/design-requirements.md`
- `openspec/changes/<change-id>/docs/api-requirements.md`，除非已明确 `api-not-required`
- `openspec/changes/<change-id>/docs/alignment-requirements.md`
- `openspec/changes/<change-id>/decisions.md`
- `openspec/changes/<change-id>/tasks.md`
- 相关 `openspec/changes/<change-id>/specs/**/spec.md`

进入代码前必须确认：

- `decisions.md` 中 `Implementation Gate` 为 `Approved`。
- `tasks.md` 已在事实文件稳定和 Gate 通过后生成或更新。
- `tasks.md` 中本次实现范围、文件边界和验收命令清楚。
- `design-requirements.md` 中存在可重读的 UI 节点索引、设计来源索引或等价 Figma source 信息。
- `alignment-requirements.md` 没有阻塞实现的 `Needs product/design/backend/component decision`。
- 如果接口不参与，本结论已在事实文件或决策文件中标记 `api-not-required`。

OpenSpec 场景下，聊天摘要、历史分析和 `tasks.md` 的简短描述都不能替代上述文件。若实现中发现事实变化，先更新对应事实文件或 `decisions.md`，再继续写代码。

### 未使用 OpenSpec 时

如果当前任务没有启用 OpenSpec，则使用项目稳定文档或用户明确输入作为 source of truth。实现前必须确认至少有以下输入之一：

- `docs/ai/product-requirements.md`、`docs/ai/design-requirements.md`、`docs/ai/api-requirements.md`、`docs/ai/alignment-requirements.md`
- 项目其他约定路径下的等价需求文档
- 用户在当前任务中明确提供的产品需求、设计需求、接口需求和对齐决策

非 OpenSpec 场景仍需满足：

- 有产品目标、页面范围和验收口径。
- 有设计来源，例如 Figma node、设计截图、原型或明确的现有页面参照；如果使用 Figma，`design-requirements.md` 或等价材料应保存可重读的 UI 节点索引。
- 涉及接口数据时，有接口字段、状态、错误码、权限和分页/筛选规则；无接口时明确 `api-not-required`。
- 产品、UI/设计和 API 存在差异时，有字段映射、adapter 决策和待确认问题处理结论。

缺少上述上游产物时，不要直接写代码；先建议补齐 `frontend-requirements-product`、`frontend-requirements-design`、`frontend-requirements-api` 或 `frontend-requirements-alignment` 产物。

## 工作流

### 使用 OpenSpec 时

1. 定位 active change，并读取 `proposal.md`、`docs/*-requirements.md`、`decisions.md`、`tasks.md` 和相关 `specs/**/spec.md`。
2. 执行 OpenSpec 准入检查；如果 `Implementation Gate` 未通过或有阻塞决策，停止实现并回到事实文件或决策文件。
3. 从 `tasks.md` 中确认本次要实现的任务编号、文件范围、验收命令和不做范围。
4. 若任务涉及 Figma，从 `design-requirements.md` 的 UI 节点索引和设计来源索引中确认要实现的精确 frame/node。
5. 重新读取这些 Figma 节点的结构化设计上下文和同一节点截图；如果上下文过大，先读取节点结构，再缩小到关键子节点。
6. 对比二次读取结果和 `design-requirements.md`：如果节点缺失、截图明显变化、状态变体不一致或关键视觉事实冲突，停止实现并更新设计需求或请求 owner 决策。
7. 读取当前仓库规则，例如 `AGENTS.md`、`CLAUDE.md`、`.cursorrules`、README 和 `docs/ai/`，确认它们是否补充或约束 active change。
8. 检查项目技术栈、组件库、路由、状态管理、请求封装、i18n、权限、mock 和页面模板。
9. 判断组件体系：
   - 如果仓库使用 `@ninebot/pc-titan-components`、已有 `Ti*` 组件或项目规则要求 Titan，先读取 `references/titan-component-map.md` 入口索引和 `references/titan-components/common.md`，再按入口索引只读取本次涉及的组件族文件。
   - 如果仓库使用 Ant Design、Element Plus、Naive UI、Arco、Material UI、自研组件库或其他体系，先搜索目标仓库里的真实用法，再按项目既有模式实现。
   - 如果没有明确组件库，优先复用本地已有业务组件；确实没有可复用组件时才写原生 HTML/CSS。
10. 读取 `references/repo-conventions.md`，并补充目标仓库的真实约定。
11. 按 `alignment-requirements.md` 和 `tasks.md` 实现页面；组件选择优先遵守当前仓库组件体系。
12. 接入真实数据、mock 数据、loading、empty、error、disabled、hover、focus、active 等必要状态。
13. 用真实浏览器对照 Figma 截图验证桌面端和移动端表现。
14. 完成前读取 `references/validation-checklist.md`，运行 `tasks.md` 或项目规则要求的最小验证命令。
15. 若实现改变了需求事实、接口映射、权限或验收口径，先回写 active change，再汇报代码结果。

### 未使用 OpenSpec 时

1. 读取 `AGENTS.md`、`CLAUDE.md`、`.cursorrules`、README、`docs/ai/` 和用户提供的需求材料。
2. 执行非 OpenSpec 准入检查；缺少产品、设计、接口或对齐输入时，先补齐对应 requirements 产物。
3. 若任务涉及 Figma，从 `design-requirements.md`、`docs/ai/` 或用户提供材料中的 UI 节点索引确认要实现的精确 frame/node。
4. 重新读取这些 Figma 节点的结构化设计上下文和同一节点截图；如果上下文过大，先读取节点结构，再缩小到关键子节点。
5. 对比二次读取结果和设计需求材料；如果源节点缺失、截图明显变化或关键视觉事实冲突，先更新设计需求或请求 owner 决策。
6. 检查项目技术栈、组件库、路由、状态管理、请求封装、i18n、权限、mock 和页面模板。
7. 判断组件体系：
   - 如果仓库使用 `@ninebot/pc-titan-components`、已有 `Ti*` 组件或项目规则要求 Titan，先读取 `references/titan-component-map.md` 入口索引和 `references/titan-components/common.md`，再按入口索引只读取本次涉及的组件族文件。
   - 如果仓库使用 Ant Design、Element Plus、Naive UI、Arco、Material UI、自研组件库或其他体系，先搜索目标仓库里的真实用法，再按项目既有模式实现。
   - 如果没有明确组件库，优先复用本地已有业务组件；确实没有可复用组件时才写原生 HTML/CSS。
8. 读取 `references/repo-conventions.md`，并补充目标仓库的真实约定。
9. 按已确认的产品需求、设计需求、接口需求和对齐结果实现页面；组件选择优先遵守当前仓库组件体系。
10. 接入真实数据、mock 数据、loading、empty、error、disabled、hover、focus、active 等必要状态。
11. 用真实浏览器对照 Figma 截图验证桌面端和移动端表现。
12. 完成前读取 `references/validation-checklist.md`，运行项目可用的最小验证命令，例如构建、类型检查、lint 或页面冒烟验证。

## 组件选择

- 默认优先级：项目已有业务组件 → 项目组件库 → 框架/基础 UI 库 → 原生 HTML/CSS。
- 对任何组件库，都必须先搜索目标仓库中的真实用法，不根据设计稿外观臆测 props、事件或插槽契约。
- 遇到弹窗、抽屉、表单、表格、上传、筛选、分页等常见交互容器时，优先复用相邻页面的提交流程和状态模式。
- 当仓库启用 Titan 时，优先级变为：Titan 组件 → Element Plus fallback → 原生 HTML/自定义布局；Titan 已覆盖的组件不允许直接用 Element Plus 替代。
- Titan 组件不是 Element Plus 的同名皮肤。使用前必须确认该组件是“透明透传型”还是“业务封装型”：
  - 透明透传型：例如 `TiSelect`、`TiSearchInput`，可以大量沿用 Element Plus props/slots/events，并叠加 Titan 自定义默认图标或样式。
  - 业务封装型：例如 `TiSearchSelect`、`TiMultipleSelect`、`TiTable`、`TiDialog`、`TiDrawer`、上传组件、业务弹窗类组件，必须使用 Titan 自己的 props/events/slots，不要照搬 Element Plus 写法。
- Titan 详细规则按组件族拆在 `references/titan-components/` 下。不要一次性读取所有子文件；只读取本次涉及的组件族文件。
- 如果对应组件族文件没覆盖目标组件或场景，必须在目标仓库中继续搜索组件源码、`types.ts`、README、`demo.vue` 和实际业务调用，再实现；不要用“看起来像 Element Plus”作为 API 依据。

## 翻译原则

- 表单校验应显式声明合适的 `trigger`，并通过表单实例的 `validate(...)` 驱动提交；不要依赖 `canSubmit` 一类按钮禁用态去替代表单错误反馈。
- 将 Figma 图层视为设计意图，不把图层名称、像素值或自动生成结构当成最终代码。
- 视觉细节和项目规则冲突时，优先项目规则，再通过间距、token 和局部样式让效果接近设计稿。
- 不新增平行设计系统，不重复造已有组件。
- Figma 返回的真实图片或 SVG 资产应优先复用；不要随意发明占位图。
- 如果 Figma 资产地址是 `localhost`，只把它作为提取素材的来源，不要保留为生产运行时地址。
- 如果必须偏离设计稿，在最终说明中解释原因；只有复杂且高风险的偏离才写代码注释。

## 失败处理

- 如果 Figma 上下文过大或被截断，先缩小节点范围再继续。
- 如果同一页面存在多个相似 variant，确认用户指定的 source of truth。
- 如果缺少产品需求、设计需求、接口需求或对齐需求结论，先补齐上游产物，不要越级实现。
- 如果组件库无法覆盖某个形态，先查项目既有页面，再选择基础 UI fallback 或自定义实现。
- 如果浏览器截图和 Figma 差异明显，优先检查组件选择、布局、尺寸、间距、排版，再检查颜色和交互态。

## 参考文件

- `references/titan-component-map.md`：仅在仓库使用 Titan 时读取的入口索引，用于判断要按需读取哪些 `references/titan-components/*.md` 组件族规则。
- `references/repo-conventions.md`：把设计稿适配到现有仓库时的通用检查点。
- `references/validation-checklist.md`：完成前的视觉、交互、响应式和代码质量验收清单。
