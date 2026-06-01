---
name: frontend-alignment-requirements
description: Use when 对照前端产品事实、UI 设计事实和接口契约事实；读取 product-requirements、design-requirements、api-requirements，输出字段、状态、异常、查询/操作能力的交叉检查与差异清单；只暴露一致、缺失、冲突和 Needs product/design/backend decision，不做实现准入、不写 adapter/service/component 决策、不编排流程。
---

# 前端对齐需求

## 定位

对照产品、UI、API 三类 source of truth，产出前端需求差异清单。

它只回答：

- 产品事实、UI 事实、接口契约是否在描述同一件事。
- 哪些字段、状态、异常、查询/操作能力是一致的。
- 哪些内容缺失、冲突或来源不足。
- 缺口应该归属为 `Needs product decision`、`Needs design decision` 或 `Needs backend decision`。

它不回答怎么实现、由哪层适配、是否允许进入实现、任务怎么拆。

## 硬性边界

- 不写业务代码。
- 不创建或修改页面、组件、types、service、mock、fixtures 或测试。
- 不编排后续任务、推荐顺序、实现计划、验收流程或实现准入。
- 不新增产品事实、UI 事实或接口事实；只引用已有来源。
- 不根据 UI 猜接口字段，不根据 API 反推产品语义，不根据产品描述补 UI 细节。
- 不写 adapter、service、component、backend 实现方案或处理层。
- 不把差异伪装成前端可自行处理的问题。
- 不为完整性强行补齐字段、状态、查询能力或异常矩阵。
- 不清楚的信息只标记对应的 `Needs ... decision`，不要自行补全。
- 结果必须写入对齐差异清单；不要只留在聊天上下文。

## 输入

优先读取已经沉淀的事实文件：

- `docs/ai/product-requirements.md`
- `docs/ai/design-requirements.md`
- `docs/ai/api-requirements.md`
- `openspec/changes/<change-id>/docs/product-requirements.md`
- `openspec/changes/<change-id>/docs/design-requirements.md`
- `openspec/changes/<change-id>/docs/api-requirements.md`

只在事实文件不足时读取原始 PRD、Figma、接口文档或用户补充说明，并把它们记录为补充来源。补充来源不能覆盖已确认事实；冲突时写入差异清单。

如果缺少某一类事实文件，不要强行完整对齐。可以输出“来源不足”的对齐文档，并把受影响项标记为：

- `Needs product decision`
- `Needs design decision`
- `Needs backend decision`

## 输出内容

使用 `assets/templates/alignment-requirements.md` 作为基础模板，输出到：

- active OpenSpec change 存在时：`openspec/changes/<change-id>/docs/alignment-requirements.md`
- 否则：`docs/ai/alignment-requirements.md`

文档只沉淀以下内容：

- 输入来源：产品、UI、API 的路径/链接、可信度、覆盖范围。
- 对齐范围：本次只对照哪些页面、模块、字段、状态或接口。
- 字段/文案/数据差异：UI 可见项、产品语义、API 契约之间的一致、缺失或冲突。
- 状态与异常差异：产品口径、UI 表现、API 错误/状态之间的一致、缺失或冲突。
- 查询/操作能力差异：产品能力、UI 控件、API 支持之间的一致、缺失或冲突。
- 差异清单：每个差异的 owner、影响和状态。

允许的结论值：

- `consistent`
- `missing-in-product`
- `missing-in-design`
- `missing-in-api`
- `conflict`
- `source-insufficient`
- `not-applicable`
- `Needs product decision`
- `Needs design decision`
- `Needs backend decision`

不要输出 `adapter`、`service`、`component`、`implementation-ready`、`allow implement` 等实现导向结论。

最终回复包含：

- 产物文件路径
- 输入来源和可信度
- 对齐范围摘要
- 关键一致项摘要
- 关键差异和对应 `Needs ... decision`

## 常见失败

- 字段、状态或能力没对上，就直接写实现建议。
- 把产品语义冲突说成前端 adapter 可以处理。
- 接口缺字段时建议本地过滤、前端兜底或 mock 字段。
- 缺少产品/UI/API 来源时，仍然强行输出完整对齐矩阵。
- 在对齐文档里写 service、component、adapter、tasks 或实现准入。
- 对齐结果只留在聊天里，没有写入 `alignment-requirements.md`。

## 资源

- `assets/templates/alignment-requirements.md`
