---
layout: page
title: Vue.js
permalink: /vue/core-concepts
---

- TOC
{:toc}

---

# Introduction

- For user interfaces and single-page applications.
- Front end JavaScript framework for reactive web frontends (browser side web applications).
  - **Framework** : 3rd party library with utilities and set of rules to build your application.
  - **Reactive** : App responds to user input and updates the screen dynamically (like error highlighed textboxes)

**Why Framework like Vue is required?**
- Modern web frontends get HTML once, then update DOM using JS based on the data.
- Standardized set of rules, easy to work in teams.
- Can focus on core business logic and let framework do the boilerplate actions.
- With plain JS - Interative approach, we define every single step like get the element, add event listner, get element and add item.

**Different ways of Using Vue**
- Widget : Part of the page controlled by Vue. example - sidebar, chat app etc.
- Single Page Application (SPA) : Everything controlled by Vue.

**Vue Alternatives**
- [Angular vs React vs Vue](https://academind.com/tutorials/angular-vs-react-vs-vue-my-thoughts/){:target="_blank"}

## How a Vue app Bootstraps ?

```html
<!-- index.html -->
<script src="https://unpkg.com/vue@next"></script>
<script src="app.js" defer></script>

<div id="app"></div>
```
```js
// app.js
const app = Vue.createApp(options); // if writing logic into app.js or main.js itself
const app = Vue.createApp(App); // where App.vue is file in src
app.mount('#app');
```
```js
const options = {
  // shorthand - data() { return {key:"value"} },
  data: function(){
    return {attribute:"value"}
  },
  methods: {
    method1() { console.log(this.attribute1); },
    method2() { console.log(this.attribute2); }
    // attributes have to be accessed as this.attr
  }
}
```

# DOM Interaction

- The portion of HTML being controlled by the Vue is called its ***template***.
- `data()` defines the initial model attributes for the template.

## Interpolation
- `js -> template` : output attributes from js on template.
- example - `{ { courseGoal }}`

### Binding Attributes : v-bind Directive
- `v-bind:href="courseGoalLink"`
- `:href="courseGoalLink"`

```html
<section id="user-goal">
  <h2>My Course Goal</h2>
  <p>{ { courseGoal }}</p>
  <p>{ { embeddedHtml }}</p>  <!-- won't work, security feature to protect from XSS attacks -->
  <p v-html="embeddedHtml"></p>
  <p>{ { 1 + 1 }}</p>
  <p>{ { Math.random() }}</p>
  <p>Link for <a :href="googleLink" target="_blank">Google Search</a></p>
</section>
```
```js
const app = Vue.createApp({
  data() {
    return {
      courseGoal: "Finish Vue Course",
      googleLink: "http://www.google.com",
      embeddedHtml: "<h2>New HTML for interpolation</h2>"
    };
  },
});
app.mount("#user-goal");
```

## methods (option)

```html
<section id="user-goal">
  <h2>My Course Goal</h2>
  <p>{ { outputGoal() }}</p>
  <p>Link for <a :href="googleLink" target="_blank">Google Search</a></p>
</section>
```
```js
const app = Vue.createApp({
  method: {
    // attributes defined in data() have to be accessed as this.attr
    outputGoal() {
      const randomNumber = Math.random();
      if(randomNumber<0.5){ return 'First Goal'; }
      else { return 'Second Goal'; }
    };
  },
});
app.mount("#user-goal");
```

## Events
- `v-on:click="incrementCount()"`
- `@click="incrementCount()"`
- ***We can add click event to any html element***

```html
<input type="text" @input="setName">
<input type="text" @input="setName($event, 'Tripathi')">
<button @click="increment">Add</button>
<button @mouseenter="decrement()">Reduce</button>
<p>Result : { { counter }}</p>
```
```js
method: {
  increment(){this.counter++;},
  decrement(){this.counter--;},
  add(num){this.counter += num;},
  setName(event){this.name = event.target.value}, // passed as default
  setName(event, surname){this.name = event.target.value + ' ' + surname;},
}
```

### Event Modifiers
```html
<form @submit.prevent="submitForm">
  <input type="text" @input="setName" @keyup.enter="confirmName">
  <button @click.right="increment">Add</button>
</form>
```
```js
method: {
  setName(event, surname){this.name = event.target.value + ' ' + surname;},
}
```

If you want an element to be updated only once then add `v-once` to the element.

## Two way Binding (v-model)

`v-bind` + `v-on` is 2-way binding 

```html
<input type="text" v-model="name">
<button @click=resetName>Reset Input</button>
```

## computed (option)

```html
<p>{ {counter}}</p>
<p>{ { getFullName() }}</p>
```
- Vue executes all the methods in interpolation when trying to re-render after any change, as it doesn't know which method will make changes to values that are being rendered on the template.
  - For example, Increment counter also executes the setFullName() to see if it changes the counter internally.
- To avoid this we should use computed properties provided by vue. 
- computed properties are methods but used as properties so name them like normal properties.
- computed properties are cached based on their reactive dependencies.
  - A computed property will only re-evaluate when some of its reactive dependencies have changed.
  - As long as `name` is not changed, multiple access to `fullname` computed property will immediately return the previously computed result without having to run the function again.

```js
computed: {
  fullname(){
    console.log('Running again...');
    if(this.name === ''){ return '';}
    return this.name+' '+Tripathi;
  }
}
```

## Watchers (option) watch
- Executed when there is a change in dependecy
- no return value
- not used for output in template.
- name same as prop or data attribute
- Useful to perform actions on change of a single property.
  - example : on change of page number, get paginated list from backend
- 

```js
watch: {
  // data property
  name(newValue, oldValue) {
    this.fullname = (newValue === '') ? '' : (newValue + ' Tripathi');
    // no return value
  }
}
```

## Methods vs Computed vs Watch
- **methods**
  - use with event binding or data binding
  - data binding : method executed for every re-render cycle of component
  - primarily use for even binding
  - use for events or data that really needs to be re-evaluated all the time
- **computed**
  - use with data binding
  - only re-evaluated if one of their 'used values' changed
  - use for data that depends on other data
- **watch**
  - not used directly in template
  - run any code in reaction to changed data (eg. Http request etc.)
  - use for any non data update you want to make.

## Dynamic Styling
- ***We can add click event to any html element***
- vue provides object notation for binding style and class property

```html
<div class="demo"
  :style="{'border-color': boxASelected ? red : '#ccc'}" <!-- hypenated (ke-bab) -->
  @click="boxASelected=true"></div>

<div class="demo"
  :style="{borderColor: boxASelected ? red : '#ccc'}" <!-- camelCase -->
  @click="boxASelected=true"></div>
```

```html
<div :class="{demo: true, active: boxASelected}"
  @click="boxASelected=true"></div>

<!-- object notation -->
<div class="demo"
  :class="{active: boxASelected}"
  @click="boxASelected=true"></div>

<!-- array notation -->
<div :class="['demo', {active: boxASelected}]"
  @click="boxASelected=true"></div>
```

# Render Conditional Content and Lists

## v-if, v-else, v-else-if

- Conditionally render html elements on DOM

```html
<div v-if="count === 0">IF count==0</div>
<p></p> <!-- Wrong, v-else-if and v-else should be immediate neighbourh -->
<div v-else-if="count < 10">ELSE IF count < 10</div>
<div v-else>Else, you have count >= 10</div>
```

# v-show
- Rendered on DOM always, but handles visibility of element

```html
<div v-show="count === 0">I am present, but hidden until count==0</div>
```

## v-for

- `v-for` is quite efficient as it only rendders the changes in list rather than rendering the whole list again on pushing a data item to array.
- `v-for` element must always have `key` so that vue can identify the element.
  - This is because vue tries to re-use the dom elements behind the scene to optimize performance.
  - this can lead to bugs if element contains state.
  - ie. if we delete an element in the array, vue copies the content of next item into the prev item until it reaches the new length hence it appears to have an element removed

```html
<ul v-if="items.length > 0">
  <li v-for="item in items" :key="item.id">{ {item.label}}</li>
</ul>
<ul v-else>
  <li v-for="(item, index) in items" :key="item.id">{ {item.label}} - { {index}}</li>
</ul>
```

### Loop over numbers
```html
<ul>
  <li v-for="num in 10" :key="num">{ {num}}</li>
</ul>
```

### Loop over object properties
```html
<ul>
  <li v-for="value in {name: 'Arpit', age: '29'}">{ {value}}</li>
</ul>

<!-- renders below -->
<ul>
  <li>Arpit</li>
  <li>29</li>
</ul>
```
```html
<ul>
  <li v-for="(value, key) in {name: 'Arpit', age: '29'}">{ {key}} -> { {value}}</li>
</ul>
```
```html
<ul>
  <li v-for="(value, key, index) in {name: 'Arpit', age: '29'}">{ {index}}. { {key}} -> { {value}}</li>
</ul>
```

# LifeCycle Events

## beforeMount()
- beforeMount() executes from Parent to Child.

## mounted()
- mounted() executes from Child to Parent.

# Modes and Environment Variables

[Modes and Environment Variables](https://cli.vuejs.org/guide/mode-and-env.html#modes){:target="_blank"}

By default, there are three modes:
- development is used by vue-cli-service serve
- test is used by vue-cli-service test:unit
- production is used by vue-cli-service build and vue-cli-service test:e2e
