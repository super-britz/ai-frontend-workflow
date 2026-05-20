#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="${ROOT_DIR}/skills"
TARGET_DIR=""
MANIFEST_FILE=""
DRY_RUN=0
STATUS_ONLY=0

declare -a REQUESTED_SKILLS=()
declare -a REQUESTED_AGENTS=()
declare -a MANIFEST_SKILLS=()
declare -a MANIFEST_AGENTS=()

usage() {
  cat <<'USAGE'
安装本仓库的前端 AI skills。

用法:
  scripts/install-skills.sh [--manifest FILE] [--agent AGENT] [--skill NAME] [--dry-run]
  scripts/install-skills.sh --manifest FILE --agent all --status

选项:
  --manifest FILE  读取业务项目的 .ai/skills.yaml
  --agent AGENT    安装目标: codex, copilot, claude, all。可重复或用逗号分隔
  --skill NAME     只安装指定 skill。可重复或用逗号分隔
  --target DIR     覆盖 codex/copilot 的 skills 目录；默认按 Agent 选择
  --status         只检查 selected skills 是否已安装
  --dry-run        只打印将要执行的操作，不写入文件
  -h, --help       显示帮助

默认行为保持兼容：不传参数时安装全部 skills 到 ${CODEX_HOME:-$HOME/.codex}/skills。
USAGE
}

fail() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

trim() {
  local value="$1"
  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"
  printf '%s' "$value"
}

strip_quotes() {
  local value="$1"
  value="${value%\"}"
  value="${value#\"}"
  value="${value%\'}"
  value="${value#\'}"
  printf '%s' "$value"
}

lower() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]'
}

append_csv_values() {
  local kind="$1"
  local raw="$2"
  local old_ifs="$IFS"
  local value
  IFS=','
  read -ra values <<< "$raw"
  IFS="$old_ifs"
  for value in "${values[@]}"; do
    value="$(trim "$value")"
    [[ -n "$value" ]] || continue
    case "$kind" in
      agent) REQUESTED_AGENTS+=("$(lower "$value")") ;;
      skill) REQUESTED_SKILLS+=("$value") ;;
      *) fail "unknown value kind: $kind" ;;
    esac
  done
}

parse_manifest() {
  [[ -f "$MANIFEST_FILE" ]] || fail "manifest not found: $MANIFEST_FILE"

  local section=""
  local raw line key value skill agent_value
  while IFS= read -r raw || [[ -n "$raw" ]]; do
    line="${raw%%#*}"
    line="$(trim "$line")"
    [[ -n "$line" ]] || continue

    case "$line" in
      source:)
        section="source"
        continue
        ;;
      skills:)
        section="skills"
        continue
        ;;
      agents:)
        section="agents"
        continue
        ;;
    esac

    if [[ "$section" == "skills" && "$line" == -* ]]; then
      skill="$(trim "${line#-}")"
      skill="$(strip_quotes "$skill")"
      [[ -n "$skill" ]] && MANIFEST_SKILLS+=("$skill")
      continue
    fi

    if [[ "$section" == "agents" && "$line" == *:* ]]; then
      key="$(trim "${line%%:*}")"
      value="$(trim "${line#*:}")"
      value="$(strip_quotes "$value")"
      agent_value="$(lower "$value")"
      case "$agent_value" in
        false|disabled|none|no|off)
          ;;
        *)
          [[ -n "$key" ]] && MANIFEST_AGENTS+=("$(lower "$key")")
          ;;
      esac
    fi
  done < "$MANIFEST_FILE"
}

list_all_skills() {
  local skill_dir
  for skill_dir in "$SOURCE_DIR"/*; do
    [[ -d "$skill_dir" ]] || continue
    basename "$skill_dir"
  done | sort
}

normalize_agents() {
  local agent
  local expanded=()

  if [[ "${#REQUESTED_AGENTS[@]}" -gt 0 ]]; then
    expanded=("${REQUESTED_AGENTS[@]}")
  elif [[ "${#MANIFEST_AGENTS[@]}" -gt 0 ]]; then
    expanded=("${MANIFEST_AGENTS[@]}")
  else
    expanded=("codex")
  fi

  REQUESTED_AGENTS=()
  for agent in "${expanded[@]}"; do
    case "$agent" in
      all)
        REQUESTED_AGENTS+=("codex" "copilot" "claude")
        ;;
      codex|copilot|claude)
        REQUESTED_AGENTS+=("$agent")
        ;;
      *)
        fail "unsupported agent: $agent"
        ;;
    esac
  done
}

normalize_skills() {
  local skill
  if [[ "${#REQUESTED_SKILLS[@]}" -eq 0 && "${#MANIFEST_SKILLS[@]}" -gt 0 ]]; then
    REQUESTED_SKILLS=("${MANIFEST_SKILLS[@]}")
  fi

  if [[ "${#REQUESTED_SKILLS[@]}" -eq 0 ]]; then
    while IFS= read -r skill; do
      REQUESTED_SKILLS+=("$skill")
    done < <(list_all_skills)
  fi

  for skill in "${REQUESTED_SKILLS[@]}"; do
    [[ -d "${SOURCE_DIR}/${skill}" ]] || fail "skill not found: $skill"
  done
}

agent_skill_dir() {
  local agent="$1"
  case "$agent" in
    codex)
      printf '%s\n' "${TARGET_DIR:-${CODEX_HOME:-${HOME}/.codex}/skills}"
      ;;
    copilot)
      printf '%s\n' "${TARGET_DIR:-${COPILOT_HOME:-${HOME}/.copilot}/skills}"
      ;;
    claude)
      printf '%s\n' "${AI_FRONTEND_WORKFLOW_HOME:-${HOME}/.ai-frontend-workflow}/skills"
      ;;
    *)
      fail "unsupported agent: $agent"
      ;;
  esac
}

claude_commands_dir() {
  printf '%s\n' "${CLAUDE_HOME:-${HOME}/.claude}/commands"
}

install_skill_dir() {
  local skill_name="$1"
  local target_dir="$2"
  local source_dir="${SOURCE_DIR}/${skill_name}"
  local target_path="${target_dir}/${skill_name}"

  if [[ "$DRY_RUN" -eq 1 ]]; then
    printf '[dry-run] copy %s -> %s\n' "$source_dir" "$target_path"
    return
  fi

  mkdir -p "$target_dir"
  rm -rf "$target_path"
  cp -R "$source_dir" "$target_path"
}

install_claude_command() {
  local skill_name="$1"
  local skill_dir="$2"
  local commands_dir
  local command_file
  commands_dir="$(claude_commands_dir)"
  command_file="${commands_dir}/${skill_name}.md"

  if [[ "$DRY_RUN" -eq 1 ]]; then
    printf '[dry-run] write Claude command %s\n' "$command_file"
    return
  fi

  mkdir -p "$commands_dir"
  cat > "$command_file" <<EOF
Use the team frontend skill \`${skill_name}\`.

1. Read \`${skill_dir}/${skill_name}/SKILL.md\`.
2. Resolve referenced files relative to \`${skill_dir}/${skill_name}\`.
3. Follow the skill workflow before making changes or giving the final answer.
EOF
}

install_agent() {
  local agent="$1"
  local target_dir
  local skill
  target_dir="$(agent_skill_dir "$agent")"

  for skill in "${REQUESTED_SKILLS[@]}"; do
    install_skill_dir "$skill" "$target_dir"
    if [[ "$agent" == "claude" ]]; then
      install_claude_command "$skill" "$target_dir"
    fi
    if [[ "$DRY_RUN" -eq 1 ]]; then
      printf 'Would install %s for %s -> %s\n' "$skill" "$agent" "$target_dir"
    else
      printf 'Installed %s for %s -> %s\n' "$skill" "$agent" "$target_dir"
    fi
  done
}

print_status() {
  local agent target_dir skill command_file
  for agent in "${REQUESTED_AGENTS[@]}"; do
    target_dir="$(agent_skill_dir "$agent")"
    printf '[%s] target: %s\n' "$agent" "$target_dir"
    for skill in "${REQUESTED_SKILLS[@]}"; do
      if [[ "$agent" == "claude" ]]; then
        command_file="$(claude_commands_dir)/${skill}.md"
        if [[ -e "${target_dir}/${skill}/SKILL.md" && -f "$command_file" ]]; then
          printf '  installed: %s\n' "$skill"
        else
          printf '  missing:   %s\n' "$skill"
        fi
      elif [[ -e "${target_dir}/${skill}/SKILL.md" ]]; then
        printf '  installed: %s\n' "$skill"
      else
        printf '  missing:   %s\n' "$skill"
      fi
    done
  done
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --manifest)
      [[ $# -ge 2 ]] || fail "--manifest requires a file"
      MANIFEST_FILE="$2"
      shift 2
      ;;
    --agent)
      [[ $# -ge 2 ]] || fail "--agent requires a value"
      append_csv_values agent "$2"
      shift 2
      ;;
    --skill)
      [[ $# -ge 2 ]] || fail "--skill requires a value"
      append_csv_values skill "$2"
      shift 2
      ;;
    --target)
      [[ $# -ge 2 ]] || fail "--target requires a directory"
      TARGET_DIR="$2"
      shift 2
      ;;
    --status)
      STATUS_ONLY=1
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

[[ -d "$SOURCE_DIR" ]] || fail "skills directory not found"

if [[ -n "$MANIFEST_FILE" ]]; then
  parse_manifest
fi

normalize_agents
normalize_skills

if [[ "$STATUS_ONLY" -eq 1 ]]; then
  print_status
  exit 0
fi

for agent in "${REQUESTED_AGENTS[@]}"; do
  install_agent "$agent"
done
