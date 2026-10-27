#!/usr/bin/env bash
# Instala o actualiza el kit multiagente en el repo actual.
#   curl -fsSL https://raw.githubusercontent.com/zaned897/skills/main/setup.sh | bash
#   curl -fsSL .../setup.sh | bash -s -- --dry-run      # solo muestra qué haría
# Primera vez: copia template/ sin pisar nada (igual que install.sh).
# Si ya existe .kit-version: actualiza solo lo común (skills y tools/agentes) y deja
# lo propio del repo (AGENTS.md, CLAUDE.md, preambulo.md, la skill delegar, CI, scripts).
set -euo pipefail
REPO="${KIT_REPO:-https://github.com/zaned897/skills}"
REF="${KIT_REF:-main}"
DRY=0; [ "${1:-}" = "--dry-run" ] && DRY=1

DST="$(git rev-parse --show-toplevel 2>/dev/null)" || { echo "Corre esto dentro de un repo git."; exit 1; }
if [ -n "${KIT_SRC:-}" ]; then SRC="$KIT_SRC"; else
  SRC="$(mktemp -d)"; trap 'rm -rf "$SRC"' EXIT
  git clone -q --depth 1 -b "$REF" "$REPO" "$SRC"
fi
NUEVA="$(cat "$SRC/VERSION")"

if [ ! -f "$DST/.kit-version" ]; then
  echo "Instalando kit-multiagente $NUEVA en $DST"
  if [ $DRY = 1 ]; then bash "$SRC/install.sh" "$DST" --dry-run; exit 0; fi
  bash "$SRC/install.sh" "$DST"
  echo "$NUEVA" > "$DST/.kit-version"
  echo "Listo. Sigue los pasos de arriba y lee COMPARTIR.md del kit."
  exit 0
fi

ACTUAL="$(cat "$DST/.kit-version")"
echo "Actualizando kit-multiagente $ACTUAL → $NUEVA en $DST"
T="$SRC/template"
# Lo común: se reemplaza. Lo propio del repo nunca está en esta lista.
COMUNES=()
for s in "$T"/.agents/skills/*/; do n="$(basename "$s")"; [ "$n" = delegar ] || COMUNES+=(".agents/skills/$n"); done
COMUNES+=(".agents/skills/README.md" "tools/agentes/delegar.py" "tools/agentes/sincronizar-skills.py" "tools/agentes/exportar.py" "tools/agentes/README.md" "tools/agentes/plantillas")
for rel in "${COMUNES[@]}"; do
  if [ -e "$DST/$rel" ] && diff -rq "$T/$rel" "$DST/$rel" >/dev/null 2>&1; then continue; fi
  printf '  ~ %s\n' "$rel"
  [ $DRY = 1 ] && continue
  rm -rf "${DST:?}/$rel"; mkdir -p "$(dirname "$DST/$rel")"; cp -r "$T/$rel" "$DST/$rel"
done
[ $DRY = 1 ] && { echo "Simulación: nada se escribió."; exit 0; }
( cd "$DST" && "$(command -v python3 || command -v python)" tools/agentes/sincronizar-skills.py )
echo "$NUEVA" > "$DST/.kit-version"
echo "Listo. Revisa el diff (git diff --stat), corre tus checks y abre un PR."
