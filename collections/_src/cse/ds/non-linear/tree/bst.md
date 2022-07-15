---
layout: post
title: BST - Binary Search Tree
permalink: /ds/bst
---

- TOC
{:toc}

---

# BST - Binary Search Tree
- For each node, `left < root` and  `root < right`.
- left and right subtree must be BST.
- left-subtree < parent < right-subtree. 
- BST provide moderate access/search (quicker than Linked List and slower than arrays).
- BST provide moderate insertion/deletion (quicker than Arrays and slower than Linked Lists).
- main use is in search application where data is constantly entering/leaving and data needs to printed in sorted order.
- example: e-commerce websites where a new product is added or product goes out of stock and all products are listed in sorted order.

|Time Complexities||
|---|---|
|Search     |  O(h)
|Insertion  | O(h)
|Deletion   | O(h)
|Extra Space| O(n) for pointers
|h          | Height of BST
|n          | Number of nodes in BST
|Height Balanced BST| h = O(Log n)| 

Self-Balancing BSTs such as AVL Tree, Red-Black Tree and Splay Tree make sure that height of BST remains O(Log n)

# Binary Search Tree (BST)
- BST
- left node <= root
- right node > root

# BST Implementation
- Dynamically generated nodes
- arrays - used for heaps

## Array Implementation
- number the nodes level-wise.
- for complete binary tree
  - left = 2i+1
  - right = 2i+2

# BST Operations

## BST Traversal

### Breadth First Search
- Level Order Traversal

### Depth First Search
- Preorder traversal - dLR
- Inorder traversal - LdR - Ascending Order
- Postorder traversal - LRd
- Time Complexity - O(n)
- Space Complexity - O(h)
  - Worst - O(n)
  - Average - O(log n)

## isBST Check

![]({{site.cdn}}/cse/ds/tree/bst/isBST.png)

Use Range query rather than isSubtreeLesser and isSubtreeGreater.

![]({{site.cdn}}/cse/ds/tree/bst/isBST-range-query.png)

## Delete Node

- if leaf node, delete it.
- if having single child, set single child a subtree.
- if 2 child,
  - set current = min(rightSubtree) and delete that value in right subtree.

## Inorder Successor
