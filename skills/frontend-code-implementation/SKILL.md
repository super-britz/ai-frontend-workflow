---
name: frontend-code-implementation
description: Use when 根据已确认的设计需求、接口需求和设计接口对齐结果，实现前端页面或组件代码；适用于 Figma URL、Figma node、设计稿截图、组件库优先、Vue/React/Vite/Next/Nuxt 页面实现。
---

# 前端代码实现

## 目标

把 Figma 中的精确设计节点，或已确认的前端需求，翻译成当前仓库可维护、可联调、可验收的生产代码。实现时优先使用项目已有组件体系、业务模式和样式 token，而不是照搬 Figma 导出的 React/Tailwind/绝对定位结构。

Titan 只是组件体系分支之一：当仓库使用 `@ninebot/pc-titan-components`、已有 `Ti*` 组件注册，或项目规则明确要求 Titan 时，才启用 Titan 映射表。其他项目按当前仓库的默认组件库和已有页面模式实现。

## 实现准入

当本 skill 被 `frontend-openspec-workflow`、`AGENTS.md` 或用户明确要求为强制步骤时，它不是可选优化，而是前端页面实现的前置 Gate。未完成本节检查前，不得新增或修改页面实现代码。

如果当前仓库的 `AGENTS.md`、`docs/ai/` 或用户要求中启用了本工作流，且任务不是明确的“跳过上游分析直接实现”，实现前必须先确认：

- 已有 `docs/ai/product-requirements.md` 或 active OpenSpec change 中的 `docs/product-requirements.md`，或用户明确提供等价产品需求。
- 已有 `docs/ai/design-requirements.md`，或用户明确提供等价的设计需求。
- 涉及接口数据时，已有 `docs/ai/api-requirements.md`。
- 设计和接口都参与本次页面时，已有 `docs/ai/alignment-requirements.md`，且结论允许进入实现。
- 若启用 OpenSpec，已有 `openspec/changes/<change-id>/docs/*` 上游事实文件，且 `openspec/changes/<change-id>/decisions.md` 中 `Implementation Gate: Approved`。
- 若启用 OpenSpec，`tasks.md` 应在事实文件稳定和 Gate 通过后生成；实现时读取文件，不以聊天摘要替代。

缺少上述上游产物时，不要直接写代码；先建议补齐 `frontend-product-requirements`、`frontend-design-requirements`、`frontend-api-requirements` 或 `frontend-design-api-alignment` 产物。纯静态页面或无接口依赖页面，可以接受 `api-not-required` 决策后进入实现。

## 工作流

1. 解析用户提供的 Figma URL 或当前选中节点，确认要实现的精确 frame/node。
2. 获取 Figma 结构化设计上下文和同一节点截图；如果上下文过大，先读取节点结构，再缩小到关键子节点。
3. 读取当前仓库规则，例如 `AGENTS.md`、`CLAUDE.md`、`.cursorrules`、README、docs 或 active OpenSpec change，并执行“实现准入”检查。
4. 检查项目技术栈、组件库、路由、状态管理、请求封装、i18n、权限、mock 和页面模板。
5. 判断组件体系：
   - 如果仓库使用 `@ninebot/pc-titan-components`、已有 `Ti*` 组件或项目规则要求 Titan，先读取 `references/titan-component-map.md` 入口索引和 `references/titan-components/common.md`，再按入口索引只读取本次涉及的组件族文件。
   - 如果仓库使用 Ant Design、Element Plus、Naive UI、Arco、Material UI、自研组件库或其他体系，先搜索目标仓库里的真实用法，再按项目既有模式实现。
   - 如果没有明确组件库，优先复用本地已有业务组件；确实没有可复用组件时才写原生 HTML/CSS。
6. 读取 `references/repo-conventions.md`，并补充目标仓库的真实约定。
7. 按已确认的设计需求、接口需求和对齐结果实现页面；组件选择优先遵守当前仓库组件体系。
8. 接入真实数据、mock 数据、loading、empty、error、disabled、hover、focus、active 等必要状态。
9. 用真实浏览器对照 Figma 截图验证桌面端和移动端表现。
10. 完成前读取 `references/validation-checklist.md`，运行项目可用的最小验证命令，例如构建、类型检查、lint 或页面冒烟验证。

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
- 如果缺少设计需求、接口需求或设计接口对齐结论，先补齐上游产物，不要越级实现。
- 如果组件库无法覆盖某个形态，先查项目既有页面，再选择基础 UI fallback 或自定义实现。
- 如果浏览器截图和 Figma 差异明显，优先检查组件选择、布局、尺寸、间距、排版，再检查颜色和交互态。

## 参考文件

- `references/titan-component-map.md`：仅在仓库使用 Titan 时读取的入口索引，用于判断要按需读取哪些 `references/titan-components/*.md` 组件族规则。
- `references/repo-conventions.md`：把设计稿适配到现有仓库时的通用检查点。
- `references/validation-checklist.md`：完成前的视觉、交互、响应式和代码质量验收清单。
