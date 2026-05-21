# Titan 弹窗、抽屉与确认组件

## 弹窗、抽屉和确认

### `TiDialog`

适用：标准居中弹窗。不是 Element Plus `el-dialog` 的直接调用方式。

Props：

- `visible: boolean`
- `headerTitle?: string`
- `showClose?: boolean`，默认 `true`。
- `isShowFooter?: boolean`，默认 `true`。
- `dialogWidth?: string`，默认 `480px`。
- `closeOnClickModal?: boolean`，默认 `false`。
- `scrollLinerConfig?: { isShowTopLine?: boolean; isShowBottomLine?: boolean } | null`
- `headerTitleToolTip?: { content: string; placement?: string; effect?: string; svgName?: string }`
- `footerContentText?: string`
- `footerContentType?: FOOTER_CONTENT_TYPE`
- `footerButtonGroupType?: number`
- `submitBtnLoading?: boolean`
- `submitBtnDisable?: boolean`

事件：

- `onClose`
- `onSubmit`
- `onSelect(value)`，底部复选框模式。

Slots：

- `#header`
- default：弹窗内容。
- `#dialog-footer`：自定义底部。注意不是 Element Plus 的 `#footer`。

常用写法：

```vue
<TiDialog
  :visible="dialogVisible"
  header-title="编辑配置"
  dialog-width="640px"
  :submit-btn-loading="submitting"
  @onClose="dialogVisible = false"
  @onSubmit="submitForm"
>
  <el-form ref="formRef" :model="form" :rules="rules" label-width="96px">
    <!-- form items -->
  </el-form>
</TiDialog>
```

差异：

- 组件不通过 `v-model` 自动回写；父组件必须在 `@onClose` 或 `@onSubmit` 中修改 `visible`。
- 默认 footer 已含取消/确认按钮。只有复杂底部才用 `#dialog-footer`。
- 标题字段是 `headerTitle` / `header-title`，不是 Element Plus 的 `title`。

### `TiDrawer`

适用：右侧抽屉。

Props：

- `visible: boolean`
- `headerTitle?: string`
- `scrollLinerConfig?: { isShowTopLine?: boolean; isShowBottomLine?: boolean }`
- `headerTitleToolTip?: { content: string; placement?: string; effect?: string; svgName?: string }`
- `submitBtnLoading?: boolean`
- `submitBtnDisable?: boolean`
- `isShowFooter?: boolean`，默认 `true`。

事件：

- `close`
- `sure`

Slots：

- `#drawer-header`，推荐。
- `#header`，兼容旧用法。
- default：抽屉内容。
- `#drawer-footer`，注意不是 Element Plus 的 `#footer`。

常用写法：

```vue
<TiDrawer
  :visible="drawerVisible"
  header-title="筛选条件"
  :submit-btn-loading="submitting"
  @close="drawerVisible = false"
  @sure="submitForm"
>
  <el-form ref="formRef" :model="form" :rules="rules" label-width="96px">
    <!-- form items -->
  </el-form>
</TiDrawer>
```

差异：

- 组件不自动更新 `visible`。
- 默认 footer 已含取消/确定按钮。自定义底部使用 `#drawer-footer`。
- 内部已经处理内容滚动和分隔线，不要再在外层套一个页面级滚动容器。

### `TiDialogFull`

适用：全屏弹窗/全屏编辑页。

Props：

- `title?: string`
- `showType?: boolean`，控制显示。
- `isShowBtns?: boolean`
- `sureBtnDisable?: boolean`
- `submitLoading?: boolean`
- `contentWidth?: string`

事件：`close`、`sure`。

Slots：

- `#dialog-header`
- `#btns`
- default。

注意：显示字段是 `showType` / `show-type`，不是 `visible`。

### `TiTreeSelectDialog`

适用：树选择弹窗。

Props：

- `visible: boolean`
- `headerTitle?: string`
- `treeData: Array<Record<string, any>>`
- `selectedList?: Array<Record<string, any>>`

事件：

- `confirm(list)`
- `cancel`

数据约定：

- 树节点默认字段：`id`、`name`、`children`。
- 内部使用 `el-tree` 的 `node-key="id"`，筛选按 `name`。

### `TiTransferDialog`

适用：属性/字段穿梭选择弹窗。

核心 Props：

- `v-model` / `modelValue?: boolean`
- `title?: string`
- `width?: string | number`
- `selecteds?: TiTransferDialogItem[]`
- `tableData?: TiTransferDialogItem[]`
- `attrType?: string`
- `eventId?: number`
- `loading?: boolean`
- `searchPlaceholder?: string`
- `selectedLabel?: string`
- `listHeight?: string | number`
- `itemLabel?: (item) => string`
- `request?: (keyword: string) => Promise<TiTransferDialogItem[]>`
- `onCreateBatch?: (payload) => Promise<unknown>`
- `onDeleteBatch?: (relationIds) => Promise<unknown>`

`TiTransferDialogItem` 必要字段：

```ts
{
  id: string | number
  relationId?: string | number
  attrName: string
  attrDesc: string
  attrTypeDef?: string
}
```

事件：

- `update:modelValue`
- `search(keyword)`
- `selection-change(items)`
- `submit(diff)`
- `error(error)`

Expose：

- `open()`、`close()`、`submit()`、`refresh()`、`getSelectedItems()`、`clear()`。

### `MessageBox`

`TiMessageBox` 导出的是函数 `MessageBox(params)`，不是一个模板组件。

```ts
import { MessageBox } from '@ninebot/pc-titan-components'

MessageBox({
  title: '提示',
  message: '确认删除该数据吗？',
  cancelButtonText: '取消',
  confirmButtonText: '删除',
  type: 'warning',
  distinguishCancelAndClose: true,
  success: onConfirm,
  fail: onCancel,
  close: onClose,
})
```
