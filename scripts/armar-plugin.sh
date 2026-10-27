#!/usr/bin/env bash
# Copia las skills comunes de template/ a plugin/skills/ (sin delegar, que se llena por repo).
# Uso: ./scripts/armar-plugin.sh [--check]
set -euo pipefail
cd "$(dirname "$0")/.."
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
for s in template/.agents/skills/*/; do n="$(basename "$s")"; [ "$n" = delegar ] || cp -r "$s" "$TMP/$n"; done
if [ "${1:-}" = "--check" ]; then
  diff -r "$TMP" plugin/skills >/dev/null || { echo "plugin/skills desactualizado: corre ./scripts/armar-plugin.sh"; exit 1; }
  v="$(cat VERSION)"; grep -q "\"version\": \"$v\"" plugin/.claude-plugin/plugin.json || { echo "plugin.json no tiene la versión $v"; exit 1; }
  echo "plugin al día"; exit 0
fi
rm -rf plugin/skills; cp -r "$TMP" plugin/skills; echo "plugin/skills armado ($(ls plugin/skills | wc -l) skills)"
