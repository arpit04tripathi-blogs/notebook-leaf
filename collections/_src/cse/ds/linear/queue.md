---
layout: post
title: Queue
permalink: /ds/queue
---

- TOC
{:toc}

---

# Queue ADT
- First in First out (FIFO)
- Addition at rear, deletion at front
- Application 
  - shared resource keeps queue of request
  - cpu is shared resource
- Queue Implementations
  - As Array
  - As Circular Array
  - As LinkedList
  - No Circular Linked List as array was having capacity issue which is not there in Linked List.

|Operations||
|---|---|
|enqueue or push||
|dequeue or pop|get element and delete it|
|peek or front|get element but not delete it|
|isEmpty||

### Queue
- FIFO (first in, first out). Operations - enqueue, dequeue. Implementation - both array and linked list.
- Insertion         : O(1)
- Deletion          : O(1)
- Access Time     : O(n) [Worst Case]

**Example**: used in CPU scheduling, Disk Scheduling and when data is transferred asynchronously (data not necessarily received at same rate as sent) between two processes. Examples include IO Buffers, pipes, file IO, etc.

### Circular Queue
- reduces wastage of space in case of array implementation.
- insertion of the (n+1)’th element is done at the 0’th index if it is empty.

