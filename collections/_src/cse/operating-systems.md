---
layout: post
title: Operating System
permalink: /os
---

- TOC
{:toc}

---

# Introduction to OS

First thing a computer has to do when it is turned on, is start up a special program called an operating system. 

OS’s job - To help other computer programs to work by handling the details of controlling the computer’s hardware.

### Computer Systems
- Hardware – cpu, memory, io-devices
- Softwares 
	- System Softwares – OS, Compiler, Loader. 
	- Application Software – email, ms-office, games, railway reservation system.
- Users – people, computer

***Operating system*** is an interface between user and hardware.

### Responsibilities of OS:
- Provide an environment in which user can execute programs. 
- Resource allocator
- Manager – Memory, processes, files, security etc.

![os-functions]({{site.cdn}}/cse/os/os-functions.png)

### Goals of OS:
- Primary - convenience
- Secondary - efficiency

## System Boot Step Sequence

![system-boot-process]({{site.cdn}}/cse/os/system-boot-process.png)
```
System and Application Programs
Computer Hardware
Operating System
User 1
User 2
User 3
```

**Data Types** – Defines the Type of data and operations allowed on it.

# Types of Operating Systems

![types-of-os]({{site.cdn}}/cse/os/types-of-os.png)

## Batch OS
- Jobs with similar needs batched together, run as a group.
- First come first served.

### Disadvantages
- Only after completion of job1, control is transferred to job2.
- Under-utilisation of resources.
- Lack of interaction between user and program.

## Multitasking OS
- Jobs should be executed in time sharing mode.
- Fixed time quantum to every job (Preemption).

# Topics

**Introduction to OS**
- [Introduction to OS](intro)
- [Types of OS](types-of-os)
- Services and Examples
- Types of OS
  - Single Tasking
  - Multiprogramming and Multitasking
  - Multithreading
    - Real-world examples
    - Disadvantages
    - Examples of Race Condition
  - Multiprocessing
  - Multiuser
- Thread V/S Process
- User Threads V/S Kernel Threads

**Process Management**
- Introduction to Program and Process
- Process States
  - For Single Tasking Systems.
  - Multiprogramming Systems 
  - 5-States Model
  - 7-States Model
- Process Control Block(PCB)
- Process Scheduler
  - Long Term Scheduler
  - Short Term Scheduler
  - Medium Term Scheduler
- Scheduling Algorithms
  - Background
  - Explaining various times in Scheduling algorithms
  - Goals of Scheduling Algorithms
- FCFS Algorithm (Non-Preemptive)
  - Understanding using a problem
  - Calculating various times
  - Characteristics of FCFS Algo
- SJFS Algorithm (Non-Preemptive)
  - Understanding using a problem
  - Calculating various times
  - Characteristics of SJFS Algo
- SJF or SRTF Algorithm(Pre-emptive)
  - Understanding using a problem
  - Calculating various times
  - Characteristics of SJF or SRTF Algo
- Priority Scheduling (Non-Preemptive)
  - Understanding using a problem
  - Calculating various times
- Priority Scheduling (Preemptive)
  - Understanding using a problem
  - Calculating various times
- Problems with Priority Scheduling
- Round Robin Scheduling (Pre-emptive)
  - Characteristic
  - Calculating various times using a problem
- Multilevel Queue Scheduling
- Multilevel Queue Scheduling with Feedback

**Process Synchronization**
- Introduction
- Consumer and Producer Problem
- Race Condition
- Goals of Synchronization Mechanism
  - Mutual Exclusion
  - Progress
  - Bounded Waiting
  - Performance
- Overview of Synchronization Mechanism
  - Disabling Interrupts
  - Locks(or Mutex)
  - Semaphores
  - Monitors
  - Application of Process Synchronization
- Locks for Synchronization
  - Problems of Deposit and Withdrawl problem
  - TSL Lock mechanism
- Critical Section
  - Problems of Deposit and Withdrawl problem
  - Entry Section
  - Critical Section
  - Exit Section
  - Non-Critical Section
- Semaphores
  - wait() and signal() function
  - Original importance by Dijkstra
- Binary Semaphore
  - Internal Working of Semaphore
  - Binary Semaphore
  - Wait and Signal Protocol in Binary Semaphore
- Monitors
  - Introduction, Syntax and Working

**Deadlock**
- Introduction and Understanding
  - Mutual Exclusion
  - Hold and Wait
  - No Preemption
  - Circular Wait
  - Resource Allocation Graph
- Deadlock Handling Mechanism
  - Deadlock Prevention
  - Deadlock Avoidance
  - Detection and Recovery
  - Ignoring the Deadlock
  - EDEADLK
- Deadlock Prevention Mechanism
  - Mutual Exclusion
  - Hold and Wait
  - No Preemption
  - Circular Wait
- Deadlock Avoidance Mechanism
  - Bankers Algorithm
- Discussion on Deadlock Detection and Recovery

**Memory Management**
- Working behind the compilation and running of a program
- Address Binding
  - Compile Time
  - Load Time
  - Run Time
  - Problems of Runtime Binding
  - Logical and Physical Address
- Runtime Binding
  - Working
- Memory Management and hierarchy
  - Access time, capacity and cost
- Evolution of Memory Management
  - Single Tasking
  - Multitasking
  - Memory Allocation
- Dynamic Partitioning
  - Bitmap
  - Linked List
- Virtual Memory Introduction
  - Concept discussion
  - Performance Impact of Page Fault
- TLB, Demand Paging, Thrashing, Page Replacement Algorithm
- Segmentation and Paging with Segmentation
