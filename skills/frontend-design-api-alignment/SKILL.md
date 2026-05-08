---
name: frontend-design-api-alignment
description: Use when 对齐前端设计拆解和接口契约；比较 Figma 字段、页面状态、筛选、分页、排序、权限、错误态、枚举、mock 与 API response；在写代码前输出字段映射、差异清单、adapter 决策和 Needs design/product/backend decision。
---

# 设计接口对齐

## 概览

在写业务代码前，对齐设计拆解和接口契约，确认页面要展示什么、接口能提供什么、差异应该在哪里处理。这个 skill 只产出对齐文档和决策清单，不实现页面代码。

核心原则：**不对齐，不实现。**

## 输入

优先读取：

- `docs/ai/design-breakdown.md`
- `docs/ai/api-contract.md`
- `docs/ai/component-map.md`
- `docs/ai/component-usage.md`
- `AGENTS.md`
- Figma 链接、PRD、接口文档或用户补充说明

如果缺少设计拆解或接口契约，先要求补齐对应上游产物，不要直接对齐空白信息。

## 硬性边界

- 不写页面代码。
- 不创建或修改组件、service、types、mock。
- 不根据设计稿猜接口字段。
- 不根据 mock 反推真实接口结构。
- 不把产品语义冲突伪装成前端 adapter。
- 不清楚的信息必须标记为 `Needs design decision`、`Needs product decision` 或 `Needs backend decision`。

## 工作流程

### 1. 建立对齐基线

分别提取：

- 设计字段：页面上出现的文案、字段、筛选项、表格列、详情项、表单项。
- 接口字段：请求参数、响应字段、枚举、分页、错误码、权限字段。
- 设计状态：default、loading、empty、error、permission、disabled、success。
- 接口状态：HTTP 状态码、业务码、错误结构、空数据结构、权限结构。
- 交互能力：搜索、筛选、分页、排序、上传、下载、批量操作、导入导出。

### 2. 建字段映射

为每个设计字段给出映射结论：

- `direct`：接口字段可直接展示。
- `format`：需要格式化，例如时间、金额、百分比、枚举文案。
- `combine`：由多个接口字段组合。
- `derive`：由接口字段计算得出。
- `frontend-only`：纯前端展示，不依赖接口。
- `missing-in-api`：设计需要但接口没有。
- `missing-in-design`：接口提供但设计没有展示。

字段转换优先放在 service/adapter 层，不散落在页面组件里。

### 3. 对齐状态和错误

检查：

- 空数据如何判断。
- loading 是否覆盖首次加载和局部刷新。
- error 是否覆盖网络错误、业务错误、参数错误。
- permission 是否有接口字段或错误码支持。
- disabled/submitting/success 是否有明确触发条件。
- 设计中的状态是否需要后端枚举或业务码。

### 4. 对齐查询能力

检查搜索、筛选、分页、排序：

- 设计上有哪些控件。
- 接口是否有对应参数。
- 参数类型、默认值、枚举范围是否明确。
- 排序字段和排序方向是否受支持。
- 分页结构是否和项目约定一致。

接口不支持的交互不能直接实现为“假筛选”或“前端本地过滤”，除非产品明确接受。

### 5. 分类差异和决策

把差异分成四类：

- 可直接实现：设计和接口一致。
- 前端适配：字段名、格式化、枚举文案、轻量组合可在 adapter/service 层处理。
- 需要产品/设计确认：展示语义、交互流程、状态表现不一致。
- 需要后端确认：字段缺失、参数缺失、枚举缺失、错误码缺失、权限结构缺失。

### 6. 输出对齐文档

默认输出到 `docs/ai/design-api-alignment.md`，除非项目已有更合适的文档约定。

使用 `assets/templates/design-api-alignment.md` 作为基础模板。

最终回复必须包含：

- 对齐输入来源
- 字段映射摘要
- 状态映射摘要
- 查询能力对齐结论
- 可前端 adapter 的清单
- 必须确认的问题
- 是否允许进入实现阶段

## 进入实现的条件

只有满足全部条件，才建议进入 `figma-titan-to-code` 或 `writing-plans`：

- 关键展示字段都有来源或明确决策。
- loading、empty、error、permission 等关键状态有处理规则。
- 搜索、筛选、分页、排序能力已确认。
- 接口缺失项已决策为后端补齐、产品调整或前端移除。
- adapter 规则明确放在 service/adapter 层。

## 与其他 skill 的关系

- 前置设计拆解：`frontend-design-breakdown`
- 前置接口契约：`frontend-api-contract`
- 后续实现计划：`writing-plans`
- 后续实现：`figma-titan-to-code`
- 后续验收：`frontend-visual-verification`
- 后续 Review：`codex-review-frontend`

推荐顺序：

```text
frontend-design-breakdown
→ frontend-api-contract
→ frontend-design-api-alignment
→ writing-plans
→ figma-titan-to-code
```

## 常见失败

- 设计字段和接口字段没对上，就直接写页面。
- 接口没有筛选参数，却做了看似可用的本地筛选。
- mock 有字段就当真实接口有字段。
- 把产品语义冲突塞进前端 adapter。
- 状态码和错误结构没确认，只写成功态。

## 资源

- `assets/templates/design-api-alignment.md`
- `assets/templates/alignment-decision-log.md`
