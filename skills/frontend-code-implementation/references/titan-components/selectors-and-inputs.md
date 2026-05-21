# Titan 选择器与输入组件

## 选择器组件

### `TiSelect`

适用：普通下拉、需要 Element Plus Select 完整能力、需要透传 `multiple`、`filterable`、`clearable`、`remote` 等场景。

API 依据：`TiSelect/types.ts` 与 `TiSelect/index.vue`。它以 Element Plus `SelectPropsPublic` 为基准，重定义了 `tagTooltip`、`suffixIcon`，并透传未知 attrs 和全部插槽。

常用写法：

```vue
<TiSelect v-model="form.status" clearable placeholder="请选择" style="width: 240px">
  <el-option
    v-for="item in statusOptions"
    :key="item.value"
    :label="item.label"
    :value="item.value"
  />
</TiSelect>
```

事件：

- 标准：`update:modelValue`、`change`、`popup-scroll`、`remove-tag`、`visible-change`、`focus`、`blur`、`clear`。
- 兼容：`onSelect`、`close`、`sure`。新代码优先用标准事件，除非相邻页面仍使用 legacy 事件。

注意：

- `suffixIcon` 可以传字符串或组件；不传时 Titan 使用默认箭头图标。
- 所有常见 `el-select` 插槽会转发，例如 `default`、`header`、`footer`、`prefix`、`empty`、`loading`、`tag`、`label`。

### `TiSearchSelect`

适用：筛选区中带左侧文字 label 的紧凑 select。它不是 `TiSelect` 的别名。

Props：

- `label?: string`
- `width?: string`
- `options?: Array<{ key: string | number; text: string; value: string | number; label: string }>`
- `optionsDataType?: 'local' | 'network' | string`
- `placeholder?: string`

常用写法：

```vue
<TiSearchSelect
  v-model="query.type"
  label="类型"
  width="240px"
  placeholder="请选择"
  :options="typeOptions"
  options-data-type="network"
  clearable
/>
```

差异：

- 内部使用 `defineModel<string>`，默认值是 `null`；空值清除逻辑由组件处理。
- `optionsDataType='local'` 时会用 i18n key 转 label；接口数据用 `network`，不要让组件把接口文案当 i18n key。
- 无 `width` 时组件会按 label + selected label 动态计算宽度。

### `TiRemoteSearchSelect`

适用：远程搜索、分页加载、虚拟列表、大量选项、需要预设值回显 label 的 select。

核心 Props：

- `modelValue?: unknown`
- `request(params): Promise<{ list: any[]; hasMore?: boolean; total?: number }>`，必传。
- `requestSelected?({ values, ...requestParams }): Promise<{ list: any[] }>`，用于按已选 value 精确回显。
- `pageSize?: number`，默认 `20`。
- `ensureModelValueMaxPages?: number`，默认 `10`。
- `requestParams?: Record<string, unknown> | (() => Record<string, unknown>)`
- `immediate?: boolean`，默认 `true`。
- `loadMoreThreshold?: number`，默认 `240`。
- `dedupe?: boolean`，默认 `true`。
- `showArrow?: boolean`，默认 `false`。

默认行为：

- 内部默认 `remote=true`、`filterable=true`、`clearable=true`、`collapseTags=true`。
- `keyword === ''` 表示默认列表。
- 打开下拉是否请求默认列表由 `immediate` 控制。
- `modelValue` 有值但列表中没有对应项时，会优先调用 `requestSelected`；未提供时补拉默认列表尝试命中。

常用写法：

```vue
<TiRemoteSearchSelect
  v-model="form.deviceIds"
  multiple
  placeholder="输入关键字搜索设备"
  :request="fetchDevices"
  :request-selected="fetchSelectedDevices"
  :request-params="{ tenantId }"
/>
```

```ts
async function fetchDevices(params: {
  page: number
  pageSize: number
  keyword: string
  tenantId?: string
}) {
  const res = await api.getDevices(params)
  return {
    list: res.records.map((item) => ({
      label: item.name,
      value: item.id,
      raw: item,
    })),
    total: res.total,
    hasMore: res.current < res.pages,
  }
}
```

事件：`update:modelValue`、`change`、`visible-change`、`remove-tag`、`clear`、`focus`、`blur`、`remote-method`。

Slots：

- `#option="{ item, index, isDisabled }"` 推荐用于自定义选项。
- `#empty` 自定义空态。
- 其他 `el-select-v2` 插槽会转发。

### `TiMultipleSelect`

适用：多选下拉，选项前带复选框，可选全选区域。

Props：

- `options?: Array<{ key: string; value: string; label: string }>`
- `children?: { key: string; value: string; label: string }`
- `showAll?: boolean`
- `optionsDataType?: 'local' | 'network'`，默认 `local`。

常用写法：

```vue
<TiMultipleSelect
  v-model="form.types"
  :options="typeOptions"
  :show-all="true"
  options-data-type="network"
/>
```

差异：

- `v-model` 是数组。
- 内部固定 `multiple`、`clearable`，并使用自定义 checkbox 选项 UI。
- `optionsDataType='local'` 会把 `label` 当 i18n key；接口文案使用 `network`。

### `TiSelectGroup`

适用：两个筛选 select + 一个输入/数字输入组成的固定筛选组。

Props：

- `selectFirst`，必传：`{ label, placeholder, options, optionsDataType }`
- `selectSecond?`：同上，`options.length > 0` 时展示。
- `inputConfig?`：`{ width, placeholder, type: 'input' | 'input-number', ... }`

事件：

- `changeMethod(type, value)`，其中 type 为 `selectFirstChange`、`selectSecondChange`、`inputChange`。

## 输入、日期、级联、单选

### `TiSearchInput`

透明透传 `el-input`，额外 props：

- `width?: string`，默认 `180px`。
- `hasPrefix?: boolean`，默认 `true`。

常用写法：

```vue
<TiSearchInput
  v-model="query.keyword"
  width="320px"
  placeholder="请输入"
  clearable
/>
```

注意：宽度也可由 class 控制。业务页面优先 class，demo 中的 inline style 只是演示。

### `TiDatePicker`

透明包装 `el-date-picker`，额外默认：

- `type` 默认 `daterange`。
- 固定 `value-format="x"`，值是时间戳字符串/数组，不是 `Date`。
- 默认 prefix icon 使用 Titan 日期图标。

常用写法：

```vue
<TiDatePicker
  v-model="query.timeRange"
  type="daterange"
  start-placeholder="开始时间"
  end-placeholder="结束时间"
/>
```

### `TiCascader`

包装 `el-cascader`。

Props：

- `width?: string`，默认 `200px`。
- `modelValue?: string`。
- `props?: Record<string, any>`，透传给 `el-cascader` 的 props 配置。

事件：`update:modelValue`。

注意：当前内部 `innerValue` 只 watch 内部值向外 emit，没有 watch 外部 `modelValue` 回写；如果业务需要外部重置，先验证真实页面行为。

### `TiRadioGroup`

按钮式单选。

Props：

- `modelValue: string`
- `options: Array<{ value: string; label: string; disabled?: boolean }>`

事件：`update:modelValue`。

常用写法：

```vue
<TiRadioGroup
  v-model="form.mode"
  :options="[
    { value: 'auto', label: '自动' },
    { value: 'manual', label: '手动', disabled: true }
  ]"
/>
```
