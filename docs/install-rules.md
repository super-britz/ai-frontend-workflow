# AI skills 安装规则

## 分层职责

团队采用三层模型维护 skills：

```text
skill 仓库定规则
业务项目定依赖
个人机器定本地路径
```

| 层级 | 负责内容 | 是否提交 |
| --- | --- | --- |
| `ai-frontend-workflow` | skill 源码、manifest 格式、安装脚本、校验脚本、Agent 适配策略 | 是 |
| 业务项目 | 引用哪个版本、需要哪些 skills、哪些 Agent 必须支持 | 是 |
| 个人机器 | 本机缓存目录、各 Agent 的个人安装目录 | 否 |

业务项目不要手工复制一份 `skills/` 源码。需要使用本仓库提供的 manifest 和安装脚本安装到各 Agent 能识别的位置。

## 业务项目 manifest

业务项目推荐提交 `.ai/skills.yaml`：

```yaml
source:
  repo: git@github.com:your-org/ai-frontend-workflow.git
  version: v0.3.0

skills:
  - frontend-project-bootstrap
  - frontend-product-requirements
  - frontend-design-requirements
  - frontend-api-requirements
  - frontend-alignment-requirements
  - frontend-code-implementation
  - frontend-visual-verification
  - frontend-code-review

agents:
  codex: required
  copilot: required
  claude: required
```

规则：

- `source.repo` 指向本 skill 仓库。
- `source.version` 使用 tag、commit SHA 或分支名；团队项目优先使用 tag。
- `skills` 只列当前业务项目需要的 skills。
- `agents` 只声明这个业务项目需要支持的 Agent。
- `required` 和 `optional` 都会安装；`false`、`disabled`、`none` 不会安装。

## Agent 适配

### Codex

Codex 使用原生 skills 目录：

```text
${CODEX_HOME:-$HOME/.codex}/skills/<skill-name>/SKILL.md
```

安装后可以通过 `$frontend-code-review` 这类 skill 名触发。

### VS Code 中的 GitHub Copilot

VS Code Copilot 的稳定入口是仓库说明文件：

```text
.github/copilot-instructions.md
```

同时，Copilot 的 agent skills 可以放在个人目录：

```text
${COPILOT_HOME:-$HOME/.copilot}/skills/<skill-name>/SKILL.md
```

团队规则：

- 业务项目必须提交 `.github/copilot-instructions.md`，告诉 Copilot 本项目引用 `.ai/skills.yaml`。
- 个人机器通过安装脚本把 manifest 中的 skills 安装到 `${COPILOT_HOME:-$HOME/.copilot}/skills`。
- 如果当前 Copilot 环境没有自动调用 skill，应按 `.github/copilot-instructions.md` 的说明读取对应 `SKILL.md`。

### Claude Code

Claude Code 的稳定入口是项目记忆文件：

```text
CLAUDE.md
```

Claude Code 也支持自定义 slash commands。安装脚本会：

- 把 selected skills 安装到 `${AI_FRONTEND_WORKFLOW_HOME:-$HOME/.ai-frontend-workflow}/skills`。
- 为每个 skill 生成 `${CLAUDE_HOME:-$HOME/.claude}/commands/<skill-name>.md`。

安装后可以在 Claude Code 中使用：

```text
/frontend-code-review
```

团队规则：

- 业务项目必须提交 `CLAUDE.md`，告诉 Claude Code 本项目引用 `.ai/skills.yaml`。
- slash command 只作为便捷入口；真正的 source of truth 仍是本仓库的 `SKILL.md`。

## 推荐命令

在 skill 仓库内安装当前仓库全部 skills 到 Codex：

```bash
./scripts/install-skills.sh
```

按业务项目 manifest 安装到三个 Agent：

```bash
./scripts/install-skills.sh --manifest /path/to/project/.ai/skills.yaml --agent all
```

只安装到某个 Agent：

```bash
./scripts/install-skills.sh --manifest /path/to/project/.ai/skills.yaml --agent codex
./scripts/install-skills.sh --manifest /path/to/project/.ai/skills.yaml --agent copilot
./scripts/install-skills.sh --manifest /path/to/project/.ai/skills.yaml --agent claude
```

安装脚本统一使用复制模式。维护者修改本仓库 skills 后，需要重新执行安装命令同步到对应 Agent 的运行时目录：

```bash
./scripts/install-skills.sh --manifest /path/to/project/.ai/skills.yaml --agent all
```

查看 manifest 中声明的 skills 是否已安装：

```bash
./scripts/install-skills.sh --manifest /path/to/project/.ai/skills.yaml --agent all --status
```

## 业务项目入口文件

业务项目至少提交这些文件：

```text
.ai/skills.yaml
AGENTS.md
CLAUDE.md
.github/copilot-instructions.md
scripts/setup-ai-skills.sh
```

入口文件只写项目规则和 skill 引用，不复制完整 skill 内容。

可直接从模板复制：

```text
examples/business-project-template/
```

## 版本策略

- 日常业务项目使用 tag，例如 `v0.3.0`。
- 试点项目可以使用分支，但必须在验收后切回 tag。
- skill 仓库修改后运行 `./scripts/check-skills.sh`。
- 发布新版本时，业务项目只改 `.ai/skills.yaml` 的 `source.version`。

## 本地覆盖

个人可以通过环境变量覆盖安装路径：

```bash
CODEX_HOME="$HOME/.codex" ./scripts/install-skills.sh --agent codex
COPILOT_HOME="$HOME/.copilot" ./scripts/install-skills.sh --agent copilot
CLAUDE_HOME="$HOME/.claude" ./scripts/install-skills.sh --agent claude
AI_FRONTEND_WORKFLOW_HOME="$HOME/.ai-frontend-workflow" ./scripts/install-skills.sh --agent claude
```

这些路径属于个人环境，不写入业务项目。
