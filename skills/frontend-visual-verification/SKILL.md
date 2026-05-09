---
name: frontend-visual-verification
description: Use when 验证前端 UI、设计还原、Figma 对照、Playwright 截图、视觉回归、响应式 viewport、loading/empty/error/permission/disabled/success 状态、浏览器冒烟验收，或防止只用 build 代替真实页面验收。
---

# 前端视觉验收

## 概览

用真实浏览器验证前端页面是否可用、是否符合设计、是否覆盖关键状态。这个 skill 关注页面最终体验，不用 `lint/test/build` 通过来替代视觉和交互验收。

## 执行原则

- 先确认验收对象：路由、页面、组件、Figma 链接或截图。
- 优先使用项目已有 dev server、Playwright、Cypress、storybook 或截图脚本。
- 没有自动化能力时，也要用真实浏览器做最小人工观察。
- 至少覆盖一个桌面视口和一个移动视口，除非项目明确只支持单端。
- 必须检查默认、加载、空、错误、禁用、权限不足、成功反馈等相关状态。
- 发现问题先定位到页面区域、状态和可能原因，再建议修复。
- 不能只说“看起来可以”；必须给出通过项、失败项和未验证项。

## 工作流程

### 1. 收集验收依据

按需读取：

- `AGENTS.md`、`docs/ai/visual-checklist.md`
- active OpenSpec change：`docs/design-breakdown.md`、`docs/api-contract.md`、`docs/design-api-alignment.md`、`decisions.md`
- Figma 链接、设计截图、PRD 或验收说明
- 相关页面代码、路由、mock、接口契约
- `package.json` 中的 dev、test、e2e、storybook、screenshot 命令
- Playwright、Cypress 或浏览器测试配置

整理：

- 目标路由或组件
- 需要验证的视口
- 需要验证的状态
- 设计或产品验收重点
- 可运行的验收命令

### 2. 建立验收矩阵

使用 `assets/templates/visual-verification-report.md` 或项目已有模板，明确：

- 页面/组件
- 视口：桌面、移动，必要时加平板
- 状态：default、loading、empty、error、permission、disabled、success
- 交互：hover、focus、active、打开/关闭、提交、重置、分页、筛选
- 数据：正常数据、空数据、长文本、边界值、权限不足

### 3. 运行真实页面

优先顺序：

1. 使用正在运行的本地服务。
2. 使用项目命令启动 dev server。
3. 使用 Storybook 或组件预览环境。
4. 使用 Playwright/Cypress 运行现有 E2E。
5. 无自动化能力时，用浏览器打开页面做手动观察。

如果服务无法启动，记录阻塞原因，不要伪造验收结论。

### 4. 检查视觉和交互

必须关注：

- 布局、间距、对齐、密度、滚动区域
- 字体、颜色、圆角、阴影、边框、图标
- 文案是否溢出、遮挡、重叠、截断异常
- 响应式下核心信息和操作是否保留
- 表单校验、按钮状态、弹窗/抽屉打开关闭
- loading、empty、error、permission 等状态是否真实可见
- 键盘 focus、基础可访问性、明显的控制台错误

有 Figma 对照时，记录偏差类型：布局、组件选择、间距、颜色、文案、状态、交互。

### 5. 输出验收结论

最终回复必须包含：

- 验收对象和依据
- 运行过的命令或浏览器检查方式
- 已覆盖的视口、状态和交互
- 发现的问题，按严重程度排序
- 未验证项和原因
- 是否通过视觉验收

如果生成截图或报告，写清文件路径。

如果存在 active OpenSpec change，优先把验收结论写入 `openspec/changes/<change-id>/verification.md`；否则使用项目已有验收报告路径。

## 严重程度

- P0：页面不可用、关键流程阻断、核心数据不可见。
- P1：设计还原或交互明显错误，影响主要用户任务。
- P2：局部视觉偏差、边界状态缺失、移动端体验问题。
- P3：轻微样式、文案或一致性问题。

## 常见失败

- 只运行 build，就声称 UI 验收通过。
- 只看默认态，没看 loading、empty、error、permission。
- 只看桌面，不看移动端。
- 只看截图，不点击真实交互。
- 发现视觉偏差但没有说明区域、状态和可能原因。

## 资源

- `assets/templates/visual-verification-report.md`
- `assets/templates/viewport-state-matrix.md`
