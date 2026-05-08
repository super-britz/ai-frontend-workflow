---
name: frontend-project-bootstrap
description: Use when 初始化或接入前端仓库的 AI 开发工作流；生成或更新 AGENTS.md；建立 Codex、Claude、Superpowers、Figma-to-code、component-library-first、前端 Review、Playwright、CI、设计验收规则；或排查 AI 生成前端代码不稳定。
---

# 前端项目初始化

## 概览

把一个前端仓库初始化成适合 AI Agent 稳定协作的项目。先建立项目入口规则、组件边界、设计到代码约束、Review 检查点和验收命令，再开始具体功能开发。

这个 skill 负责建立护栏，不负责实现业务功能。

## 执行原则

- 先检查仓库现状，再写规则。
- 保留已有 `AGENTS.md`、`CLAUDE.md`、`README.md` 或项目文档里的用户规则。
- 更新已有文档时只合并、补齐和标注冲突，不默认覆盖用户规则。
- 项目特定事实写进仓库文档，不硬编码进本 skill。
- 优先写具体命令、文件路径、组件名和项目约定，避免泛泛建议。
- 只有无法从仓库发现的信息，才标记为 `Needs owner decision`。
- 生成的文档要短、清楚、可执行，避免未来 Agent 读不完或不愿读。

## 工作流程

### 1. 探测仓库

按需读取：

- `package.json`、lockfile、构建配置、测试配置
- `AGENTS.md`、`CLAUDE.md`、`.cursorrules`、`README.md`、`docs/`
- `src/`、`app/`、`pages/`、`views/`、`components/`、`layouts/`、`routes/`
- `.github/workflows/`、CI 脚本、Playwright 或 Cypress 配置

整理项目画像：

- 框架和语言：React、Vue、Next、Nuxt、Vite、JavaScript、TypeScript
- UI 栈：组件库、图标库、样式方案、设计 token
- 代码组织：页面、公共组件、业务组件、services、stores、tests
- 常用命令：install、dev、lint、typecheck、test、build、E2E
- 当前缺口：测试缺失、视觉验收缺失、组件归属不清、文档薄弱

### 2. 生成或更新 `AGENTS.md`

使用 `assets/templates/AGENTS.frontend.md` 作为基础模板。

必须包含：

- 协作偏好
- 项目命令
- 前端实现规则
- 组件库优先规则
- 样式与设计 token 规则
- Figma / 设计到代码规则
- 测试与验收规则
- Review 检查清单
- 禁止事项

如果已有 `AGENTS.md`：

- 保留用户语言偏好、commit 规则、安全规则和项目偏好。
- 只补充缺失的前端章节。
- 发现冲突时，在最终回复中说明，不静默选择。

### 3. 添加 AI 支撑文档

只创建当前仓库真正需要的文档。默认放在 `docs/ai/`，除非仓库已有更合适的文档约定。

- `component-map.md`：组件归属或 Figma 映射不清时创建。
- `component-usage.md`：组件库不完整、不稳定或容易被绕过时创建。
- `figma-to-code.md`：设计稿实现是常见工作流时创建。
- `visual-checklist.md`：UI 验收依赖截图、响应式或状态检查时创建。
- `review-checklist.md`：需要前端专项 Review 标准时创建。

模板位于 `assets/templates/`。

### 4. 定义最小质量门禁

初始化后的仓库必须写清：

- 前端改动后 Agent 需要运行哪些准确命令。
- 页面任务必须覆盖哪些 UI 状态：默认、加载、空、错误、禁用、权限、成功。
- 是否有 Playwright、Cypress、截图或 E2E 验收能力。
- 新增组件、hooks/composables、页面、services 时是否必须补测试。
- 哪些文件、配置或公共区域不能随意改。

### 5. 汇报初始化结果

最终回复必须包含：

- 从仓库检查出的项目画像。
- 创建或更新了哪些文件。
- 仍会影响 AI 生成质量的重要缺口。
- 建议用来验证工作流的第一个真实任务。

## 推荐默认值

- skill 安装路径：`${CODEX_HOME:-$HOME/.codex}/skills/frontend-project-bootstrap`
- 仓库文档路径：`docs/ai/`
- `AGENTS.md` 保持简洁，详细规则链接到 `docs/ai/`
- 组件库不稳定时，先创建 `component-usage.md`，再做 Figma 实现
- 设计还原很重要时，至少要求桌面和移动各一张截图验收

## 常见失败

- 没检查仓库，就生成一份通用 `AGENTS.md`。
- 允许 Agent 自造已有组件库覆盖的按钮、弹窗、表单、表格、上传或图标。
- 把 Figma 实现当成纯样式问题，遗漏状态、响应式和交互。
- 写太长的流程文档，导致未来 Agent 实际不会读。
- 只靠 Review 文案约束本该由 lint、test、build 或截图自动验证的内容。

## 资源

- `assets/templates/AGENTS.frontend.md`
- `assets/templates/component-map.md`
- `assets/templates/component-usage.md`
- `assets/templates/figma-to-code.md`
- `assets/templates/visual-checklist.md`
- `assets/templates/review-checklist.md`
