---
layout: page
title: SASS
permalink: /sass
---

- TOC
{:toc}

---

# Introduction

* Syntactically Awesome StyleSheets
* Sass is an extension of css and allows variables, nested rules, mixins, inline imports etc. 
* Sass includes two syntax options:
    - SCSS (Sassy CSS): .scss file.
    - Indented (simply called 'Sass'): .sass file, indentation rather than brackets;
    - Files can be converted from one syntax to the other using the sass-convert command.

```
sass-convert style.sass style.scss
sass-convert style.scss style.sass
```

```ts
// Variables
$font-stack:    Helvetica, sans-serif;
$primary-color: #333;
body {
  font: 100% $font-stack;
  color: $primary-color;
}
```
```ts
// Nesting
nav {
  ul {
    margin: 0;
    padding: 0;
    list-style: none;
   }
   li { display: inline-block; }
}
```
```ts
// Mixins
@mixin border-radius($radius) {
  -webkit-border-radius: $radius;
     -moz-border-radius: $radius;
      -ms-border-radius: $radius;
          border-radius: $radius;
}
.box { @include border-radius(10px); }
```
Operators - few built-in functions to help manipulate numbers like percentage(), floor() and round()
