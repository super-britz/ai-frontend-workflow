---
name: frontend-change-design
description: Use when 为前端 OpenSpec change 编写或收紧 design.md 工程架构契约；在需求事实和 decisions.md 明确后，沉淀实现准入、影响面、模块边界、数据流、状态策略、集成策略、风险和 tasks handoff；不补事实、不改决策、不生成任务、不写代码。
---

# 前端 Change 架构设计

## 定位

编写当前 OpenSpec change 的 `design.md`，沉淀前端工程架构契约。

这里的 design 是 engineering design，不是 UI design。UI 事实属于 `docs/ui-requirements.md`。

`design.md` 的目标是让后续 `frontend-change-tasks` 能按明确边界拆任务，让 `frontend-code-implementation` 不需要临场重做架构判断。

本 skill 只回答：

- 当前架构状态是 `Draft`、`Blocked` 还是 `Ready for tasks`。
- 产品、UI、API 和 alignment 事实会落到哪些工程边界。
- 现有代码和模块会受到什么影响。
- 页面、组件、route、store、service、adapter、hook/composable 等工程边界怎么划分。
- 数据流、状态来源、权限、异常和错误处理策略是什么。
- 哪些文件、模块或公共能力允许改，哪些明确不能碰。
- 方案有哪些风险、迁移点、测试和验收关注点。

它不回答产品是否正确、设计稿是否正确、接口契约是否正确，也不写具体实现任务或代码。

## 硬性边界

- 不新增产品事实、UI 事实或接口契约；缺口回到 `docs/*-requirements.md` 或 `decisions.md`。
- 不替 owner 批准 Gate。
- 不生成或更新 `tasks.md`。
- 不写业务代码、types、service、mock、fixtures 或测试。
- 不用架构设计掩盖未关闭的 `Needs product/ui/backend decision`。
- 不写到具体逐行实现步骤；文件级执行清单属于 `frontend-change-tasks`。
- 不把 `Handoff To Tasks` 写成 checkbox 任务清单。
- 不把组件库 props、接口字段或 mock 示例当作架构设计发明出来。

## 写法护栏

- 只写本 change 相关的架构影响；无影响项写 `N/A`，不要为了填满模板扩写。
- 新发现的产品、UI 或接口事实回写 `docs/*-requirements.md`，不要塞进 `design.md`。
- owner 取舍、Gate 状态和阻塞问题回写 `decisions.md`，不要在 `design.md` 里自行拍板。
- 具体实现步骤、文件清单和验收命令属于 `tasks.md`。

## 架构契约要求

`design.md` 必须尽量结构化，避免只写叙述性架构作文。至少覆盖：

- `Implementation Readiness`：架构状态只能是 `Draft`、`Blocked` 或 `Ready for tasks`，并列出 evidence。
- `Requirement To Architecture Mapping`：把关键产品、UI、API、alignment 输入映射到模块、状态、接口策略或风险。
- `Implementation Boundaries`：列出允许修改的 route、page、component、store、service、hook/composable、adapter 或样式边界；列出禁止改动区域。
- `State Strategy / Coverage Matrix`：明确 default、loading、empty、error、permission、disabled、submitting、success、long text、responsive 等与本 change 相关的状态由哪里承载。
- `Integration Contract`：记录 API 使用边界、鉴权、分页、错误结构、时间格式、数据归一化和降级策略；只写来源已确认的契约，不生成 types/service。
- `Do Not Implement`：明确本 change 不做什么，防止实现阶段顺手扩范围。
- `Handoff To Tasks`：给 `frontend-change-tasks` 的实现单元摘要，不能包含执行步骤、命令或代码。

## 输入

优先读取 active OpenSpec change 中的：

- `proposal.md`
- `docs/product-requirements.md`
- `docs/ui-requirements.md`
- `docs/api-requirements.md`
- `docs/alignment-requirements.md`
- `decisions.md`

再读取项目中的相关代码、组件库约定、路由、状态管理、请求封装和相似页面。只引用实际存在的代码和已确认事实。

如果 `decisions.md` 中仍有阻塞 `Implementation Gate` 的问题，可以输出架构草案，但必须标注 blocked，不要把它包装成可执行方案。

## 输出

使用 `assets/templates/design.md` 作为基础模板，输出或更新：

```text
openspec/changes/<change-id>/design.md
```

文档只沉淀：

- 背景、设计状态和实现准入。
- 输入来源。
- 需求事实到工程边界的映射。
- 现有实现影响面。
- 前端架构方案。
- 数据流和状态策略。
- 接口集成、权限、异常和边界处理策略。
- 复用与变更边界。
- 禁止实现范围。
- 给 `frontend-change-tasks` 的 handoff 摘要。
- 风险和待确认问题。
- 测试和验收关注点。

## Gate 关系

- `Architecture Gate` 可由本文件作为 evidence。
- `Ready for tasks` 只表示架构契约足够拆任务，不等于允许写代码。
- `Implementation Gate` 仍必须由 `decisions.md` 中的 owner 决策确认。
- 如果架构设计发现事实冲突，先更新 `decisions.md` 或对应需求事实文件，再继续。

## 最终回复

说明：

- `design.md` 路径。
- 架构状态：Draft / Blocked / Ready for tasks。
- 关键影响面和方案摘要。
- 允许和禁止的实现边界摘要。
- 仍需 owner 决策的问题。

## 资源

- `assets/templates/design.md`
