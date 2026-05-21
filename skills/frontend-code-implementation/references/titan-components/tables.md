# Titan 表格组件

## 表格

### `TiTable`

适用：列表页数据表格，内置分页区域。

Props：

- `tableData?: any[]`
- `columns?: TiColumnsType[]`
- `paginationInfo?: { page: number; size: number; total: number }`
- `paginationConfig?: { layout?: string; background?: boolean }`
- `isTableHeightFull?: boolean`
- `isShowPagination?: boolean`
- `tableLoading?: boolean`

`TiColumnsType`：

```ts
{
  label?: string
  prop: string
  type?: 'default' | 'selection' | 'index' | 'expand' | string
  width?: number
  minWidth?: number
  fixed?: boolean | string
  sortable?: boolean | string
  slot?: boolean
  isShow?: boolean | ((row?: any, index?: number) => boolean)
  align?: string
  showOverflowTooltip?: boolean
}
```

事件：

- `onPageSizeChange(size)`
- `onPageCurrentChange(page)`
- `onSelectionChange(selection)`

Slots：

- 列内容 slot：slot 名等于 `column.prop`，参数 `{ row, column, $index }`。
- 表头 slot：slot 名等于 `${prop}Header`。
- `#empty`。

常用写法：

```vue
<TiTable
  :table-data="list"
  :columns="columns"
  :pagination-info="{ page: query.page, size: query.size, total }"
  :table-loading="loading"
  @onPageSizeChange="handleSizeChange"
  @onPageCurrentChange="handlePageChange"
>
  <template #actions="{ row }">
    <el-button text type="primary" @click="edit(row)">编辑</el-button>
  </template>
  <template #empty>
    <TiEmpty card-type="table" label="暂无数据" />
  </template>
</TiTable>
```

差异：

- 使用 `tableData` / `table-data`，不是 Element Plus 的 `data`。
- 使用 `columns` 配置驱动列，而不是手写多个 `el-table-column`。
- 操作列 prop 建议命名为 `actions`，组件会自动计算操作列宽度。
- 分页事件名是 `onPageSizeChange` / `onPageCurrentChange`。

### `TiTableSort`

适用：拖拽排序表格。

Props：

- `tableData?: any[]`
- `columns?: TiColumnsType[]`
- `tableLoading?: boolean`
- `domId?: string`，默认 `sortTable`，多实例必须唯一。
- `draggable?: boolean`
- `showIndex?: boolean`

事件：

- `sortEnd(newRows)`。

注意：基于 `sortablejs`，多表格页面必须传不同 `domId`。

### `TiTableColumnGradient`

Props：

- `percentage?: number`

用法：

```vue
<TiTableColumnGradient :percentage="row.rate">
  {{ row.rate }}%
</TiTableColumnGradient>
```
