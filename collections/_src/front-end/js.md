---
layout: page
title: Javascript
permalink: /js
---

- TOC
  {:toc}

---

# Introduction

- **javascript is a Synchronous, single-threaded language.**
- JS is a lightweight, interpreted, object-oriented scripting language for web-pages.
  - **lightweight** - small memory footprint, easy to implement.
  - **interpreted** - no compilation, instructions are executed directly as opposed to java where intermediate bytecode is compiled and then executed.

<img src="{{site.cdn}}/ui/js/why-js.png" width="400"/>

- Browser receives html as a string and constructs a DOM tree from it. This conversion will always result in same output.
- JS is used to provide dynamic functionality to this.

## Use Cases for Learning JS

- Client side web development - native javascript, jQuery, AgularJS, React, Ember
- Server side development - NodeJS, Express
- Browser Extensions
- Desktop applications
- Mobile applications
- IOT applications

# Execution Context

- **_Execution Context._**
- Execution Context has 2 components
  1. Memory Component (Variable Enviroment) - variable and function stored as key-value pairs.
  2. Code Component (Thread of Execution) - js code is executed here.

## How JS code is executed by JS Engine

- When you run a JS code, Global execution context is created.
- This Global Execution Context is created in 2 phases
  1. Memory Creation Phase - Allocates memory to variables and functions.
  - variables - assigned `undefined`
  - functions - whole function code is assigned
  2. Code Execution Phase - actual values are assigned to variables and functions are invoked.
- Each function invocation creates a new Execution Context and with return statement that execution context is destroyed.

## Call Stack

- Maintains the Order of Execution for Execution Contexts.
- Manages Global Execution Context and child execution context.
- Global Execution Context <= EC1 <= EC2 (top-of-stack)
- Also known as
  - Call Stack
  - Execution Context Stack
  - Program Stack
  - Control Stack
  - Runtime Stack
  - Machine Stack

## Hoisting

- All the variables and functions defined in the js are created during memory allocation phase.
  - vars as undefined
  - functions as copied code block
- Functions defines as arrow function or var are allocated as if they are vars ie. undefined.

### not-defined vs undefined

- **not defined** - means variable/function was not defined in Memory Creation Phase
- **undefined** - means variable/function was defined in Memory Creation phase but value is not assigned.

## Shortest JS Program

- Empty js file is the shortest js program.
- JS Engine creates the following
  - Global Execution Context
  - Global Object - `window` for browsers
  - this - pointed to window
- same : `this.a` , `window.a`, `a`

# Types and Variables

- **Primitive Types for js**
  - number
  - string
  - booleans
  - undefined
  - null
  - symbol - similar to enumeration (introduced in ES6)
- **Type Wrapper Objects**
  - String
  - Number
  - Boolean
  - Symbol

```js
var value; // Declaration // here, value = undefined
value = 42; // Definition
console.log(typeof value);
```

- No types info is attached with variables in js, **_loosely typed language_**.
- same variable can be assigned values of different types
- No scoping info in variable declaration as opposed to java (private, public, static etc.)
- variables type can be interrogated - typeof

## Type Coercion and === operator

- **Type Coercion** - Type casting
- **== operator** - check for equals
- **=== operator**
  - check for equals as well as type match
  - precise checks

```js
var a = 10;
var b = "10";
console.log(a == b); // true
console.log(a === b); // false

if (a) {
  console.log("a is true");
}
```

### Variable evaluation for if condition

- int - zero, means false
- string - empty, means false
- undefined - false
- null - false

This means every primitive type has a boolean type associated with it, coercion.

## undefined vs null

- undefined
  - it is a variable type as well.
  - value has never been initialized (untouched form field)
- null - value was assigned but not a proper value (visited form field)
  - you can set an object property as null to convey that property name is valid but currently no value is set.

# Objects

- Objects are of free form as js doesn't have concept of classes.
- No strict structure of objects.
- In js, objects behave as key-value pair like a map.
- Object literal notion to create objects.
- Object properties can be accessed directly.
- New properties can be added to objects directly.
- Objects can have methods.

```js
var myObj = {};
console.log(myObj);
myObject.name = "Arpit Tripathi";
```

## Dot and [ ] Notation

- Object properties can be accessed by **dot** notation or **square bracket** notation.
- Used when property name is
  - a reserved word or invalid identifier.
  - starts with a number.
  - dynamic
- returns value or undefined
- Runtime engine may not be able to optimize [] notation.
- Dot and [] notations can be interchanged.

```js
var myObject = {
  "name":"Arpit Tripathi",
  "1":"One"
  "address":{
    "state" : "Maharashtra",
    "country": "India"
  }
};
console.log(myObj.name);
console.log(myObj["name"]);
console.log(myObj.1); // Dot operator will fail due invalid identifier
console.log(myObj["1"]); // So, we use square bracket identifier
var propertyName = "dynamicProperty";
console.log(myObj[propertyName]); // Dynamic Property Name
console.log(myObj.address.country); // accessing internal proerty
```

## Deleting a property

```js
delete myObj["1"];
console.log(myObj);
```

## JSON vs JS Object

**_Difference Between JSON Object and JavaScript Object_**

- JSON stands for JavaScript Object Notation.
- JSON is a lightweight data interchange format.
- Human readable, Easy to parse, Lightweight
- JSON is plain text that we use to transfer data.
- JSON is not specific to JavaScript. can parse a JSON string using any other programming language, like PHP, .Net, Pearl.
- Unlike JavaScript Object, a JSON Object has to be fed into a variable as a String and then parsed into JavaScript.
- For JSON, keys can also be any valid string.
- The JSON values can only be one of the six datatypes (strings, numbers, objects, arrays, Boolean, null). JavaScript values on the other hand can be any valid JavaScript Structure.

![json-vs-jsObject]({{site.cdn}}/angular/json-vs-jsObject.png)

- d is JSON string
- e is JavaScript Object
- f is also a JavaScript Object, we just parse a JSON string into a JavaScript Object.
- d and e both look the same. So most developers feel that d is a JSON object.

| JSON                                   | JS Object                                      |
| -------------------------------------- | ---------------------------------------------- |
| ![json]({{site.cdn}}/angular/json.png) | ![jsObject]({{site.cdn}}/angular/jsObject.png) |

## Global Objects

- `Math` is a Global object provided in js.
- `Date`
- `window`

## Constructor

```js
function createEmployeeObject(fname, lname, gender, designation) {
  var newObject = {};
  newObject.fname = fname;
  newObject.lname = lname;
  newObject.gender = gender;
  newObject.designation = designation;
  return newObject;
}

var emp1 = createEmployeeObject("Arpit", "Tripathi", "M", "Developer");
var emp2 = new Employee("Arpit", "Tripathi", "M", "Developer");

function Employee(fname, lname, gender, designation) {
  this.fname = fname;
  this.lname = lname;
  this.gender = gender;
  this.designation = designation;
}
```

# Arrays

- Arrays are not homogeneous due to free form.
- 0 based indexing
- undefined for out of bound index.
- js array is underneath a js object with a property length.
  - property names are numbers - 0,1,2...
  - arr[3] is internally converted to arr["3"] for square bracket notation.

```js
var arr = [100, 200, 300];
arr[3] = 400;
arr.length;
var arr = [10, 20, "hello", {}]; // Valid Declaration
```

## Array Methods

```js
var arr = [10,20,'Hello',{}];
arr.push(50); // adds at end
arr.pop(); // removes from end
arr.splice(index,1); // find index and removes 1 element
arr.shift(); // removes from front
arr.unshift(42); // adds at front
var myFunction = fucntion(item, index, array){ // 3 parameters passed by forEach
  console.log("For each element "+item);
};
arr.forEach(myFunction);
```

# Functions

- free form language, hence method overloading is not possible.
- flexible argument counts.
- In JS, functions are values.

```js
// Function Declaration
function sayHello(name, surname) {
  // No need to declare type as everything is var
  console.log("Hello " + name + " " + surname);
}
sayHello("Arpit", "Tripathi");
sayHello("Arpit"); // no compilation error, surname will be undefined
sayHello("Arpit", "Tripathi", "India"); // No compilation error, 3rd argument is ignored
var value = ("Arpit", "Tripathi"); // returns undefined
function sayHello(name, surname) {
  return "Hello " + name + " " + surname;
}
```

## Function Expression and Anonymous Function Expression

```js
// Function Expression - Note ';' at end of function
var hello = function sayHello(name, surname) {
  console.log("Hello " + name + " " + surname);
};
hello("Arpit", "Tripathi");

// Anonymous Function Expression
var hello = function sayHello(name, surname) {
  console.log("Hello " + name + " " + surname);
};
hello("Arpit", "Tripathi");
```

## Function as Argument

```js
// Passing function as argument
var executor = function (fn) {
  fn();
};
executor(hello);
```

## Function as Object Property

```js
var myObj = {
  propa: "hello",
};
myObj.myMethod = function () {
  console.log("Method in object property");
};
myObj.myMethod();
```

# this Keyword

```js
var person = {
  firstName: "Arpit",
  lastName: "Arpit",
  getFullname: function () {
    return person.firstName + person.lastName;
  }, // called when function execution is initiated
};
var fullName = person.getFullname();
console.log(fullName);
var person2 = person;
person = {};
fullName = person2.getFullname(); // here getFullname is constructed from person rather than person2

var person = {
  firstName: "Arpit",
  lastName: "Arpit",
  getFullname: function () {
    return this.firstName + this.lastName;
  },
};
```

```js
foo(); // 'this' will refer to global object
obj.foo(); // 'this' will refer to obj
new foo(); // 'this' will refer to newly created object
foo.call(myObj); // 'this' will refer to myObj
```

# Default Function Arguments

- we get 2 properties - `arguments` and `this`
- arguments value is not an array, we use it as array but it is an object.

```js
var add = fucntion(a,b){
  console.log(arguments); // captures full list of passed arguments
  return (a+b);
}
add(2,3);
add(2,3,4,5,6);

var add = fucntion(){
  console.log(arguments); // captures full list of passed arguments
  var i, sum = 0;
  for(i=0; i<arguments.length, i++){
    sum += arguments[i];
  }
  return sum;
}
```

# Scopes

- javascript is not block-scoped, it is function-scoped

```js
var name = "Arpit";
if (name == "Arpit") {
  var surname = "Tripathi";
}
console.log(name + " " + surname);

function validate() {
  if (name == "Arpit") {
    // accessing parent scoped var
    var surname = "Tripathi";
  }
}
validate();
console.log(name + " " + surname); // runtime error, js is function scoped but we are trying to access child scoped var
```

- Global scoped vars are created in one master global object.
  - for browser, it is `window` where we can see all the global objects registered.
  - console object is also available in this

## Scope Chains

## Immediately Invoked Function Expression (IIFE)

Why avoid Global variables

- Generally, multiple js files are loaded at a time and they share same namespace. Hence, global variables will be overridden.
- Same goes for function names.

```js
// IIFE - No global funtion defined, but invoked once
(function () {
  var a = 40;
  var b = 60;
  console.log(a + b);
})();
```

# Compilation and Interpretation

**Compilation Phase**

- web browser loads and compiles the source js file, not compiled to some intermediate file.
- Here, we register variables as per the scope.
- This phase is executed very quickly.

**Interpretation Phase**

- Executes based on variables registered during compilation phase.

```js
var a = 10;
function myFn() {
  var b = a;
  console.log(b);
  c = 100;
  // creates variable in global scope rather than myFn scope as it already looked upto Global scope
  // solution - use var to create myFn scoped variables
}
myFn();
```

Due to these separate steps of compilation and interpretation, order of vars in same scope doesn't affect anything. (example below)

```js
var a = 10;
function outer() {
  var b = a;
  console.log(b);
  function inner() {
    var c = b; // Here, b is expected to be 10 from the global scope. but it will be undefined due to function scope.
    console.log(c);
    var b = 20;
  }
  inner();
}
outer();
```

```js
console.log(a);
var a = 10;
```

## Hoisting

- Declarartion of vars and functions are hoisted to the top of their scope while execution stays in sequence of code.

```js
function funcA() {
  funcB();
}

function funcB() {
  funcA();
}
// Here hoisting is important as funcB is defined after funcA, but funcA calls funcB.
```

## Strict Mode

- Introduced in ES5 (Ecma Script).
- ES is a standardization for JS to be implemented by clients.
- `"use strict;"`

```js
var myName = "Arpit";
myname = "Arpit Tripathi"; // here another global scoped var is created

("use strict;");
var myName = "Arpit";
myname = "Arpit Tripathi";
// Error : reference to undeclared variable
```

# Closures

- function declaration keeps a snapshot of scope as well ie. it points to same variables as inside the function.
- **Closure** is a function that remembers scope during the time of declaration, even if it is executed from a different scope.
- Closures are useful in callbacks and creating modules.

```js
var a = 10; // global scoped var
function outer() {
  var b = 20; // function scoped var
  var inner = function () {
    a++;
    b++;
    console.log(a);
    console.log(b);
  };
  return inner;
}
var b = 50;
var innerFn = outer(); // new copy of var b created in function
innerFn(); // prints 11 and 21 due to closures
var innerFn2 = outer();
innerFn2(); // prints 12 and 21 due to closures
```

**Callback**

```js
var a = 10;
fucntion fn(){
  console.log(a);
}
setTimeout(fn, 1000); // Here, closure has the var a definition even when passed to 3rd party function
console.log("Done!"); // Print done and then a
```

**Module Pattern**

```js
function person(fname, lname) {
  var firstName = fname;
  var lastName = lname;
  var returnObj = {
    getFirstName: function () {
      return firstName;
    },
    getLastName: function () {
      return lastName;
    },
    setFirstName: function (name) {
      firstName = name;
    },
    setLastName: function (name) {
      lastName = name;
    },
  };
  return returnObj;
}
var p = person("Arpit", "Tripathi");
console.log(p.getFirstName()); // var firstName accessed by closures
console.log(p.firstName); // undefined, property was not included in returned object
```

## Closure in Async Callbacks

```js
var i;
var print = function () {
  console.log(i);
};
for (i = 0; i < 10; i++) {
  print(); // print 0 to 9
}
for (i = 0; i < 10; i++) {
  setTimeout(print, 1000); // print 10 for 10 times, all are pointing to same i
  // IIFE
  (function (curr) {
    setTimeout(function () {
      console.log(curr);
    }, 1000);
  })(i);
}
```

# Prototype

- Objects created from same function shares same prototype.
- Prototype is used to define behaviors for similar objects.
- you can add properties to prototype on runtime, different from classes in Java where all behaviors are needs to be defined upfront.

```js
function foo() {}
foo.prototype; // points to prototype object of foo
foo.prototype.constructor; // points to foo
var myObj = new foo();
// myObj has __proto__ pointing to prototype object of foo function
myObj.hello; // check myObj for property and if not found, check prototype object for property
```

- `Object` is a global function which also have a prototype.

```js
var simple = {};
var myObj = new Object();
console.log(Object.prototype === myObj.__proto__);
// both var are constructed from Object prototype
var f = new foo(); // foo prototype has __proto__ for Object prototype
console.log(Object.prototype === f.__proto__.__proto__);
```

- prototypes can be used to implement inheritance in js.

![]({{site.cdn}}/ui/js/prototypes.png)

![]({{site.cdn}}/ui/js/inheritance-with-prototype.png)

# ToDo

- [LocalStorage, sessionStorage](https://javascript.info/localstorage)

# References

- [JS Introduction](https://www.youtube.com/watch?v=s6R0VEdoVt4&list=PLqq-6Pq4lTTYFJxC9NLJ7dSTI5Z1WWB6K)
- [Scopes and Closures](https://www.youtube.com/watch?v=O312eN5J2bc&list=PLqq-6Pq4lTTZ_LyvzfrndUOkIvOF4y-_c)
- [Objects and Prototypes](https://www.youtube.com/watch?v=fBpPfPjxOhc&list=PLqq-6Pq4lTTaflXUL0v3TSm86nodn0c_u)
- [onload vs ondomcontentloaded](https://javascript.info/onload-ondomcontentloaded){:target="\_blank"}
