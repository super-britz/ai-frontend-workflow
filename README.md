# AI Frontend Workflow

前端 AI 自动化开发工作流的团队级 skills 集合，用于把 Codex / Superpowers 接入前端项目，并沉淀项目初始化、设计还原、组件映射、接口契约和验收规则。

## Skills

| Skill | 用途 |
| --- | --- |
| `frontend-project-bootstrap` | 初始化前端仓库的 `AGENTS.md`、组件边界、设计还原和验收护栏 |
| `frontend-api-contract` | 把接口文档沉淀为前端可执行契约、类型、service、mock 和状态处理规则 |
| `figma-titan-to-code` | 将 Figma 设计稿实现为基于 Ninebot Titan 组件体系的生产级前端代码 |
| `frontend-visual-verification` | 验证前端页面的设计还原、响应式、核心状态和截图验收 |
| `codex-review-frontend` | 审查前端改动的组件复用、接口契约、状态覆盖和验收质量 |

## 安装

```bash
mkdir -p ~/.codex/skills
cp -R skills/* ~/.codex/skills/
```

安装后可以这样调用：

```text
Use $frontend-project-bootstrap 初始化这个前端仓库的 Codex/Superpowers 协作规则、组件边界和验收护栏。
Use $frontend-api-contract 根据接口文档生成前端接口契约、类型、service、mock 和状态处理规则。
Use $figma-titan-to-code 根据这个 Figma 页面实现 Titan 前端页面。
Use $frontend-visual-verification 验证这个页面的设计还原、响应式和核心状态。
Use $codex-review-frontend review 这次前端改动。
```

## 推荐工作流

1. 新项目或老项目接入 AI 前，先运行 `frontend-project-bootstrap`。
2. 有 Figma 页面实现任务时，使用 `figma-titan-to-code`，并遵守组件映射规则。
3. 有接口文档或联调任务时，使用 `frontend-api-contract`，先生成接口契约再写业务代码。
4. 页面实现完成后，使用 `frontend-visual-verification` 做真实浏览器、响应式和状态验收。
5. 合并前使用 `codex-review-frontend` 做前端专项 Review。
6. 项目级规则放在业务仓库的 `AGENTS.md` 和 `docs/ai/`，本仓库只维护跨项目可复用的 skills。

## 维护原则

- Skill 内容优先使用中文，保留必要英文关键词便于检索。
- 不提交 token、密钥、Cookie、真实用户数据或内部敏感接口地址。
- 项目特定规则不要硬编码进 skill，应沉淀到项目仓库的 `AGENTS.md` 或 `docs/ai/`。
- 修改 skill 后运行官方校验脚本，确保 `SKILL.md` 和 `agents/openai.yaml` 可被 Codex 识别。
