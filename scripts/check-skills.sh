#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="${ROOT_DIR}/skills"
README_FILE="${ROOT_DIR}/README.md"

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

skill_dirs=()
while IFS= read -r skill_dir; do
  skill_dirs+=("$skill_dir")
done < <(find "$SKILLS_DIR" -mindepth 1 -maxdepth 1 -type d | sort)
[[ "${#skill_dirs[@]}" -gt 0 ]] || fail "no skills found"

for skill_dir in "${skill_dirs[@]}"; do
  validate_skill "$skill_dir"
done

if grep -R -n -E 'gho_|ghp_|github_pat_|sk-[A-Za-z0-9]|api[_-]?key|secret|password|cookie|Authorization|Bearer|/Users/[^/ ]+' \
  --exclude='check-skills.sh' \
  -- README.md skills scripts examples .github 2>/dev/null; then
  fail "potential secret or local path found"
fi

printf 'Validated %s skills.\n' "${#skill_dirs[@]}"
