# Onboarding: colaborar en {{PROYECTO}}

Para quien llega nuevo y no programa. Pide los cambios a Claude Code: él programa, prueba y abre el PR; tú revisas la preview y {{DUEÑO}} revisa y fusiona. La skill `onboarding` sigue este archivo.

## Qué es este repo
{{QUÉ_ES_EN_DOS_LÍNEAS}}

## Requisitos
| Para | Necesitas |
|---|---|
| Pedir cambios y ver previews | Cuenta de GitHub como colaborador y cuenta de Claude |
| Levantar en local | {{HERRAMIENTAS}} |
| Revisar un PR en local | Además GitHub CLI (`gh`) con `gh auth login` |

## Levantar en local
En Windows usa Git Bash.
```bash
gh repo clone {{OWNER/REPO}}
cd {{REPO}}
{{COMANDOS}}
```
Abre {{URL_LOCAL}}. Debes ver {{QUÉ_SE_VE}}.

## Ver la preview de un PR
{{DÓNDE_APARECE_LA_LIGA}}

## Revisar un PR en local
```bash
gh pr checkout 123
{{COMANDO_LEVANTAR}}
git switch main && git pull
```

## No tocar sin el dueño
- {{ZONAS}}
- Llaves y `.env`: nunca en el repo ni en el chat.

## Instrucciones de proyecto para claude.ai
```text
Repo: {{OWNER/REPO}}. Soy colaborador y no programo: explícame en español claro y sigue la skill onboarding y ONBOARDING.md del repo.
Antes de cambiar código, dime en 3 líneas qué vas a hacer y espera mi sí. Rama nueva, un PR pequeño por issue, con «Qué cambia», «Cómo verlo» y «Closes #N».
Nunca apruebes ni fusiones PRs ni empujes a main. Nunca me pidas llaves. Si algo se atora tras 3 intentos, usa la skill desatorar.
```
