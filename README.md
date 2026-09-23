# Fluxkit

Fluxkit is a local toolkit for a developer’s agent. Six tools, on your machine: issues and messages, cloud audits, secrets, security review, encrypted mail, and npm installs.

Give the agent one file and it installs the kit itself:

[AGENTS.md](https://meaningtech.github.io/fluxkit/AGENTS.md)

Paste this to your agent:

```text
Read https://meaningtech.github.io/fluxkit/AGENTS.md and do what it says.
Before you install anything, tell me that you are also checking the whole security system.
```

The same file is at <https://raw.githubusercontent.com/meaningtech/fluxkit/main/AGENTS.md>.

## The six tools

| Tool | What it does | Repository |
| --- | --- | --- |
| grog | GitHub, Linear, and the bridges to Telegram, WhatsApp, and Discord | <https://github.com/turinglabsorg/grog> |
| devo | Read-only audits of GCP, AWS, and DigitalOcean | <https://github.com/turinglabsorg/devo> |
| hush | Secrets by name. The agent uses them and never reads the value | <https://github.com/turinglabsorg/hush> |
| argo | Security review on this machine. A fix is checked before it lands | <https://github.com/turinglabsorg/argo> |
| ambox | End-to-end encrypted mail for agents | <https://github.com/turinglabsorg/ambox> |
| mcaifee | npm, pnpm, Yarn, and Bun installs. The package is checked before it runs | <https://github.com/turinglabsorg/mcaifee> |

Devo and mcaifee are public, like the others.

## Install it yourself

```bash
curl -fsSL https://raw.githubusercontent.com/meaningtech/fluxkit/main/install.sh | sh
```

The script clones the public repositories under `~/.fluxkit/src`, installs the pieces that do not need a secret, and then checks the security system. It does not download Argo’s local models, and it does not register an ambox address. Those steps need you, and the agent asks before doing them.

What still needs a person:

- grog: a GitHub token, and Linear or chat tokens only if you want those bridges
- hush: `signal-cli`, then `hush signal link` from your phone
- ambox: `ambox register --agent-id NAME`, once. Back up the private key
- argo: Python 3.12, uv, Docker, and Ollama. The models are large. Say yes before they download
- devo: `gcloud`, `aws`, or `doctl` for the clouds you actually use

## What the security check looks at

It does not read secret values. It checks whether the sensitive files are private, whether the gcloud guard hook is installed, and whether Argo can run a doctor check. The agent has to tell you that this check is happening, and then tell you what it found.
