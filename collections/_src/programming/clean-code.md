---
layout: page
title: Clean Code
permalink: /clean-code
---

- TOC
{:toc}

---

# Chapter 1 : Clean Code

**What is Clean Code?**
- Clean code is focused.
  - Each function, each class, each module exposes a single-minded attitude that remains entirely undistracted, and unpolluted, by the surrounding details.
- Write one method that says more clearly what it does, and some submethods saying how it is done.
- clean code when each routine you read turns out to be pretty much what you expected.

# Chapter 2 : Meaningful Names
- Use Intention-Revealing Names
- Length of a name should correspond to the size of its scope.

> Clarity is king, Professionals use their powers for good and write code that others can understand.

> We want our code to be a quick skim, not an intense study. 

## Class Names
- Classes and objects should have noun or noun phrase names like Customer, WikiPage, Account, and AddressParser.
- A class name should not be a verb.
  - Avoid words like Manager, Processor, Data, or Info in the name of a class.
- When constructors are overloaded, use static factory methods with names that describe the arguments.

```java
Complex fulcrumPoint = Complex.FromRealNumber(23.0); 
```

## Method Names
- Should have verb or verb phrase names like postPayment, deletePage, or save.
- Accessors, mutators, and predicates should be named for their value and prefixed with get, set, and is according to the javabean standard.
- **Pick One Word per Concept**
  - Pick one word for one abstract concept and stick with it.
  - For instance, it’s confusing to have fetch, retrieve, and get as equivalent methods of different classes.

# Chapter 3 : Functions
- should be small.
- Functions should hardly ever be 20 lines long.
- blocks within if, else, while and so on should be one line long.
  - Probably that line should be a function call.
- The indent level of a function should not be greater than one or two.

>FUNCTIONS SHOULD DO ONE THING.  
THEY SHOULD DO IT WELL.  
THEY SHOULD DO IT ONLY.  

- One Level of Abstraction per Function.
- Be consistent in your names. Use the same phrases, nouns, and verbs in the function names you choose for your modules.
  - Example - the names includeSetupAndTeardownPages, includeSetupPages, includeSuiteSetupPage, and includeSetupPage.

## Function Arguments - max 3.
- Difficult for Unit testing all combinations of parameters.
- One input argument is the next best thing to no arguments.
- Flag Arguments
  - Passing a boolean into a function is a truly terrible practice.
  - It immediately complicates the signature of the method, loudly proclaiming that this function does more than one thing.
    - It does one thing if the flag is true and another if the flag is false!
  - method call render(true) is just plain confusing to a poor reader.
  - We should have split the function into two: renderForSuite() and renderForSingleTest().

## Have No Side Effects
**Output Arguments**
- Arguments are most naturally interpreted as inputs to a function.
- In general output arguments should be avoided.
- If your function must change the state of something, have it change the state of its owning object.

```java
appendFooter(s);
// public void appendFooter(StringBuffer report)
report.appendFooter();
```

## Command Query Separation
- Either your function should change the state of an object, or it should return some information about that object. Doing both often leads to confusion.

```java
// sets the value of a named attribute and returns true if it is successful
// and false if no such attribute exists. 
if (set("username", "unclebob")) {
  ...
  // statement reads as “If the username attribute was previously set to unclebob”
  // which is misleading.
}

// Here, separate the command from the query so that the ambiguity cannot occur.
if (attributeExists("username")) {
  setAttribute("username", "unclebob");
  ...
}
// or alternatively rename set("username", "unclebob") to setIfExists("username", "unclebob")
```

## Prefers Exceptions over Returning Error Codes
- use exceptions instead of returned error codes, then the error processing code can be separated from the happy path code and can be simplified.
- It is better to extract the bodies of the try and catch blocks out into functions of their own.
- Functions should do one thing. Error handing is one thing. Thus, a function that handles errors should do nothing else. 
  - try should be the very first word in the function and that there should be nothing after the catch/finally blocks.
- If error codes used - change in Error enum will need all client classes to be recompiled and deployed.
- If exceptions used - new exceptions are derivatives of the exception class. They can be added without forcing any recompilation or redeployment.

## Don’t Repeat Yourself
- Duplication may be the root of all evil in software.

# Chapter 4 : Comments
- Minimize comments, better try to clean code and make self explanatory
- Comments are not maintainable.
- copyright and authorship statements are necessary and reasonable things to put into a comment at the start of each source file.

```java
// Check to see if the employee is eligible for full benefits
if ((employee.flags & HOURLY_FLAG) &&
(employee.age > 65))

if (employee.isEligibleForFullBenefits())
```

## Good Comments
- Legal Comments
- Clarification
- TODO
- Javadocs in Public APIs

# Chapter 5 : Formatting
pg 106