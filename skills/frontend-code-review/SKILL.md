---
name: frontend-code-review
description: Use when review 前端改动、PR、diff、前端专项 Review、组件复用、组件库优先、Figma 还原、接口契约、TypeScript 类型、UI 状态、响应式、可访问性、测试和 Playwright 验收，或排查 AI 生成前端代码质量风险。
---

# 前端专项 Review

## 概览

对前端改动做专项代码审查，优先发现会导致线上问题、设计还原失败、组件体系失控、接口契约漂移或验收不足的风险。这个 skill 默认采用 code review 姿态：问题优先，少写泛泛表扬。

## 执行原则

- 先确认 review 范围：当前 diff、指定提交、PR 或具体文件。
- 先读项目规则：`AGENTS.md`、`docs/ai/`、active OpenSpec change、组件映射、接口契约、视觉验收清单。
- 只审查范围内的改动；不要把无关历史问题混进结论。
- 发现问题必须给出文件和行号，说明影响和触发条件。
- 优先报告会影响用户、数据、可维护性和交付验收的问题。
- 不为纯个人风格、无影响命名或格式噪音占用主要结论。
- 不直接改代码，除非用户明确要求“修复”。

## 工作流程

### 1. 确认范围

按需使用：

- `git status -sb`
- `git diff`
- `git diff --stat`
- `git show <commit>`
- PR diff 或用户指定文件

整理：

- 修改了哪些页面、组件、service、types、样式、测试、配置
- 是否涉及 Figma 还原
- 是否涉及接口契约
- 是否涉及公共组件或全局样式
- 是否涉及路由、权限、状态管理或构建配置

### 2. 读取项目约束

优先查看：

- `AGENTS.md`
- `docs/ai/component-map.md`
- `docs/ai/component-usage.md`
- `docs/ai/api-requirements.md`
- `docs/ai/visual-checklist.md`
- `docs/ai/review-checklist.md`
- `openspec/changes/<change-id>/docs/*`
- `openspec/changes/<change-id>/decisions.md`
- `openspec/changes/<change-id>/verification.md`
- 相邻页面和已有组件实现

如果仓库没有这些文档，按当前代码库惯例审查，并在结论中说明缺口。

### 3. 审查重点

#### 组件与设计系统

- 是否绕过已有组件库自造按钮、表单、表格、弹窗、抽屉、上传、图标。
- 是否重复封装已有业务组件。
- 是否破坏组件 props、事件、slot、样式约定。
- Figma 还原是否误把图层结构当代码结构。

#### 接口与数据

- 是否遵守 `frontend-api-contract` 或项目接口契约。
- 是否在页面里硬编码接口路径、分页结构、错误码或响应包裹。
- TypeScript 类型是否与接口文档一致。
- loading、empty、error、permission、success 是否覆盖。
- mock 是否被当成真实接口契约。

#### UI 状态与交互

- 表单校验、提交中、防重复提交、错误提示是否完整。
- 弹窗/抽屉关闭、重置、回填、确认流程是否正确。
- 筛选、分页、排序、上传、下载是否处理边界。
- 长文本、空数据、异常数据是否导致溢出或遮挡。

#### 响应式与可访问性

- 移动端、窄屏、滚动容器是否可用。
- 文案是否溢出、重叠、遮挡。
- 键盘 focus、aria、label、按钮语义是否有明显问题。
- 颜色对比、禁用态、错误态是否可辨认。

#### 测试与验收

- 是否补了必要单元测试、组件测试、service 测试或 E2E。
- 是否真实运行 lint、typecheck、test、build。
- UI 改动是否有截图或浏览器验收。
- 测试是否只测 mock 行为，没测真实逻辑。

### 4. 输出格式

有问题时，按严重程度排序：

- P0：会导致崩溃、数据错误、安全风险、关键流程不可用。
- P1：主要功能错误、设计还原明显失败、接口契约错误。
- P2：边界状态缺失、响应式问题、可维护性明显退化。
- P3：轻微一致性、低风险测试缺口。

每个问题包含：

- 标题
- 文件和行号
- 影响
- 触发条件
- 建议修复方向

没有发现问题时，明确说明“未发现阻塞性问题”，并列出仍未验证的风险。

在 Codex app 中输出可定位代码评论时，使用 `::code-comment{...}`；普通聊天中使用文件路径和行号。

如果存在 active OpenSpec change，优先把 Review 摘要写入 `openspec/changes/<change-id>/review.md`。

## 常见失败

- 只看代码能不能编译，不看 UI 状态和视觉验收。
- 只指出风格问题，漏掉组件库绕过、接口猜字段、状态缺失。
- 把无关历史问题混入本次 review。
- 没有文件和行号，导致反馈无法落地。
- 没有区分严重程度，导致真正风险被噪音淹没。

## 资源

- `assets/templates/frontend-review-report.md`
- `assets/templates/frontend-review-checklist.md`
