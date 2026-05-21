# 接口接入检查清单

## 接入前

- 已确认接口来源和更新时间。
- 已确认全局响应包裹结构。
- 已确认分页、错误码、权限和鉴权规则。
- 已搜索已有 service、types、mock 和相邻页面实现。
- 不明确字段已标记 `Needs backend decision`。

## 代码结构

- 请求只通过项目 request 封装发出。
- service 方法放在项目约定目录。
- 类型定义放在项目约定目录。
- 页面组件不硬编码接口路径、状态码、分页结构。
- 不重复定义已有全局类型。

## 状态处理

- loading
- empty
- error
- permission
- disabled
- success
- retry

## Mock 与测试

- mock 覆盖成功态。
- mock 覆盖空态。
- mock 覆盖错误态。
- mock 覆盖权限不足。
- mock 覆盖字段缺失或边界值。
- 已补 service 测试、组件测试或关键路径 E2E。

## 验证命令

- Lint：
- Typecheck：
- Test：
- Build：
- E2E：
