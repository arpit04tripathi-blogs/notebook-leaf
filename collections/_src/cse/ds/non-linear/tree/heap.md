---
layout: post
title: Heap
permalink: /ds/heap
---

- TOC
{:toc}

---

# Binary Heap
- complete tree (last level with all keys as left), it makes them suitable to be stored in an array.
- either Min Heap or Max Heap. 
- Min Binary Heap - key root minimum among all keys, same must be recursively true for all nodes in Binary Tree.
- mainly implemented using array.

|Operations||
|---|---|
|Get Minimum in Min Heap |O(1)     [Or Get Max in Max Heap]
|Extract Minimum Min Heap|O(Log n) [Or Extract Max in Max Heap]
|Decrease Key in Min Heap|O(Log n) [Or Extract Max in Max Heap]
|Insert                  |O(Log n) 
|Delete                  |O(Log n)

- used to implement efficient priority-queues, which are used for scheduling processes in os.
- priority queues are also used in Dijstra’s and Prim’s graph algorithms.
- used to efficiently find the k smallest (or largest) elements in an array, merging k sorted arrays, median of a stream, etc.
- it’s a special data structure that cannot be used for searching of a particular element.
