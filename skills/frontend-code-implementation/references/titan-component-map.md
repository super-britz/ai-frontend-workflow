# Titan 组件按需加载索引

当仓库使用 `@ninebot/pc-titan-components`，或项目规则要求优先使用 Titan 时，先读本文件判断组件族，再只读取相关子文件。不要一次性读取 `titan-components/` 下所有文件。

## 使用顺序

1. 先读 `titan-components/common.md`，确认 API 溯源顺序、Element Plus fallback、表单、token 和自检规则。
2. 根据 Figma 形态或业务语义，在下方表格找到目标组件和对应规则文件。
3. 只读取本次页面涉及的组件族文件；如果同一页面同时包含表格、筛选和弹窗，只读 `selectors-and-inputs.md`、`tables.md`、`overlays.md`。
4. 组件族文件仍不足时，再搜索目标仓库真实调用与 `packages/pc-titan-components/src/components/<component>/` 源码、`types.ts`、README、`demo.vue`。

## 关键原则

- Titan 组件不是 Element Plus 的同名皮肤。先判断组件是“透明透传型”还是“业务封装型”。
- 透明透传型，例如 `TiSelect`、`TiSearchInput`，可以参考 Element Plus props/slots/events 并叠加 Titan 默认样式。
- 业务封装型，例如 `TiSearchSelect`、`TiMultipleSelect`、`TiTable`、`TiDialog`、`TiDrawer`、上传组件，必须按 Titan 自己的 props/events/slots 使用。
- Element Plus 官方 API 只作为透传型组件的补充，不作为业务封装型组件的默认依据。
- 不要根据 Figma 图层名推断 API；Figma 只表达形态和意图，组件 API 以源码和真实调用为准。

## 按需路由

| Figma 形态或行为 | 使用 | 规则文件 |
|---|---|---|
| 带放大镜图标的搜索输入框 | `TiSearchInput` | `titan-components/selectors-and-inputs.md` |
| 普通下拉，或需要完整 Element Plus Select 能力 | `TiSelect` | `titan-components/selectors-and-inputs.md` |
| 带左侧 label 的紧凑筛选下拉 | `TiSearchSelect` | `titan-components/selectors-and-inputs.md` |
| 远程搜索、分页加载、虚拟列表下拉 | `TiRemoteSearchSelect` | `titan-components/selectors-and-inputs.md` |
| 带可移除标签、复选项、可全选的多选下拉 | `TiMultipleSelect` | `titan-components/selectors-and-inputs.md` |
| 多个有关联的筛选下拉 + 输入 | `TiSelectGroup` | `titan-components/selectors-and-inputs.md` |
| 级联地区/分类选择 | `TiCascader` | `titan-components/selectors-and-inputs.md` |
| 日期或日期范围 | `TiDatePicker` | `titan-components/selectors-and-inputs.md` |
| 横向按钮式单选 | `TiRadioGroup` | `titan-components/selectors-and-inputs.md` |
| 居中弹窗 | `TiDialog` | `titan-components/overlays.md` |
| 全屏弹窗 | `TiDialogFull` | `titan-components/overlays.md` |
| 侧边抽屉 | `TiDrawer` | `titan-components/overlays.md` |
| 弹窗中的树选择 | `TiTreeSelectDialog` | `titan-components/overlays.md` |
| 属性/字段穿梭选择弹窗 | `TiTransferDialog` | `titan-components/overlays.md` |
| 确认或警告弹窗 | `MessageBox` from `TiMessageBox` | `titan-components/overlays.md` |
| 多语言配置弹窗 | `TiMultilingual` | `titan-components/layout-display.md` |
| 数据表格 + 分页 | `TiTable` | `titan-components/tables.md` |
| 表格强调渐变列 | `TiTableColumnGradient` | `titan-components/tables.md` |
| 可拖拽排序表格 | `TiTableSort` | `titan-components/tables.md` |
| 图片上传网格 | `TiImgUpload` | `titan-components/uploads.md` |
| 视频上传 | `TiVideoUpload` | `titan-components/uploads.md` |
| 视频预览 | `TiVideoPreview` | `titan-components/uploads.md` |
| 文件上传列表 | `TiFileUpload` | `titan-components/uploads.md` |
| 自定义上传流程/下载/预览/替换按钮 | `TiCustomFileUpload` | `titan-components/uploads.md` |
| 横向标签页 | `TiTabs` | `titan-components/layout-display.md` |
| 步骤条 | `TiSteps` | `titan-components/layout-display.md` |
| 标签组、超出折叠、tooltip | `TiTagGroup` | `titan-components/layout-display.md` |
| 空状态插图和文案 | `TiEmpty` | `titan-components/layout-display.md` |
| SVG 在线图标 | `TiSvgIcon` | `titan-components/layout-display.md` |
| 列表页搜索/筛选卡片 | `TiSearchCard` | `titan-components/layout-display.md` |
| 双栏卡片布局 | `TiTwoColumnLayoutCard` | `titan-components/layout-display.md` |
| 横向可拖拽卡片 | `TiHorizontalDraggerCard` | `titan-components/layout-display.md` |
| 行内展示/编辑表单项 | `TiFormItemEdit` | `titan-components/layout-display.md` |
| 按钮组，最后一个按钮为主按钮 | `TiWeightButtonGroup` | `titan-components/layout-display.md` |

## 自检

- 已读取 `titan-components/common.md`。
- 已按本次涉及的组件族读取对应文件，没有一次性加载全部组件规则。
- 已确认目标组件真实 props/events/slots，而不是照搬 Element Plus。
- 若规则文件未覆盖目标场景，已搜索目标仓库真实调用和组件库源码。
