# Titan 上传与预览组件

## 上传与预览

上传组件都接入 Element Plus `useFormItem()`，上传成功或回显时会触发表单 `change` 校验。放在 `el-form-item` 中时，rules trigger 应使用 `change`。

### `TiImgUpload`

Props：

- `tokenType: number`，必传，七牛桶 id。
- `getToken: Function`，必传。
- `tips?: string`
- `uploadTextShow?: boolean`
- `type?: string`，默认 `qiniu`。
- `maxSize?: number`，单位 MB，默认 `3`。
- `imgSize?: { width?: number; height?: number }`
- `accept?: string`，默认 `.png,.jpg,.jpeg`。
- `isEdit?: boolean`
- `imgName?: string`
- `imgURL?: string`
- `isVerifyFileName?: boolean`
- `imgContainerHeight?: string`
- `imgContainerWidth?: string`
- `enablePreview?: boolean`

事件：

- `beginUpload`
- `uploadSuccess(response)`
- `uploadFail(error)`
- `imageChange(response)`

### `TiVideoUpload`

Props：

- `tokenType: number`，必传。
- `getToken: Function`，必传。
- `tips?: string`
- `uploadTextShow?: boolean`
- `type?: string`，默认 `qiniu`。
- `maxSize?: number`，单位 MB。
- `videoSize?: object`
- `accept?: string`，默认 `.mp4,.mp3,.mov,.m4v`。
- `videoUrl?: string`
- `videoName?: string`
- `previewFrameVideo?: number`
- `isEdit?: boolean`
- `isVerifyFileName?: boolean`

事件：`beginUpload`、`uploadSuccess`、`uploadFail`、`imageChange`。

### `TiFileUpload`

Props：

- `tokenType: number`，必传。
- `getToken: Function`，必传。
- `isEdit?: boolean`
- `tips?: string`
- `dragTipShow?: boolean`
- `maxSize?: number`，单位 MB，默认 `10`。
- `accept?: string`，默认 `.zip`。
- `fileInfo?: { name?: string; size?: number; url?: string; [key: string]: any }`
- `isVerifyFileName?: boolean`

事件：

- `beginUpload`
- `uploadSuccess(response)`
- `uploadFail(error)`
- `fileChange(file)`

Slots：

- `#success-icon`
- `#btn-group`

### `TiCustomFileUpload`

适用：不用七牛 `tokenType/getToken`，而是业务传入自定义上传函数，且需要下载/预览/替换/删除按钮配置。

Props：

- `buttonLabel?: string`
- `buttonDescription?: string`
- `isEdit?: boolean`
- `tips?: string`
- `dragTipShow?: boolean`
- `maxSize?: number`
- `accept?: string`
- `fileInfo?: UploadResponse`
- `isVerifyFileName?: boolean`
- `customFileNameValidationRules?: RegExp`
- `customFileNameValidationErrorMsg?: string`
- `showDownload?: boolean`
- `showDelete?: boolean`
- `showReplace?: boolean`
- `showPreview?: boolean`
- `isShowIconButton?: boolean`
- `fileUpload?: ({ file, ...params }) => Promise<any>`
- `fileUploadParams?: Record<string, any>`
- `containerStyle?: Record<string, any>`
- `downloadFile?: Function`
- `previewFile?: Function`

事件：

- `beginUpload`
- `uploadEnd`
- `uploadSuccess(response)`
- `removeFile(response)`
- `uploadFail(error)`
- `fileChange(file)`

### `TiVideoPreview`

Props：

- `v-model` / `modelValue?: boolean`
- `url?: string`

事件：`update:modelValue`。
