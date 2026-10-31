# Fluxkit landing

A flux capacitor console. Black ground, one white mark that carries light, monospace everywhere, and the time circuits of the DeLorean as the only color. The page is a single file, `index.html`, with its CSS and a small script inline.

The mark is the conduit: three strokes meeting at a point. The stem points up. The two arms point down. That is the usual figure turned 180 degrees. It is white, with a white bloom, and it is the only drawing on the page; the other pictures are mocks: Cora's channel with its agents' desktops, and pastazzo's shelf. In the hero it sits in a housing, the flux capacitor box, and light runs down each conduit into the core.

## Color

| Token | Value | Use |
| --- | --- | --- |
| `--void` | `#000` | Page ground |
| `--panel` | `#07080a` | Housing, terminal, tool cells |
| `--ink` | `#ececec` | Names, headings |
| `--ink-2` | `#a8a8a8` | Sentences |
| `--ink-3` | `#6b6b6b` | Labels, prompts, meta |
| `--rule` | `#1d1f22` | Dividers, cell borders |
| `--rule-hi` | `#34373c` | Hover border, buttons |
| `--flux` | `#ffffff` | The mark and its glow |
| `--tc-red` | `#ff3b2f` | Time circuits, first readout |
| `--tc-green` | `#2bff88` | Time circuits, second readout, `ok` lines in the terminal |
| `--tc-amber` | `#ffb21e` | Time circuits, third readout, the blinking cursor |
| `--pastazzo` | `#ff7a1a` | The pastazzo cell only |
| `--cora` | `#f2a93b` | The Cora cell only |

The three time-circuit colors appear in the readouts and, sparingly, in the terminal transcript. Nothing else on the page is colored. The pastazzo orange is pastazzo's own icon color, and it never leaves pastazzo's cell. The Cora amber is the one accent of Cora's own panel, and it never leaves Cora's cell.

The ground is black with a faint radial bloom behind the mark and a fixed grain overlay at low opacity that does not catch clicks.

## Type

Fonts are self-hosted in `fonts/` (OFL, licenses next to the files). Do not load them from Google at runtime and do not fall back to a system mono as the design face.

| Role | Face | File |
| --- | --- | --- |
| Everything | Martian Mono, variable width 75–112.5 and weight 100–800 | `fonts/martian-mono.woff2` (latin) |
| Readout digits | DSEG7 Classic Bold | `fonts/dseg7-classic-bold.woff2` |

- The wordmark `fluxkit` is Martian Mono at width 112.5, weight 800, lowercase, tight tracking.
- Section labels are 11px, uppercase, width 100, letter-spacing 0.14em, `--ink-3`, prefixed by an index like `01`.
- Tool names are width 112.5, weight 700. Sentences are width 87.5, weight 400, `--ink-2`.
- Readout digits always sit on a ghost `88` at low opacity, like an unlit segment display.
- Arrows are drawn as SVG; Martian Mono's latin subset is the only glyph set guaranteed.

## Layout

The page measure is `min(72rem, 100% - 2rem)`. Nothing scrolls sideways at 1440, 1280, 1024, 768, or 390.

1. **Bar.** `meaningtech / fluxkit` on the left, `AGENTS.md` and `source` on the right. The row wraps when the links cannot fit, including at 320px.
2. **Hero.** Two columns above 860px, stacked below. Left: the prompt line `$ fluxkit`, the wordmark, the line “Where we're going, we don't need roads.”, one sentence on what the kit is (agents of your own first, then the toolkit for the coding agent, then the clipboard), and two actions: copy the agent prompt, open `AGENTS.md`. Right: the flux capacitor housing (corner screws, a small `FLUX CAPACITOR` plate, the mark with light running down the conduits).
3. **Time circuits.** Three readouts in a row, each a label plate and digits: `TOOLS 13` red, `SECRETS PRINTED 00` green, `MPH 88` amber. The first two are facts; the third is the joke. Update `TOOLS` when the kit changes.
4. **The kit.** Section label `01 the kit`, the heading “Agents of your own. Tools for the one in your terminal.”, and a short note on the right. Then four groups, each under a `//` label. Tools are numbered 01 to 13 in the order of the table below. Each ordinary cell: the number, a short tag, the name, one sentence, and `turinglabsorg/<repo>` with an arrow. The whole cell is the link.
   - `// agents of your own`: Cora, the flagship, top left and full width. Its cell carries the Cora amber on its number, its tag, its top border and a soft glow above it. Left: the name at the largest size on the page after the wordmark, one sentence, and two rows of chips, `lives on` (Discord, Slack, Telegram) and `thinks with` (Claude Code, Codex, Grok Build, Muse Code, Ollama). Right: a dark mock of a channel, `# launch` with an `on air` lamp, three lines where the human names an agent (`@Ada`, an amber mention) and it answers, and under them the three agents' desktops: Ada working (a browser, an amber outline, a pointer that moves), Brio on a routine (a chart), Lux asleep (a dark screen). One column below 1024px. Cora has separate setup and is not installed by the core installer.
   - `// for your coding agent`: one grid of eight ordinary cells: scott, then doc, grog, devo, hush, argo, ambox, mcaifee. scott is a cell like the others; its sentence says the next seven ride inside it. Four columns above 1024px, two above 640px, one below.
   - `// companions`: Ziggy (10), Milo (11) and ubercal (12), three columns above 1024px, one below. Ziggy is the social media agent; Milo is the human's email client with an Ollama assistant; ubercal merges the human's calendars into share links and is the one hosted tool (ubercal.fluxkit.dev, whose sign-in and legal pages belong to fluxkit.dev). Ziggy and Milo have separate setup and are not bundled inside scott or installed by the core installer; ubercal needs no setup. The installation section states this explicitly, for Cora too.
   - `// next to you`: pastazzo. It is not an agent tool: it is for the human working next to the agent. Its cell is full width, with the pastazzo orange on its number, its tag, its top border and a soft glow above it, a keycap row `Shift Alt V`, and on the right a dark mock of the shelf: search field, a transfer pill, four items with age and device, the first one selected. The row of items is clipped with a fade; it never widens the page.
5. **Ask your agent.** Section label `02 ask your agent`. A terminal window: the human's message (the exact prompt below), the agent's first line (the security sentence), then installer lines with `ok` in green. Lines appear one after the other on load. Under it, copy and open, and the `curl` line for people who install it themselves, with its own copy.
6. **Footer.** The quote and its attribution, `meaningtech`, `source`, `AGENTS.md`, `privacy`, `terms`.

## Legal pages

`privacy/index.html` and `terms/index.html` are the legal home of every hosted Fluxkit service (ubercal first, then milo): one Google sign-in, one consent screen, one policy. They share `legal.css`: the same ground, grain, Martian Mono and bar as the landing, a narrower measure (`min(46rem, 100% - 2rem)`), an uppercase `legal` label, the title at width 112.5 weight 800, a boxed summary, and numbered sections (`01`…) whose number sits in `--ink-3`. No script and no analytics on these pages. When a hosted service starts using new data, its section is added here before it ships.

Cells are square, 1px `--rule` border, `--panel` fill. On hover a cell's border goes `--rule-hi` and its arrow moves 2px. No radius anywhere except keycaps (3px).

## Tools

| Name | Sentence | Tag | Link |
| --- | --- | --- | --- |
| cora | Agents that live with your team, each on its own computer. They answer when named, work many threads at once, remember, run routines, and ask you on your phone when they need you. | resident agents | github.com/turinglabsorg/cora |
| scott | Portable Claude Code. The next seven tools are already inside and ready to use. | vehicle | github.com/turinglabsorg/great-scott |
| doc | Scott's sidekick. A comment is checked before it goes out, and estimates stay out of the reply. | guard | github.com/turinglabsorg/doc |
| grog | GitHub, Linear, and the bridges to Telegram, WhatsApp, and Discord. Now with a desktop of its own: a real browser, where a site sees a person. | issues, chat | github.com/turinglabsorg/grog |
| devo | Read-only audits of GCP, AWS, and DigitalOcean. | cloud | github.com/turinglabsorg/devo |
| hush | Secrets by name. The agent uses them and never reads the value. | secrets | github.com/turinglabsorg/hush |
| argo | Security review on this machine. A fix is checked before it lands. | review | github.com/turinglabsorg/argo |
| ambox | End-to-end encrypted mail for agents. Decryption stays on this machine. | mail | github.com/turinglabsorg/ambox |
| mcaifee | Antivirus for agents. A package is checked before it runs. | packages | github.com/turinglabsorg/mcaifee |
| ziggy | Your agent's social media manager. Brand assets, short videos, publishing, and replies, with a separate playbook for each brand. | social agent | github.com/turinglabsorg/ziggy |
| milo | Your inbox, with room to think. An email client for Gmail and IMAP/SMTP, with Ollama for summaries and proposed replies. Your archive follows you across devices. | email client | github.com/turinglabsorg/milo |
| ubercal | Every calendar, one link. Merge Google calendars and .ics links into share links that show each calendar in full, as busy time, or not at all, from the dates you choose. Hosted at ubercal.fluxkit.dev. | calendars | github.com/turinglabsorg/ubercal |
| pastazzo | Clipboard history for GNOME and macOS. Everything you copy lands on a shelf, synced across your devices end to end. | clipboard | github.com/turinglabsorg/pastazzo |

Devo is a public repository. The page does not call it private. Pastazzo is not inside scott: it needs a desktop.

## Ask the agent

Copy writes exactly:

```text
Read https://fluxkit.dev/AGENTS.md and do what it says.
Before you install anything, tell me that you are also checking the whole security system.
```

The word changes to `copied` for two seconds. If the clipboard refuses, it changes to `copy failed`. The `curl` copy behaves the same.

Open is a link to `AGENTS.md` with `target="_blank"` and `rel="noopener noreferrer"`.

## Motion

- Light pulses run down the three conduits into the core, staggered, on a loop. The core breathes.
- On load the hero rises in, the readouts count up once, the terminal lines appear one by one.
- In Cora's mock the `on air` lamp and Ada's LED breathe, and Ada's pointer moves across her browser.
- `prefers-reduced-motion: reduce` turns all of it off: no pulses, no count, every line visible, the pointer still.

## Open Graph

`og.png` is 1200×630, black, drawn from `og.html` with a headless browser. The same mark, stem up, in white. Under it, the line “Where we're going, we don't need roads.”, the attribution Back to the Future, and the current tool names in order: cora, scott, doc, grog, devo, hush, argo, ambox, mcaifee, ziggy, milo, ubercal, pastazzo. The tool line is centered, balanced, and capped at 1080px so names can wrap within the card. When the kit changes, update `og.html`, redraw the card, and bump the `?v=` on `og:image` and `twitter:image` (both on https://fluxkit.dev). The description on those tags is the same sentence as `meta name="description"`.

The favicon is the same mark on black: `favicon.svg` for current browsers, `favicon.ico` at 16, 32, and 48, and `apple-touch-icon.png` at 180.
