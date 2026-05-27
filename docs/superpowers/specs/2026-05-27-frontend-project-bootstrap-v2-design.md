# frontend-project-bootstrap v2 Design

## Goal

Rewrite `frontend-project-bootstrap` into a focused AGENTS.md initializer/updater.

The skill should help an AI assistant inspect a frontend repository and create or update the root `AGENTS.md` with concise project-level collaboration rules. It should not create requirement documents, component usage documents, OpenSpec changes, verification reports, review reports, or task routing rules.

## Scope

### Keep

- Inspect the repository before writing rules.
- Generate `AGENTS.md` when it is missing.
- Update `AGENTS.md` when it already exists.
- Preserve existing user rules, language preferences, safety rules, and commit rules.
- Record discovered project facts such as framework, language, package manager, UI library, key directories, and available commands.
- Add concise project-level guardrails for code edits, frontend implementation, validation, git usage, and prohibited actions.
- Mark important missing information as `Needs project discovery` instead of inventing facts.

### Remove

- Do not create `docs/ai/component-usage.md`.
- Do not create `docs/ai/*-requirements.md`.
- Do not create or update OpenSpec files.
- Do not add frontend skill routing rules.
- Do not add Figma node, Implementation Gate, visual verification, or review workflow details.
- Do not attempt to design a project component system during bootstrap.

## Output Contract

The skill has one file output:

```text
AGENTS.md
```

If the repository already has `AGENTS.md`, the skill updates it in place. If it has nearby agent rule files such as `CLAUDE.md`, `.github/copilot-instructions.md`, `.cursorrules`, or README instructions, the skill reads them and preserves non-conflicting project rules in `AGENTS.md`.

## AGENTS.md Content

The generated or updated file should stay short and practical. Recommended sections:

- Global preferences
- Project overview
- Common commands
- Code change rules
- Frontend implementation rules
- Validation rules
- Git rules
- Prohibited actions
- Unknowns

The frontend implementation rules should remain project-level and lightweight, for example:

- Search existing pages and components before adding new UI.
- Prefer the project UI library and existing local abstractions.
- Avoid unrelated global style, routing, build, dependency, or API changes.
- Avoid new dependencies unless the task explicitly requires them.

## Failure Modes To Avoid

- Generating a long generic AGENTS.md that future agents will not read.
- Inventing commands, component names, routes, test tools, or project conventions.
- Replacing user-written rules instead of merging them.
- Turning bootstrap into a requirement-analysis, OpenSpec, Figma, verification, or review workflow.
- Creating extra documentation files as a side effect.

## Success Criteria

- `frontend-project-bootstrap` is easy to explain in one sentence: generate or update `AGENTS.md` for a frontend repository.
- The skill body is shorter than the current version and has fewer responsibilities.
- The AGENTS template is shorter and contains no task routing rules.
- `scripts/check-skills.sh` passes after the rewrite.
