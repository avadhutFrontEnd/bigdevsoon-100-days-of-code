# HTML vs Body – Which Properties Go Where

## `html` (root element)

- The **root** of the document; wraps `<head>` and `<body>`.
- Use it for: **full-page / viewport-sized behavior** and a background that fills the entire window.

### Properties to use on `html`

| Property | Why |
|----------|-----|
| `height: 100%` | Gives the document a defined height so `body { height: 100% }` works when you want full viewport height. |
| `background-image` (+ `background-size: cover`, etc.) | So the gradient (or any background) fills the **entire viewport**. If only `body` has the background, the area outside the 1512px strip can show the default (e.g. white). |

---

## `body` (visible content)

- Holds the **visible page content**.
- Use it for: **layout** of that content, **typography**, and your **design frame** (e.g. 1512×982).

### Properties to use on `body`

| Property | Why |
|----------|-----|
| `font-family` | Typography for the page. |
| `display: flex` | Layout for the content inside `body`. |
| `width`, `max-width`, `margin: 0 auto` | Your design frame width (e.g. 1512px) and centering. |
| `height`, `min-height` | Match your Figma frame height (e.g. 982px). |
| `background-image` | Optional: repeat the same gradient on the body so the strip looks the same. |

---

## Summary

- **`html`** → Full-page height + full-viewport background.
- **`body`** → Layout (flex), font, and the 1512×982 design frame (width, height, centering).

---

# Background properties (gradient) – why not `background-color`?

## `background-image: linear-gradient(to bottom, #482CE6, #480022)`

- **What it does:** Paints a gradient from top to bottom: purple (`#482CE6`) at the top → dark purple/magenta (`#480022`) at the bottom.
- **Why not `background-color`?**  
  `background-color` only supports a **single solid color**. Your design uses a **blend of two colors** (purple to dark purple). That effect is a gradient, so it has to be done with `background-image` and `linear-gradient(...)`, not with `background-color`.

## `background-size: cover`

- **What it does:** Scales the background image (here, the gradient) so it **covers the entire element** (e.g. `html`). The image is scaled to always fill the area; parts may be cropped if the aspect ratio doesn’t match.
- **Why:** So the gradient always fills the full viewport from edge to edge on any screen size, with no gaps.

## `background-attachment: fixed`

- **What it does:** Pins the background to the **viewport** when the user scrolls. The content scrolls, but the background stays in place.
- **Why:** On long pages, the gradient doesn’t scroll away with the content; the “sky” stays fixed. (If you want the gradient to scroll with the page, use `background-attachment: scroll` or omit this property.)

## Summary

| Property | Role |
|----------|------|
| `background-image: linear-gradient(...)` | Creates the two-color gradient (can’t be done with `background-color`). |
| `background-size: cover` | Makes that gradient fill the whole area. |
| `background-attachment: fixed` | Keeps the gradient fixed while the page scrolls. |

**Why not `background-color`?**  
Because the design is a **gradient** (two colors blending), not a single flat color. Gradients are always done with `background-image`.

---

# Gradient on `html` vs `body` – why does it look the same?

Even when the viewport is **wider than 1512px** (e.g. 2304px) and the gradient is only on `body`, the whole screen can still show the gradient. That’s because of **background propagation**.

## What is background propagation?

In CSS, the **canvas** is the area that fills the viewport. For the **root element** (`html`):

- If `html` has **no background** (or it’s transparent), the browser uses the **`body`’s background** to paint the entire canvas.
- So the `body`’s gradient is **propagated** and used to fill the full viewport, even though the `body` element itself is only 1512px wide.

So with gradient on `body` and nothing on `html`, you still get a full-screen gradient: the body’s background is drawn across the whole viewport by the browser, not just behind the body box.

## When would you see a difference?

You’d only see a difference if **both** had backgrounds. For example:

- Give `html` a solid color (e.g. `background: #fff`) and keep the gradient on `body`. Then the side strips (outside the 1512px body) would show that solid color, and only the middle would show the gradient.

## Summary

- **Gradient on `body` only, `html` has no background** → Looks the same as gradient on `html` because of **background propagation** (body’s background is used for the full canvas).
- **Gradient on `html`** → Explicit and clear: the root owns the full-page background.
- Putting the gradient on **`html`** is still a good practice: it’s explicit and doesn’t rely on propagation.

---

# Figma font weight → CSS

Figma shows font weights by name (e.g. "Medium", "Semi Bold"). In CSS you must use **numeric values** or the keywords `normal` and `bold`. Names like `medium` or `semi bold` are **invalid** and are ignored by the browser.

## Figma → CSS mapping

| Figma        | CSS value |
|-------------|-----------|
| Thin        | 100       |
| Extra Light | 200       |
| Light       | 300       |
| Regular     | 400       |
| **Medium**  | **500**   |
| Semi Bold   | 600       |
| Bold        | 700       |
| Extra Bold  | 800       |
| Black       | 900       |

## Valid in CSS

- Numbers: `100`, `200`, `300`, `400`, `500`, `600`, `700`, `800`, `900`
- Keywords: `normal` (= 400), `bold` (= 700)

## Invalid

- `font-weight: medium` → use `font-weight: 500`
- `font-weight: semi bold` → use `font-weight: 600`

---

# CSS triangle (border trick)

**Idea:** Use an element with **no width or height**. Only the **borders** are visible. Where two borders meet they form a 45° edge, so coloring one border and making the others transparent creates a triangle.

## How it works

1. **`width: 0; height: 0`** – The box has no area; only the borders are visible.
2. **Two borders** – Same size, **transparent**. They still take space and form two edges of the triangle.
3. **One border** – **Colored**. Its edge becomes the base of the triangle; the transparent borders form the point.

**Direction = which border you color:**

| Shape   | Colored border    | Others transparent   |
|--------|-------------------|------------------------|
| ▼ Down | `border-top`      | left, right            |
| ▲ Up   | `border-bottom`   | left, right            |
| ▶ Right| `border-left`     | top, bottom           |
| ◀ Left | `border-right`    | top, bottom           |

**Sizing:** Left/right borders = half the base width (e.g. 21px → 42px base). Top/bottom border = height (e.g. 42px).

**Example (point-down triangle):**

```css
width: 0;
height: 0;
border-left: 21px solid transparent;
border-right: 21px solid transparent;
border-top: 42px solid #FF007A;
```
