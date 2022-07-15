---
layout: post
title: Segment Tree
permalink: /ds/segment-tree
---

- TOC
{:toc}

---

# Segment Tree

- when there are a lot of queries on a set of values. 
- queries involve minimum, maximum, sum, .. etc on a input range of given set. 
- Queries also involve updation of values in given set. 
- Segment Trees are implemented using array.

![segment-tree.png]({{site.cdn}}/cse/ds/tree/segment-tree.png)

# Operations

|Segment Tree||
|---|---|
|Creation   | O(N)
|Query      | O(log N)
|Update     | O(log N)
|Space      | O(N) [Exact space = 2*N-1]

# Segment Tree Examples
It is used when we need to find Maximum/Minumum /Sum/Product of numbers in a range.

