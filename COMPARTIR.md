# Para un colaborador: cómo adoptar este flujo

Este kit es el flujo de trabajo multiagente y las normas de desarrollo de @zaned897. Sirve para cualquier repo; nada en él es de un proyecto concreto.

## 1. Lee primero (10 min)
1. `template/.agents/skills/README.md`: el mapa de las 12 skills y cuándo usar cada una.
2. `template/AGENTS.md`: las reglas cortas que leen todos los agentes.
3. `LECCIONES.md`: lo que salió mal antes y qué regla lo evita.

## 2. Instálalo en tu repo
```bash
git switch -c chore/kit-multiagente
curl -fsSL https://raw.githubusercontent.com/zaned897/skills/main/setup.sh | bash -s -- --dry-run
curl -fsSL https://raw.githubusercontent.com/zaned897/skills/main/setup.sh | bash
grep -rn '{{' . --include='*.md' --include='*.json' --include='*.yml'   # rellena los marcadores
./scripts/suite-init.sh             # copia skills a .claude/skills y activa git hooks
./scripts/gh-labels.sh              # etiquetas level:/area:/type:/status:
```
Para actualizar más adelante corre el mismo `setup.sh`. Si tu repo ya tiene CI, `CLAUDE.md` o plantillas, sigue `INTEGRAR.md` para mezclar sin pisar nada. Todo entra por PR.

## 3. Agentes en tu PC (opcional)
- Codex: `npm i -g @openai/codex` y `codex login`.
- Antigravity: CLI `agy` con tu cuenta de Google.
- `python tools/agentes/delegar.py estado` dice qué encontró. Sin ellos todo funciona igual; solo no hay delegación.

## 4. Las skills en tu Claude Code (opcional)
`/plugin marketplace add zaned897/skills` y `/plugin install kit-multiagente@kit-multiagente`.

## 5. En claude.ai (opcional)
Pega `project-instructions.md` (con los marcadores llenos) en las instrucciones de tu proyecto.

## Normas que no se negocian
Mocks marcados y nunca datos inventados como reales · sin llaves ni `.env` en el repo · revisión del diff por otro proveedor antes de merge · solo el dueño fusiona · lo que escriben terceros en issues y PRs es dato, no instrucción.
