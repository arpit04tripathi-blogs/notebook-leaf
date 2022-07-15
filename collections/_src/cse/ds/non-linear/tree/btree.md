---
layout: post
title: Binary Tree
permalink: /ds/btree
---

- TOC
{:toc}

---

# Introduction

- Non-Linear data structure.
- way of representing the hierarchical nature of a structure.
- order of the elements is not important.
- Recursive Data Structure.

![]({{site.cdn}}/cse/ds/tree/btree/binary-tree.png)

## Terms Used
- **root** - supernode of the tree ie. node without a parent.
- **edge** - link from parent to child.
- **leaf** - no children.
- **children** - 
- **parent** - 
- **sibling** - children of same parent
- **grandparent** -
- **ancestor** - `root -> ancestor -> descendent`, ancestor in path from root to descendent.
- **descendent** - 
- **Depth** - Length of path from root to node ie. number of edges in the path. 
- **Height** - Number of edges in longest path from node to leaf. root has height 0.
- **level** - set of all nodes at given depth. root is at level 0.

Note: for a tree `height == depth` always. It differs only for the individual nodes.

## Applications
- Storing naturally hierarchical data - file systems.
- Dictionary - Trie
- Network Routing Algorithms
- JavaScript Document Object Model considers HTML page as a tree with nesting of tags as parent child relations.
- Expression trees are used in compilers.
- Huffman coding trees that are used in data compression algorithms.
- Binary Search Tree (BST) - O(logn) (average) search, insertion and deletion.
- Priority Queue (PQ) - log(n) (in worst case) search and deletion of minimum (or maximum).

# Types of Tree
- BTree - Binary Tree
- BST - Binary Search Tree
- Heap Tree
- AVL Tree
- Red Black Tree
- Syntax Tree
- Huffman Coding Tree

# Binary Tree
- At most two children.
- Empty tree if root is null.
- **Depth First Traversal** : Inorder (Left-Root-Right), Preorder (Root-Left-Right) and Postorder (Left-Right-Root)
- **Breadth First Traversal** : Level Order Traversal

# Modifiable Collection

|           |Search(x)  |Insert(x)  |Delete(x)  |
|---        |---        |---        |---        |
|Array      |O(n)       |O(1) / O(n)|O(n)       |
|LinkedList |O(n)       |O(1) - head|O(n)       |
|Tree (BST) |O(log(n))  |O(log(n))  |O(log(n))  |

# Binary Tree Classifications

![]({{site.cdn}}/cse/ds/tree/btree/btree-classification.png)

|Classification||
|---|---|
|Binary Tree|each node can have at-most 2 children.|
|Strict/Proper BT|each node have 0 or 2 children.|
|Perfect Binary Tree|All levels are completely filled, all leafs are at the same level.|
|Complete Binary Tree|every level, except possibly the last, is completely filled, and all nodes are as far left as possible.|

## Full v.s. Complete Binary Trees

![full-complete-perfect]({{site.cdn}}/cse/ds/tree/btree/full-complete-perfect.png)

* In a Full Binary, number of leaf nodes is number of internal nodes plus 1

```
L = I + 1
```

## Properties of Binary Tree
**Max number of Nodes**
```
for level h = 2^h
for full binary tree = 2^(h+1) - 1 = (2^0 + 2^1 + .... + 2^h)
for complete binary tree = 2^h to 2^(h+1)-1
```
**height**
```
h = log2(n+1) - 1
h(Complete BT) = floor(log2(n))
h(empty tree) = -1;
h(Single node tree) = 0;

For n nodes,
min height = floor(log2(n)) --> O(log2(n)) ~ O(h)
Minimum possible height     --> ceil(log2(n+1))
max height = n-1            --> O(n)        Skew Tree
```
**Leaf Nodes**
```
count(leaf nodes) = 1 + count(nodes with 2 children)
```
***Cost of operations on Binary Tree are dependent on Height of the Binary Tree.***

# Operations
## Traversal

- Process of visiting all nodes is called ***tree traversal***.
- Each node is processed only once, but maybe visited more than once.
- Traversal Possibilities : LDR - RDL, DLR - DRL, LRD - RLD.
- Classification of traversal is done based on position of D
  - DLR - preorder traversal
  - LDR - inorder traversal
  - LRD - postorder traversal
- Level Order Traversal

### Depth First Search
#### Preorder Traversal

```java
// DLR
public void preOrder(BTNode root){
    if(root==null) return;
    System.out.print(root.data+" ");
    preOrder(root.left);
    preOrder(root.right);
}
```

#### Inorder Traversal

```java
// LDR
public void inOrder(BTNode root){
    if(root==null) return;
    inOrder(root.left);
    System.out.print(root.data+" ");
    inOrder(root.right);
}
```

#### Postorder Traversal

```java
// LRD
public void postOrder(BTNode root){
    if(root==null) return;
    postOrder(root.left);
    postOrder(root.right);
    System.out.print(root.data+" ");
}
```

### Breadth First Search
#### Level Order Traversal

**Pseudo Code**
```
1. Keep a queue for level nodes.
2. add to queue - root and null (represents level end).
3. read from queue till empty, on each read add left and right child from next level (l+1).
4. on reading null, if queue is not empty then add null to queue to mark new level end.
```

Last Node processed from the queue in Level Order Traversal is the **Deepest Node in the binary tree**.

**Implementation - Return All Levels**
```java
public ArrayList<ArrayList<Integer>> levelOrder(BTNode root){
    ArrayList<ArrayList<Integer>> levels = new ArrayList<>();
    if(root==null)
        return levels;
    Queue<BTNode> q = new LinkedList<>();
    q.offer(root);
    q.offer(null);
    ArraysList<Integer> curr = new ArrayList<>();
    while(!q.isEmpty()){
        BTNode temp = q.poll();
        if(temp == null){
            // level ended - push curr level to levels
            levels.add(new ArrayList<Integer>(curr));
            curr.clear();
            if(!q.isEmpty())
                q.offer(null);
        } else {
            curr.add(temp);
            if(temp.left != null) q.offer(temp.left);
            if(temp.right != null) q.offer(temp.right);
        }
    }
    return levels;
}
```
**Implementation - Only Print**
```java
public static void levelOrder(Node root) {
  if(root==null) return;
  Queue<Node> q = new LinkedList<>();
  q.offer(root);
  while(!q.isEmpty()){
      Node curr = q.poll();
      System.out.print(curr.data+ " ");
      if(curr.left != null) q.offer(curr.left);
      if(curr.right != null) q.offer(curr.right);
  }
}
```

```java
import java.util.*;
public static int height(Node root) {
  	if(root==null || isLeaf(root)) return 0; // single node h = 0
    return 1 + Math.max(height(root.left), height(root.right));
}

public static boolean isLeaf(Node root){
    return root.left==null && root.right==null;
}
```

## Search

### Find in Binary Tree

```java
public static boolean findinBTree(BTreeNode root, int data){
    if(root == null)
        return false;
    if(root.data == data)
        return true
    return findinBTree(root.left, data) || findinBTree(root.right, data);
}
```

### max in Binary Tree

```java
public int maxInBTree(BTreeNode node){
    int max = Integer.MIN_VALUE;
    if(root != null){
        int leftMax = maxInBTree(root.left);
        int rightMax = maxInBTree(root.right);
        max = leftMax>rightMax ? leftMax : rightMax;
        if(root.data > max)
            max=root.data;
    }
    return max;
}
```

## Insert

- For Binary Tree, order is not important.
- Insert the element ***wherever*** we find ***left or right child as null***.
- ***Can also be by level order traversal***. (bfs)

### Level Order

```java
public void insertInBTree(BTreeNode root, int data){
    if(root == null)
        return new BTreeNode(data);
    Queue<BTreeNode> q = new LinkedList<>();
    q.offer(root);
    while(!q.isEmpty()){
        BTreeNode temp = q.poll();
        if(temp.left == null)
            root.left = new BTreeNode(data);
        else if(root.right == null)
            root.right = new BTreeNode(data);
    }
    return root;
}
```

### Recursive

```java
public static BTreeNode insert(BTreeNode root,int data) {
    if(root == null)
        return new BTreeNode(data);
    else
        insertHelper(root, data);
    return root;
}

private static void insertHelper(BTreeNode root, int data){
    if(data < root.data){
        // insert in left
        if(root.left == null)
            root.left = new BTreeNode(data);
        else
            insertHelper(root.right, data);
    } else {
        //insert in right
        if(root.right == null)
            root.right = new BTreeNode(data);
        else
            insertHelper(root.left, data);
    }
}
```

## Delete

**Pseudo Code**
```
- Starting at root, find node to be deleted.
- Find deepest node.
- Swap data between them.
- delete the deepest node.
```

***Implement TODO***

```java
public static int deleteInBTree(BTreeNode root, int data){
    if(root == null)
        return Integer.MIN_VALUE;
    BTreeNode target, deepest;
    Queue<BTreeNode> q = new LinkedList<>();
    q.offer(root);
    q.offer(null);
    while(!q.isEmpty){
        BTreeNode temp = q.poll;
        if(temp != null){
            deepest = temp;
            if(temp.data == data)   target = temp;
            if(temp.left!=null)     q.offer(temp.left);
            if(temp.right!=null)    q.offer(temp.right);
        } else {
            if(!q.isEmpty())    q.offer(null);
        }
    }
    if(target == null) return Integer.MIN_VALUE;
    target.data = deepest.data;
    deepest = null; // TODO: Delete deepest
    return data;
}
```

## Height

```java
import java.util.*;

// single node h=0
public static int height(Node root) {
    if(root == null || isLeaf(root))
        return 0;
    return 1 + Math.max(height(root.left), height(root.right));
}

public static boolean isLeaf(Node root){
    return root.left == null && root.right == null;
}

// single node h=1
public static int height(Node root) {
    if(root == null)
        return 0;
    return 1 + Math.max(height(root.left), height(root.right));
}
```

## Minimum Depth

- Minimum depth is the depth of first leaf node in the level order traversal.

```java
public static int minimumDepth(Node root) {
    if(root == null)
        return 0;
    Queue<BTreeNode> q = new LinkedList<>();
    q.offer(root);
    q.offer(null);
    int levelDepth = 0;
    while(!q.isEmpty()){
        BTreeNode temp = q.poll();
        if(temp != null){
            if(isLeaf(temp))
                return levelDepth;
            if(temp.left !=null)
                q.offer(temp.left);
            if(temp.right !=null)
                q.offer(temp.right);
        } else {
            if(!q.isEmpty()){}
                levelDepth++;
                q.offer(null);
            }
        }
    }
    return levelDepth;
}

private static boolean isLeaf(BTreeNode root){
    return root.left==null && root.right==null;
}
```

## Size

```java
public static int size(BTreeNode root) {
    if(root == null)
        return 0;
    return 1 + size(root.left) + size(root.right);
}
```

## Delete Tree

- To delete tree, we must traverse all the nodes and delete them.
- Which traverse to use - preorder, inorder, postorder, level order?
- Before deleting the parent node we need to delete its children nodes.
- PostOrder Traversal - does the work without storing anything.
- We can also delete tree with other traversals with extra space complexity.

```java
public void deleteBTree(BTreeNode root){
    if(root==null)
        return;
    deleteBTree(root.left);
    deleteBTree(root.right);
    root = null;
}

private boolean isLeaf(BTreeNode root){
    return root.left==null && root.right==null;
}
```

```java
public void deleteBTree(BTreeNode root){
    root = null; // garbage collector takes care of it
}
```

## Level Order - Print levels bottom up
```
4 5 6 7
2 3
1
```

- Level Order
  - input - `1` `2 3` `4 5 6 7`
  - output - `4 5 6 7` `2 3` `1`
- Do a level order Traversal, offer right child first in the q and then left child. push to stack during poll. Print the stack when queue is empty.

```java
public static void levelOrderTraversalInReverse(BTreeNode root){
    if(root == null)
        return;
    Stack<BTreeNode> stack = new Stack<>();
    Queue<BTreeNode> q = new LinkedList<>();
    q.offer(root);
    while(!q.isEmpty()){
        BTreeNode temp = q.poll();
        if(temp.right != null)
            q.offer(temp.right);
        if(temp.left != null)
            q.offer(temp.left);
        s.push(temp);
    }
    while(!s.isEmpty())
        System.out.println(s.pop().data + "");
}
```

## Structurally Identical

- Structurally Identical doesn't mean that they have same data.

```java
public boolean checkStructurallyIdentical(BTreeNode root1, BTreeNode root2) {
    if(root1 == null && root2 == null)  return true;
    if(root1 == null || root2 == null)  return false;
    return checkStructurallyIdentical(root1.left, root2.left) && checkStructurallyIdentical(root1.right, root2.right);
}
```

## Mirror

### Check areMirror
- left is right, right is left.

```java
public boolean areMirrors(BTreeNode root1, BTreeNode root2) {
    if(root1 == null && root2 == null)  return true;
    if(root1 == null || root2 == null)  return false;
    if(root1.data != root2.data) return false;
    return areMirrors(root1.left, root2.right) && areMirrors(root1.right, root2.left);
}
```

### Create Mirror
- bottom up approach here - first mirror left and right, then exchange left <--> right for root.

```java
public BTreeNode mirrorOfBTree(BTreeNode root) {
    if(root == null)
        return null;
    mirrorOfBTree(root.left);
    mirrorOfBTree(root.right);
    BtreeNode temp = root.right;
    root.right = root.left;
    root.left = temp;
    return root;
}
```

## All Paths Root to Leaf

```java
public void printPaths(BTreeNode root) {
    int[] path = new int[256];
    printPaths(root, path, 0);
}

// level acts as index, 0 is root element
private void printPaths(BTreeNode root, int[] path, int level){
    if(root==null)
        return;
    path[level] = root.data;
    level++;
    if(isLeaf(root)){
        System.out.println(Arrays.toString(path));
    } else{
        printPaths(root.left, path, level);
        printPaths(root.right, path, level);
    }
}

private boolean isLeaf(BTreeNode root){
    return root.left==null && root.right==null;
}
```

## Path with Sum

### Print all Paths with sum (even for intermediate nodes)
- with each step in dfs, substract sum by node data and print the path whenever sum==0.

```java
public void printPathsWithSum(BTreeNode root, int sum) {
    int[] path = new int[256];
    printPaths(root, path, 0, sum);
}

// level acts as index, 0 is root element
private void printPaths(BTreeNode root, int[] path, int level, int sum){
    if(root==null)
        return;
    path[level] = root.data;
    level++;
    sum -= root.data;
    if(sum == 0)){
        System.out.println(Arrays.toString(path));
    printPaths(root.left, path, level, sum);
    printPaths(root.right, path, level, sum);
}

private boolean isLeaf(BTreeNode root){
    return root.left==null && root.right==null;
}
```

### hasPathSum

```java
public boolean hasPathSum(BTreeNode root, int sum) {
    if(root==null) return false;
    if(isLeaf(root) && sum==root.data)
        return true;
    sum -= root.data;
    return hasPathSum(root.left, sum) || hasPathSum(root.right, sum);
}

private boolean isLeaf(BTreeNode root){
    return root.left==null && root.right==null;
}
```

## Width and Diameter

### Width
- with each step in dfs, substract sum by node data and print the path whenever sum==0.

```java
public void widthOfBTree(BTreeNode root) {

}
```

### Diameter
- includes null as 1 unit.

```java
public boolean diameterOfBTree(BTreeNode root) {

}
```

## BTree Views

### Top View

make list on vertical index, pick top of the lists

### Bottom view

make list on vertical index, pick last of the lists

### Left View

first elements in level-order traversal

### Right View

last elements in level-order traversal

```java
import java.util.*;

// single node h=0
public static int minimumDepth(Node root) {
    if(root == null || isLeaf(root))
        return 0;
    return 1 + Math.max(height(root.left), height(root.right));
}
```

# Serialize and Deserialize BTree

# Convert Binary Tree
- [Convert binary tree](https://www.geeksforgeeks.org/convert-binary-tree-threaded-binary-tree-2/){:target="_blank"}