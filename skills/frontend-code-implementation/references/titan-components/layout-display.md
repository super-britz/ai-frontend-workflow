# Titan 布局、状态与展示组件

## 布局、状态和展示组件

### `TiTabs`

Props：

- `tabPaneArr: Array<{ label: string; name: string; isShow?: boolean | (() => any) }>`

Slots：

- 每个 tab 内容 slot 名等于 `name`。
- 其他 `el-tabs` 插槽会透传。

```vue
<TiTabs :tab-pane-arr="tabs">
  <template #base>基础信息</template>
  <template #log>操作日志</template>
</TiTabs>
```

### `TiSteps`

Props：

- `active?: number`
- `stepsItemArr?: Array<{ title: string; status?: string }>`
- `colorConfig?: Partial<StepsColorConfig>`

注意：`active` 是从 `0` 开始的索引。

### `TiTagGroup`

Props：

- `items?: Array<string | number | { label: string; value?: string | number; disabled?: boolean }>`
- `tags?: string[]`，兼容旧字段，新代码用 `items`。
- `maxVisible?: number`
- `autoFit?: boolean`
- `tagMaxWidth?: string | number`
- `tooltipMode?: 'default' | 'wide' | 'scroll' | 'widest' | 'tallest'`
- `separator?: string`
- `bordered?: boolean`

### `TiEmpty`

Props：

- `label?: string`，默认 `暂无数据`。
- `labelStyle?: Record<string, any>`
- `cardType?: 'table' | 'search' | 'card'`，默认 `table`。

Slots：

- `#image`
- `#button`

### `TiSearchCard`

适用：列表页筛选区。内部使用 `TiTwoColumnLayoutCard` + `TiWeightButtonGroup`。

Slots：

- `#filter`
- `#tableBtnArea`

```vue
<TiSearchCard>
  <template #filter>
    <el-form inline :model="query">
      <!-- filters -->
    </el-form>
  </template>
  <template #tableBtnArea>
    <el-button @click="reset">重置</el-button>
    <el-button type="primary" @click="search">查询</el-button>
  </template>
</TiSearchCard>
```

### `TiTwoColumnLayoutCard`

Props：

- `leftWidth?: number`，默认 `500`。

Slots：

- `#left`
- `#right`

### `TiHorizontalDraggerCard`

Props：

- `minWidth?: number`，默认 `300`。

Events：

- `getWidth(width: string)`，折叠/展开时触发。

Slots：

- `#horizontal-dragger`

### `TiWeightButtonGroup`

Slots：

- default：放一组按钮。组件会在 mounted 后把最后一个按钮改成 primary，其它按钮改成 plain；加 `remain` 属性的按钮不被改写。

### `TiFormItemEdit`

当前实现的 props 以 SFC 内部定义为准：

- `isEdit?: boolean`
- `labelName?: string`
- `name?: string`
- `fontSize?: string`

Slots：

- default：编辑态内容。
- `#name`：非编辑态展示内容。
- `#labelName`：自定义 label。
- `#labelBtn`：label 侧按钮。

### `TiSvgIcon`

Props：

- `url: string`，必传，在线 SVG 地址。
- `color?: string`，默认 `#333`。

注意：通过 CSS mask/background 渲染，调用侧要用 class 或 style 设置宽高。

### `TiMultilingual`

适用：多个业务字段的多语言文案配置弹窗。

Props：

- `visible?: boolean`
- `headerTitle?: string`
- `multipleLangItems?: Array<{ key: string; label: string; multilingualData?: Record<string, string> }>`
- `maxlength?: number`，默认 `15`。
- `otherMaxlength?: number`，默认 `100`。

事件：

- `onClose`
- `onSure(data)`，返回 `Record<string, Record<string, string>>`。

注意：

- 当前主语言固定为 `zh` 且必填。
- 组件不自动更新 `visible`，父组件在 `@onClose` 和 `@onSure` 中关闭。
