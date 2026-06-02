# AGENTS.md

## 全局偏好

- 使用中文回复。
- git commit 时不要添加 Co-Authored-By 或任何暴露 AI 工具身份的信息。

## AI skills

本项目使用团队前端 AI skills，声明文件见 `.ai/skills.yaml`。

首次使用或更新 skills：

```bash
./scripts/setup-ai-skills.sh
```

开始任务前：

- 先读取 `.ai/skills.yaml`，确认本项目引用哪些 skills。
- 如果当前 Agent 支持 skill 调用，任务匹配时优先调用对应 skill。
- 如果当前 Agent 不能直接调用 skill，则读取已安装的对应 `SKILL.md`，并按其中流程执行。
- 项目事实写进 `AGENTS.md`、`docs/ai/` 或 OpenSpec change，不写进团队通用 skill。

常用 skills：

- `$frontend-project-bootstrap`：生成或更新项目根目录 `AGENTS.md`。
- `$frontend-change-planning`：把较大的前端需求拆成多个 OpenSpec change 候选。
- `$frontend-requirements-product`：从 PRD、Wiki 或产品说明沉淀产品事实。
- `$frontend-requirements-ui`：写代码前拆解 Figma 或设计稿。
- `$frontend-requirements-api`：沉淀前端接口契约摘录与缺口清单。
- `$frontend-requirements-alignment`：对照产品、UI 和 API 事实，输出缺失与冲突差异清单。
- `$frontend-change-decisions`：维护 `decisions.md` 的 Gate、owner 决策和阻塞问题。
- `$frontend-change-design`：根据已确认事实和决策编写 `design.md` 前端架构设计。
- `$frontend-change-tasks`：在 Implementation Gate 通过后维护 `tasks.md` 执行清单。
- `$frontend-code-implementation`：根据已确认事实、Figma 上下文和项目组件体系实现前端页面。
- `$frontend-visual-verification`：做页面截图、响应式和状态验收。
- `$frontend-code-review`：做前端专项 Review。

如果项目还有外部组件体系 skill，例如 `ti-component-skills`，先确认它已安装，再在项目级 `AGENTS.md` 里补一句“实现前先读取该 skill 并按其规则执行”。

## 项目命令

按当前项目实际情况维护：

```bash
pnpm install
pnpm dev
pnpm lint
pnpm typecheck
pnpm test
pnpm build
```

## 前端实现规则

- 优先使用项目已有组件、hooks、services、stores 和样式 token。
- 不根据 UI 猜接口字段；接口事实必须来自接口文档、OpenAPI、mock schema 或后端确认。
- 页面任务至少考虑默认、加载、空、错误、禁用、权限和成功状态。
- 涉及视觉还原时，必须做桌面和移动 viewport 验收。
- 涉及前端页面实现时，先确认 `decisions.md` 和 `design.md`，再让 `tasks.md` 的第一项实现任务由 Superpowers 计划执行 `$frontend-code-implementation` handoff，并重新读取 active OpenSpec change 和 Figma 上下文。
- 不把一次需求里的临时结论写进全局 rules；稳定事实再沉淀到项目文档。
