#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="${ROOT_DIR}/skills"
README_FILE="${ROOT_DIR}/README.md"
INSTALL_RULES_FILE="${ROOT_DIR}/docs/install-rules.md"
MANIFEST_EXAMPLE_FILE="${ROOT_DIR}/examples/skills.manifest.yaml"
BUSINESS_TEMPLATE_MANIFEST_FILE="${ROOT_DIR}/examples/business-project-template/.ai/skills.yaml"

fail() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

require_file() {
  local file="$1"
  [[ -f "$file" ]] || fail "missing file: ${file#${ROOT_DIR}/}"
}

validate_skill() {
  local skill_dir="$1"
  local skill_name
  skill_name="$(basename "$skill_dir")"

  require_file "${skill_dir}/SKILL.md"
  require_file "${skill_dir}/agents/openai.yaml"

  grep -q '^---$' "${skill_dir}/SKILL.md" || fail "${skill_name}: SKILL.md missing YAML frontmatter"
  grep -q "^name: ${skill_name}$" "${skill_dir}/SKILL.md" || fail "${skill_name}: frontmatter name must match directory"
  grep -q '^description: .\+' "${skill_dir}/SKILL.md" || fail "${skill_name}: missing description"
  grep -q 'display_name:' "${skill_dir}/agents/openai.yaml" || fail "${skill_name}: openai.yaml missing display_name"
  grep -q 'short_description:' "${skill_dir}/agents/openai.yaml" || fail "${skill_name}: openai.yaml missing short_description"
  grep -q 'default_prompt:' "${skill_dir}/agents/openai.yaml" || fail "${skill_name}: openai.yaml missing default_prompt"
  grep -Fq "\$${skill_name}" "${skill_dir}/agents/openai.yaml" || fail "${skill_name}: default_prompt must mention \$${skill_name}"
  grep -Fq "\`${skill_name}\`" "${README_FILE}" || fail "${skill_name}: README does not list this skill"
}

[[ -d "$SKILLS_DIR" ]] || fail "missing skills directory"
require_file "$README_FILE"
require_file "$INSTALL_RULES_FILE"
require_file "$MANIFEST_EXAMPLE_FILE"
require_file "${ROOT_DIR}/examples/CLAUDE.md"
require_file "${ROOT_DIR}/examples/copilot-instructions.md"
require_file "$BUSINESS_TEMPLATE_MANIFEST_FILE"
require_file "${ROOT_DIR}/examples/business-project-template/AGENTS.md"
require_file "${ROOT_DIR}/examples/business-project-template/CLAUDE.md"
require_file "${ROOT_DIR}/examples/business-project-template/.github/copilot-instructions.md"
require_file "${ROOT_DIR}/examples/business-project-template/scripts/setup-ai-skills.sh"
require_file "${ROOT_DIR}/examples/business-project-template/README.md"
require_file "${ROOT_DIR}/templates/openspec/frontend/tasks.md"
require_file "${ROOT_DIR}/templates/openspec/frontend/decisions.md"
require_file "${ROOT_DIR}/templates/openspec/frontend/verification.md"
require_file "${ROOT_DIR}/templates/openspec/frontend/review.md"
require_file "${ROOT_DIR}/templates/openspec/frontend/change-index.md"
require_file "${ROOT_DIR}/scripts/init-frontend-openspec-change.sh"

skill_dirs=()
while IFS= read -r skill_dir; do
  skill_dirs+=("$skill_dir")
done < <(find "$SKILLS_DIR" -mindepth 1 -maxdepth 1 -type d | sort)
[[ "${#skill_dirs[@]}" -gt 0 ]] || fail "no skills found"

for skill_dir in "${skill_dirs[@]}"; do
  validate_skill "$skill_dir"
done

validate_manifest_skills() {
  local manifest_file="$1"
  local manifest_skill
  while IFS= read -r manifest_skill; do
    [[ -d "${SKILLS_DIR}/${manifest_skill}" ]] || fail "${manifest_file#${ROOT_DIR}/} references unknown skill: ${manifest_skill}"
  done < <(
  awk '
    /^skills:/ { in_skills = 1; next }
    /^[^[:space:]-]/ { in_skills = 0 }
    in_skills && /^[[:space:]]*-/ {
      sub(/^[[:space:]]*-[[:space:]]*/, "")
      gsub(/["'\'']/, "")
      print
    }
  ' "$manifest_file"
  )
}

validate_manifest_skills "$MANIFEST_EXAMPLE_FILE"
validate_manifest_skills "$BUSINESS_TEMPLATE_MANIFEST_FILE"

grep -q 'Codex' "$INSTALL_RULES_FILE" || fail "install rules must mention Codex"
grep -q 'GitHub Copilot' "$INSTALL_RULES_FILE" || fail "install rules must mention GitHub Copilot"
grep -q 'Claude Code' "$INSTALL_RULES_FILE" || fail "install rules must mention Claude Code"
grep -q 'frontend-code-implementation' "${ROOT_DIR}/templates/openspec/frontend/tasks.md" || fail "frontend tasks template must require frontend-code-implementation"
bash -n "${ROOT_DIR}/scripts/init-frontend-openspec-change.sh"
bash -n "${ROOT_DIR}/examples/business-project-template/scripts/setup-ai-skills.sh"

if grep -R -n -E 'gho_|ghp_|github_pat_|sk-[A-Za-z0-9]|api[_-]?key|secret|password|cookie|Authorization|Bearer|/Users/[^/ ]+' \
  --exclude='check-skills.sh' \
  -- README.md docs skills scripts examples .github 2>/dev/null; then
  fail "potential secret or local path found"
fi

printf 'Validated %s skills.\n' "${#skill_dirs[@]}"
