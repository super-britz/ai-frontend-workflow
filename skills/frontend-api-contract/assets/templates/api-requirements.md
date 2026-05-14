# 前端接口契约

## 来源

- 文档来源：
- 来源类型：OpenAPI / Swagger / Apifox / YApi / Markdown / 其他
- 更新时间：
- 后端负责人：
- 前端负责人：
- 环境：
- Base URL：
- 可信度：已确认 / 部分确认 / 待确认

## 全局约定

- 鉴权方式：
- 请求封装：
- 响应包裹结构：
- 错误结构：
- 分页结构：
- 时间格式：
- 文件上传：
- 文件下载：
- 多语言/租户/权限参数：

## 接口清单

| 场景 | 方法 | 路径 | Service 方法 | 请求类型 | 响应类型 | 状态 |
| --- | --- | --- | --- | --- | --- | --- |
| 获取列表 | GET | `/xxx/list` | `getXxxList` | `XxxListParams` | `XxxListResponse` | 待确认 |

## 接口详情

### 获取列表

- 方法：`GET`
- 路径：`/xxx/list`
- 用途：
- 权限：
- 缓存：
- 防抖/节流：
- 取消请求：

#### 请求参数

| 字段 | 类型 | 必填 | 默认值 | 说明 | 来源 |
| --- | --- | --- | --- | --- | --- |
| pageNo | number | 是 | 1 | 页码 | 文档 |
| pageSize | number | 是 | 20 | 每页数量 | 文档 |

#### 响应数据

| 字段 | 类型 | 必填 | 说明 | 来源 |
| --- | --- | --- | --- | --- |
| list | XxxItem[] | 是 | 列表数据 | 文档 |
| total | number | 是 | 总数 | 文档 |

#### 错误与边界

| 场景 | 状态码/业务码 | 前端处理 |
| --- | --- | --- |
| 无权限 |  |  |
| 参数错误 |  |  |
| 服务异常 |  |  |

#### 前端状态映射

- loading：
- empty：
- error：
- permission：
- success：
- retry：

#### TypeScript 类型

```ts
export interface XxxListParams {
  pageNo: number;
  pageSize: number;
}

export interface XxxItem {
  id: string;
}

export interface XxxListResponse {
  list: XxxItem[];
  total: number;
}
```

#### Service 方法

```ts
export function getXxxList(params: XxxListParams) {
  return request<XxxListResponse>({
    url: '/xxx/list',
    method: 'GET',
    params,
  });
}
```

#### Mock 示例

```json
{
  "code": 0,
  "message": "success",
  "data": {
    "list": [],
    "total": 0
  }
}
```

## 未决问题

- `Needs backend decision`：
