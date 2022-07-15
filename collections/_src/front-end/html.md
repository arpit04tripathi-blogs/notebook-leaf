---
layout: page
title: HTML
permalink: /html
---

- TOC
  {:toc}

---

# References

- [HTML Color Picker](https://www.w3schools.com/colors/colors_picker.asp){:target="\_blank"}
- [CSS properties](https://www.w3schools.com/cssref/default.asp){:target="\_blank"}
- [css_tricks](https://css-tricks.com/){:target="\_blank"}
- [::before and ::after](https://css-tricks.com/almanac/selectors/a/after-and-before/){:target="\_blank"}

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <!-- meta -->
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <!-- link -->
    <link rel="stylesheet" href="style.css" />
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <!-- scripts -->
    <script src="script.js"></script>
  </head>
  <body></body>
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

## Form

```html
<form action="/process" method="post">
  <pre>
        username: <input type="text" name="username" id="username" placeholder="name"><br>
        password: <input type="password" name="password" id="password" required><br>
        email: <input type="email" name="email" id="email"><br>
        file: <input type="file" name="file" id="file"><br>
        telephone: <input type="tel" name="telephone" id="telephone"><br>
        <input type="submit" value="Submit">
    </pre>
</form>
```

## Table

```html
<table>
  <thead>
    <th>FName</th>
    <th>LName</th>
  </thead>
  <tbody>
    <tr>
      <td>Arpit</td>
      <td>Tripathi</td>
    </tr>
    <tr>
      <td>Second</td>
      <td>name</td>
    </tr>
  </tbody>
</table>
```

# Input Types

```html
<input type="text" />
<input type="password" />
<input type="radio" />
<input type="checkbox" />
<input type="button" />
<input type="color" />
<input type="email" />
<input type="file" />
<input type="hidden" />
<input type="image" />
<input type="number" />
<input type="range" value="5" min="1" max="20" />
<input type="search" />
<input type="tel" />
<input type="time" />
<input type="date" />
<input type="datetime-local" />
<input type="week" />
<input type="month" />
<input type="url" />
<input type="submit" />
<input type="reset" />
```

# Details and Summary

```html
<details>
  <summary>Heading Title</summary>
  <p>Full long Description here</p>
</details>
```

# Unique tags

```html
<meter min="0" max="100" value="50"></meter>
<progress max="100" , value="10"></progress>
```

## datalist

```html
<label for="cars-choice">Choose a Car:</label>
<input list="cars-suggestions" size="50px" placeholder="search..." />
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

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body>
    <header>Header</header>
    <nav>Navbar</nav>
    <main>
      <section>
        Section 1
        <article>Article 1</article>
        <article>Article 2</article>
      </section>
    </main>
    <aside>Aside</aside>
    <footer>Footer</footer>
  </body>
</html>
```
