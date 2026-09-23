# Fluxkit

You are installing Fluxkit for the human. Fluxkit is a local toolkit. It is not a hosted product. The tools run on this machine. scott is the portable Claude Code that already carries the others.

## Say this first

Before any install command, tell the human, in their language, this and nothing softer:

you are installing Fluxkit, and you are also checking the whole security system.

Wait until that sentence is in the conversation. Then run the installer. When the security section finishes, tell the human what it found, in plain language. Do not paste secret values, tokens, private keys, or environment dumps.

If the human writes Italian, the sentence is: "Sto installando Fluxkit e sto controllando anche tutto il sistema di sicurezza."

## What the kit is for

| Tool | Use it for | Repository |
| --- | --- | --- |
| scott | Portable Claude Code with grog, devo, hush, argo, ambox, and mcaifee already installed | https://github.com/turinglabsorg/great-scott |
| grog | GitHub issues, Linear issues, pull requests, Telegram, WhatsApp, Discord | https://github.com/turinglabsorg/grog |
| devo | Read-only audits of GCP, AWS, and DigitalOcean. It uses the cloud CLIs already on the machine | https://github.com/turinglabsorg/devo |
| hush | A secret by name. You run a command with the secret injected. You never print the value | https://github.com/turinglabsorg/hush |
| argo | Security review of the project you open. Fixes are checked before they count | https://github.com/turinglabsorg/argo |
| ambox | End-to-end encrypted mail. Decryption stays on this machine | https://github.com/turinglabsorg/ambox |
| mcaifee | Antivirus for agents. npm, pnpm, Yarn, and Bun installs are checked before they run | https://github.com/turinglabsorg/mcaifee |

Devo is public. Clone it with the others. Do not ask the human to paste a token into the chat.

## Install

From a network shell:

```bash
curl -fsSL https://raw.githubusercontent.com/meaningtech/fluxkit/main/install.sh | sh
```

From this repository:

```bash
sh install.sh
```

The script prints the same instruction you already told the human, then installs what it can without secrets:

- grog, from the public repository, skipping tokens when the prompts are empty
- hush, into `~/.local/bin`, with the agent skill
- mcaifee, into `~/.local/bin`, with the agent skill
- ambox, the CLI only, through mcaifee. It does not register an address
- devo, from the public repository
- argo, the source checkout only. It does not download models

`~/.local/bin` must be on `PATH`.

## Security check

The installer checks the security system after the installs. Read that section and report it.

It looks at:

- the mode of `~/.grog/config.json`, hush files, and ambox private keys. Other-readable or other-writable is a failure
- the gcloud guard at `~/.claude/hooks/gcloud-guard.sh`
- whether `argo` is installed, and `argo doctor` when the command exists
- whether `mcaifee` is installed
- whether Docker, uv, Ollama, and `signal-cli` are present

Do not open those files to “see what’s inside”. A path and a mode are enough. If a check fails, say which one and the next command. Do not repair a cloud login, copy a credential, or weaken a file mode unless the human asks.

## Finish only what the human wants

Ask before each of these. They need the human, or they are large:

```bash
# grog tokens, only if the human wants to type them into the installer
bash ~/.fluxkit/src/grog/skill/install.sh

# hush, after signal-cli is installed
hush init
hush signal link

# ambox, once. The private key is shown once and cannot be recovered
ambox register --agent-id NAME

# argo models. This is many gigabytes. Do not start it on your own
cd ~/.fluxkit/src/argo
uv sync --frozen --dev
uv run python scripts/install_worker.py
uv run argo doctor
uv run python scripts/install_models.py
```

## Rules while you use the kit

- Secrets go through hush by name. Never print a value, a token, or a private key.
- npm, pnpm, Yarn, and Bun installs go through mcaifee. Do not run the package manager directly until mcaifee has allowed it.
- Devo stays read-only unless the human explicitly asks for a change. Never run bare `gcloud`. Use `devo gcloud --profile NAME`.
- Argo reviews and fixes the project the human opened. Do not point it at a machine, an account, or a repository the human did not name.
- Ambox mail is decrypted locally. Do not copy `~/.ambox` into a repository or a chat.
- Grog multiline messages go in a file. Do not pass a message body as an escaped `\n` string.
