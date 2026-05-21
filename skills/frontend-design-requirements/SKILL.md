---
name: frontend-design-requirements
description: Use when 沉淀前端设计需求；拆解 Figma、设计稿、设计截图、页面原型、组件映射、状态清单、交互清单、视觉验收点，或需要在写代码前分析设计结构；只输出设计需求和决策问题，不实现代码、不改业务文件。
---

# 前端设计需求

## 概览

在写代码前，把 Figma 或设计稿拆成可实现、可对齐接口、可验收的前端设计需求说明。这个 skill 只做分析和文档产出，不实现代码。

它回答“设计稿要求什么”，不回答“代码怎么写完”。

## 硬性边界

- 不写业务代码。
- 不创建页面、组件、service、types 或 mock。
- 不根据设计稿猜接口字段。
- 不把 Figma 图层结构直接当成代码结构。
- 不把未确认交互当成已确认需求。
- 发现缺口时标记 `Needs design/product decision`，不要自行补全。
- 结果必须写入设计需求文档；不要只把拆解留在聊天上下文。

## 工作流程

### 1. 确认设计输入

按需读取：

- Figma URL、node、frame 或设计截图
- PRD、需求说明、交互说明
- OpenSpec change：`openspec/changes/<change-id>/proposal.md`、`design.md`、`decisions.md`
- 项目 `AGENTS.md`、`docs/ai/component-usage.md`
- 现有相似页面、组件库、设计 token 和视觉验收规则

整理：

- 目标页面或组件
- 设计来源和可信度
- 适用平台：桌面、移动、响应式、后台管理、H5
- 是否需要 Titan、Element Plus 或其他组件体系

如果同一个页面来自多个 Figma 文件、frame 或 node，且它们只是默认态、弹窗态、空态、错误态、权限态等状态变体，不要拆成多个 `design-requirements.md`。应在同一份设计需求中建立“设计来源索引”，把每个 Figma 来源标注为主状态、状态补充、弹窗状态或独立页面候选。

只有当 Figma 来源对应不同完整页面、独立流程、跨页面可复用视觉规范，或不同来源之间存在需要单独审计的冲突时，才考虑拆出独立设计需求文件或在 `decisions.md` 中记录取舍。

### 2. 保存 UI 节点索引

设计需求文档必须保存可被实现阶段重新读取的 UI 来源索引，而不是只写“见 Figma”：

- Figma file、page、frame/node 名称和 node id
- 节点用途：主页面、状态变体、弹窗/抽屉、局部组件、独立页面候选
- 读取时间、读取方式和可信度
- 对应状态：default、empty、error、permission、loading、新增/编辑/详情等
- 关键截图或导出资产路径；如没有落盘截图，记录截图来源和获取方式
- 与产品或接口对齐相关的关键 UI 字段、按钮、筛选项、表格列、弹窗表单
- 需要实现阶段二次读取的节点清单

不要把完整 Figma JSON、所有图层 dump 或大段自动生成样式粘进设计需求。文档应保存“索引 + 关键视觉事实 + 待确认问题”，让实现阶段能准确回到源头，而不是替代源头。

读两遍是合理的：设计阶段第一次读取用于沉淀需求和审查，实现阶段第二次读取用于拿最新节点结构、截图、资产和尺寸细节。第二次读取不是重复劳动，而是防止设计稿、文档和代码实现之间漂移。

### 3. 拆页面结构

输出页面结构，不输出代码：

- 页面级布局：头部、筛选区、内容区、操作区、弹窗/抽屉、底部
- 区块层级：哪些是页面容器，哪些是业务组件，哪些是基础组件组合
- 数据展示区：表格、列表、卡片、图表、详情、表单
- 关键交互入口：新增、编辑、删除、筛选、搜索、导入、导出、上传、下载

### 4. 建组件映射

优先映射到项目已有组件或组件库：

- Figma 视觉形态
- 推荐前端组件
- 是否需要业务封装
- 禁止自造的基础组件
- Titan / Element Plus / 项目组件的优先级
- 无法匹配时标记 `Needs component decision`

如果仓库使用 Titan，后续实现阶段交给 `frontend-code-implementation` 读取 Titan 映射规则。

### 5. 列状态和交互

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

### 6. 输出视觉验收点

至少覆盖：

- 桌面和移动视口
- 布局、间距、对齐、密度
- 字号、颜色、圆角、阴影、图标
- 文案溢出、遮挡、重叠
- 空/错/加载/权限状态
- 设计稿未表达但项目必须覆盖的边界状态

视觉规格优先和页面结构、状态变体放在同一个 `design-requirements.md` 中，按章节组织；不要因为来源是多个 Figma node 就过早拆文件。若单个设计需求超过约 600-800 行、覆盖多个完整页面，或实现时频繁只需要视觉规格，再拆出 `ui-reproduction-requirements.md` 或页面级子文档。

### 7. 生成设计需求文档

如果存在 active OpenSpec change，优先输出到 `openspec/changes/<change-id>/docs/design-requirements.md`。否则默认输出到 `docs/ai/design-requirements.md`，除非项目已有更合适的文档约定。

使用 `assets/templates/design-requirements.md` 作为基础模板。

如果人工审核发现拆解不准，直接修改 `design-requirements.md`。有取舍、争议或 owner 的内容，写入 active change 的 `decisions.md`，不要只在聊天里纠正。

最终回复必须包含：

- 产物文件路径
- 设计来源和可信度
- UI 节点索引和需要实现阶段二次读取的节点
- 页面结构清单
- 组件映射摘要
- 状态和交互清单
- 视觉验收点
- 必须确认的问题
- 建议下一步：接口需求、产品/UI/API 对齐或实现计划

## 与其他 skill 的关系

- 前置：`frontend-project-bootstrap`
- 前置产品需求：`frontend-product-requirements`
- OpenSpec 编排：`frontend-openspec-workflow`
- 后续接口需求：`frontend-api-requirements`
- 后续对齐需求：`frontend-alignment-requirements`
- 后续实现：`frontend-code-implementation`
- 后续验收：`frontend-visual-verification`
- 后续 Review：`frontend-code-review`

推荐顺序：

```text
frontend-product-requirements
→ frontend-design-requirements
→ frontend-api-requirements
→ frontend-alignment-requirements
→ writing-plans
→ frontend-code-implementation
→ frontend-visual-verification
→ frontend-code-review
```

## 常见失败

- 还没拆设计，就直接开始写页面。
- 只在聊天里总结拆解，没有写入 `design-requirements.md`。
- 拆解被指出不准后，只口头确认，不更新文件。
- 把 Figma 图层命名当成组件命名。
- 设计稿没有错误态，就忽略错误态。
- UI 看起来有字段，就猜接口一定有该字段。
- 组件库已有能力，却在拆解阶段暗示自造组件。

## 资源

- `assets/templates/design-requirements.md`
- `assets/templates/design-decision-log.md`
