---
layout: post
title: Stacks
permalink: /ds/stack
---

- TOC
{:toc}

---

# TODO
- Evaluate postfix
- Evaluate prefix
- infix to postfix

# Stack
- LIFO (Last in - First out)
- Insert or delete can be done from top only.
- Example - Tower of Hanoi
- LIFO (last in, first out). Operations – push and pop. implemented - array and linked list.
- Insertion         : O(1)
- Deletion         : O(1)
- Access Time     : O(n) [Worst Case] Insertion and Deletion are allowed on one end. 

**Example** : used for maintaining function calls. can always remove recursion with the help of stacks. 
used in reversal operations, check for balanced parenthesis, undo operation and back functionality in web browsers.

# Applications
- Function Calls / Recursion
- undo in editor
- balanced parantheses

# Stack Implementation

## As Array

## As List
- LIFO (Last in - First out)
- Insert or delete can be done from top only.
- Can perform operations at tail (O(n)) or
- Can perform operations at head (o(1)).
  - Recommended as we need push/pop in constant time.
  - addFirst, deleteFirst, getHead

# Reverse
LinkedList Reverse - Use Stack.
String Reverse - Use 2 pointers in character array.

# Applications
## Check Balanced Parantheses

## Infix, Postfix, Prefix Expression

Order of Operation
- Parantheses
- Exponents (Right Associativity)
- Multiplication/Division
- Addition/Substraction

```
Infix   : a+b*c
Postfix : abc*+
Prefix  : +a*bc
```
