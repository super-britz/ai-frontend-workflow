---
name: frontend-product-requirements
description: Use when 沉淀前端产品需求和 Scope Gate；从 PRD、Wiki、产品说明、需求单、会议纪要或用户描述提炼业务目标、范围、产品规则、权限、异常、验收口径和产品待确认问题；只输出产品事实和产品决策问题，不拆设计、不猜接口、不写实现方案。
---

# 前端产品需求

## 概览

在设计需求、接口需求和代码实现之前，把 PRD、Wiki、产品说明或需求讨论沉淀成前端可执行的产品事实和 Scope Gate。这个 skill 只产出产品需求文档和产品决策问题，不实现代码。

它回答“产品要什么、为什么要、做到什么程度、哪些范围已确认”，不回答“界面长什么样”“接口怎么给”或“代码怎么实现”。

## 硬性边界

- 不写业务代码。
- 不创建页面、组件、service、types 或 mock。
- 不拆页面结构、组件映射、视觉状态或 Figma 节点。
- 不写接口字段、响应结构、分页结构、错误码或 adapter 决策。
- 不写实现方案、文件路径、技术选型或组件封装建议。
- 不根据 Figma 视觉细节补产品规则。
- 不根据接口字段反推产品语义。
- 不把 mock、示例数据或历史页面表现当成产品事实。
- 不把未确认范围、权限、校验、异常、降级策略或验收口径当成已确认需求。
- 发现缺口时标记 `Needs product decision`，不要自行补全。
- 结果必须写入产品需求文档；不要只把需求整理留在聊天上下文。

## 工作流程

### 1. 确认产品输入

按需读取：

- PRD、Wiki、需求单、飞书/Notion 文档、会议纪要或用户描述
- OpenSpec change：`openspec/changes/<change-id>/proposal.md`、`decisions.md`
- 项目 `AGENTS.md`、README、现有 specs 或相邻业务文档
- 现有相似页面、路由、权限、业务规则和验收说明

整理产品来源索引：

- 来源名称、链接或文件路径
- 来源类型、版本、更新时间和读取时间
- 可信度：confirmed / likely / stale / conflict / unknown
- 来源覆盖的业务范围和不覆盖范围
- 多来源冲突点和需要产品 owner 拍板的问题

如果输入不足以形成产品需求，只输出来源审计、已知事实和 `Needs product decision`，不要补写完整范围、规则或验收。

整理产品事实：

- 目标用户、业务目标和成功标准
- 页面、流程或模块的业务范围
- 非目标和明确不做的内容
- 影响产品范围的依赖：权限、数据、运营配置、灰度、合规或上下游系统

### 2. 提炼业务范围

输出产品范围，不输出设计结构、接口字段或实现任务：

- 业务对象和核心动作
- 新增、编辑、删除、查看、搜索、筛选、导入、导出等能力
- 页面或流程入口
- 角色、权限、租户、区域、语言、状态机等规则
- 数据生命周期、引用保护、审核流或风控要求

范围必须分成：

- `In Scope`：产品材料明确要求或 owner 已确认的能力。
- `Out of Scope`：产品材料明确不做的内容。
- `Needs product decision`：会影响实现、设计或接口，但产品材料未确认的范围。

### 3. 提炼产品规则和异常

必须覆盖：

- 字段含义和业务校验
- 默认值、枚举、边界值、长文本、空值
- 成功、失败、取消、撤销、重复提交
- 空数据、无权限、不可编辑、不可删除、引用中、过期、禁用
- 提示文案的产品语义，而不是视觉样式或组件表现

如果输入材料只有“正常成功态”，也要列出需要产品确认的异常和边界状态。

### 4. 输出验收口径

至少写清：

- 用户能完成哪些任务
- 哪些状态算通过
- 哪些数据或权限场景必须覆盖
- 哪些产品口径仍未确认
- 是否允许静态展示、前端兜底、本地过滤或阶段性降级；未明确时标记 `Needs product decision`

验收口径只描述业务可接受结果，不写视觉验收点、接口测试点或代码验收命令。

### 5. 生成产品需求文档

如果存在 active OpenSpec change，优先输出到 `openspec/changes/<change-id>/docs/product-requirements.md`。否则默认输出到 `docs/ai/product-requirements.md`，除非项目已有更合适的文档约定。

使用 `assets/templates/product-requirements.md` 作为基础模板。

如果人工审核发现产品需求不准，直接修改 `product-requirements.md`。有取舍、争议或 owner 的内容，写入 active change 的 `decisions.md`，不要只在聊天里纠正。

最终回复必须包含：

- 产物文件路径
- 产品来源索引和可信度
- 业务目标和范围摘要
- 关键业务规则
- 权限、异常和验收口径
- 必须确认的产品问题
- 建议下一步：设计需求、接口需求或产品/UI/API 对齐

## 与其他 skill 的关系

- 前置：`frontend-project-bootstrap`
- OpenSpec 编排：`frontend-openspec-workflow`
- 后续设计需求：`frontend-design-requirements`
- 后续接口需求：`frontend-api-requirements`
- 后续对齐需求：`frontend-alignment-requirements`
- 后续实现：`frontend-code-implementation`

推荐顺序：

```text
frontend-product-requirements
→ frontend-design-requirements
→ frontend-api-requirements
→ frontend-alignment-requirements
→ writing-plans
→ frontend-code-implementation
```

## 常见失败

- 只在聊天里总结 PRD，没有写入 `product-requirements.md`。
- 把设计稿上的字段当成产品已确认字段。
- 把接口返回字段当成产品语义。
- 把 mock 或历史页面表现当成产品事实。
- 在产品需求里提前写组件、接口、adapter 或实现方案。
- 只写正常流程，遗漏权限、异常、边界和验收口径。
- 产品需求被指出不准后，只口头确认，不更新文件。
- 在产品范围不清楚时提前生成 tasks 或实现代码。

## 资源

- `assets/templates/product-requirements.md`
