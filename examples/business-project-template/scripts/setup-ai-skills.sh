#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MANIFEST_FILE="${PROJECT_ROOT}/.ai/skills.yaml"
CACHE_ROOT="${AI_FRONTEND_WORKFLOW_CACHE:-${HOME}/.cache/ai-frontend-workflow}"

usage() {
  cat <<'USAGE'
安装本项目声明的团队前端 AI skills。

用法:
  scripts/setup-ai-skills.sh [--agent codex|copilot|claude|all] [--status]

选项:
  --agent AGENT  安装目标，默认 all
  --status       只检查安装状态
  -h, --help     显示帮助
USAGE
}

fail() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

manifest_value() {
  local key="$1"
  awk -v key="$key" '
    $1 == key ":" {
      sub(/^[^:]+:[[:space:]]*/, "")
      gsub(/["'\'']/, "")
      print
      exit
    }
  ' "$MANIFEST_FILE"
}

AGENT="all"
STATUS_ARGS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --agent)
      [[ $# -ge 2 ]] || fail "--agent requires a value"
      AGENT="$2"
      shift 2
      ;;
    --status)
      STATUS_ARGS+=(--status)
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      fail "unknown option: $1"
      ;;
  esac
done

[[ -f "$MANIFEST_FILE" ]] || fail "manifest not found: $MANIFEST_FILE"
SOURCE_REPO="$(manifest_value repo)"
SOURCE_VERSION="$(manifest_value version)"

[[ -n "$SOURCE_REPO" ]] || fail "source.repo is required in .ai/skills.yaml"
[[ -n "$SOURCE_VERSION" ]] || fail "source.version is required in .ai/skills.yaml"

mkdir -p "$CACHE_ROOT"

if [[ ! -d "${CACHE_ROOT}/.git" ]]; then
  git clone "$SOURCE_REPO" "$CACHE_ROOT"
else
  git -C "$CACHE_ROOT" fetch --tags --prune
fi

git -C "$CACHE_ROOT" checkout "$SOURCE_VERSION"

"${CACHE_ROOT}/scripts/install-skills.sh" \
  --manifest "$MANIFEST_FILE" \
  --agent "$AGENT" \
  "${STATUS_ARGS[@]}"
