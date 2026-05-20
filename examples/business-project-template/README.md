# 业务项目 AI skills 接入模板

把本目录中的文件复制到业务项目根目录：

```text
.ai/skills.yaml
AGENTS.md
CLAUDE.md
.github/copilot-instructions.md
scripts/setup-ai-skills.sh
```

接入步骤：

1. 修改 `.ai/skills.yaml` 的 `source.repo` 和 `source.version`。
2. 按项目实际情况更新 `AGENTS.md` 中的项目命令和前端规则。
3. 运行 `./scripts/setup-ai-skills.sh --status` 查看当前安装状态。
4. 运行 `./scripts/setup-ai-skills.sh` 安装到 Codex、VS Code Copilot 和 Claude Code。
5. 在三个工具里各触发一次 `frontend-code-review`，确认入口能读到对应规则。

发布新版本时，业务项目只需要更新 `.ai/skills.yaml` 的 `source.version`。
