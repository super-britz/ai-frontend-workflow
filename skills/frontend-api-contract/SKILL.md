---
name: frontend-api-contract
description: Use when 处理前端接口文档、OpenAPI、Swagger、Apifox、YApi、接口契约、API types、request service、mock、联调、分页、错误码、权限、loading/empty/error 状态，或防止 AI 根据 UI 猜接口字段和响应结构。
---

# 前端接口契约

## 概览

把后端接口文档沉淀成前端可执行的接口契约。重点是让 Agent 明确字段、类型、service、mock、状态处理和未决问题，避免根据 UI 或臆测生成接口代码。

这个 skill 默认先产出契约文档和接入规则，不直接实现页面。只有接口契约已确认，且用户明确要求生成代码时，才可以生成 types、service、mock 等接口层代码；仍然不负责实现业务页面，也不替代 OpenAPI 代码生成工具。

如果当前任务同时涉及设计稿，接口契约生成后应进入 `frontend-design-api-alignment`，先对齐设计字段、接口字段、状态、权限和差异决策，再进入实现。

## 执行原则

- 先确认接口来源，再生成前端契约。
- 优先使用结构化来源：OpenAPI / Swagger / Apifox / YApi 导出。
- Markdown、飞书、截图或口头说明只能作为补充，不能覆盖结构化接口源。
- 不根据 UI 猜字段、分页结构、错误码、权限规则或响应包裹结构。
- 不把接口请求散落在页面组件里，必须遵守项目已有 request/service 分层。
- 不重复定义已有类型；先搜索已有 types、services、mocks 和相邻页面。
- 不清楚的信息标记为 `Needs backend decision`，不要自行补全。
- 未确认契约前，不创建或修改业务页面代码。
- 如需生成代码，只生成接口层：types、service、mock、fixtures 或测试，不写页面展示逻辑。

## 工作流程

### 1. 探测项目接口约定

按需读取：

- `package.json`、接口生成脚本、mock 脚本
- `AGENTS.md`、`README.md`、`docs/`
- request 封装：`request`、`http`、`axios`、`fetch`、`client`
- service 目录：`api/`、`services/`、`request/`
- 类型目录：`types/`、`interfaces/`、`model/`
- mock 目录：`mock/`、`mocks/`、`fixtures/`
- 相邻页面的列表、详情、创建、编辑、删除接口接入方式

整理：

- 请求库和封装入口
- service 命名与文件组织
- 类型命名与导出方式
- 响应包裹结构
- 分页结构
- 错误码与错误提示方式
- 鉴权、权限、租户、语言、环境变量规则
- mock 与联调方式

### 2. 读取接口来源

来源优先级：

1. OpenAPI / Swagger JSON 或 YAML
2. Apifox / YApi 导出
3. 后端维护的 Markdown / 文档平台
4. 已有前端 service 与后端联调代码
5. UI 设计稿或需求描述

如果多个来源冲突：

- 以结构化接口源为准。
- 记录冲突字段、路径、类型或状态码。
- 在最终回复中标记需要后端确认。

### 3. 生成或更新接口契约文档

默认生成到 `docs/ai/api-contract.md`，除非仓库已有接口文档约定。

使用 `assets/templates/api-contract.md` 作为基础模板，必须写清：

- 文档来源与更新时间
- 全局请求和响应约定
- 接口清单
- 每个接口的用途、权限、请求参数、响应字段、错误状态
- 前端 service 方法名
- TypeScript 类型名
- mock 示例
- loading、empty、error、permission、success 状态映射
- 未决问题

### 4. 生成前端接入规则

需要写清 Agent 后续实现时应该如何接入：

- service 文件路径和方法命名
- request 封装调用方式
- params、body、query 的传参规则
- 类型定义位置
- mock 数据位置
- 错误提示和空状态处理方式
- 是否需要取消请求、防抖、节流、缓存或轮询
- 是否需要权限、租户、语言或环境参数

可使用 `assets/templates/api-integration-checklist.md`。

### 5. 可选生成接口层代码

只有满足全部条件才进入本步骤：

- 用户明确要求生成接口层代码。
- `docs/ai/api-contract.md` 已确认或未决项不影响本次接口。
- 项目已有 request/service/types/mock 约定已识别。
- 不需要靠 UI 或 mock 反推字段。

允许生成：

- TypeScript 类型
- service 方法
- mock / fixtures
- service 测试或类型测试

禁止生成：

- 页面组件
- 业务表单逻辑
- 路由和权限配置
- 设计还原代码
- 未确认字段的兼容逻辑

### 6. 定义质量门禁

接口相关改动完成前必须检查：

- 类型与接口文档一致。
- service 只做请求封装和轻量数据适配，不承载页面状态。
- 页面不硬编码接口路径、状态码、分页结构或响应包裹结构。
- mock 数据覆盖成功、空、错误、权限不足和边界字段。
- 新增逻辑有单元测试、service 测试或关键路径 E2E。
- 可用的 lint、typecheck、test、build 已运行。

### 7. 汇报结果

最终回复必须包含：

- 接口来源和可信度。
- 创建或更新了哪些契约文档。
- 已确认的全局接口约定。
- 仍需后端确认的问题。
- 建议下一个前端接入任务。

## 推荐默认值

- 仓库文档路径：`docs/ai/api-contract.md`
- 接入检查清单：`docs/ai/api-integration-checklist.md`
- 未确认字段统一写 `Needs backend decision`
- 类型命名：`XxxParams`、`XxxRequest`、`XxxResponse`、`XxxItem`
- service 方法命名：`getXxxList`、`getXxxDetail`、`createXxx`、`updateXxx`、`deleteXxx`

## 常见失败

- 看着页面设计稿猜接口字段。
- 直接复制 mock 当真实接口契约。
- 在页面组件里散写 `axios.get('/xxx')`。
- 为单个页面重复定义已有分页、错误码或响应包裹类型。
- 忽略后端错误结构，导致前端只处理成功态。
- 接口字段不明确时自行发明字段名。

## 资源

- `assets/templates/api-contract.md`
- `assets/templates/api-integration-checklist.md`
- `assets/templates/api-source-audit.md`
- `assets/templates/mock-data-rules.md`
