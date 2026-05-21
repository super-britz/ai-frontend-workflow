# Titan 通用规则

本文件只放跨组件通用规则。具体组件 props/events/slots 请按入口文件路由读取对应组件族文件。

## API 溯源顺序

实现前必须按这个顺序确认组件用法：

1. 目标业务仓库里的真实调用：`rg "TiDialog|TiSelect|TiTable|ti-dialog|ti-select"`。
2. 当前组件库源码：`packages/pc-titan-components/src/components/<component>/`。
3. 组件类型文件：`types.ts` 或 `src/*.ts` 中的 props、emits、接口定义。
4. 组件 `README.md` 和 `demo.vue`。
5. Element Plus 官方 API 只作为透传型组件的补充，不作为业务封装型组件的默认依据。

禁止行为：

- 不要因为组件内部用了 `el-select`、`el-dialog`、`el-upload`，就在调用侧直接写 Element Plus 的完整用法。
- 不要把 Element Plus 的 `v-model`、`#footer`、`@close`、`@confirm` 默认套到 Titan 组件上。
- 不要用 Element Plus 替代 Titan 已覆盖的组件，除非 Titan 无法覆盖目标交互，且已在实现说明中解释。
- 不要根据 Figma 图层名推断 API。Figma 只表达形态和意图，组件 API 以源码和真实调用为准。

## 包和注册约定

- 包名：`@ninebot/pc-titan-components`。
- 组件前缀：`Ti`。
- 全量安装时通过插件注册；局部引入时从包导出组件，例如 `import { TiSelect } from '@ninebot/pc-titan-components'`。
- 页面样式使用 `<style scoped>`。
- 不要用 inline style 做稳定布局或视觉样式；demo 里的 inline style 只作为演示，不作为业务页面规范。
- 旧目录中可能存在被注释导出的 legacy `dialog`、`drawer`。实现新页面优先使用新版 `src/components/TiDialog` 和 `src/components/TiDrawer`。

## 组件优先级

1. 优先使用 Titan 组件。
2. Titan 没覆盖时，使用 Element Plus 作为表单容器、基础交互或 fallback。
3. Titan 和 Element Plus 都不合适时，再使用原生 HTML 或自定义布局。

如果 Figma 视觉细节与这些规则冲突，优先遵守本规则；通过规范化间距、token、布局和局部样式保持视觉接近。

## Element Plus 允许场景

以下组件可以使用，因为 Titan 没覆盖，或推荐模式本身需要 Element Plus 容器配合 Titan 控件：

- 表单容器：`el-form`、`el-form-item`
- 按钮：`el-button`
- 普通输入框和数字输入框：`el-input`、`el-input-number`
- 普通单选下拉，且不需要 Titan 统一样式或特殊交互：`el-select`
- 分页：`el-pagination`
- 气泡确认：`el-popconfirm`
- 提示：`el-tooltip`
- 弹出层：`el-popover`
- 通知和消息 API：`ElNotification`、`ElMessage`
- 加载指令：`v-loading`
- 图片预览：`el-image`
- 标签：`el-tag`
- 开关：`el-switch`
- 复选框：`el-checkbox`、`el-checkbox-group`

## 表单模式

使用 Element Plus 表单容器，内部优先放 Titan 输入控件：

```vue
<el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
  <el-form-item label="关键词" prop="keyword">
    <TiSearchInput v-model="form.keyword" placeholder="请输入" />
  </el-form-item>
  <el-form-item label="时间" prop="dateRange">
    <TiDatePicker v-model="form.dateRange" type="daterange" />
  </el-form-item>
  <el-form-item label="类型" prop="types">
    <TiMultipleSelect v-model="form.types" :options="typeOptions" />
  </el-form-item>
</el-form>
```

表单校验规则：

- `el-form-item` 的 `prop` 必须对应 model 字段。
- rules 要显式设置 `trigger`，例如输入控件 `blur`，下拉/日期/上传组件 `change`。
- 提交时调用 `await formRef.value?.validate()`，不要只靠按钮 disabled 代替错误反馈。

## Token 和布局

- 间距优先使用 `4px`、`8px`、`12px`、`16px`、`20px`。
- 将 Figma 中任意间距值规范化到最近的允许值。
- 大于 `20px` 的间距通常也应归一到 `20px`，除非项目既有页面明确使用更大的模式。
- 颜色、字号、圆角、阴影优先使用 Element Plus 或 Titan CSS 变量。
- 不要在样式中硬编码 hex 颜色，除非是组件 API 明确要求的配置值，例如 `TiSteps.colorConfig`。
- 控件高度使用标准值：`large` 40px，默认 32px，`small` 24px。
- Figma 中 28px、30px、36px 等中间高度应归一到最近标准控件高度。
- 优先用 flex 布局；复杂二维布局使用 grid。
- 相邻元素间距优先用 `gap`，少用 margin。
- 响应式断点使用 `576`、`768`、`992`、`1200`、`1920`。

## 自检

- 已按“API 溯源顺序”确认目标组件真实 API。
- 没有用 Element Plus 替代 Titan 已覆盖的组件。
- 没有把业务封装型 Titan 组件当成透明 Element Plus 组件使用。
- 所有 `Ti*` 组件都来自 `@ninebot/pc-titan-components` 或项目已注册的 Titan 组件体系。
- `TiDialog` 使用 `visible`、`header-title`、`@onClose`、`@onSubmit`、`#dialog-footer`。
- `TiDrawer` 使用 `visible`、`header-title`、`@close`、`@sure`、`#drawer-footer`。
- `TiTable` 使用 `table-data`、`columns`、`pagination-info` 和 `onPage*` 事件。
- 远程下拉的 `request` 返回 `{ list, hasMore?, total? }`。
- 上传组件放在表单中时，校验 trigger 使用 `change`。
- 没有遗留项目规则禁止的硬编码颜色。
- 间距符合允许值。
- 表单使用 `el-form` 和 `el-form-item` 容器，并在其中优先使用 Titan 控件。
- 复杂业务布局使用 flex/grid，不强行把每个区域都塞进卡片组件。
