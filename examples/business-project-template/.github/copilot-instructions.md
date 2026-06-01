# GitHub Copilot instructions

本项目使用团队前端 AI skills，声明文件见 `.ai/skills.yaml`。

首次使用或更新 skills：

```bash
./scripts/setup-ai-skills.sh
```

开始工作前：

- 先读取 `AGENTS.md` 和 `.ai/skills.yaml`，确认本项目引用哪些 skills。
- 如果当前 Copilot 环境支持 agent skills，优先使用已安装的同名 skill。
- 如果不能直接调用 skill，则根据 `.ai/skills.yaml` 中的 skill 名读取对应 `SKILL.md`，并严格按其中流程执行。
- 不要在 git commit 中添加 Co-Authored-By 或任何暴露 AI 工具身份的信息。

常用 skills：

- `frontend-project-bootstrap`
- `frontend-change-planning`
- `frontend-requirements-product`
- `frontend-requirements-design`
- `frontend-requirements-api`
- `frontend-requirements-alignment`
- `frontend-change-decisions`
- `frontend-change-design`
- `frontend-change-tasks`
- `frontend-code-implementation`
- `frontend-visual-verification`
- `frontend-code-review`
