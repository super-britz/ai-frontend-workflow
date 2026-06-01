---
name: frontend-requirements-api
description: Use when 沉淀前端接口契约事实；从 OpenAPI、Swagger、Apifox、YApi、后端接口文档或联调说明记录接口来源、路径、方法、请求、响应、错误、分页、鉴权和未确认项；只输出接口事实和 Needs backend decision，不根据 UI/mock 猜字段，不生成 types/service/mock/test，不写接入方案。
---

# 前端接口需求

## 定位

把后端接口资料沉淀成前端视角的接口契约摘录与缺口清单。

它不是后端接口文档副本；原始接口文档以来源链接或文件路径为准。

它只回答：

- 接口来源是什么，可信度如何。
- 接口路径、方法、请求参数、请求体、响应结构、错误结构是什么。
- 全局鉴权、headers、响应包裹、分页、文件上传下载等契约是什么。
- 哪些接口信息缺失或冲突，需要 `Needs backend decision`。

它不回答 UI 如何展示、service 怎么命名、类型文件放哪里、mock 怎么写、代码怎么接。

## 硬性边界

- 不写业务代码。
- 不创建或修改页面、组件、types、service、mock、fixtures 或测试。
- 不生成 TypeScript interface、service 方法、request 示例或 mock 示例。
- 不写接口接入 checklist、文件路径、命名规范、质量门禁或后续实现方案。
- 不根据 UI、设计稿、mock、历史页面或示例数据反推真实接口字段。
- 不全文搬运接口文档；只摘录前端消费接口必须依赖的契约字段、结构、约束、错误和未决问题。
- 不把口头说明、Markdown、截图覆盖结构化接口源，除非后端明确确认。
- 不把未确认字段、枚举、错误码、分页结构、权限结构当成已确认契约。
- 缺失或冲突只标记 `Needs backend decision`，不要自行补全。
- 结果必须写入接口需求文档；不要只留在聊天上下文。

## 读取内容

来源优先级：

1. OpenAPI / Swagger JSON 或 YAML
2. Apifox / YApi 导出
3. 后端维护的 Markdown、文档平台或联调说明
4. 已有前端 service 或联调代码；只能作为现状参照，不能覆盖后端契约
5. UI、mock 或用户描述；只能提示需要确认的问题，不能作为接口事实

记录：

- 来源名称、链接或文件路径、类型、版本、更新时间、读取时间、负责人和可信度。
- 多来源之间的路径、方法、字段、类型、枚举、状态码、错误结构冲突。
- 缺失但会影响接口契约的信息，统一写 `Needs backend decision`。

## 输出内容

使用 `assets/templates/api-requirements.md` 作为基础模板，输出到：

- active OpenSpec change 存在时：`openspec/changes/<change-id>/docs/api-requirements.md`
- 否则：`docs/ai/api-requirements.md`

文档只沉淀以下内容：

- 接口来源索引：来源、版本、可信度、覆盖范围、冲突。
- 全局契约：Base URL、鉴权、headers、响应包裹、错误结构、分页结构、时间格式、上传/下载约定。
- 接口清单：场景、方法、路径、来源、可信度、状态。
- 接口详情：用途说明、请求路径参数、query、headers、body、响应字段、错误码/业务码、权限/鉴权约束。
- 未决问题：只写 `Needs backend decision`。

字段只记录接口源明确给出的名称、类型、必填、枚举、默认值、说明和来源。接口源没有明确表达时，不要补类型、不猜字段、不写兼容逻辑。

最终回复包含：

- 产物文件路径
- 接口来源和可信度
- 全局接口契约摘要
- 接口覆盖范围摘要
- `Needs backend decision`

## 常见失败

- 看 UI 或 mock 猜接口字段。
- 只在聊天里整理接口，没有写入 `api-requirements.md`。
- 把示例响应当成完整响应契约。
- 把已有前端 service 当成后端最新契约。
- 在接口需求里写 TypeScript、service、mock、测试或接入方案。
- 接口字段不明确时自行发明字段名、类型、枚举或错误码。
- 接口需求被指出不准后，只口头确认，不更新文件。

## 资源

- `assets/templates/api-requirements.md`
