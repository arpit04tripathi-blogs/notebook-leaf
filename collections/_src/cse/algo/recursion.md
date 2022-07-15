---
layout: post
title: Recursion
permalink: /algo/recursion
---

- TOC
{:toc}

---

# Introduction
- Used when we can break a problem into similar sub-problems.
- Recursion is used in `Divide-N-Conquer`, `Greedy`, `Dynamic Programming`

```java
returntype recursiveFunction(int n){
    if(base condition)
        return base result;
    else
        recursiveFunction(n/2);
}
```

![]({{site.cdn}}/cse/algo/recursion/recursion-vs-iteration.png)

# When to use Recursion
- When we can breakdown problem into similar sub-problems.
- When we are ok with extra overhead(both in time and space) that comes with it.
- when we need a quick working solution instead of efficient one.

## Practical use of recursion
- Stack
- Tree - traverse/search/insert/delete
- Sorting - Quick Sort, Merge Sort etc.
- Divide and Conquer
- Dynamic Programming

# Applications

## Factorial
- For non-negative integers only.

```java
// Iterative
int factorial(int n){
    int result = 1;
    for(int i=n; i>0; i--){
        result *= i;
    }
    return result;
}
```
```java
// Recursive
int factorial(int n){
    if(n == 0)
        return 1;
    return n * factorial(n-1);
}
```

## Fibonacci Series
- First two numbers are 0 and 1.
- each element is sum of previous 2 elements.
- [nth fibonacci number](https://www.geeksforgeeks.org/program-for-nth-fibonacci-number/)

```
0 1 1 2 3 5 8 13 21 34 55 89 144 ...
```

***nth fibonacci series***
```java
int fibonacci(int n){
    if(n<0){
        throw error;
    } else if(n < 3){ // 1st and 2nd number
        // 1st number is 0th index
        return n-1;
    }else{
        return fibonacci(n-2) + fibonacci(n-1);
    }
}
```

***n elements of fibonacci***

## Power

> Do read full [article](https://guide.freecodecamp.org/algorithms/exponentiation)

* pow(2,6) = pow(2,3) x pow(2,3);
* pow(2,7) = 2 x pow(2,3) x pow(2,3);
```java
// O(logn)
int power(int x, unsigned int y) { 
    int temp; 
    if( y == 0) 
        return 1; 
    temp = power(x, y/2); 
    if (y%2 == 0) 
        return temp*temp; 
    else
        return x*temp*temp; 
} 
```
```java
Math.pow(a, b);
```
