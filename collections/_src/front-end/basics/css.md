---
layout: page
title: CSS Basic
permalink: /css
---

- TOC
{:toc}

---

# References

- We can use free fonts - [Google Fonts](https://fonts.google.com/){:target="\_blank"}
- [HTML Color Picker](https://www.w3schools.com/colors/colors_picker.asp){:target="\_blank"}
- [CSS properties](https://www.w3schools.com/cssref/default.asp){:target="\_blank"}
- [css_tricks](https://css-tricks.com/){:target="\_blank"}
- [FlexBox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/){:target="\_blank"}
- Shapes and Alignment
  - [clip-path](https://bennettfeely.com/clippy/){:target="\_blank"}

# References for CSS

- [HTML Color Picker](https://www.w3schools.com/colors/colors_picker.asp){:target="\_blank"}
- [CSS properties](https://www.w3schools.com/cssref/default.asp){:target="\_blank"}
- [css_tricks](https://css-tricks.com/){:target="\_blank"}
- [::before and ::after](https://css-tricks.com/almanac/selectors/a/after-and-before/){:target="\_blank"}

# Introduction

- Cascasded Style Sheets
- Best way to perform a basic reset using the universal selector.
- `box-sizing: border-box;` : padding and border are included in the width and height
- h1 in header is important for google search to know what the page is all about

# Selectors

```css
/* All elemets */
* {
  box-sizing: border-box;
}

/* tags */
p, h1 {
  color: red;
}

/* tags nested */
section p {
  color: red;
}

/* IDs, tags, class */
#id, h1, .class {
  color: red;
} 
```

## States

```
:hover
:link
:visited
```

## Pseudo Elements

```
::before
::after
```

# Properties

```
clip-path: polygon(0 0, 100% 0, 100% 80%, 0 100%);
```

