---
layout: post
title: Balanced Binary Tree
permalink: /ds/balanced-tree
---

- TOC
{:toc}

---

# Balanced Binary Tree
- difference of left and right subtree for each node is not more than 1.
- height of tree = O(Log2(n)) , where n is number of nodes.
- For Example, AVL tree maintains O(Log n) height by making sure that the difference between heights of left and right subtrees is 1. 

* **Red-Black trees** 
- maintain O(Log n) height by making sure that the number of Black nodes on every root to leaf paths are same and there are no adjacent red nodes. Balanced Binary Search trees are performance wise good as they provide O(log n) time for search, insert and delete.

* A **degenerate (or pathological) tree**
- A Tree where every internal node has one child. Such trees are performance-wise same as linked list.


# AVL Tree

- AVL tree avoids 'Skew Tree' by using the concept of `Rotation`.
- To keep trees balanced in order to get the benefit of BST.
- AVL tree is a balanced BST with balance factor = 1 for each node of the tree.
- Balance Factor is the difference between height of immediate left and right subtree.
- If balance factor becomes > 1, then we have to perform rotation for balancing the tree.

```java
if(root == null)
	return 0;
retrun 1 + math.max(height(root.left), height(root.right));
```
