---
layout: post
title: Searching Algorithms
permalink: /algo/search
---

- TOC
{:toc}

---

- **Linear Search**
  - Time Complexity : O(n)
- **Binary Search**
  - Time Complexity : O(Log n)
  - Auxiliary Space : 
    - iterative : O(1) for  implementation. 
    - recursion : O(Logn)  due to call stack space

# Linear Search

```
Time Complexity = O(n)
```
![linear-search.png]({{site.cdn}}/cse/algo/search/linear-search.png)

# Binary Search

**Problem Statement**: Given a sorted array arr[] of n elements, write a function to search a given element x in arr[].

### Solution Steps
- Search a sorted array by repeatedly dividing the search interval in half. 
- Begin with an interval covering the whole array. 
- If the value of the search key is less than the item in the middle of the interval, narrow the interval to the lower half.
- Otherwise narrow it to the upper half. Repeatedly check until the value is found or the interval is empty.

### Code Steps
1. Compare x with the middle element.
2. If x matches with middle element, we return the mid index.
3. Else If x is greater than the mid element, then x can only lie in right half subarray after the mid element. So, we recur for right half.
4. Else (x is smaller) recur for the left half.

``` 
Time Complexity - O(Log n)
Auxiliary Space: 
    - O(1) for iterative implementation. 
    - O(Logn) recursion call stack space, recursive implementation.
```

![binary-search.png]({{site.cdn}}/cse/algo/search/binary-search.png)

## Recursive Solution

```java
if (r>=l) { 
    int mid = l + (r - l)/2; 
    if (arr[mid] == x) // If the element is present at the middle itself 
        return mid; 
    if (arr[mid] > x) // If element is smaller than mid, then it can only be present in left subarray
        return binarySearch(arr, l, mid-1, x); 
    // Else the element can only be present in right subarray 
    return binarySearch(arr, mid+1, r, x); 
}
```
```
Time Complexity - O(Log n)
Auxiliary Space - O(Logn) due to recursion stack 
```

## Iterative Solution

```java
int l = 0, r = arr.length - 1; 
while (l <= r){ 
    int m = l + (r-l)/2; 
    if (arr[m] == x) // Check if x is present at mid
        return m; 
    if (arr[m] < x) // If x greater, ignore left half 
        l = m + 1; 
    // If x is smaller, ignore right half 
    else
        r = m - 1; 
} 
```
```
Time Complexity - O(Log n)
Auxiliary Space: O(1)
```

## Why is Binary Search preferred over Ternary Search?
Ternary makes Logn/Log3 recursive calls, but binary search makes Logn/Log2 recursive calls.
```java
// Binary
T(n) = T(n/2) + 2,  T(1) = 1
Time Complexity for Binary search = 2c(logn/log2) + O(1)
```
```java
// Ternary
T(n) = T(n/3) + 4, T(1) = 1
Time Complexity for Ternary search = 4c(logn/log3) + O(1)
```

Value of 2(Logn/Log3) can be written as (2 / Log23) * Log2n. Since the value of (2 / Log23) is more than one, Ternary Search does more comparisons than Binary Search in worst case.

## Problem in Many Binary Search Implementations
- The expression “m = (l+r)/2”. It fails for large values of l and r. Specifically, it fails if the sum of low and high is greater than the maximum positive int value (231– 1). The sum overflows to a negative value, and the value stays negative when divided by two. In C this causes an array index out of bounds with unpredictable results.
- **Solution**: 
	- `int mid = low + ((high - low) / 2);` OR 
	- `int mid = (low + high) >>> 1;`
