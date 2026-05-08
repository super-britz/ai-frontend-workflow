# 设计接口对齐

## 基本信息

- 页面/模块：
- 设计拆解来源：
- 接口契约来源：
- 接口依赖：required / api-not-required
- 对齐时间：
- 负责人：
- 是否允许进入实现：否

## 输入来源

| 类型 | 路径/链接 | 状态 | 备注 |
| --- | --- | --- | --- |
| 设计拆解 | `docs/ai/design-breakdown.md` | 待确认 |  |
| 接口契约 | `docs/ai/api-contract.md` | 待确认 |  |

## 无接口依赖说明

- 是否 `api-not-required`：
- 静态数据来源：
- 状态豁免原因：
- 仍需验收的视觉/交互点：

## 字段映射

| 设计字段 | 设计文案 | 接口字段 | 类型 | 映射方式 | 处理层 | 状态 | 备注 |
| --- | --- | --- | --- | --- | --- | --- | --- |
|  |  |  |  | direct / format / combine / derive / frontend-only / missing-in-api / missing-in-design | service / adapter / component | 待确认 |  |

## 状态映射

| 页面状态 | 设计表现 | 接口依据 | 前端处理 | 状态 |
| --- | --- | --- | --- | --- |
| loading |  | 请求中 |  | 待确认 |
| empty |  | 空列表/空对象 |  | 待确认 |
| error |  | HTTP 状态码/业务码 |  | 待确认 |
| permission |  | 权限字段/错误码 |  | 待确认 |
| disabled |  | 字段/权限/流程状态 |  | 待确认 |
| success |  | 操作结果 |  | 待确认 |

## 查询能力对齐

| 能力 | 设计控件 | 接口参数 | 默认值 | 是否支持 | 决策 |
| --- | --- | --- | --- | --- | --- |
| 搜索 |  |  |  | 待确认 |  |
| 筛选 |  |  |  | 待确认 |  |
| 分页 |  |  |  | 待确认 |  |
| 排序 |  |  |  | 待确认 |  |

## 前端 Adapter 决策

| 场景 | 输入字段 | 输出字段 | 处理位置 | 规则 |
| --- | --- | --- | --- | --- |
|  |  |  | service / adapter |  |

## 差异清单

| 优先级 | 类型 | 差异 | 影响 | 决策 |
| --- | --- | --- | --- | --- |
| P1 | backend |  | 阻塞实现 | `Needs backend decision` |
| P2 | product |  | 影响交互 | `Needs product decision` |
| P2 | design |  | 影响视觉/状态 | `Needs design decision` |

## 实现准入结论

- 允许进入实现：
- 阻塞项：
- 可并行项：
- 下一步：
