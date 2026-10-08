# Fluxkit landing

A flux capacitor console. Black ground, one white mark that carries light, monospace everywhere, and the time circuits of the DeLorean as the only color. The page is a single file, `index.html`, with its CSS and a small script inline.

The mark is the conduit: three strokes meeting at a point. The stem points up. The two arms point down. That is the usual figure turned 180 degrees. It is white, with a white bloom, and it is the only drawing on the page; the other picture is a mock of pastazzo's shelf. In the hero it sits in a housing, the flux capacitor box, and light runs down each conduit into the core.

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

The three time-circuit colors appear in the readouts and, sparingly, in the terminal transcript. Nothing else on the page is colored. The pastazzo orange is pastazzo's own icon color, and it never leaves pastazzo's cell.

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

1. **Bar.** `meaningtech / fluxkit` on the left, `AGENTS.md` and `source` on the right.
2. **Hero.** Two columns above 860px, stacked below. Left: the prompt line `$ fluxkit`, the wordmark, the line “Where we're going, we don't need roads.”, one sentence on what the kit is, and two actions: copy the agent prompt, open `AGENTS.md`. Right: the flux capacitor housing (corner screws, a small `FLUX CAPACITOR` plate, the mark with light running down the conduits).
3. **Time circuits.** Three readouts in a row, each a label plate and digits: `TOOLS 09` red, `SECRETS PRINTED 00` green, `MPH 88` amber. The first two are facts; the third is the joke. Update `TOOLS` when the kit changes.
4. **The kit.** Section label `01 the kit`, a heading, and a short note on the right. Then two groups, each under a `//` label. Tools are numbered 01 to 09 in the order of the table below.
   - `// for the agent`: one grid. scott is the first cell, two columns wide, with the seven tools it carries as `+ name` chips. Then doc, grog, devo, hush, argo, ambox, mcaifee. Three columns above 1024px, two above 640px (scott and the last cell span both), one below. Each cell: the number, a short tag, the name, one sentence, and `turinglabsorg/<repo>` with an arrow. The whole cell is the link.
   - `// next to you`: pastazzo. It is not an agent tool: it is for the human working next to the agent. Its cell is full width, with the pastazzo orange on its number, its tag, its top border and a soft glow above it, a keycap row `Shift Alt V`, and on the right a dark mock of the shelf: search field, a transfer pill, four items with age and device, the first one selected. The row of items is clipped with a fade; it never widens the page.
5. **Ask your agent.** Section label `02 ask your agent`. A terminal window: the human's message (the exact prompt below), the agent's first line (the security sentence), then installer lines with `ok` in green. Lines appear one after the other on load. Under it, copy and open, and the `curl` line for people who install it themselves, with its own copy.
6. **Footer.** The quote and its attribution, `meaningtech`, `MIT`.

Cells are square, 1px `--rule` border, `--panel` fill. On hover a cell's border goes `--rule-hi` and its arrow moves 2px. No radius anywhere except keycaps (3px).

## Tools

| Name | Sentence | Tag | Link |
| --- | --- | --- | --- |
| scott | Portable Claude Code. doc, grog, devo, hush, argo, ambox, and mcaifee are already in it and ready to use. | vehicle | github.com/turinglabsorg/great-scott |
| doc | Scott's sidekick. A comment is checked before it goes out, and estimates stay out of the reply. | guard | github.com/turinglabsorg/doc |
| grog | GitHub, Linear, and the bridges to Telegram, WhatsApp, and Discord. | issues, chat | github.com/turinglabsorg/grog |
| devo | Read-only audits of GCP, AWS, and DigitalOcean. | cloud | github.com/turinglabsorg/devo |
| hush | Secrets by name. The agent uses them and never reads the value. | secrets | github.com/turinglabsorg/hush |
| argo | Security review on this machine. A fix is checked before it lands. | review | github.com/turinglabsorg/argo |
| ambox | End-to-end encrypted mail for agents. Decryption stays on this machine. | mail | github.com/turinglabsorg/ambox |
| mcaifee | Antivirus for agents. A package is checked before it runs. | packages | github.com/turinglabsorg/mcaifee |
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
- `prefers-reduced-motion: reduce` turns all of it off: no pulses, no count, every line visible.

## Open Graph

`og.png` is 1200×630, black, drawn from `og.html` with a headless browser. The same mark, stem up, in white. Under it, the line “Where we're going, we don't need roads.”, the attribution Back to the Future, and the current tool names in order: scott, doc, grog, devo, hush, argo, ambox, mcaifee, pastazzo. When the kit changes, update `og.html`, redraw the card, and bump the `?v=` on `og:image` and `twitter:image` (both on https://fluxkit.dev). The description on those tags is the same sentence as `meta name="description"`.

The favicon is the same mark on black: `favicon.svg` for current browsers, `favicon.ico` at 16, 32, and 48, and `apple-touch-icon.png` at 180.
