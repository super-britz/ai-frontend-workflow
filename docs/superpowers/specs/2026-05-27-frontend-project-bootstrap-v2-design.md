# frontend-project-bootstrap v2 设计说明

## 目标

将 `frontend-project-bootstrap` 重写为一个聚焦的 `AGENTS.md` 初始化 / 更新 skill。

这个 skill 应帮助 AI 助手检查前端仓库，并在项目根目录创建或更新简洁、可执行的 `AGENTS.md` 项目级协作规则。它不负责创建需求文档、组件使用文档、OpenSpec change、验收报告、Review 报告，也不负责写任务分流规则。

## 范围

### 保留职责

- 写规则前先检查仓库。
- 缺少 `AGENTS.md` 时生成该文件。
- 已存在 `AGENTS.md` 时就地更新。
- 保留已有用户规则、语言偏好、安全规则和 commit 规则。
- 记录已发现的项目事实，例如框架、语言、包管理器、UI 库、关键目录和可用命令。
- 添加简洁的项目级护栏，覆盖代码修改、前端实现、验证、Git 使用和禁止事项。
- 对重要但无法从仓库确认的信息标记 `Needs project discovery`，不要编造项目事实。

### 职责边界

`frontend-project-bootstrap` 只维护 `AGENTS.md`。需求分析、组件规范、OpenSpec、Figma、视觉验收、Review 和任务分流都交给后续专项流程处理。

## 输出契约

这个 skill 只有一个文件产物：

```text
AGENTS.md
```

如果仓库已经有 `AGENTS.md`，则直接更新该文件。如果仓库存在相邻的 agent 规则文件，例如 `CLAUDE.md`、`.github/copilot-instructions.md`、`.cursorrules` 或 README 中的项目说明，则读取这些文件，并把不冲突的项目规则保留到 `AGENTS.md` 中。

## AGENTS.md 内容

生成或更新后的文件应保持简短、实用。推荐章节：

- 全局偏好
- 项目概况
- 常用命令
- 代码修改规则
- 前端实现规则
- 验证规则
- Git 规则
- 禁止事项
- 未确认项

前端实现规则只保留项目级、轻量级约束，例如：

- 新增 UI 前先搜索已有页面和组件。
- 优先复用项目 UI 库和已有本地封装。
- 避免无关的全局样式、路由、构建、依赖或 API 修改。
- 除非任务明确要求，否则不新增依赖。

## 需要避免的失败模式

- 生成过长、泛泛而谈、后续 agent 不会认真阅读的 `AGENTS.md`。
- 编造命令、组件名、路由、测试工具或项目约定。
- 覆盖用户已写规则，而不是合并保留。
- 把 bootstrap 变成需求分析、OpenSpec、Figma、验收或 Review 工作流。
- 顺手创建额外文档文件。

## 成功标准

- `frontend-project-bootstrap` 可以用一句话解释：为前端仓库生成或更新 `AGENTS.md`。
- skill 正文比当前版本更短，职责更少。
- `AGENTS.md` 模板更短，不包含任务分流规则。
- 重写后 `scripts/check-skills.sh` 通过。
