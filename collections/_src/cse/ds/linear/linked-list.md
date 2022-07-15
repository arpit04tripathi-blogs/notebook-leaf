---
layout: post
title: Linked List
permalink: /ds/list
---

- TOC
{:toc}

---

# Introduction

- Linear Data Structure
- Dynamic Size

**Types of Linked List**
- ***Singly Linked List (SLL)***
- **Circular SLL** - Used in elimination based board game (turn by turn chances to player). Example, After the Player 4 we should give chance to Player 1.
- **Doubly Linked List (DLL)** - Music Player next and prev button.
- **Circular DLL** - When we want to loop through the list indefinitely until the list exists, example - Alt+Tab in windows.

### Linked List
- Linear DS (like arrays) where each element is a separate object.
- Node - data + reference to next node.

* **Singly Linked List**: node has reference of next node only. last node has next as NULL. example 1->2->3->4->NULL
* **Doubly Linked List**: node has prev and next reference, can traverse both directions. example. NULL<-1<->2<->3->NULL
* **Circular Linked List**:  all nodes connect to form a circle. no NULL at the end. can be either singly or doubyl. any node can be made as starting node, useful in implementation of circular queue in linked list. example. 1->2->3->1

- Accessing time of an element: O(n)    //no random access
- Search time of an element   : O(n)
- Insertion of an Element     : O(1) [If we are at the position where we have to insert an element] 
- Deletion of an Element      : O(1) [If we know address of node previous the node to be deleted] 

General Operations
- Create a List
- Insert
- Traverse
- Search
- Delete
- Delete entire List

## Array vs List

||Array|List|
|---|---|---|
|Size|Fixed Size, unused memory|No unused memory, extra 4 bytes per item for pointer|
|Memory|Contiguous, may not be available for large size requirements|Sparse|
|Access|O(1)|O(n) - traverse to element|
|Insert(Head)|O(n)|O(1)|
|Insert(Tail)|O(n)|O(n)|
|Insert(Mid)|O(n)|O(n)|

# SLL - Singly Linked List

![]({{site.cdn}}/cse/ds/list/singly-linked-list.png)


|SLL Operations|||
|---|---|---|
|Insert at head|O(1)|
|Insert at tail|O(n)|Traverse till last and delete, if tail pointer then O(1)|
|Insert at index n|O(n)|
|Delete at head|O(1)|
|Delete at tail|O(n)|Traverse till the element and then delete|
|Delete at index n|O(n)|
|Search|O(n)||

To improve insert/delete at tail to O(1), we can have tail reference along with head reference.

|Reverse a List|Iterative|Recurive|
|---|---|---|
|Time Complexity|O(n)|O(n)|
|Space Complexity|O(1)|O(n)|

## Operations

### Insert

### Delete

### Search

# DLL - Doubly Linked List

- contains pointer to both prev and next node, extra memory requirement.
- forward and reverse lookup.
- For int data, each node is 12 bytes(4bytes + 4bytes + 4bytes)

For Deleting DLL completely, delete prev field of every node and then delete head and tail references.

# CLL - Circular Linked List

# CDLL - Circular Doubly Linked List

# Memory Efficient DLL - XOR

