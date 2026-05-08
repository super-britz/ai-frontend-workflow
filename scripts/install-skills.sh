#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="${ROOT_DIR}/skills"
TARGET_DIR="${CODEX_HOME:-${HOME}/.codex}/skills"

usage() {
  cat <<'USAGE'
安装本仓库的 Codex skills。

用法:
  scripts/install-skills.sh [--target DIR] [--dry-run]

选项:
  --target DIR  安装到指定目录，默认 ${CODEX_HOME:-$HOME/.codex}/skills
  --dry-run     只打印将要安装的 skill，不写入文件
  -h, --help    显示帮助
USAGE
}

dry_run=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      [[ $# -ge 2 ]] || { echo "ERROR: --target requires a directory" >&2; exit 1; }
      TARGET_DIR="$2"
      shift 2
      ;;
    --dry-run)
      dry_run=1
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

[[ -d "$SOURCE_DIR" ]] || { echo "ERROR: skills directory not found" >&2; exit 1; }

if [[ "$dry_run" -eq 1 ]]; then
  printf 'Target: %s\n' "$TARGET_DIR"
  find "$SOURCE_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort
  exit 0
fi

mkdir -p "$TARGET_DIR"
for skill_dir in "$SOURCE_DIR"/*; do
  [[ -d "$skill_dir" ]] || continue
  skill_name="$(basename "$skill_dir")"
  rm -rf "${TARGET_DIR}/${skill_name}"
  cp -R "$skill_dir" "${TARGET_DIR}/${skill_name}"
  printf 'Installed %s -> %s\n' "$skill_name" "$TARGET_DIR"
done
