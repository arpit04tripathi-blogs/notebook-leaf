---
layout: post
title: Abstract Data Types
permalink: /ds/abstract-data-types
---

- TOC
{:toc}

---


* `Abstract Data Types` (ADT) – Define data and operations but no implementation.
* ADT is a type (or class) for objects whose behavior is defined by a set of value and a set of operations.
* Definition of ADT mentions what operations are to be performed but not how to implemented.

# List ADT
A list contains elements of same type arranged in sequential order and following operations can be performed on the list.
- **get()** - Return an element from the list at any given position.
- **insert()**   - Insert an element at any position of the list.
- **remove()**   - Remove the first occurrence of any element from a non-empty list.
- **removeAt()** - Remove the element at a specified location from a non-empty list.
- **replace()**  - Replace an element at any position by another element.
- **size()**     - Return the number of elements in the list.
- **isEmpty()**  - Return true if the list is empty, otherwise return false.
- **isFull()**   - Return true if the list is full, otherwise return false.

# Stack ADT
A Stack contains elements of same type arranged in sequential order. All operations takes place at a single end that is top of the stack and following operations can be performed:
- **push()**    - Insert an element at one end of the stack called top.
- **pop()**     - Remove and return the element at the top of the stack, if it is not empty.
- **peek()**    - Return the element at the top of the stack without removing it, if the stack is not empty.
- **size()**    - Return the number of elements in the stack.
- **isEmpty()** - Return true if the stack is empty, otherwise return false.
- **isFull()**  - Return true if the stack is full, otherwise return false.

# Queue ADT
A Queue contains elements of same type arranged in sequential order. Operations takes place at both ends, insertion is done at end and deletion is done at front. Following operations can be performed:
- **enqueue()** - Insert an element at the end of the queue.
- **dequeue()** - Remove and return the first element of queue, if the queue is not empty.
- **peek()**    - Return the element of the queue without removing it, if the queue is not empty.
- **size()**    - Return the number of elements in the queue.
- **isEmpty()** - Return true if the queue is empty, otherwise return false.
- **isFull()**  - Return true if the queue is full, otherwise return false.

There can be different ways to implement an ADT.
- List ADT can be implemented using arrays, or singly linked list or doubly linked list.
- Stack ADT can be implemented using arrays or linked lists.
- Queue ADT can be implemented using arrays or linked lists.
