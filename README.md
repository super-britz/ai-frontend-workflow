# AI Frontend Workflow

前端 AI 自动化开发工作流的团队级 skills 集合，用于把 Codex / OpenSpec / Superpowers 接入前端项目：OpenSpec 负责项目事实和需求变更，Superpowers 负责执行过程和工程质量，frontend skills 负责前端专业判断。

## 推荐组合

| 层 | 负责 | 典型动作 |
| --- | --- | --- |
| OpenSpec | 项目事实、需求边界、变更生命周期 | `openspec init`、`openspec new change`、`openspec validate`、`openspec archive` |
| Superpowers | 执行纪律、TDD、worktree、review、完成前验证 | `brainstorming`、`writing-plans`、`test-driven-development`、`verification-before-completion` |
| Frontend skills | 设计拆解、接口契约、设计接口对齐、实现、视觉验收、前端 Review | `frontend-design-breakdown`、`frontend-api-contract`、`frontend-design-api-alignment` |

最稳的心智模型：

```text
OpenSpec 先定义事实和变更边界
→ Superpowers 主导工程执行
→ 开发中事实变化回写 OpenSpec
→ 验收后 OpenSpec validate / archive
```

## Skills

| Skill | 用途 |
| --- | --- |
| `frontend-project-bootstrap` | 初始化前端仓库的 `AGENTS.md`、组件边界、设计还原和验收护栏 |
| `frontend-openspec-workflow` | 为单个前端需求创建或选择 OpenSpec change，并规划文档落点、人工 Gate 和归档 |
| `frontend-design-breakdown` | 写代码前拆解 Figma 设计稿的页面结构、组件映射、状态和验收点 |
| `frontend-api-contract` | 把接口文档沉淀为前端可执行契约和接入规则，确认后再生成接口层代码 |
| `frontend-design-api-alignment` | 对齐设计拆解和接口契约的字段、状态、权限、查询能力和差异决策 |
| `frontend-titan-implementation` | 将 Figma 设计稿实现为基于 Ninebot Titan 组件体系的生产级前端代码 |
| `frontend-visual-verification` | 验证前端页面的设计还原、响应式、核心状态和截图验收 |
| `frontend-code-review` | 审查前端改动的组件复用、接口契约、状态覆盖和验收质量 |

## 安装

```bash
mkdir -p ~/.codex/skills
cp -R skills/* ~/.codex/skills/
```

也可以使用脚本安装：

```bash
./scripts/install-skills.sh
```

更新本仓库并重新安装：

```bash
./scripts/update-skills.sh
```

安装后可以这样调用：

```text
Use $frontend-project-bootstrap 初始化这个前端仓库的 Codex/Superpowers 协作规则、组件边界和验收护栏。
Use $frontend-openspec-workflow 为这个前端需求设计 OpenSpec、Superpowers 和 frontend skills 的分层协作流程。
Use $frontend-design-breakdown 拆解这个 Figma 页面，输出页面结构、组件映射、状态清单和视觉验收点，不写代码。
Use $frontend-api-contract 根据接口文档生成前端接口契约、类型、service、mock 和状态处理规则。
Use $frontend-design-api-alignment 对齐设计拆解和接口契约，输出字段映射、状态映射、差异清单和实现决策，不写代码。
Use $frontend-titan-implementation 根据这个 Figma 页面实现 Titan 前端页面。
Use $frontend-visual-verification 验证这个页面的设计还原、响应式和核心状态。
Use $frontend-code-review review 这次前端改动。
```

## 推荐工作流

1. 新项目或老项目接入 AI 前，先运行 `frontend-project-bootstrap`。
2. 明确需求边界时，用 OpenSpec 创建或选择 change；需要编排前端文档时使用 `frontend-openspec-workflow`。
3. 有 Figma 页面任务时，使用 `frontend-design-breakdown` 只拆设计事实。
4. 有接口文档或联调任务时，使用 `frontend-api-contract` 只拆接口事实。
5. 使用 `frontend-design-api-alignment` 对齐设计和接口，产出冲突和人工决策。
6. `Implementation Gate: Approved` 后，由 Superpowers 主导 `writing-plans`、TDD、worktree、review 和完成前验证。
7. 实现阶段按需使用 `frontend-titan-implementation`、`frontend-visual-verification` 和 `frontend-code-review`。
8. 开发中发现事实变化，先回写 OpenSpec change 和 `decisions.md`，再继续写代码。
9. 验收通过后运行 OpenSpec validate/archive，把长期有效规则归档到 `openspec/specs/` 或项目稳定文档。

业务项目可以参考：

- `examples/AGENTS.workflow.md`

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
- 扫描常见 token、密钥和本地绝对路径

## 维护原则

- Skill 内容优先使用中文，保留必要英文关键词便于检索。
- 不提交 token、密钥、Cookie、真实用户数据或内部敏感接口地址。
- 项目特定规则不要硬编码进 skill，应沉淀到项目仓库的 `AGENTS.md` 或 `docs/ai/`。
- 修改 skill 后运行官方校验脚本，确保 `SKILL.md` 和 `agents/openai.yaml` 可被 Codex 识别。
