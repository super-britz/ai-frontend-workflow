---
name: frontend-project-bootstrap
description: Use when 初始化或接入前端仓库的 AI 辅助开发工作流；生成或更新 AGENTS.md；建立工具中立的协作规则、组件库优先、需求级事实归属、前端 Review/验收入口、Playwright、CI 和质量门禁规则；或排查 AI 生成前端代码不稳定。
---

# 前端项目初始化

## 概览

把一个前端仓库初始化成适合 AI 助手稳定协作的项目。先建立项目入口规则、组件使用与沉淀机制、需求级事实文件的归属规则和最小质量门禁，再开始具体功能开发。

这个 skill 负责建立项目级护栏，不负责实现业务功能，不产出需求级设计、接口、对齐、验收或 Review 细节，也不在初始化阶段提前定稿完整业务组件边界。

## 执行原则

- 先检查仓库现状，再写规则。
- 保留已有 `AGENTS.md`、`CLAUDE.md`、`README.md` 或项目文档里的用户规则。
- 更新已有文档时只合并、补齐和标注冲突，不默认覆盖用户规则。
- 项目特定事实写进仓库文档，不硬编码进本 skill。
- 只把仓库中已经存在或从真实需求确认的信息写成项目事实。
- 对尚未出现的业务组件，写发现流程、记录位置和升级条件，不假设结论。
- 需求级产品、设计、接口、对齐、验收和 Review 事实由对应前端专项 skill 或 OpenSpec change 承载，不复制到 bootstrap 模板。
- 优先写具体命令、文件路径、已有组件名和项目约定，避免泛泛建议。
- 无法从仓库发现且会影响实现决策的信息，标记为 `Needs owner decision` 或 `Needs project discovery`。
- 生成的文档要短、清楚、可执行，避免未来 AI 助手读不完或不愿读。

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
- 当前缺口：测试缺失、视觉验收能力缺失、组件使用路径不清、文档薄弱

### 2. 生成或更新 `AGENTS.md`

使用 `assets/templates/AGENTS.frontend.md` 作为基础模板。

必须包含：

- 协作偏好
- 项目命令
- 前端实现规则
- 组件库优先和组件沉淀规则
- 样式与设计 token 规则
- 需求级事实文件归属规则
- 测试与验收规则
- Review 检查清单
- 禁止事项

如果已有 `AGENTS.md`：

- 保留用户语言偏好、commit 规则、安全规则和项目偏好。
- 只补充缺失的前端章节。
- 发现冲突时，在最终回复中说明，不静默选择。

### 3. 添加项目级 AI 支撑文档

只创建当前仓库真正需要的项目级文档。默认放在 `docs/ai/`，除非仓库已有更合适的文档约定。

- `component-usage.md`：组件库不完整、不稳定或容易被绕过时创建。
- `component-usage.md` 是活文档，只沉淀已验证的项目级组件使用规则、封装约定、风险组件和升级条件。
- 不创建 Figma、API、alignment、visual verification 或 review 的细节模板；这些由 `frontend-design-requirements`、`frontend-api-requirements`、`frontend-alignment-requirements`、`frontend-visual-verification` 和 `frontend-code-review` 负责。
- 需要按需求沉淀上下文和人工 Gate 时，引入 `frontend-openspec-workflow`。OpenSpec 启用时，`openspec/changes/<change-id>/docs/*` 是需求级事实来源；`docs/ai/*` 只保存跨需求稳定规则和无 OpenSpec 场景下的轻量 fallback。

模板位于 `assets/templates/`。

### 4. 定义最小质量门禁

初始化后的仓库必须写清：

- 前端改动后 AI 助手需要运行哪些准确命令。
- 页面任务必须覆盖哪些 UI 状态：默认、加载、空、错误、禁用、权限、成功。
- 组件边界不清时，必须先搜索相似实现，再选择局部组合、复用已有封装或记录候选封装。
- 设计、接口、对齐、验收和 Review 细节必须进入对应专项 skill 的产物；若启用 OpenSpec，必须写清 active change、`decisions.md` 和 `Implementation Gate: Approved` 的要求。
- 是否有 Playwright、Cypress、截图或 E2E 验收能力。
- 新增组件、hooks/composables、页面、services 时是否必须补测试。
- 哪些文件、配置或公共区域不能随意改。

### 5. 汇报初始化结果

最终回复必须包含：

- 从仓库检查出的项目画像。
- 创建或更新了哪些文件。
- 已确认的项目事实、仍待沉淀的未知项和会影响 AI 生成质量的重要缺口。
- 建议用来验证工作流的第一个真实任务。

## 推荐默认值

- skill 安装路径：`${CODEX_HOME:-$HOME/.codex}/skills/frontend-project-bootstrap`
- 项目级文档路径：`docs/ai/`
- `AGENTS.md` 保持简洁，详细组件使用规则链接到 `docs/ai/component-usage.md`
- 组件库不稳定时，先创建 `component-usage.md`，记录已有封装、发现路径和新增条件
- OpenSpec 启用时，需求级事实默认写入 `openspec/changes/<change-id>/docs/*`，不写入 bootstrap 生成的项目级模板

## 常见失败

- 没检查仓库，就生成一份通用 `AGENTS.md`。
- 初始化时提前虚构业务组件边界、组件清单或 Figma 映射。
- 在 bootstrap 里创建 Figma、接口、对齐、验收或 Review 细节模板，和专项 skill 的产物重复。
- 允许 AI 助手自造已有组件库覆盖的按钮、弹窗、表单、表格、上传或图标。
- 把 Figma 实现当成纯样式问题，遗漏状态、响应式和交互。
- 写太长的流程文档，导致未来 AI 助手实际不会读。
- 只靠 Review 文案约束本该由 lint、test、build 或截图自动验证的内容。

## 资源

- `assets/templates/AGENTS.frontend.md`
- `assets/templates/component-usage.md`
