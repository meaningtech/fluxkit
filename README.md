# Fluxkit

Fluxkit is a local toolkit: agents of your own that live with your team, tools for the coding agent in your terminal, and a clipboard for you. Twelve open-source tools: resident agents on their own computers, a portable Claude Code, Scott's sidekick, issues, messages and a desktop, cloud audits, secrets, security review, encrypted mail, an antivirus for agents, a social media agent, an email client, and a clipboard.

Give the agent one file and it installs the kit itself:

[AGENTS.md](https://fluxkit.dev/AGENTS.md)

Paste this to your agent:

```text
Read https://fluxkit.dev/AGENTS.md and do what it says.
Before you install anything, tell me that you are also checking the whole security system.
```

The same file is at <https://raw.githubusercontent.com/meaningtech/fluxkit/main/AGENTS.md>.

## The twelve tools

| Tool | What it does | Repository |
| --- | --- | --- |
| cora | Agents of your own that live with your team, each on its own computer with a Linux desktop. They talk on Discord, Slack, or Telegram, work many threads at once, remember, run routines, and ask you on your phone. They run on Claude Code, Codex, Grok Build, or Muse Code subscriptions, or on Ollama | <https://github.com/turinglabsorg/cora> |
| scott | Portable Claude Code, with doc, grog, devo, hush, argo, ambox, and mcaifee already inside | <https://github.com/turinglabsorg/great-scott> |
| doc | Scott's sidekick. A comment is checked before it goes out, and estimates stay out of the reply | <https://github.com/turinglabsorg/doc> |
| grog | GitHub, Linear, and the bridges to Telegram, WhatsApp, and Discord, plus a desktop of its own with a real browser | <https://github.com/turinglabsorg/grog> |
| devo | Read-only audits of GCP, AWS, and DigitalOcean | <https://github.com/turinglabsorg/devo> |
| hush | Secrets by name. The agent uses them and never reads the value | <https://github.com/turinglabsorg/hush> |
| argo | Security review on this machine. A fix is checked before it lands | <https://github.com/turinglabsorg/argo> |
| ambox | End-to-end encrypted mail for agents | <https://github.com/turinglabsorg/ambox> |
| mcaifee | Antivirus for agents. A package is checked before it runs | <https://github.com/turinglabsorg/mcaifee> |
| ziggy | Social media manager for coding agents: brand assets, videos, publishing, and replies, with a playbook per brand | <https://github.com/turinglabsorg/ziggy> |
| milo | Email client for Gmail and IMAP/SMTP, with an Ollama assistant for summaries and proposed replies, and a shared archive across devices | <https://github.com/turinglabsorg/milo> |
| pastazzo | Clipboard history for GNOME and macOS, synced across your devices end to end. It is for you, not for the agent | <https://github.com/turinglabsorg/pastazzo> |

All of them are public.

Cora, Ziggy, and Milo are optional companions with their own setup; the core installer does not install them. Follow [Cora's run guide](https://github.com/turinglabsorg/cora#run), the [Ziggy installation guide](https://github.com/turinglabsorg/ziggy#install), or the [Milo setup guide](https://github.com/turinglabsorg/milo#run-on-linux). Cora needs Docker, a machine that stays on, and a Claude Code, Codex, Grok Build, or Muse Code subscription (or an Ollama Cloud key); Ziggy needs a publishing provider and hush-held keys; Milo needs PostgreSQL and mailbox authorization.

## Install it yourself

```bash
curl -fsSL https://raw.githubusercontent.com/meaningtech/fluxkit/main/install.sh | sh
```

The script clones the public repositories under `~/.fluxkit/src`, installs the pieces that do not need a secret, and then checks the security system. It does not download Argo’s local models, it does not register an ambox address, and it does not install the pastazzo desktop app. Those steps need you, and the agent asks before doing them.

What still needs a person:

- grog: a GitHub token, and Linear or chat tokens only if you want those bridges
- hush: `signal-cli`, then `hush signal link` from your phone
- ambox: `ambox register --agent-id NAME`, once. Back up the private key
- argo: Python 3.12, uv, Docker, and Ollama. The models are large. Say yes before they download
- devo: `gcloud` or `doctl` for the clouds you actually use. The installer adds the AWS CLI itself, without a profile or a key
- pastazzo: a desktop. On GNOME on Wayland it builds with cargo and wants a log out and back in; on macOS you build it from Terminal on the Mac itself. Sync needs an invite to a pastazzo server

## What the security check looks at

It does not read secret values. It checks whether the sensitive files are private (AWS credentials and caches, and the pastazzo clipboard history and its sync keys, included), warns about static AWS keys, and checks whether the gcloud guard hook is installed, and whether Argo can run a doctor check. The agent has to tell you that this check is happening, and then tell you what it found.
