---
layout: post
title: Algorithm Classifications
permalink: /algo/classification
---

- TOC
{:toc}

---

# Algorithms Design Techniques

## Classification by Implementation Method

1. **Recursion or Iteration**
   - Recursive
   - Iterative
2. **Procedural or Declarative (non-Procedural)**
   - Declarative
     - We tell what we want without telling how to do it.
     - example : SQL, queries don't specify the steps to produce result
   - Procedural
     - We have to specify the exact steps to get the result.
     - example : C, PHP, and PERL
3. **Serial or Parallel or Distributed**
   - Serial : we assume that computers execute one instruction at a time. 
   - Parallel : take advantage of computer architectures to process several instructions at a time.
     - They divide the problem into subproblems and serve them to several processors or threads.
     - Iterative algorithms are generally parallelizable.
   - Distributed : When the parallel algorithms are distributed on to different machines.
4. **Deterministic or Non-Deterministic**
   - Deterministic : solve the problem with a predefined process.
   - Non-Deterministic : guess the best solution at each step through the use of heuristics.
5. **Exact or Approximate**
   - Exact : algorithms for which we are able to find the optimal solutions 
   - Approximate : generally associated with NP-hard problems

## Classification by Design Method
1. **Greedy Method**
   - Work in stages. In each stage, a decision is made that is good at that point, without bothering about the future consequences.
   - local best is chosen. It assumes that the local best selection also makes for the global optimal solution.
2. **Divide and Conquer**
   - 3 Steps
     - Divide: Breaking the problem into sub problems that are themselves smaller instances of the same type of problem.
     - Recursion: Recursively solving these sub problems.
     - Conquer: Appropriately combining their answers.
   - No overlap of subproblems.
   - Examples: merge sort and binary search algorithms.
3. **Dynamic Programming**
   - Dynamic programming (DP) and memoization work together.
   - There will be an overlap of sub-problems.
   - By using memoization [maintaining a table for already solved sub problems], DP reduces the exponential complexity to polynomial complexity (O(n2), O(n3), etc.) for many problems.
   - The difference between dynamic programming and recursion is in the memoization of recursive calls. 
4. **Linear Programming**
   - there are inequalities in terms of inputs and maximizing (or minimizing) some linear function of the inputs.
   - Many problems (example: maximum flow for directed graphs) can be discussed using linear programming.
5. **Reduction [Transform and Conquer]**
   - we solve a difficult problem by transforming it into a known problem for which we have asymptotically optimal algorithms. 
   - example : the selection algorithm for finding the median in a list involves first sorting the list and then finding out the middle element in the sorted list.

## Other Classifications
1. **Classification by Research Area**
   - In computer science each field has its own problems and needs efficient algorithms.
   - Examples: search algorithms, sorting algorithms, merge algorithms, numerical algorithms, graph algorithms, string algorithms, geometric algorithms, combinatorial algorithms, machine learning, cryptography, parallel algorithms, data compression algorithms, parsing techniques, and more.
2. **Classification by Complexity**
3. **Randomized Algorithms**
   - A few algorithms make choices randomly.
   - For some problems, the fastest solutions must involve randomness.
   - Example: Quick Sort.
4. **Branch and Bound Enumeration and Backtracking**

# Greedy Algorithms

**Greedy Strategy**
- Greedy algorithms work in stages.
- In each stage, a decision is made that is good at that point, without bothering about the future. 
- Some local best is chosen, it assumes that alocal good selection makes for a global optimal solution.

**Elements of Greedy Algorithms**
1. Greedy choice property
   - Iteratively makes one Greedy choice after another and reduces the given problem to a smaller one.
2. Optimal substructure
   - A problem exhibits optimal substructure if an optimal solution to the problem contains optimal solutions to the subproblems.
   - That means we can solve subproblems and build up the solutions to solve larger problems.

**Does Greedy Always Work?**
- Making locally optimal choices does not always work. Specially in DP problems.

**Advantages**
- straightforward
- easy to understand
- easy to code
- once we make a decision, we do not have to spend time reexamining the already computed values.

**Disadvantages**
- In many cases there is no guarantee that making locally optimal improvements in a locally optimal solution gives the optimal global solution.

**Greedy Applications**
- Sorting: Selection sort, Topological sort
- Priority Queues: Heap sort
- Huffman coding compression algorithm
- Prim’s and Kruskal’s algorithms
- Shortest path in Weighted Graph (Dijkstra’s)
- Coin change problem
- Fractional Knapsack problem
- Disjoint sets-UNION by size and UNION by height (or rank)
- Job scheduling algorithm
- Greedy techniques can be used as an approximation algorithm for complex problems

# Divide and Conquer

A problem using following three steps
- Divide: Break the given problem into subproblems of same type.
- Conquer: Recursively solve these subproblems.
- Combine: Appropriately combine the answers.

## Standard D&C Alogorithms
 
Binary Search is a searching algorithm. 
- In each step, the algorithm compares the input element x with the value of the middle element in array. 
	- values match, return the index of middle.
	- if x is less than the middle element, then the algorithm recurs for left side of middle element, 
	- else recurs for right side of middle element.

Quicksort is a sorting algorithm. 
- Picks a pivot element
- Rearranges the array elements with all smaller elements to left side of pivot, and all greater elements to right side. 
- Finally, the algorithm recursively sorts the subarrays on left and right of pivot element.

Merge Sort is also a sorting algorithm. 
- The algorithm divides the array in two halves, recursively sorts them and finally merges the two sorted halves.

Closest Pair of Points (To find the closest pair of points in a set of points in x-y plane)
- Normal Solution, O(n^2) time, by calculating distances of every pair of points and comparing to find the minimum. 
- The Divide and Conquer algorithm solve the problem in O(n Logn) time.

Strassen’s Algorithm (an efficient algorithm to multiply two matrices)
- Simple method to multiply two matrices need 3 nested loops and is O(n^3). 
- Strassen’s algorithm multiplies two matrices in O(n^2.8974) time.

Cooley–Tukey Fast Fourier Transform (FFT) algorithm is the most common algorithm for FFT. 
- It is a divide and conquer algorithm which works in O(n logn) time.

Karatsuba algorithm for fast multiplication 
- Multiplication of two n-digit numbers in at most 3n^(log2 3) = 3n^(1.585)                                                      
- single-digit multiplications in general (and exactly n^(log2 3) when n is a power of 2).                             
- It is therefore faster than the classical algorithm, which requires n2 single-digit products. If n = 2^10 = 1024, in particular, the exact counts are 3^10 = 59,049 and (2^10)^2 = 1,048,576, respectively.

Divide and Conquer (D & C) vs Dynamic Programming (DP)
- Both paradigms (D&C and DP) divide the given problem into subproblems and solve subproblems. 

How to choose one of them for a given problem? 
- D&C should be used when same subproblems are not evaluated many times. 
- Otherwise Dynamic Programming or Memorization should be used. 
- For example, Binary Search is a Divide and Conquer algorithm, we never evaluate the same subproblems again. On the other hand, for calculating nth Fibonacci number, Dynamic Programming should be preferred.

# Brute Force Algorithms

Brute Force Algorithms refers to a programming style that does not include any shortcuts to improve performance, but instead relies on sheer computing power to try all possibilities until the solution to a problem is found.

A classic example is the traveling salesman problem (TSP). Suppose a salesman needs to visit 10 cities across the country. How does one determine the order in which cities should be visited such that the total distance traveled is minimized? The brute force solution is simply to calculate the total distance for every possible route and then select the shortest one. This is not particularly efficient because it is possible to eliminate many possible routes through clever algorithms.

Another example: 5-digit password, in the worst-case scenario would take 105 tries to crack.
The time complexity of brute force is **O(n*m)**. So, if we were to search for a string of ‘n’ characters in a string of ‘m’ characters using brute force, it would take us n * m tries.