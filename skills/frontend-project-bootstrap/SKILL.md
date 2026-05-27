---
name: frontend-project-bootstrap
description: Use when 初始化或接入一个前端仓库，需要检查项目结构并生成或更新根目录 AGENTS.md；只维护项目级 AI 协作规则、常用命令、代码修改边界、前端实现基础规则和验证要求。
---

# 前端项目 Bootstrap

## 目标

为前端仓库生成或更新根目录 `AGENTS.md`，让后续 AI 助手先读到项目级协作规则。

本 skill 只维护 `AGENTS.md`。需求分析、组件规范、OpenSpec、Figma、视觉验收、Review 和任务分流交给后续专项流程处理。

## 工作流程

### 1. 检查仓库

优先读取能直接确认项目事实的文件：

- 入口规则：`AGENTS.md`、`CLAUDE.md`、`.github/copilot-instructions.md`、`.cursorrules`
- 项目说明：`README.md`、`docs/`
- 技术栈：`package.json`、lockfile、构建配置、测试配置、路由配置
- 代码结构：`src/`、`app/`、`pages/`、`views/`、`components/`、`layouts/`、`services/`、`stores/`
- 自动化：`.github/workflows/`、Playwright、Cypress、Vitest、Jest 或其他测试配置

只记录已经确认的事实；无法确认但会影响后续实现的信息，写入 `Needs project discovery`。

### 2. 生成或更新 `AGENTS.md`

使用 `assets/templates/AGENTS.frontend.md` 作为基础模板，并按当前仓库裁剪。

如果已有 `AGENTS.md`：

- 保留用户已有的语言偏好、提交规则、安全规则和项目约束。
- 合并缺失的项目级章节，不覆盖用户明确写过的规则。
- 如果发现规则冲突，在最终回复里说明，不静默改写。

`AGENTS.md` 推荐包含：

- 全局偏好
- 项目概况
- 常用命令
- 代码修改规则
- 前端实现规则
- 验证规则
- Git 规则
- 禁止事项
- 未确认项

保持短、具体、可执行。不要把一次需求里的临时结论写成项目级规则。

### 3. 最终回复

回复中说明：

- 已创建或更新的 `AGENTS.md` 路径。
- 从仓库确认的关键项目事实。
- 仍标记为 `Needs project discovery` 的未知项。
- 发现但未自动解决的规则冲突。

## 资源

- `assets/templates/AGENTS.frontend.md`
