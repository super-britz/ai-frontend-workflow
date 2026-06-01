# AI Frontend Workflow

前端 AI 自动化开发工作流的团队级 skills 集合，用于把 Codex / OpenSpec / Superpowers 接入前端项目：OpenSpec 负责项目事实和需求变更，Superpowers 负责执行过程和工程质量，frontend skills 负责前端专业判断。

## 推荐组合

| 层 | 负责 | 典型动作 |
| --- | --- | --- |
| OpenSpec | 项目事实、需求边界、变更生命周期 | `openspec init`、`openspec new change`、`openspec validate`、`openspec archive` |
| Superpowers | 执行纪律、TDD、worktree、review、完成前验证 | `brainstorming`、`writing-plans`、`test-driven-development`、`verification-before-completion` |
| Frontend skills | change 规划、产品需求、设计需求、接口需求、产品/UI/API 对齐、实现、视觉验收、前端 Review | `frontend-change-planning`、`frontend-product-requirements`、`frontend-design-requirements`、`frontend-api-requirements`、`frontend-alignment-requirements` |

最稳的心智模型：

```text
OpenSpec 先定义事实和变更边界
→ Superpowers 主导工程执行
→ 开发中事实变化回写 OpenSpec
→ 验收后 OpenSpec validate / archive
```

硬规则：

```text
facts 先稳定 → decisions 再确认 → tasks 最后生成
```

产品需求、设计需求、接口需求和产品/UI/API 对齐结果必须写入 OpenSpec change 或 `docs/ai/` 文件；聊天摘要不能作为 source of truth。

## Skills

| Skill | 用途 |
| --- | --- |
| `frontend-project-bootstrap` | 检查前端仓库并生成或更新项目根目录 `AGENTS.md` |
| `frontend-change-planning` | 把较大的前端需求拆成多个可进入 OpenSpec 的 change 候选 |
| `frontend-product-requirements` | 从 PRD、Wiki 或产品说明沉淀产品事实、范围、规则和待确认问题 |
| `frontend-design-requirements` | 从 Figma 或设计稿沉淀 UI 设计事实、状态变体和视觉验收点 |
| `frontend-api-requirements` | 从接口文档沉淀前端接口契约摘录与缺口清单 |
| `frontend-alignment-requirements` | 对照产品、UI 和 API 事实，输出缺失与冲突差异清单 |
| `frontend-code-implementation` | 根据已确认产品、设计、接口、对齐结果和组件体系实现生产级前端页面 |
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

### 按业务项目 manifest 安装

支持 Codex、VS Code 中的 GitHub Copilot、Claude Code：

```bash
./scripts/install-skills.sh --manifest /path/to/project/.ai/skills.yaml --agent all
```

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
Use $frontend-product-requirements 从 PRD/Wiki/产品说明提炼产品事实、范围、规则和待确认问题，不写代码。
Use $frontend-design-requirements 沉淀这个 Figma 页面的 UI 设计拆解，输出设计来源索引、UI 结构、视觉元素、状态变体和视觉验收点。
Use $frontend-api-requirements 根据接口文档沉淀接口来源、路径、方法、请求、响应、错误、分页、鉴权和未确认项。
Use $frontend-alignment-requirements 对照产品事实、UI 设计事实和接口契约事实，输出字段、状态、异常、查询/操作能力的交叉检查与差异清单。
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
| `docs/design-requirements.md` | 设计事实 |
| `docs/api-requirements.md` | 接口事实 |
| `docs/alignment-requirements.md` | 产品 / 设计 / API 对齐结果 |
| `decisions.md` | 已拍板和待拍板问题 |
| `tasks.md` | 执行清单 |
| `specs/**/spec.md` | 最终系统能力契约 |

1. 新项目或老项目接入 AI 前，先运行 `frontend-project-bootstrap`。
2. 需求较大或边界不清时，先用 `frontend-change-planning` 拆成多个 change 候选。
3. 明确单个 change 边界后，用 OpenSpec 创建或选择 change；需要前端 Gate/tasks/verification 模板时运行 `./scripts/init-frontend-openspec-change.sh <change-id>`。
4. 有 PRD、Wiki 或产品说明时，使用 `frontend-product-requirements` 只拆产品事实。
5. 有 Figma 页面任务时，使用 `frontend-design-requirements` 只拆 UI 设计事实。
6. 有接口文档或联调任务时，使用 `frontend-api-requirements` 只做接口契约摘录与缺口清单。
7. 人工审核事实文件；拆解或契约不准时直接修改 `docs/product-requirements.md`、`docs/design-requirements.md`、`docs/api-requirements.md` 或 `docs/alignment-requirements.md`。
8. 有取舍、争议或 owner 的内容写入 `decisions.md`。
9. 使用 `frontend-alignment-requirements` 对照产品、UI 和 API 事实，产出缺失与冲突差异清单。
10. `Implementation Gate: Approved` 后，再生成或更新 `tasks.md`；涉及前端页面实现时，`tasks.md` 第一项必须是由 Superpowers 计划执行 `frontend-code-implementation` handoff，并重新读取 active OpenSpec change。
11. 实现阶段由 Superpowers 主导执行；页面代码修改前必须经过 `frontend-code-implementation` 准入，再用 `frontend-visual-verification` 和 `frontend-code-review` 验收。
12. 开发中发现事实变化，先回写 OpenSpec change 和 `decisions.md`，再继续写代码。
13. 验收通过后运行 OpenSpec validate/archive，把长期有效规则归档到 `openspec/specs/` 或项目稳定文档。

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
