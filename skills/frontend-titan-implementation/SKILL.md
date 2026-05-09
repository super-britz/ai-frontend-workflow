---
name: frontend-titan-implementation
description: Use when 根据已确认的设计拆解、接口契约和设计接口对齐结果，将 Figma 设计稿实现为基于 Ninebot Titan 组件体系的生产级前端代码；适用于 Figma URL、Figma node、设计稿截图、Titan/Element Plus/Vue/Vite 后台页面实现。
---

# 前端 Titan 实现

## 目标

把 Figma 中的精确设计节点，翻译成当前仓库可维护、可联调、可验收的生产代码。实现时优先使用 Titan 组件和项目既有模式，而不是照搬 Figma 导出的 React/Tailwind/绝对定位结构。

## 实现准入

如果当前仓库的 `AGENTS.md`、`docs/ai/` 或用户要求中启用了本工作流，且任务不是明确的“跳过上游分析直接实现”，实现前必须先确认：

- 已有 `docs/ai/design-breakdown.md`，或用户明确提供等价的设计拆解。
- 涉及接口数据时，已有 `docs/ai/api-contract.md`。
- 设计和接口都参与本次页面时，已有 `docs/ai/design-api-alignment.md`，且结论允许进入实现。

缺少上述上游产物时，不要直接写代码；先建议使用 `frontend-design-breakdown`、`frontend-api-contract` 或 `frontend-design-api-alignment` 补齐。纯静态页面或无接口依赖页面，可以接受 `api-not-required` 决策后进入实现。

## 工作流

1. 解析用户提供的 Figma URL 或当前选中节点，确认要实现的精确 frame/node。
2. 获取 Figma 结构化设计上下文和同一节点截图；如果上下文过大，先读取节点结构，再缩小到关键子节点。
3. 读取当前仓库规则，例如 `AGENTS.md`、`CLAUDE.md`、`.cursorrules`、README 或 docs，并执行“实现准入”检查。
4. 检查项目技术栈、组件库、路由、状态管理、请求封装、i18n、权限、mock 和页面模板。
5. 如果仓库使用 `@ninebot/pc-titan-components` 或提到 Titan，读取 `references/titan-component-map.md`。
6. 如果需要梳理仓库通用约定，读取 `references/repo-conventions.md`。
7. 按已确认的设计拆解、接口契约和对齐结果实现页面；组件选择优先遵守 Titan 映射规则。
8. 接入真实数据、mock 数据、loading、empty、error、disabled、hover、focus、active 等必要状态。
9. 用真实浏览器对照 Figma 截图验证桌面端和移动端表现。
10. 完成前读取 `references/validation-checklist.md`，运行项目可用的最小验证命令，例如构建、类型检查、lint 或页面冒烟验证。

## 翻译原则

- 优先使用 Titan 组件；Titan 没覆盖时再用 Element Plus；两者都不合适时才写原生 HTML 或自定义布局。
- 将 Figma 图层视为设计意图，不把图层名称、像素值或自动生成结构当成最终代码。
- 视觉细节和项目规则冲突时，优先项目规则，再通过间距、token 和局部样式让效果接近设计稿。
- 不新增平行设计系统，不重复造已有组件。
- Figma 返回的真实图片或 SVG 资产应优先复用；不要随意发明占位图。
- 如果 Figma 资产地址是 `localhost`，只把它作为提取素材的来源，不要保留为生产运行时地址。
- 如果必须偏离设计稿，在最终说明中解释原因；只有复杂且高风险的偏离才写代码注释。

## 失败处理

- 如果 Figma 上下文过大或被截断，先缩小节点范围再继续。
- 如果同一页面存在多个相似 variant，确认用户指定的 source of truth。
- 如果缺少设计拆解、接口契约或设计接口对齐结论，先补齐上游产物，不要越级实现。
- 如果 Titan 组件无法覆盖某个形态，先查项目既有页面，再选择 Element Plus fallback 或自定义实现。
- 如果浏览器截图和 Figma 差异明显，优先检查组件选择、布局、尺寸、间距、排版，再检查颜色和交互态。

## 参考文件

- `references/titan-component-map.md`：Figma 形态到 Titan/Element Plus 组件的映射规则。
- `references/repo-conventions.md`：把设计稿适配到现有仓库时的通用检查点。
- `references/validation-checklist.md`：完成前的视觉、交互、响应式和代码质量验收清单。
