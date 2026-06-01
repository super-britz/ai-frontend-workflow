#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE_DIR="${ROOT_DIR}/templates/openspec/frontend"

usage() {
  printf 'Usage: %s <change-id>\n' "$(basename "$0")" >&2
}

if [[ $# -ne 1 ]]; then
  usage
  exit 1
fi

CHANGE_ID="$1"
CHANGE_DIR="${ROOT_DIR}/openspec/changes/${CHANGE_ID}"

if [[ ! -d "$CHANGE_DIR" ]]; then
  printf 'ERROR: OpenSpec change does not exist: %s\n' "${CHANGE_DIR#${ROOT_DIR}/}" >&2
  printf 'Create the change with OpenSpec first, then rerun this script.\n' >&2
  exit 1
fi

copy_if_missing() {
  local source_file="$1"
  local target_file="$2"

  if [[ -e "$target_file" ]]; then
    printf 'skip %s\n' "${target_file#${ROOT_DIR}/}"
    return
  fi

  mkdir -p "$(dirname "$target_file")"
  cp "$source_file" "$target_file"
  printf 'create %s\n' "${target_file#${ROOT_DIR}/}"
}

mkdir -p "${CHANGE_DIR}/docs"

copy_if_missing "${TEMPLATE_DIR}/decisions.md" "${CHANGE_DIR}/decisions.md"
copy_if_missing "${TEMPLATE_DIR}/tasks.md" "${CHANGE_DIR}/tasks.md"
copy_if_missing "${TEMPLATE_DIR}/verification.md" "${CHANGE_DIR}/verification.md"
copy_if_missing "${TEMPLATE_DIR}/review.md" "${CHANGE_DIR}/review.md"
copy_if_missing "${TEMPLATE_DIR}/change-index.md" "${CHANGE_DIR}/frontend-change-index.md"

printf 'Frontend OpenSpec templates are ready for %s.\n' "$CHANGE_ID"
