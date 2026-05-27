# Claude Code instructions

本项目使用团队前端 AI skills，声明文件见 `.ai/skills.yaml`。

开始工作前：

- 确认已运行 `./scripts/setup-ai-skills.sh`，或由维护者从 `ai-frontend-workflow` 运行安装脚本。
- 如果任务匹配某个 frontend skill，优先使用对应 slash command，例如 `/frontend-code-review`。
- 如果 slash command 不可用，读取 `.ai/skills.yaml`，再读取已安装的 `SKILL.md` 并按其中流程执行。

常用 skills：

- `frontend-project-bootstrap`
- `frontend-change-planning`
- `frontend-openspec-workflow`
- `frontend-product-requirements`
- `frontend-design-requirements`
- `frontend-api-requirements`
- `frontend-alignment-requirements`
- `frontend-code-implementation`
- `frontend-visual-verification`
- `frontend-code-review`
