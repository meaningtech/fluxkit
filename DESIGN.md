# Fluxkit landing

The page is the two objects in the reference, sitting on a table. It is not a dashboard and it is not a diagram of a Y.

Reference: a time-circuit display on the left, a conduit case on the right, dark wood with the grain running left to right. We do not reuse the film’s dates or its captions. The skeleton is the same. The words are the five tools.

## What failed before

- An editorial page, then an orange diagram on black, then a CSS sketch of the props.
- The sketch used vertical planks. The table grain is horizontal.
- The “digits” were a monospace font inside boxes. A circuit is unlit segments plus lit segments.
- The conduit was a flat purple rectangle and a stroke. The reference is a beige case, a thick black window, violet glass, and white tubes.
- The ask control was a link. It clipped, and it could not copy anything.

## The scene

One table. Two objects, centered as a pair. A plate in front of them for the agent instructions. Nothing else in the scene except the two corner links, meaningtech and source.

The left object is wider. The right object is narrower and about the same height. On a 1440×900 screen they sit in the middle with table visible around them. They do not stretch to the edges.

Light comes from above. Each object has a soft contact shadow on the wood. The bezel of the circuit is a warm off-white. The case of the conduit is a warm beige, lighter on the top edge.

## Left object: the circuit

Three rows. Red, then green, then amber. A seven-cell row was drawn and previewed. At the size of the circuit the letters collapsed into noise. The row is therefore two modules only: the name, large, and the number beside it. The other cells stay in the markup and are not shown.

| Row | Color | Shown | Links to |
| --- | --- | --- | --- |
| grog | red | GROG 01 | github.com/turinglabsorg/grog |
| hush | green | HUSH 03 | github.com/turinglabsorg/hush |
| argo | amber | ARGO 04 | github.com/turinglabsorg/argo |

The bottom edge of the screen is one line: DEVO · PRIVATE, with no link, and AMBOX · MAIL, linked to github.com/turinglabsorg/ambox.

Every letter is a 14-segment figure. Unlit segments stay visible at low opacity. Lit segments use the row color and a tight glow. If a letter cannot be built from those segments, it does not go on the display.

## Right object: the conduit

A beige case. A red slot centered on the top face. A window with a thick black rim and a large corner radius. Inside, violet glass, brighter at the center, dark at the rim.

Three white tubes meet at a bulb. One arm goes down. The other two go up and out. Yellow wires run beside the tubes, not on top of them. A brown bar crosses the lower arm, above the bottom bulb. One screw sits at the bottom right of the case.

The tubes are the thickest thing in the window. A thin stroke is the wrong drawing.

## Ask the agent

The plate says “Ask your agent”. Two controls sit on it. Both are at least 44×44 pixels. Both have a visible icon and a visible word. The icon alone is not the label.

Copy. Two overlapping sheets. Click copies this text and nothing else:

```text
Read https://meaningtech.github.io/fluxkit/AGENTS.md and do what it says.
Before you install anything, tell me that you are also checking the whole security system.
```

The button then reads “Copied” for two seconds, then returns to “Copy”. If the clipboard refuses, the button reads “Copy failed” and the text stays in the page so it can be selected.

Open. A box with an arrow leaving the top right. It is a link to `AGENTS.md` with `target="_blank"` and `rel="noopener noreferrer"`.

Both controls show a focus ring. Enter and Space activate them.

## Viewports

| Width | Arrangement | Circuit | Conduit | Ask plate |
| --- | --- | --- | --- | --- |
| 1440, 1280 | side by side, vertically centered | full grid | full case | one row: sentence, then the two buttons |
| 1024 | side by side, scaled down | full grid, no clipped cell | full case | same row, wraps if the sentence does not fit |
| 768, 390 | stacked, circuit first | the name only: GROG, HUSH, ARGO. DEVO and AMBOX stay on the bottom line | centered, at most 280px wide | buttons on their own row, never off the screen |

At every width, `documentElement.scrollWidth` equals `documentElement.clientWidth`. Text is not cut off mid-letter. The page may scroll vertically. It does not scroll horizontally.

## Done

- Local preview, not only the file on disk.
- Screenshots at 1440, 1024, 768, and 390.
- A click on Copy leaves the prompt above in the clipboard, or shows the failure state if the browser blocks it.
- The Open control is an anchor, opens a new tab, and points at `AGENTS.md`.
- The horizontal-overflow check passes at those four widths.
