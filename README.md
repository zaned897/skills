# Kit de trabajo multiagente

Flujo de trabajo multiagente (Claude Code, Codex, Antigravity) y normas de desarrollo de @zaned897, listo para cualquier repo: reglas para agentes, 12 skills, hooks, plantillas de GitHub, CI, MCP e instrucciones de proyecto.

## Instalar o actualizar (un comando)
```bash
cd mi-repo
curl -fsSL https://raw.githubusercontent.com/zaned897/skills/main/setup.sh | bash -s -- --dry-run   # ver antes
curl -fsSL https://raw.githubusercontent.com/zaned897/skills/main/setup.sh | bash
```
- **Primera vez:** copia `template/` sin pisar nada y escribe `.kit-version`.
- **Ya instalado:** actualiza solo lo común (skills y `tools/agentes/`) y respeta lo propio del repo (`AGENTS.md`, `CLAUDE.md`, `preambulo.md`, la skill `delegar`, CI, scripts). El CI de cada repo avisa cuando hay una versión nueva.

## Solo las skills, en tu Claude Code
```
/plugin marketplace add zaned897/skills
/plugin install kit-multiagente@kit-multiagente
```
Te da las 11 skills comunes en todos tus proyectos. Codex y Antigravity no las ven así; para ellos instala el kit en el repo.

## Cambiar el kit
Edita `template/.agents/skills/`, corre `python template/tools/agentes/sincronizar-skills.py` y `./scripts/armar-plugin.sh`, sube `VERSION` y la versión de `plugin/.claude-plugin/plugin.json`, y abre un PR. CI revisa todo eso e instala y actualiza el kit en un repo vacío.

## El flujo en una línea
**Diseño en un artefacto → aprobación → issues por nivel → un hilo y un PR por issue → review de otro proveedor → merge → captura real en el artefacto.**

## Qué trae
| Carpeta / archivo | Qué es |
|---|---|
| `template/` | Lo que se copia a la raíz del repo nuevo (ver tabla abajo) |
| `project-instructions.md` | Bloque para pegar en las instrucciones del proyecto en claude.ai |
| `mcp/` | `.mcp.json` base y cómo dar los mismos MCP a Codex y al agente de frontend |
| `LECCIONES.md` | Lo que salió mal y qué regla lo evita |
| `INTEGRAR.md` | Pasos para sumarlo a un proyecto que ya trabaja, sin romper sus flujos |
| `COMPARTIR.md` | Guía de una página para un colaborador que adopta el flujo |
| `install.sh` | Copia `template/` a otro repo sin pisar archivos (`--dry-run` para ver antes) |

### `template/`
| Pieza | Para qué |
|---|---|
| `AGENTS.md`, `CLAUDE.md` | Reglas cortas comunes a Claude Code, Codex y el agente de frontend: zonas, niveles, convenciones |
| `.agents/skills/` | 12 skills compartidas (fuente; `.claude/skills/` es su copia): coordinación `orchestrate`, `parallel-prs`, `relay`, `delegar`; proceso `design-first`, `prototype-scope`, `gh-issues`, `pr-intake`; programación `anti-vibe-coding`, `desatorar`; herramientas `scout`, `radar` |
| `tools/agentes/` | `delegar.py` (pasa tareas a Codex o Antigravity en un worktree y pide revisión), `sincronizar-skills.py`, `exportar.py` |
| `.claude/` | Permisos (bloquea `.env`), hook `scout-hint` y dos subagentes de ejemplo |
| `toolbox/` | `capabilities.json` (instalado y aparcado con disparadores), `models.md` (routing), `decisions.md`, hook |
| `.githooks/` | pre-commit (llaves, `.env`, `scripts/check.sh`) y commit-msg (commits convencionales) |
| `.github/` | Plantillas de issue (prototipo con enlace al diseño, idea, bug), plantilla de PR y CI |
| `scripts/` | `check.sh` (punto único de calidad), `dev.sh`, `suite-init.sh`, `gh-labels.sh`, `worktrees.sh` |
| `docs/` | `API.md` (contrato) y `HANDOFF.md` (pedidos entre zonas) |
| `CONTRIBUTING.md`, `.github/CODEOWNERS` | Flujo visual primero para contribuidores y cómo proteger `main` (tu aprobación + CI en verde) |
| `render.yaml.example` | Despliegue gratis con previews por PR, incluido el sitio de diseño |
| `scripts/design-proposal.mjs` | Arma el artefacto de una propuesta con interruptor Antes / Después: contribuidores comentan en claude.ai, sin GitHub ni llaves |
| `docs/design/comparar.html`, `scripts/design-shots.mjs`, `.github/workflows/diseno-*.yml` | Antes y después de cada PR `[sketch]`: página lado a lado y capturas pegadas en el PR | (para quien trabaja en git) |

## Instalar a mano (sin curl)
```bash
bash install.sh ../mi-proyecto          # no sobrescribe nada que ya exista
cd ../mi-proyecto
grep -rn '{{' . --include='*.md' --include='*.json' --include='*.yml'   # rellena los marcadores
# edita scripts/check.sh y scripts/dev.sh para tu stack
./scripts/suite-init.sh                      # enlaza skills y activa hooks
./scripts/gh-labels.sh                       # etiquetas level:/area:/type:/status:
```
Luego, en claude.ai: crea el proyecto, pega `project-instructions.md`, conecta GitHub, y pide el primer artefacto de diseño («dame un adelanto de cómo se verá la app»). Pega su URL en `AGENTS.md` (`DESIGN_URL`) y en las instrucciones del proyecto.

En GitHub, activa **Settings → General → Automatically delete head branches** (ver `parallel-prs`).

## Skills en tu cuenta vs. en el repo
- **En el repo** (`.agents/skills/`): las lee cualquier agente que abra el repo, incluidos contribuidores externos. Aquí van las reglas del proyecto.
- **En tu cuenta de Claude**: te siguen a todos los proyectos. Conviene tener ahí `design-first`, `parallel-prs` y una para montar este kit; las demás pueden vivir solo en el repo.
