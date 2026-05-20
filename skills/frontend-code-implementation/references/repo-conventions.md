# 仓库适配约定

将 Figma 设计稿实现到现有仓库时，先理解仓库，而不是直接从设计稿生成新体系。

## 开发前检查

实现前先查看：

- 包管理和框架文件：`package.json`、lockfile、Vite/Nuxt/Next/Vue/React 配置。
- 本地说明：`AGENTS.md`、`CLAUDE.md`、`.cursorrules`、README、`docs/`。
- 组件目录：`components/`、`src/components/`、`src/views/`、`src/pages/`、`src/layouts/`。
- 样式系统：CSS 变量、主题文件、SCSS 变量、设计 token 文件。
- 与目标页面相似的现有页面。

## 映射方式

- 优先扩展已有本地组件，不轻易创建重复组件。
- 优先使用已有 composables、hooks、stores，不新增并行状态模式。
- 路由、API、i18n、权限、loading、empty、error 等模式要贴近相邻页面。
- Figma 图层名只是设计提示，不一定是最终代码命名。
- 文件名、组件名、props、class 命名遵守仓库现有约定。

## Figma 和仓库不一致时

- 组件选择、token、可访问性和工程约定优先按仓库规则执行。
- 保留 Figma 的布局意图：层级、分组、信息密度和操作流。
- 将 Figma 原始像素值归一到项目认可的间距、颜色、圆角、字体和控件尺寸。
- 如果有明显偏离，在最终交付说明中说明原因。
