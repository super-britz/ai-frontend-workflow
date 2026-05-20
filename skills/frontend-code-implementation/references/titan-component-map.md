# Titan 组件映射表

当仓库使用 `@ninebot/pc-titan-components`，或项目规则要求优先使用 Titan 时，按本文件把 Figma 视觉形态翻译成 Titan 与 Element Plus 组件。

## 优先级

1. 优先使用 Titan 组件。
2. Titan 没覆盖时，使用 Element Plus 作为表单容器、基础交互或 fallback。
3. Titan 和 Element Plus 都不合适时，再使用原生 HTML 或自定义布局。

如果 Figma 视觉细节与这些规则冲突，优先遵守本规则；通过规范化间距、token、布局和局部样式保持视觉接近。

## 包和组件约定

- Titan 组件来自 `@ninebot/pc-titan-components`。
- Titan 组件前缀是 `Ti`。
- 不要用 Element Plus 替代 Titan 已覆盖的组件。
- 页面样式使用 `<style scoped>`。
- 不要用 inline style 做布局或视觉样式。

## Figma 形态识别

Figma 中很多元素可能只是矩形、文字和图标组合，不一定是真实组件实例。实现时根据外观、行为和业务语义推断组件。

| Figma 形态或行为 | 使用 | 避免 |
|---|---|---|
| 带放大镜图标的搜索输入框 | `TiSearchInput` | `el-input` 加 prefix icon |
| 带可移除标签的多选下拉 | `TiMultipleSelect` | `el-select multiple` |
| 可搜索下拉框 | `TiSearchSelect` | `el-select filterable` |
| 多个有关联的筛选下拉 | `TiSelectGroup` | 临时拼 wrapper |
| 级联地区/分类选择 | `TiCascader` | `el-cascader` |
| 日期或日期范围 | `TiDatePicker` | `el-date-picker` |
| 横向单选项 | `TiRadioGroup` | `el-radio-group` |
| 按钮式分段选择 | `TiWeightButtonGroup` | button 样式 radio group |
| 数据表格 | `TiTable` | `el-table` |
| 表格强调渐变列 | `TiTableColumnGradient` | 自定义渐变 div |
| 可拖拽排序表格 | `TiTableSort` | 手写拖拽表格 |
| 横向标签页 | `TiTabs` | `el-tabs` |
| 步骤条 | `TiSteps` | `el-steps` |
| 空状态插图和文案 | `TiEmpty` | `el-empty` |
| SVG 图标 | `TiSvgIcon` | `el-icon` |
| 居中弹窗 | `TiDialog` | `el-dialog` |
| 全屏弹窗 | `TiDialogFull` | `el-dialog fullscreen` |
| 侧边抽屉 | `TiDrawer` | `el-drawer` |
| 弹窗中的树选择 | `TiTreeSelectDialog` | 自定义 dialog + tree |
| 确认或警告弹窗 | `TiMessageBox` | `ElMessageBox` |
| 列表页搜索/筛选卡片 | `TiSearchCard` | `el-card` 加 `el-form` |
| 双栏卡片布局 | `TiTwoColumnLayoutCard` | 自定义卡片布局 |
| 横向可拖拽卡片 | `TiHorizontalDraggerCard` | 自定义拖拽区域 |
| 行内可编辑表单项 | `TiFormItemEdit` | 自定义展示/输入切换 |
| 图片上传网格 | `TiImgUpload` | `el-upload` |
| 视频上传 | `TiVideoUpload` | `el-upload` |
| 视频预览 | `TiVideoPreview` | 自定义播放器 |
| 文件上传列表 | `TiFileUpload` | `el-upload` |
| 自定义样式文件上传 | `TiCustomFileUpload` | `el-upload` |

## Element Plus 允许场景

以下组件可以使用，因为 Titan 没覆盖，或推荐模式本身需要 Element Plus 容器配合 Titan 控件：

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
- 表单容器：`el-form`、`el-form-item`
- 按钮：`el-button`
- 普通输入框和数字输入框：`el-input`、`el-input-number`
- 普通单选下拉，且不需要搜索：`el-select`

## 表单模式

使用 Element Plus 表单容器，内部优先放 Titan 输入控件：

```vue
<el-form :model="form" label-width="100px">
  <el-form-item label="关键词">
    <TiSearchInput v-model="form.keyword" />
  </el-form-item>
  <el-form-item label="时间">
    <TiDatePicker v-model="form.date" type="daterange" />
  </el-form-item>
  <el-form-item label="类型">
    <TiMultipleSelect v-model="form.types" :options="typeOptions" />
  </el-form-item>
</el-form>
```

## Token 和布局

- 间距优先使用 `4px`、`8px`、`12px`、`16px`、`20px`。
- 将 Figma 中任意间距值规范化到最近的允许值。
- 大于 `20px` 的间距通常也应归一到 `20px`，除非项目既有页面明确使用更大的模式。
- 颜色、字号、圆角、阴影优先使用 Element Plus 或 Titan CSS 变量。
- 不要在样式中硬编码 hex 颜色。
- 控件高度使用标准值：`large` 40px，默认 32px，`small` 24px。
- Figma 中 28px、30px、36px 等中间高度应归一到最近标准控件高度。
- 优先用 flex 布局；复杂二维布局使用 grid。
- 相邻元素间距优先用 `gap`，少用 margin。
- 响应式断点使用 `576`、`768`、`992`、`1200`、`1920`。

## 自检

- 没有用 Element Plus 替代 Titan 已覆盖的组件。
- 所有 `Ti*` 组件都来自 `@ninebot/pc-titan-components` 或项目已注册的 Titan 组件体系。
- 没有遗留项目规则禁止的硬编码颜色。
- 间距符合允许值。
- 表单使用 `el-form` 和 `el-form-item` 容器，并在其中优先使用 Titan 控件。
- 复杂业务布局使用 flex/grid，不强行把每个区域都塞进卡片组件。
