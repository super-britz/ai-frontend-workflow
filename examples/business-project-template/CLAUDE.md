# Claude Code instructions

本项目使用团队前端 AI skills，声明文件见 `.ai/skills.yaml`。

首次使用或更新 skills：

```bash
./scripts/setup-ai-skills.sh
```

开始工作前：

- 先读取 `AGENTS.md` 和 `.ai/skills.yaml`。
- 如果任务匹配某个 frontend skill，优先使用对应 slash command，例如 `/frontend-code-review`。
- 如果 slash command 不可用，读取已安装的对应 `SKILL.md` 并严格按其中流程执行。
- 不要在 git commit 中添加 Co-Authored-By 或任何暴露 AI 工具身份的信息。

常用 slash commands：

- `/frontend-project-bootstrap`
- `/frontend-openspec-workflow`
- `/frontend-design-breakdown`
- `/frontend-api-contract`
- `/frontend-design-api-alignment`
- `/frontend-code-implementation`
- `/frontend-visual-verification`
- `/frontend-code-review`
