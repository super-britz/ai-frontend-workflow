---
name: frontend-change-design
description: Use when 为前端 OpenSpec change 编写 design.md 架构设计；在需求事实和 decisions.md 明确后，沉淀前端技术方案、影响面、模块边界、数据流、状态策略、风险和测试关注点；不写 UI 事实、不改决策、不生成 tasks、不写代码。
---

# 前端 Change 架构设计

## 定位

编写当前 OpenSpec change 的 `design.md`，沉淀前端架构设计和技术方案。

这里的 design 是 engineering design，不是 UI design。UI 事实属于 `docs/design-requirements.md`。

本 skill 只回答：

- 现有代码和模块会受到什么影响。
- 页面、组件、route、store、service、adapter 等工程边界怎么划分。
- 数据流、状态来源、权限、异常和错误处理策略是什么。
- 方案有哪些风险、迁移点、测试和验收关注点。

它不回答产品是否正确、设计稿是否正确、接口契约是否正确，也不写具体实现任务。

## 硬性边界

- 不新增产品事实、UI 事实或接口契约；缺口回到 `docs/*-requirements.md` 或 `decisions.md`。
- 不替 owner 批准 Gate。
- 不生成或更新 `tasks.md`。
- 不写业务代码、types、service、mock、fixtures 或测试。
- 不用架构设计掩盖未关闭的 `Needs product/design/backend decision`。
- 不写到具体逐行实现步骤；文件级执行清单属于 `frontend-change-tasks`。

## 输入

优先读取 active OpenSpec change 中的：

- `proposal.md`
- `docs/product-requirements.md`
- `docs/design-requirements.md`
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

- 背景和设计状态。
- 输入来源。
- 现有实现影响面。
- 前端架构方案。
- 数据流和状态策略。
- 权限、异常和边界处理。
- 复用与变更边界。
- 风险和待确认问题。
- 测试和验收关注点。

## Gate 关系

- `Architecture Gate` 可由本文件作为 evidence。
- `Implementation Gate` 仍必须由 `decisions.md` 中的 owner 决策确认。
- 如果架构设计发现事实冲突，先更新 `decisions.md` 或对应需求事实文件，再继续。

## 最终回复

说明：

- `design.md` 路径。
- 架构状态：draft / blocked / ready-for-review。
- 关键影响面和方案摘要。
- 仍需 owner 决策的问题。

## 资源

- `assets/templates/design.md`
