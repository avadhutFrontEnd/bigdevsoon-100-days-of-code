# How Fonts Are Loaded (Notes)

## What "loading a font" means

The browser doesn’t know "Merriweather" by default. We have to give it:

1. **The font file** – the actual letter shapes.
2. **A name** we use in CSS: `font-family: "Merriweather"`.

**Loading the font** = downloading that font file and registering it under the name we use in CSS.

---

## How this project loads fonts

### Step 1: Getting the font file

#### Option A – From the internet (Google Fonts)

In **`index.html`**:

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Merriweather:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">
```

- **`preconnect`** – connects to Google’s servers early (can make the font load faster).
- **`stylesheet` link** – downloads the Merriweather font from Google when the page loads.

So: **one line in HTML → browser fetches the font from the internet and loads it.**  
This works even when you open the HTML file directly (e.g. double-click `index.html`).

#### Option B – From your project folder (`@font-face`)

In **`style.css`**:

```css
@font-face {
  font-family: "Merriweather";
  src: url("./assets/fonts/Merriweather-Regular.ttf") format("truetype");
  font-weight: 400;
  font-style: normal;
}
```

This says: *"The font file is in my project at `./assets/fonts/Merriweather-Regular.ttf`. When you load it, call it `Merriweather`."*

So: **`@font-face` in CSS = load this font from this file and register it under this name.**

---

## How the font gets used on the page

In **`style.css`**:

```css
body {
  font-family: "Merriweather", Georgia, serif;
}
```

That means: *"Use the font named Merriweather for the text."*

- **Loading** = getting the font file and naming it `"Merriweather"` (via Google link or `@font-face`).
- **Using** = setting `font-family: "Merriweather"` so the browser uses it for the text.

---

## Summary

| What              | Where | Meaning |
|-------------------|--------|--------|
| **Load from internet** | HTML: `<link href="https://fonts.googleapis.com/...Merriweather...">` | Download Merriweather from Google and register it as "Merriweather". |
| **Load from project**  | CSS: `@font-face { font-family: "Merriweather"; src: url("./assets/fonts/..."); }` | Use the file in my project and register it as "Merriweather". |
| **Use the font**       | CSS: `font-family: "Merriweather";` | Draw the text with the font named Merriweather. |

---

## In this project

- **Google Fonts** (in `index.html`) is what makes Merriweather show up when you open the file directly, because browsers often block loading local font files from `file://` URLs.
- **`@font-face`** (in `style.css`) is a fallback: when you serve the site from a server, the browser can use the local `.ttf` files from `assets/fonts/` instead.
