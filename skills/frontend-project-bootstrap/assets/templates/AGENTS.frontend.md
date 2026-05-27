# AGENTS.md

## 全局偏好

- 使用中文沟通。
- 修改前先阅读相关实现、项目文档和测试。
- 保持改动聚焦，不扩大无关重构范围。
- 不覆盖用户已有改动；遇到冲突先说明。
- git commit 不添加 `Co-Authored-By` 或任何暴露 AI 工具身份的信息。

## 项目概况

- 技术栈：Needs project discovery
- 包管理器：Needs project discovery
- UI 库：Needs project discovery
- 主要源码目录：Needs project discovery

## 常用命令

按当前项目实际情况维护；未配置的命令写“未配置”并说明影响。

- 安装依赖：
- 本地开发：
- Lint：
- 类型检查：
- 单元测试：
- E2E/截图：
- 构建：

## 代码修改规则

- 优先复用已有页面、组件、hooks/composables、services、types 和工具函数。
- 新增 UI 前先搜索相似实现。
- 不随意修改全局样式、主题变量、路由结构、构建配置或公共 API。
- 除非任务明确要求，不新增依赖或引入新的 UI 库、状态库、请求库。

## 前端实现规则

- 基础 UI 优先使用项目已有组件库和本地封装。
- 页面逻辑、业务组件、基础组件、接口请求和类型定义保持清晰边界。
- 新增页面或组件时覆盖必要状态，例如 loading、empty、error、disabled、permission 和 success。
- UI 文案、按钮、表单项和状态提示在桌面端和移动端都不能溢出或重叠。

## 验证规则

- 前端改动后运行项目可用的 lint、typecheck、test、build 或 E2E 命令。
- 无法运行的命令必须在最终回复里说明原因。
- 涉及 UI 的改动应使用真实浏览器或截图做最小验收。

## Git 规则

- 提交前查看 `git status`，确认只包含本次任务相关改动。
- 不回滚用户未要求处理的改动。
- commit message 使用项目已有风格。

## 禁止事项

- 不根据猜测编造命令、路由、组件名、接口字段或项目约定。
- 不把 mock 数据、调试代码、临时日志留在生产路径。
- 不为了单个需求提前抽象通用业务组件。
- 不提交未验证的前端改动。

## 未确认项

- Needs project discovery
