# AI Frontend Workflow

前端 AI 自动化开发工作流的团队级 skills 集合，用于把 Codex / OpenSpec / Superpowers 接入前端项目：OpenSpec 负责项目事实和需求变更，Superpowers 负责执行过程和工程质量，frontend skills 负责前端专业判断。

## 推荐组合

| 层 | 负责 | 典型动作 |
| --- | --- | --- |
| OpenSpec | 项目事实、需求边界、变更生命周期 | `openspec init`、`openspec new change`、`openspec validate`、`openspec archive` |
| Superpowers | 执行纪律、TDD、worktree、review、完成前验证 | `brainstorming`、`writing-plans`、`test-driven-development`、`verification-before-completion` |
| Frontend skills | change 规划、需求事实、差异对齐、决策记录、架构设计、任务清单、实现、验收、Review | `frontend-change-planning`、`frontend-requirements-product`、`frontend-requirements-ui`、`frontend-requirements-api`、`frontend-requirements-alignment`、`frontend-change-decisions`、`frontend-change-design`、`frontend-change-tasks` |

最稳的心智模型：

```text
OpenSpec 先定义事实和变更边界
→ Superpowers 主导工程执行
→ 开发中事实变化回写 OpenSpec
→ 验收后 OpenSpec validate / archive
```

硬规则：

```text
facts 先稳定 → decisions 再确认 → design 再落地 → tasks 最后生成
```

产品需求、UI 需求、接口需求和产品/UI/API 对齐结果必须写入 OpenSpec change 或 `docs/ai/` 文件；聊天摘要不能作为 source of truth。

## 防跑偏护栏

- 完整 OpenSpec 链路适合新页面、复杂需求、接口联动、跨模块改造和需要 owner 决策的 change；小范围文案、样式、单点 bugfix 可以走轻量路径，只读取项目约定、必要事实和验证要求，不强制创建完整 change。
- `docs/ui-requirements.md` 只记录 UI 事实；`design.md` 只记录前端架构设计和技术方案，不能互相替代。
- 每个文件只解决自己的问题：事实变化回写 `docs/*-requirements.md`，取舍和 Gate 回写 `decisions.md`，执行顺序写 `tasks.md`，代码实现不补事实。
- 不确定项必须标记为 `Needs product/ui/backend decision`、`Blocked` 或 open question；不要用实现假设把缺口填平。
- 外部组件体系 skill 由业务项目 `AGENTS.md` 或本机已安装 skill 声明；公共 workflow 不硬编码 Titan 或其他团队组件库路径。

## Skills

| Skill | 用途 |
| --- | --- |
| `frontend-project-bootstrap` | 检查前端仓库并生成或更新项目根目录 `AGENTS.md` |
| `frontend-change-planning` | 把较大的前端需求拆成多个可进入 OpenSpec 的 change 候选 |
| `frontend-requirements-product` | 从 PRD、Wiki 或产品说明沉淀产品事实、范围、规则和待确认问题 |
| `frontend-requirements-ui` | 从 Figma 或设计稿沉淀 UI 事实、状态变体和视觉验收点 |
| `frontend-requirements-api` | 从接口文档沉淀前端接口契约摘录与缺口清单 |
| `frontend-requirements-alignment` | 对照产品、UI 和 API 事实，输出缺失与冲突差异清单 |
| `frontend-change-decisions` | 维护 OpenSpec `decisions.md` 的 Gate、owner 决策和阻塞问题 |
| `frontend-change-design` | 根据已确认事实和决策沉淀 OpenSpec `design.md` 前端架构设计 |
| `frontend-change-tasks` | 在 Implementation Gate 通过后维护 OpenSpec `tasks.md` 执行清单 |
| `frontend-code-implementation` | 根据已确认产品、UI、接口、对齐结果和组件体系实现生产级前端页面 |
| `frontend-visual-verification` | 验证前端页面的设计还原、响应式、核心状态和截图验收 |
| `frontend-code-review` | 审查前端改动的组件复用、接口契约、状态覆盖和验收质量 |

## 安装

本仓库是团队 skills 的 source of truth；业务项目通过 manifest 声明依赖，不手工复制整份 `skills/`。

业务项目推荐提交：

```text
.ai/skills.yaml
AGENTS.md
CLAUDE.md
.github/copilot-instructions.md
scripts/setup-ai-skills.sh
```

manifest 示例见：

- `examples/skills.manifest.yaml`
- `examples/CLAUDE.md`
- `examples/copilot-instructions.md`
- `examples/business-project-template/`

完整规则见：

- `docs/install-rules.md`

### 本仓库开发者安装

```bash
./scripts/install-skills.sh
```

默认会把本仓库的 `skills/` 复制到本机 Agent 的运行时目录，不会把 skill 装进仓库本身，也不会做软链。

### 按业务项目 manifest 安装

支持 Codex、VS Code 中的 GitHub Copilot、Claude Code：

```bash
./scripts/install-skills.sh --manifest /path/to/project/.ai/skills.yaml --agent all
```

如果要改安装位置，可以给 `codex` / `copilot` 传 `--target`，支持绝对路径和相对路径：

```bash
./scripts/install-skills.sh --manifest /path/to/project/.ai/skills.yaml --agent codex --target /tmp/custom-skills
./scripts/install-skills.sh --manifest /path/to/project/.ai/skills.yaml --agent copilot --target ./runtime-skills
```

`claude` 目前使用 `AI_FRONTEND_WORKFLOW_HOME`，默认安装到 `~/.ai-frontend-workflow/skills`。

只安装到某个 Agent：

```bash
./scripts/install-skills.sh --manifest /path/to/project/.ai/skills.yaml --agent codex
./scripts/install-skills.sh --manifest /path/to/project/.ai/skills.yaml --agent copilot
./scripts/install-skills.sh --manifest /path/to/project/.ai/skills.yaml --agent claude
```

查看本机安装状态：

```bash
./scripts/install-skills.sh --manifest /path/to/project/.ai/skills.yaml --agent all --status
```

安装脚本统一使用复制模式，不使用软链。修改本仓库 skill 后，需要重新执行安装脚本同步到对应 Agent 的运行时目录。
`./scripts/update-skills.sh` 会先 `git pull --ff-only`，再重新执行安装；它是更新来源，不是安装器本身。

### 业务项目接入模板

将模板复制到业务项目根目录后，修改 `.ai/skills.yaml` 的 `source.repo` 和 `source.version`：

```text
examples/business-project-template/
  .ai/skills.yaml
  AGENTS.md
  CLAUDE.md
  .github/copilot-instructions.md
  scripts/setup-ai-skills.sh
```

业务项目内执行：

```bash
./scripts/setup-ai-skills.sh --status
./scripts/setup-ai-skills.sh
```

更新本仓库并重新安装：

```bash
./scripts/update-skills.sh
```

安装后可以这样调用：

```text
Use $frontend-project-bootstrap 检查这个前端仓库，并生成或更新项目根目录 AGENTS.md。
Use $frontend-change-planning 分析这个较大的前端需求，并输出 OpenSpec change 拆分规划。
Use $frontend-requirements-product 从 PRD/Wiki/产品说明提炼产品事实、范围、规则和待确认问题，不写代码。
Use $frontend-requirements-ui 沉淀这个 Figma 页面的 UI 拆解，输出设计来源索引、UI 结构、视觉元素、状态变体和视觉验收点。
Use $frontend-requirements-api 根据接口文档沉淀接口来源、路径、方法、请求、响应、错误、分页、鉴权和未确认项。
Use $frontend-requirements-alignment 对照产品事实、UI 事实和接口契约事实，输出字段、状态、异常、查询/操作能力的交叉检查与差异清单。
Use $frontend-change-decisions 汇总当前 OpenSpec change 的待决问题，维护 decisions.md 的 Gate 状态、owner 决策和阻塞问题。
Use $frontend-change-design 根据当前 OpenSpec change 的已确认事实和 decisions.md，编写前端 design.md 架构设计。
Use $frontend-change-tasks 根据当前 OpenSpec change 的 decisions.md 和 design.md 维护 tasks.md。
Use $frontend-code-implementation 根据这个 Figma 页面实现前端页面。
Use $frontend-visual-verification 验证这个页面的设计还原、响应式和核心状态。
Use $frontend-code-review review 这次前端改动。
```

## 推荐工作流

OpenSpec change 文件职责速查：

| 文件 | 职责 |
| --- | --- |
| `proposal.md` | 为什么做、做什么、不做什么 |
| `docs/product-requirements.md` | 产品事实 |
| `docs/ui-requirements.md` | UI 事实 |
| `docs/api-requirements.md` | 接口事实 |
| `docs/alignment-requirements.md` | 产品 / UI / API 对齐结果 |
| `decisions.md` | 已拍板和待拍板问题 |
| `design.md` | 前端架构设计 / 技术方案 |
| `tasks.md` | 执行清单 |
| `specs/**/spec.md` | 最终系统能力契约 |

1. 新项目或老项目接入 AI 前，先运行 `frontend-project-bootstrap`。
2. 需求较大或边界不清时，先用 `frontend-change-planning` 拆成多个 change 候选。
3. 明确单个 change 边界后，用 OpenSpec 创建或选择 change；需要前端 change 模板时运行 `./scripts/init-frontend-openspec-change.sh <change-id>`。
4. 有 PRD、Wiki 或产品说明时，使用 `frontend-requirements-product` 只拆产品事实。
5. 有 Figma 页面任务时，使用 `frontend-requirements-ui` 只拆 UI 事实。
6. 有接口文档或联调任务时，使用 `frontend-requirements-api` 只做接口契约摘录与缺口清单。
7. 人工审核事实文件；拆解或契约不准时直接修改 `docs/product-requirements.md`、`docs/ui-requirements.md`、`docs/api-requirements.md` 或 `docs/alignment-requirements.md`。
8. 使用 `frontend-requirements-alignment` 对照产品、UI 和 API 事实，产出缺失与冲突差异清单。
9. 有取舍、争议或 owner 的内容用 `frontend-change-decisions` 写入 `decisions.md`，AI 不替 owner 批准 Gate。
10. 关键 Gate 处理后，用 `frontend-change-design` 编写 `design.md` 前端架构设计。
11. `Implementation Gate: Approved` 后，用 `frontend-change-tasks` 生成或更新 `tasks.md`；涉及前端页面实现时，`tasks.md` 第一项必须是由 Superpowers 计划执行 `frontend-code-implementation` handoff，并重新读取 active OpenSpec change。
12. 实现阶段由 Superpowers 主导执行；页面代码修改前必须经过 `frontend-code-implementation` 准入，再用 `frontend-visual-verification` 和 `frontend-code-review` 验收。
13. 开发中发现事实变化，先回写 OpenSpec change 和 `decisions.md`，再继续写代码。
14. 验收通过后运行 OpenSpec validate/archive，把长期有效规则归档到 `openspec/specs/` 或项目稳定文档。

业务项目可以参考：

- `examples/AGENTS.workflow.md`

前端 OpenSpec 模板位于：

- `templates/openspec/frontend/`

## 校验

本仓库包含 GitHub Actions 校验，也可以本地运行：

```bash
./scripts/check-skills.sh
```

校验内容包括：

- 每个 skill 必须有 `SKILL.md` 和 `agents/openai.yaml`
- `SKILL.md` 的 `name` 必须与目录名一致
- `default_prompt` 必须包含对应 `$skill-name`
- README 必须列出每个 skill
- 安装规则文档和业务项目 manifest 示例必须存在
- 扫描常见 token、密钥和本地绝对路径

## 维护原则

- Skill 内容优先使用中文，保留必要英文关键词便于检索。
- 不提交 token、密钥、Cookie、真实用户数据或内部敏感接口地址。
- 项目特定规则不要硬编码进 skill，应沉淀到项目仓库的 `AGENTS.md` 或 `docs/ai/`。
- 修改 skill 后运行官方校验脚本，确保 `SKILL.md` 和 `agents/openai.yaml` 可被 Codex 识别。
- 安装规则由本仓库统一维护；业务项目只声明版本、skills 和 Agent 支持范围。
