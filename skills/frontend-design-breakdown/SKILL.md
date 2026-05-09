---
name: frontend-design-breakdown
description: Use when 拆解 Figma、设计稿、设计截图、页面原型、组件映射、状态清单、交互清单、视觉验收点，或需要在写代码前分析设计结构；只输出设计拆解和决策问题，不实现代码、不改业务文件。
---

# 前端设计拆解

## 概览

在写代码前，把 Figma 或设计稿拆成可实现、可对齐接口、可验收的前端设计说明。这个 skill 只做分析和文档产出，不实现代码。

它回答“设计稿要求什么”，不回答“代码怎么写完”。

## 硬性边界

- 不写业务代码。
- 不创建页面、组件、service、types 或 mock。
- 不根据设计稿猜接口字段。
- 不把 Figma 图层结构直接当成代码结构。
- 不把未确认交互当成已确认需求。
- 发现缺口时标记 `Needs design/product decision`，不要自行补全。
- 结果必须写入设计拆解文档；不要只把拆解留在聊天上下文。

## 工作流程

### 1. 确认设计输入

按需读取：

- Figma URL、node、frame 或设计截图
- PRD、需求说明、交互说明
- OpenSpec change：`openspec/changes/<change-id>/proposal.md`、`design.md`、`decisions.md`
- 项目 `AGENTS.md`、`docs/ai/component-map.md`、`docs/ai/component-usage.md`
- 现有相似页面、组件库、设计 token 和视觉验收规则

整理：

- 目标页面或组件
- 设计来源和可信度
- 适用平台：桌面、移动、响应式、后台管理、H5
- 是否需要 Titan、Element Plus 或其他组件体系

### 2. 拆页面结构

输出页面结构，不输出代码：

- 页面级布局：头部、筛选区、内容区、操作区、弹窗/抽屉、底部
- 区块层级：哪些是页面容器，哪些是业务组件，哪些是基础组件组合
- 数据展示区：表格、列表、卡片、图表、详情、表单
- 关键交互入口：新增、编辑、删除、筛选、搜索、导入、导出、上传、下载

### 3. 建组件映射

优先映射到项目已有组件或组件库：

- Figma 视觉形态
- 推荐前端组件
- 是否需要业务封装
- 禁止自造的基础组件
- Titan / Element Plus / 项目组件的优先级
- 无法匹配时标记 `Needs component decision`

如果仓库使用 Titan，后续实现阶段交给 `frontend-titan-implementation` 读取 Titan 映射规则。

### 4. 列状态和交互

必须列出设计或实现需要覆盖的状态：

- default
- loading
- empty
- error
- disabled
- permission
- submitting
- success
- long-content

必须列出关键交互：

- hover、focus、active
- 表单校验和提交
- 弹窗/抽屉打开、关闭、重置、回填
- 筛选、分页、排序
- 上传、下载、预览
- 删除、确认、撤销

### 5. 输出视觉验收点

至少覆盖：

- 桌面和移动视口
- 布局、间距、对齐、密度
- 字号、颜色、圆角、阴影、图标
- 文案溢出、遮挡、重叠
- 空/错/加载/权限状态
- 设计稿未表达但项目必须覆盖的边界状态

### 6. 生成设计拆解文档

如果存在 active OpenSpec change，优先输出到 `openspec/changes/<change-id>/docs/design-breakdown.md`。否则默认输出到 `docs/ai/design-breakdown.md`，除非项目已有更合适的文档约定。

使用 `assets/templates/design-breakdown.md` 作为基础模板。

如果人工审核发现拆解不准，直接修改 `design-breakdown.md`。有取舍、争议或 owner 的内容，写入 active change 的 `decisions.md`，不要只在聊天里纠正。

最终回复必须包含：

- 产物文件路径
- 设计来源和可信度
- 页面结构清单
- 组件映射摘要
- 状态和交互清单
- 视觉验收点
- 必须确认的问题
- 建议下一步：接口契约、设计接口对齐或实现计划

## 与其他 skill 的关系

- 前置：`frontend-project-bootstrap`
- OpenSpec 编排：`frontend-openspec-workflow`
- 后续接口契约：`frontend-api-contract`
- 后续设计接口对齐：`frontend-design-api-alignment`
- 后续实现：`frontend-titan-implementation`
- 后续验收：`frontend-visual-verification`
- 后续 Review：`frontend-code-review`

推荐顺序：

```text
frontend-design-breakdown
→ frontend-api-contract
→ frontend-design-api-alignment
→ writing-plans
→ frontend-titan-implementation
→ frontend-visual-verification
→ frontend-code-review
```

## 常见失败

- 还没拆设计，就直接开始写页面。
- 只在聊天里总结拆解，没有写入 `design-breakdown.md`。
- 拆解被指出不准后，只口头确认，不更新文件。
- 把 Figma 图层命名当成组件命名。
- 设计稿没有错误态，就忽略错误态。
- UI 看起来有字段，就猜接口一定有该字段。
- 组件库已有能力，却在拆解阶段暗示自造组件。

## 资源

- `assets/templates/design-breakdown.md`
- `assets/templates/design-decision-log.md`
