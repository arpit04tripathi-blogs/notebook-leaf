---
layout: page
title: HTML
permalink: /html
---

- TOC
{:toc}

---

# Getting Started

- HyperText Media Language
- Do follow semantics for html rather than using div everywhere.
- you should not allow others to put your site in iframe.
- A semantic element clearly describes its meaning to both the browser and the developer.
  - non-semantic elements: <div> and <span> - Tells nothing about its content.
  - semantic elements - Clearly defines its content.
- semantic elements:
  - `<header>` and `<nav>`
  - `<main>`
    - `<section>`, `<article>`, `<aside>`
    - `<figure>`, `<figcaption>`
    - `<details>`, `<summary>`
    - `<table>`
    - `<form>`
  - `<footer>`

# Semantic Template

```html
<!DOCTYPE html>
<!-- look for html tag -->
<html lang="en">
  <head>
    <!-- meta -->
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>HTML Basics</title>
    <meta name="description" content="This showcases basic htlm tags" />
    <meta name="author" content="Arpit Tripathi (arpit04tripathi)" />
    <meta name="keywords" content="html" />
    <!-- link -->
    <link rel="stylesheet" href="style.css" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <!-- scripts -->
    <script src="script.js"></script>
  </head>
  <body>
    <header>
      <h1>HTML tags</h1>
      <nav>
        <a href="/html/">HTML</a> | <a href="/css/">CSS</a> |
        <a href="/js/">JavaScript</a> | <a href="/jquery/">jQuery</a>
      </nav>
    </header>
    <main>
      <section>
        Section 1
        <article>Article 1</article>
        <article>Article 2</article>
      </section>
      <section>Section 2</section>
    </main>
    <aside>Aside</aside>
    <footer>
      <p>This is <b>footer</b></p>
    </footer>
  </body>
</html>
```

```html
<div>
  <a href="http://google.com" target="_blank">
    <button>Google Search</button>
  </a>
</div>
```

```html
&nbsp;
<!-- non-breaking space: entity in HTML -->
```

# Basic Text

```html
<h1>Heading</h1>
<p>paragraph - block elements</p>
<pre>pre - maintains format from html to render, block element</pre>
<ul>
  <li>This is <b>bold</b>.</li>
  <li>This is <i>italic</i>.</li>
  <li>
    embed to make <b><i>bold italic</i></b
    >.
  </li>
  <li>This is <big>big</big>.</li>
  <li>This is <small>small</small>.</li>
  <li>subscript - H<sub>2</sub>O</li>
  <li>superscript - 10<sup>2</sup></li>
  <li><strike>striked</strike></li>
  <li><u>underline</u></li>
  <li>highlight - <mark>mark</mark></li>
</ul>
```

# Lists

## Unordered List

```html
<ul>
  <li>Item 1</li>
  <li>Item 2</li>
</ul>
```

## Ordered List

### default

```html
<ol>
  <li>Item 1</li>
  <li>Item 2</li>
</ol>
```

### with type

```html
<ol type="1">
  <li>Item 1</li>
  <li>Item 2</li>
</ol>
<ol type="A">
  <li>Item 1</li>
  <li>Item 2</li>
</ol>
<ol type="a">
  <li>Item 1</li>
  <li>Item 2</li>
</ol>
<ol type="I">
  <li>Item 1</li>
  <li>Item 2</li>
</ol>
<ol type="i">
  <li>Item 1</li>
  <li>Item 2</li>
</ol>
```

## Description List

```html
<dl>
  <dt>Apples</dt>
  <dd>They are red, pink, green etc.</dd>
  <dt>Oranges</dt>
  <dd>They are orange.</dd>
</dl>
```

# Details and Summary

```html
<details>
  <summary>Heading Title</summary>
  <p>Full long Description here</p>
</details>
```

# Images and Videos

```html
<figure>
  <img
    src="https://images.freeimages.com/images/large-previews/1d2/music-nightclub-1420666.jpg"
    alt="random image"
    width="25%"
  />
  <figcaption>Fig1. - Trulli, Puglia, Italy.</figcaption>
</figure>
<!-- local video -->
<video
  src="video.mp4"
  poster="https://www.simplilearn.com/ice9/free_resources_article_thumb/html_video_tag.jpg"
  width="50%"
  controls
  autoplay
>
  HTML tutorial
</video>
```

# Iframe

Embed other website in our website

```html
<!-- Embed youtube -->
<iframe
  width="560"
  height="315"
  src="https://www.youtube.com/embed/pQN-pnXPaVg"
  title="YouTube video player"
  frameborder="0"
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
  allowfullscreen
></iframe>
```

# Table

```html
<table>
  <thead>
    <caption>
      <h3>Table Heading</h3>
    </caption>
    <tr>
      <th>Col 1</th>
      <th>Col 2</th>
      <th>Col 3</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Data 1 C1</td>
      <td>Data 1 C2</td>
      <td>Data 1 C3</td>
    </tr>
    <tr>
      <td>Data 2 C1</td>
      <td>Data 2 C2</td>
      <td>Data 2 C3</td>
    </tr>
    <tr>
      <td colspan="2">Data 3 colspan 2</td>
      <td>Data 3 C3</td>
    </tr>
  </tbody>
</table>
```

# Form and Inputs

```html
<form action="/process" method="post">
   <h1>Form Heading</h1>
   <section>
      <h2>Text Fields</h2>
      <p>
         <!-- label always have for="element_id" -->
         <!-- WHY? -->
         <!-- label is clickable and links to element with ID, so if I click label then it will select radio button with id in for attribute -->
         <label for="id_username">Input Text</label> <input type="text" id="id_username" name="username"
            placeholder="username placeholder" />
      </p>
      <p>
         <label for="id_password">Password Text</label> <input type="password" name="password" id="id_password"
            placeholder="enter password">
      </p>
      <p>
         <label for="id_notes">Text Area</label> <textarea name="notes" id="id_notes" cols="30" rows="5"
            placeholder="Enter a note"></textarea>
      </p>
   </section>
   <section>
      <h2>Date Fields</h2>
      <p> <label for="id_date">Date</label> <input type="date" name="date" id="id_date"> </p>
      <p><label for="id_time">Time</label> <input type="time" name="time" id="id_time"></p>
      <p>
         <label for="id_datetime_local">Datetime Local</label> <input type="datetime-local" name="datetime-local"
            id="id_datetime_local">
      </p>
      <p><label for="id_datetime">Datetime</label> <input type="datetime" name="datetime" id="id_datetime">
         <strike>deprecated</strike>
      </p>
      <p><label for="id_month">Month</label> <input type="month" name="month" id="id_month"></p>
      <p><label for="id_week">Week</label> <input type="week" name="week" id="id_week"></p>
   </section>
   <section>
      <h2>Specific Type (validated)</h2>
   </section>
   <p><label for="id_url">URL</label> <input type="url" name="url" id="id_url"></p>
   <p><label for="id_email">Email</label> <input type="email" name="email" id="id_email"></p>
   <p><label for="id_phone">Phone (maxlength 5)</label> <input type="tel" name="phone" id="id_phone" maxlength="5"
      required></p>
   <p><label for="id_range">Range</label> <input type="range" name="range" id="id_range" min="1" max="50"></p>
   <section>
      <h2>Checkbox, Radio and Dropdown</h2>
      <p>
      <fieldset>
         <legend>Quantity (fieldset legend) - can be diabled to disable all options</legend>
         <label>Quantity</label>
         <input type="checkbox" name="qty" id="id_qty_1" value="1" checked> <label for="id_qty_1">1 KG</label>
         <input type="checkbox" name="qty" id="id_qty_2" value="2"> <label for="id_qty_2">2 KG</label>
         <input type="checkbox" name="qty" id="id_qty_5" value="5"> <label for="id_qty_5">5 KG</label>
      </fieldset>
      </p>
      <p>
      <fieldset>
         <legend>Options</legend>
         <label>Radio Buttons</label>
         <input type="radio" name="radio" id="id_opt_1" value="1" checked> <label for="id_opt_1">opt 1</label>
         <input type="radio" name="radio" id="id_opt_2" value="2"> <label for="id_opt_2">opt 2</label>
         <input type="radio" name="radio" id="id_opt_all" value="all"> <label for="id_opt_all">opt ALL</label>
      </fieldset>
      </p>
      <p>
         <label for="id_cars_dl">datalist - Car:</label>
         <input list="cars-suggestions" size="50px" placeholder="search..." name="cars-choice" id="id_cars_dl" />
         <datalist id="cars-suggestions">
            <option value="mercedes">describe my car - mercedes</option>
            <option>volkswagen</option>
            <option>BMW</option>
            <option>Tesla</option>
            <option>Lamborghini</option>
         </datalist>
      </p>
      <p>
         <label for="id_cars_opt_group">Select - Car:</label>
         <select id="id_cars_opt_group" name="car">
            <optgroup label="Group 1">
               <option value="mer">mercedes</option>
               <option>volkswagen</option>
            </optgroup>
            <optgroup label="Group 2">
               <option>BMW</option>
               <option>Tesla</option>
               <option>Lamborghini</option>
            </optgroup>
            <option>Others</option>
         </select>
      </p>
   </section>
   <section>
      <h2>others</h2>
      <p><label for="id_color">Color</label> <input type="color" name="color" id="id_color"></p>
      <p><label for="id_file">File</label> <input type="file" name="file" id="id_file"></p>
      <p><label for="id_search">Search Text</label> <input type="search" name="search" id="id_search"></p>
      <p><label for="id_hidden">Hidden input</label> <input type="hidden" name="hidden-value" id="id_hidden"
         value="hidden-element-value"></p>
   </section>
   <section>
      <h2>Tags for Display</h2>
      <p>Meter : <meter min="0" max="100" value="50">Meter</meter></p>
      <p>Progress : <progress max="100" , value="10">Progress</progress></p>
   </section>
   <section>
      <h2>Submit Section</h2>
      <p><label for="id_submit">Submit Btn</label> <input type="submit" value="Submit Here" id="id_submit"></p>
      <p><label for="id_reset">Reset</label> <input type="reset" value="Reset" id="id_reset"></p>
      <p><label for="id_image">Image</label> <input type="image" src="image" alt="graphical submit buttons" id="id_image"></p>
   </section>
</form>
```

# Unique tags

```html
<meter min="0" max="100" value="50"></meter> <progress max="100" , value="10"></progress>
```

## datalist

```html
<label for="cars-choice">Choose a Car:</label>
<input list="cars-suggestions" size="50px" placeholder="search..." name="cars-choice" />
<datalist id="cars-suggestions">
  <option value="mercedes">my car - mercedes</option>
  <option>volkswagen</option>
  <option>BMW</option>
  <option>Tesla</option>
  <option>Lamborghini</option>
</datalist>
```

## optgroup

```html
<select id="suggestions">
  <optgroup label="Group 1">
    <option>mercedes</option>
    <option>volkswagen</option>
  </optgroup>
  <optgroup label="Group 2">
    <option>BMW</option>
    <option>Tesla</option>
    <option>Lamborghini</option>
  </optgroup>
  <option>Others</option>
</select>
```

# Adding Styles

There are 3 ways to add styles to html

- inline
- internal
- external

## Inline Style - within element

```html
<p style="color:red; font-size:24px; font-weight:bold;">paragraph text here.</p>
```

## Internal Style - style tag in head

```html
<head>
  <style>
    p {
      color: red;
      font-size: 24px;
      font-weight: bold;
    }
  </style>
</head>
```

## External Style - link a css

```html
<head>
  <link rel="stylesheet" href="style.css" />
</head>
```
