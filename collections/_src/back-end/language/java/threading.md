---
layout: page
title: Multi Threading
permalink: /java/threading
---

- TOC
{:toc}

---

# Introduction

* Process
	- heavyweight tasks that require their own separate address spaces.
	- Interprocess communication and Context switching are costly.
* Thread
	- Lightweight tasks that share the same address space in a process.
	- Interthread communication and Context switching are costly.
* **Multiprogramming** – A computer running more than one program at a time (like running Excel and Firefox simultaneously).
* **Multiprocessing** – A computer using more than one CPU at a time.
* **Multitasking** – Tasks sharing a common resource (like 1 CPU).
* **Multithreading** is an extension of multitasking. Thread is used to achieve multitasking.

|Process-based multitasking|Thread-based multitasking|
|---|---|
|allows your computer to run two or more programs concurrently.|thread is the smallest unit of dispatchable code.
A program is the smallest unit of code that can be dispatched by the scheduler.|a single program can perform two or more tasks simultaneously.|
|deals with the “big picture”.|handles the details.|
||Ex. text editor can format text at the same time word suggestions can be made.|

* Multithreading helps you reduce this idle time because another thread can run when one is waiting.

## Java Thread Model
* Threads enable the entire environment to be asynchronous ie. increase efficiency by using idle CPU cycles.
* Benefit - loop/polling mechanism is eliminated. 
* One thread can pause without stopping other parts of your program. 
* Idle time - when a thread reads data from network or waits for user input.

## Single vs Multi Core
* Single core system, concurrently executing threads share the CPU, with each thread receiving a slice of CPU time.
	- two or more threads do not actually run at the same time, but idle CPU time is utilized.
* Multi-core systems, two or more threads actually execute simultaneously.

# Thread Class vs Runnable Interface

* **Thread** encapsulates a thread of execution. Since you can’t directly refer to the ethereal *state of a running thread, you will deal with it through its proxy, the Thread instance that spawned it*.

## Main Thread
* On program start-up, main thread begins running immediately, because it is the one that is executed when your program begins. 
* The main thread is important for two reasons: 
	- other “child” threads will be spawned from it.
	- performs various shutdown actions, must be the last thread to finish execution.
* main thread can be controlled using Thread object.

```java
Thread t = Thread.currentThread();
static void sleep(long milliseconds, int nanoseconds) throws InterruptedException
final void setName(String threadName)
final String getName( )
```

* **sleep( )** might throw an **InterruptedException** if some other thread wanted to interrupt this sleeping one.
**main thread default** name is **main**, priority **5**, and thread-group name **main**.

| Method    | Meaning          |
|---        |---|
getName 	|Obtain a thread’s name.
getPriority |Obtain a thread’s priority.
isAlive 	|Determine if a thread is still running.
join 	    |Wait for a thread to terminate.
run 	    |Entry point for the thread.
sleep 	    |Suspend a thread for a period of time.
start 	    |Start a thread by calling its run method.

* A *thread group* is a data structure that controls the state of a collection of threads as a whole.

# Creating a Thread

## Implementing Runnable
```java
Thread()
Thread(String name)
Thread(Runnable r)
Thread(Runnable threadOb, String threadName)
```
```java
class NewThread implements Runnable {
    Thread t;
    NewThread() {
        t = new Thread(this, "Demo Thread");
        System.out.println("Child thread: " + t);
        t.start();
    }
    // run method implemented as below
}
```
```java
public void run() {
    try {
        for (int i = 5; i > 0; i--) {
            System.out.println("Child Thread: " + i);
            Thread.sleep(500);
        }
    } catch (InterruptedException e) {
        System.out.println("Child interrupted.");
    }
    System.out.println("Exiting child thread.");
}
```

## Extending Thread
```java
class NewThread extends Thread {
    NewThread() {
        super("Demo Thread");
        System.out.println("Child thread: " + this);
        start();
    }
    // run method implemented as above
}
```
* The extending class must override the run( ), which is the entry point for the new thread. 
* It must also call start( ) to begin execution of the new thread. 
* start( ) executes a call to run( ).

```java
class ExtendThread {
    public static void main(String args[]) {
        Thread t = new NewThread();
        try {
            for (int i = 5; i > 0; i--) {
                System.out.println("Main Thread: " + i);
                Thread.sleep(1000);
            }
        } catch (InterruptedException e) {
            System.out.println("Main thread interrupted.");
        }
        System.out.println("Main thread exiting.");
    }
}
```

## Choosing an Approach
* Should be extended only when modified in some way. if not overriding Thread’s methods, implement Runnable. 
* By implementing **Runnable**, your thread class is free to inherit a different class.

# Creating Multiple Threads

```java
class NewThread implements Runnable {
    String name;
    Thread t;
    NewThread(String threadname) {
        name = threadname;
        t = new Thread(this, name);
        System.out.println("New thread: " + t);
        t.start();
    }
    @Override
    public void run() {
        try {
            for (int i = 3; i > 0; i--) {
                System.out.println(name + ": " + i);
                Thread.sleep(1000);
            }
        } catch (InterruptedException e) {
            System.out.println(name + "Interrupted");
        }
        System.out.println(name + " exiting.");
    }
}
```

```java
class MultiThreadDemo {
    public static void main(String args[]) {
        new NewThread("One");
        new NewThread("Two");
        new NewThread("Three");
        try {
            Thread.sleep(10000);
        } catch (InterruptedException e) {
            System.out.println("Main thread Interrupted");
        }
        System.out.println("Main thread exiting.");
    }
}
```

* If main thread finishes before a child thread has completed, then the Java run-time system may “hang”.

# Using isAlive() and join()

* Two ways exist to determine whether a thread has finished. 
	- **isAlive()** on thread, **true** if still running. but it is occasionally useful. 
	- **join()** - Currently running threads stop executing until the thread it joins with completes its task.

```java
final void join( ) throws InterruptedException
final public void join(long milliseconds) throws InterruptedException
```
```java
class DemoJoin {
 public static void main(String args[]) { 
    NewThread ob1 = new NewThread("One");
    NewThread ob2 = new NewThread("Two");
    NewThread ob3 = new NewThread("Three");
    System.out.println("Thread One is alive: "+ ob1.t.isAlive());
    System.out.println("Thread Two is alive: "+ ob2.t.isAlive());
    System.out.println("Thread Three is alive: "+ ob3.t.isAlive());
    try {
           System.out.println("Waiting for threads to finish.");
           ob1.t.join(); ob2.t.join(); ob3.t.join();
     } catch (InterruptedException e) {
           System.out.println("Main thread Interrupted");
     }
     System.out.println("Thread One is alive: "+ ob1.t.isAlive());
     System.out.println("Thread Two is alive: "+ ob2.t.isAlive());
     System.out.println("Thread Three is alive: "+ ob3.t.isAlive());
     System.out.println("Main thread exiting.");
  }
}
```
```
// Output
New thread: Thread[One,5,main]
New thread: Thread[Two,5,main]
New thread: Thread[Three,5,main]
Thread One is alive: true
Thread Two is alive: true
Thread Three is alive: true
Waiting for threads to finish.
One: 2
Two: 2
Three: 2
One: 1
Two: 1
Three: 1
Two exiting.
Three exiting. 
One exiting.
Thread One is alive: false
Thread Two is alive: false
Thread Three is alive: false
Main thread exiting
```

# Thread Priorities

* A thread’s priority is used to decide when to switch from one running thread to the next, context switch. 
 
* The rules that determine when a context switch takes place are simple:
	- A thread can voluntarily relinquish control
		- explicitly yielding, sleeping, or blocking on pending I/O. 
		- Now, all other threads are examined, and the highest-priority thread that is ready to run is given the CPU.
	- A thread can be preempted by a higher-priority thread
		- Basically, as soon as a higher-priority thread wants to run, it does. This is called preemptive multitasking.
* When same priority threads are competing for CPU cycles, they are time-sliced automatically in round-robin fashion.

```java
final void setPriority(int level)        
final int getPriority( )
```

* static final variables in Thread class - **MIN_PRIORITY(1)**, **MAX_PRIORIT(10)** and **NORM_PRIORITY(5)**.
* Relying on preemptive behaviour causes most of the inconsistencies, instead of cooperatively giving up CPU time. 
* To obtain predictable cross-platform behaviour, use threads that voluntarily give up control of the CPU.

# Thread Class Methods

**Why Thread sleep() and yield() methods are static?**  
- Thread sleep() and yield() work on the currently executing thread, and not invoked on threads in wait state. 
- These methods are made static so that when this method is called statically, it works on the current executing thread and avoid confusion to the programmers who might think that they can invoke these methods on some non-running threads.

|Thread Methods||
|---|---|
public void run() 	                |is used to perform action for a thread.
public void start()                 |starts the execution of the thread. JVM calls the run() method on the thread.
public void sleep(long miliseconds) |Causes the currently executing thread to sleep (temporarily cease execution) for the specified number of milliseconds.
public void join()                  |waits for a thread to die.
public void join(long miliseconds)  |waits for a thread to die for the specified miliseconds.
public int getPriority()            |returns the priority of the thread.
public int setPriority(int priority)|changes the priority of the thread.
public String getName()             |returns the name of the thread.
public void setName(String name)    |changes the name of the thread.
public Thread currentThread()       |returns the reference of currently executing thread.
public int getId()                  |returns the id of the thread.
public Thread.State getState() 	    |returns the state of the thread.
public boolean isAlive() 	        |tests if the thread is alive.
public void yield() 	            |causes the currently executing thread object to temporarily pause and allow other threads to execute.
public void suspend() 	            |is used to suspend the thread(depricated).
public void resume() 	            |is used to resume the suspended thread(depricated).
public void stop() 	                |is used to stop the thread(depricated).
public boolean isDaemon() 	        |tests if the thread is a daemon thread.
public void setDaemon(boolean b) 	|marks the thread as daemon or user thread.
public void interrupt()	            |interrupts the thread.
public boolean isInterrupted()   	|tests if the thread has been interrupted.
public static boolean interrupted() |tests if the current thread has been interrupted.

# Synchronization

* **Synchronization** - ensures that resource will be used by only one thread at a time.
* **Monitor** - an object used as a mutually exclusive lock. 
	- Every object has a lock associated with it. Only one thread can own a monitor at a given time.
	- thread acquires a lock; it has entered the monitor.
	- other threads will be waiting for the monitor ie. suspended until the first thread exits the monitor. 
	- thread owning a monitor can re-enter the same monitor if it so desires.
* Java’s messaging system allows a thread to enter a synchronized method on an object, and then wait there until some other thread explicitly notifies it to come out.

## Synchronized Methods
* To enter an object’s monitor, just call a method that has been modified with the synchronized keyword. 
* While a thread is inside a **synchronized** method, all other threads that try to call it (or any other synchronized method) on the same instance have to wait. 
* To exit the monitor and relinquish control of the object to the next waiting thread, the owner of the monitor simply returns from the synchronized method.
* In this program, nothing exists to stop all three threads from calling the same method, on the same object, at the same time. This is known as a **race condition**, because the three threads are racing each other to complete the method.
* Any time that you have a method, or group of methods, that manipulates the internal state of an object in a multithreaded situation, you should use the **synchronized keyword** to guard the state from race conditions.

```java
class Callme {
    synchronized void call(String msg) { ...} 
}
Output - [Hello][Synchronized][World]
```
* Once a thread enters any synchronized method on an instance, no other thread can enter any other synchronized method on the same instance. However, non-synchronized methods on that instance will continue to be callable.

## Synchronized Statement
* Suppose, you want to synchronize access to objects of a class that was not designed for multithreaded access or class was not created by you, but by a third party, and you do not have access to the source code. Thus, you can’t add **synchronized** to the appropriate methods within the class.
* A **synchronized block** ensures that a call to a synchronized method that is a member of objRef’s class occurs only after the current thread has successfully entered objRef’s monitor.

```java
synchronized(objRef) {
    objRef.call(msg); // statements to be synchronized
}
Current Output :  Hello[Synchronized[World] ] ]
```

## Static Synchronization
If you make any ***static method as synchronized***, the lock will be on the class not on object.

**Problem without static synchronization**
* Suppose there are two objects of a shared class (e.g. Table with static variable) named object1 and object2. In case of synchronized method and synchronized block there cannot be interference between t1 and t2 or t3 and t4 because t1 and t2 both refers to a common object that have a single lock. 
* But there can be interference between t1 and t3 or t2 and t4 because t1 acquires another lock and t3 acquires another lock. 
* When we want no interference between t1 and t3 or t2 and t4, Static synchronization can solve this problem.

![synchronized-statement]({{site.cdn}}/java/multi-threading/synchronized-statement.png)

## Which is more preferred – Synchronized method or Synchronized block?
- Synchronized block is more preferred way
- because it doesn’t lock the Object, synchronized methods lock the Object.
- if there are multiple synchronization blocks in the class, even though they are not related, it will stop them from execution and put them in wait state to get the lock on Object.

```java
class Program {
  public synchronized void f() { ......... }
}
// is equivalent to ...
class Program {
  public void f() {
     synchronized(this){ ... }
  }
}
```
```java
public class Program {
  private static Object locker1 = new Object();
  private static Object locker1 = new Object();
  public void doSomething1() {
    synchronized(locker1) {  ......... //do something protected; }
  }
  public void doSomething2() {
    synchronized(locker2) {  ......... //do something protected;  }
  }
}
```

# Inter-Thread Communication

* Multithreading replaces event loop programming by dividing your tasks into discrete, logical units.
* Threads also provide a secondary benefit: they do away with polling. 
* Polling is usually implemented by a loop that is used to check some condition repeatedly. Once the condition is true, appropriate action is taken. This wastes CPU time. 

##  Example - Classic Queuing Problem 

* Here one thread is producing some data and another is consuming it. To make the problem more interesting, suppose that the producer has to wait until the consumer is finished before it generates more data. 
* To avoid polling, Java includes an elegant interprocess communication mechanism via the **wait( ), notify( ), and notifyAll( )** methods. These methods are implemented as **final** methods in **Object**, so all classes have them. 
* All three methods can be called only from within a **synchronized** context.
    - **wait( )** tells the calling thread to give up the monitor and go to sleep until some other thread enters the same monitor and calls **notify( )** or **notifyAll( )**.
    - **notify( )** wakes up a thread that called **wait( )** on the same object.
    - **notifyAll( )** wakes up all the threads that called **wait( )** on the same object. One of the threads will be granted access.

```java
final void wait( ) throws InterruptedException    
final void notify( )    
final void notify All( )
```

* Although **wait( )** normally waits until **notify( ) or notifyAll( )** is called, there is a possibility that in very rare cases the waiting thread could be awakened due to a ***spurious wakeup***. In this case, a waiting thread resumes without notify( ) or notifyAll( ) having been called. (In essence, the thread resumes for no apparent reason.)
* Because of this remote possibility, Oracle recommends that calls to wait( ) should take place within a loop that checks the condition on which the thread is waiting.

## Correct Implementation of a Producer and Consumer problem

```java
class Q {
    int n;
    boolean valueSet = false;

    //syncronized get method on q
    synchronized int get() {
        while (!valueSet) {
            try {
                wait();
            } catch (InterruptedException e) {
                System.out.println("InterruptedException caught");
            }
        }
        System.out.println("Got: " + n);
        valueSet = false;
        notify();
        return n;
    }

    //syncronized put method on q
    synchronized void put(int n) {
        while (valueSet) {
            try {
                wait();
            } catch (InterruptedException e) {
                System.out.println("InterruptedException caught");
            }
        }
        this.n = n;
        valueSet = true;
        System.out.println("Put: " + n);
        notify();
    }
}
```
```java
class Producer implements Runnable {
    Q q;
    Producer(Q q) {
        this.q = q;
        new Thread(this, "Producer").start();
    }
    public void run() {
        int i = 0;
        while (true) {
            q.put(i++);
        }
    }
}
```
```java
class Consumer implements Runnable {
    Q q;
    Consumer(Q q) {
        this.q = q;
        new Thread(this, "Consumer").start();
    }
    public void run() {
        while (true) {
            q.get();
        }
    }
}
```
```java
class PCFixed {
    public static void main(String args[]) {
        Q q = new Q();
        new Producer(q);
        new Consumer(q);
        System.out.println("Press Control-C to stop.");
    }
}
```

# Deadlock

* **Deadlock** occurs when two threads have a circular dependency on a pair of synchronized objects.
* For example, suppose one thread enters the monitor on object X and another thread enters the monitor on object Y. If the thread in X tries to call any synchronized method on Y, it will block as expected. However, if the thread in Y, in turn, tries to call any synchronized method on X, the thread waits forever, because to access X, it would have to release its own lock on Y so that the first thread could complete.
* Deadlock is a difficult error to debug for two reasons:
	- In general, it occurs only rarely, when the two threads time-slice in just the right way.
	- It may involve more than two threads and two synchronized objects.

![deadlock]({{site.cdn}}/java/multi-threading/deadlock.png)

```java
// An example of deadlock.
class A {
    synchronized void foo(B b) {
        String name = Thread.currentThread().getName();
        System.out.println(name + " entered A.foo");
        try {
            Thread.sleep(1000);
        } catch (Exception e) {
            System.out.println("A Interrupted");
        }
        System.out.println(name + " trying to call B.last()");
        b.last();
    }
    synchronized void last() {
        Sysout("Inside A.last");
    }
}
```
```java
class B {
    synchronized void bar(A a) {
        String name = Thread.currentThread().getName();
        System.out.println(name + " entered B.bar");
        try {
            Thread.sleep(1000);
        } catch (Exception e) {
            Sysout("B Interrupted");
        }
        System.out.println(name + " trying to call A.last()");
        a.last();
    }
    synchronized void last() {
        Sysout("Inside B.last");
    }
}
```
```java
class Deadlock implements Runnable {
    A a = new A();
    B b = new B();
    Deadlock() {
        Thread.currentThread().setName("MainThread");
        Thread t = new Thread(this, "RacingThread");
        t.start();
        a.foo(b); // get lock on A in this thread.
        System.out.println("Back in main thread");
    }
    public void run() {
        b.bar(a); // get lock on B in other thread.
        System.out.println("Back in other thread");
    }
    public static void main(String args[]) {
        new Deadlock();
    }
}
```
```java
// Output
MainThread entered A.foo
RacingThread entered B.bar
MainThread trying to call B.last()
RacingThread trying to call A.last()
```

Because the program has deadlocked, you need to press ctrl-c to end the program. You can see a full thread and monitor cache dump by pressing ctrl-break on a PC. You will see that ***RacingThread*** owns the monitor on b, while it is waiting for the monitor on a. At the same time, ***MainThread*** owns a and is waiting to get b. This program will never complete. As this example illustrates, if your multithreaded program locks up occasionally, deadlock is one of the first conditions that you should check for.

# Suspending, Resuming, and Stopping Threads

* Sometimes, suspending execution of a thread is useful. 
* For example, a separate thread can be used to display the time of day, when not required, then its thread can be suspended.
* Prior to Java 2, a program used **suspend( )**, **resume( )**, and **stop( )**, which are methods defined by **Thread**, to pause, restart, and stop the execution of a thread. These are **deprecated** now.
	- **suspend( )** can sometimes cause serious system failures as locks are not relinquished.
	- **resume( )** method is also deprecated. As it cannot be used without the **suspend( )**.
	- **stop( )** can sometimes cause serious system failures. Assume that a thread is writing to a critically important data structure and has completed only part of its changes. If that thread is stopped at that point, that data structure might be left in a corrupted state. The trouble is that **stop( )** causes any lock the calling thread holds to be released. Thus, the corrupted data might be used by another thread that is waiting on the same lock.
* A thread must be designed so that the **run( )** method periodically checks to determine whether that thread should suspend, resume, or stop its own execution. Typically, this is accomplished by establishing a flag variable that indicates the execution state of the thread. As long as this flag is set to “running,” the **run( )** method must continue to let the thread execute. If this variable is set to “suspend,” the thread must pause. If it is set to “***stop***”, the thread must terminate.

```java
// Suspending and resuming a thread 
class NewThread implements Runnable {
    String name; // name of thread
    Thread t;
    boolean flag;

    NewThread(String threadname) {
        name = threadname;
        t = new Thread(this, name);
        System.out.println("New thread: " + t);
        flag = false;
        t.start(); // Start the thread
    }

    public void run() {
        try {
            for (int i = 15; i > 0; i--) {
                System.out.println(name + ": " + i);
                Thread.sleep(200);
                synchronized(this) {
                    while (suspendFlag) {
                        wait();
                    }
                }
            }
        } catch (InterruptedException e) {
            System.out.println(name + " interrupted.");
        }
        System.out.println(name + " exiting.");
    }
    synchronized void mysuspend() {
        flag = true;
    }
    synchronized void myresume() {
        flag = false;
        notify();
    }
}
```
```java
class SuspendResume {
    public static void main(String args[]) {
        NewThread ob1 = new NewThread("One");
        NewThread ob2 = new NewThread("Two");
        try {
            Thread.sleep(1000);
            ob1.mysuspend();
            System.out.println("Suspending thread One");
            Thread.sleep(1000);
            ob1.myresume();
            System.out.println("Resuming thread One");
            ob2.mysuspend();
            System.out.println("Suspending thread Two");
            Thread.sleep(1000);
            ob2.myresume();
            System.out.println("Resuming thread Two");
        } catch (InterruptedException e) {
            System.out.println("Main thread Interrupted");
        }

        try { // wait for threads to finish
            System.out.println("Waiting for threads to finish.");
            ob1.t.join();
            ob2.t.join();
        } catch (InterruptedException e) {
            System.out.println("Main thread Interrupted");
        }
        System.out.println("Main thread exiting.");
    }
}
```

# Understanding the process

![thread-states-flow]({{site.cdn}}/java/multi-threading/thread-states-flow.png)

* The point to point explanation of the above diagram is as follows:
	- Threads enter to acquire lock.
	- Lock is acquired by on thread.
	- Now thread goes to waiting state if you call wait() on the object. Otherwise it releases the lock and exits.
	- If you call notify() or notifyAll() method, thread moves to the notified state (runnable state).
	- Now thread is available to acquire lock.
	- After completion of the task, thread releases the lock and exits the monitor state of the object.

|wait()	|sleep()|
---|---
wait() method releases the lock |sleep() method doesn't release the lock.
method of Object class	|method of Thread class
non-static method	|static method
Should be notified by notify() or notifyAll() methods |After the specified amount of time, sleep is completed.

**Why wait(), notify() and notifyAll() methods are defined in Object class not Thread class?**  
- In Java every Object has a monitor
- wait, notify methods are used to wait for the Object monitor or to notify other threads that Object monitor is free now. 
- There is no monitor on threads in java and synchronization can be used with any Object, that’s why it’s part of Object class so that every class in java has these essential methods for inter thread communication.

**Why wait(), notify() and notifyAll() methods have to be called from synchronized method or block?**  
To call these methods monitor on the Object must be acquired, that can be achieved only by synchronization, they need to be called from synchronized method or block.

# Thread’s State

**Thread.State** - indicates the state of the thread at the time at which the call was made (enumeration defined by Thread) 

```java
Thread.State ts = thrd.getState();
if(ts == Thread.State.RUNNABLE) // ...
```

|Value|State|
---|---
BLOCKED|A thread that has suspended execution because it is waiting to acquire a lock.
NEW |A thread that has not begun execution.
RUNNABLE |A thread that either is currently executing or will execute when it gains access to CPU.
TERMINATED |A thread that has completed execution.
TIMED_WAITING |A thread that has suspended execution for a specified period of time, such as after sleep().<br>This state is also entered when a timeout version of wait() or join() is called.
WAITING 	|A thread that has suspended execution because it is waiting for some action to occur.<br>For example, it is waiting because of a call to a non-timeout version of wait() or join().

* A thread’s state may change after the call to **getState( )**. Thus, getState( ) is not intended to provide a means of synchronizing threads. It’s used for debugging or for profiling a thread’s run-time characteristics.

![thread-states]({{site.cdn}}/java/multi-threading/thread-states.png)

* The key to utilizing Java’s multithreading features effectively is to think concurrently rather than serially. 
* For example, when you have two subsystems within a program that can execute concurrently, make them individual threads. With the careful use of multithreading, you can create very efficient programs. 
* If you create too many threads, more CPU time will be spent in context switching than executing your program!
* Thread scheduler in java is the part of the JVM that decides which thread should run. There is no guarantee that which runnable thread will be chosen to run by the **thread scheduler**. Only one thread at a time can run in a single process. 
* The thread scheduler mainly uses preemptive or time slicing scheduling to schedule the threads.
* **start()** method of Thread class is used to start a newly created thread. It performs following tasks:
	- A new thread starts (with new callstack).
	- The thread moves from New state to the Runnable state.
	- When the thread gets a chance to execute, its target run() method will run.

**Difference between preemptive scheduling and time slicing?**  
- Under **preemptive** scheduling, the highest priority task executes until it enters the waiting or dead states or a higher priority task comes into existence.
- Under **time slicing**, a task executes for a predefined slice of time and then re-enters the pool of ready tasks. The scheduler then determines which task should execute next, based on priority and other factors.

**Can we start a thread twice?**  
- No. After starting a thread, it can never be started again.
- If you does so, an **IllegalThreadStateException** is thrown. In such case, thread will run once but for second time, it will throw exception.

**What if we call run() method directly instead start() method?**  
- Each thread starts in a separate call stack.
- Invoking the run() method from main thread, the run() method goes onto the current call stack rather than at the beginning of a new call stack.

```java
public static void main(String args[]) {
    TestCallRun2 t1 = new TestCallRun2();
    TestCallRun2 t2 = new TestCallRun2();
    t1.run();
    t2.run();
}

class TestCallRun2 extends Thread {
    public void run() {
        for (int i = 1; i < 5; i++) {
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                sysout(e);
            }
            System.out.println(i);
        }
    }
}
```
```
Output:1 2 3 4 5 1 2 3 4 5
```
As you can see that there is no context-switching because here t1 and t2 will be treated as normal object not thread object.

# Deamon Thread

* **Daemon thread** in java is a service provider thread that provides services to the user thread. 
* It is a low priority thread.
* Its life depend on the mercy of user threads i.e. ***when all the user threads dies, JVM terminates this thread automatically***. 
* There are many java daemon threads running automatically e.g. gc, finalizer etc. 
* You can see all the detail by typing the jconsole in the command prompt. The jconsole tool provides information about the loaded classes, memory usage, running threads etc.

|||
---|---
public void setDaemon(boolean status)|used to mark the current thread as daemon thread or user thread.
public boolean isDaemon()|used to check that current is daemon.

* To make a user thread as Daemon, it must not be started otherwise it will throw **IllegalThreadStateException**. 

```java
t1.start();
t1.setDaemon(true);    //will throw exception here  
```

# Common Tasks - FAQ Code

## Single Task - Multiple Threads
**How to perform single task by multiple threads?**  
If you have to perform single task by many threads, have only one run() method.

```java
class TestMultitasking1 extends Thread {

    public void run() {
        sysout("task one");
    }

    public static void main(String args[]) {
        TestMultitasking1 t1 = new TestMultitasking1();
        TestMultitasking1 t2 = new TestMultitasking1();
        t1.start();
        t2.start();
    }
}
// Output: 
task one task one
```

![multitask-single-thread]({{site.cdn}}/java/multi-threading/multitask-single-thread.png)

## Multiple Task - Multiple Threads
**How to perform multiple tasks by multiple threads?**  
If you have to perform multiple tasks by multiple threads, have multiple run() methods.

```java
class Simple1 extends Thread {
    public void run() {
        System.out.println("task 1");
    }
}
```
```java
class Simple2 extends Thread {
    public void run() {
        System.out.println("task 2");
    }
}
```
```java
class TestMultitasking3 {
    public static void main(String args[]) {
        Simple1 t1 = new Simple1();
        Simple2 t2 = new Simple2();
        t1.start();
        t2.start();
    }
}
```
```
// Output:
task one
task two
```

## Print Odd Even - without wait or synchronized
**Print natural numbers 1 to 20 using two threads without using wait or synchronized where one thread prints only odd number and other thread prints only even number?**  

```java
public class EvenOddPrinterWithoutWait {
    static boolean flag = true;
    
    public static void main(String[] args) {
        Runnable odd = () - > {
            for (int i = 1; i <= 10;) {
                if (EvenOddPrinter.flag) {
                    i = printIt(i);
                }
            }
        };
        Runnable even = () - > {
            for (int i = 2; i <= 10;) {
                if (!EvenOddPrinter.flag) {
                    i = printIt(i);
                }
            }
        };
        Thread t1 = new Thread(odd, "Odd");
        Thread t2 = new Thread(even, "Even");
        t1.start();
        t2.start();
    }
    
    private static int printIt(int i) {
        System.out.println(Thread.currentThread().getName() + "\t : " + i);
        EvenOddPrinter.flag = !EvenOddPrinter.flag;
        return (i + 2);
    }
}
```

## Print Odd Even - using wait or synchronized
**Print natural numbers 1 to 20 using two threads using wait or synchronized where one thread prints only odd number and other thread prints only even number?**  

```java
public class EvenOddPrinterWithWait {

    public static final int limit = 20;
    public static void main(String...args) {

        // Runnable for even printer
        final SharedPrinterWithWait counterObj = new SharedPrinterWithWait(20);
        Runnable evenNoPrinter = () - > {
            int num = 0;
            while (true) {
                if (num >= limit) {
                    break;
                }
                num = counterObj.printNextEven();
            }
        };

        // Runnable for odd printer
        Runnable oddNoPrinter = () - > {
            int num = 0;
            while (true) {
                if (num >= limit) {
                    break;
                }
                num = counterObj.printNextOdd();
            }
        };

        new Thread(oddNoPrinter).start();
        new Thread(evenNoPrinter).start();
    }
}
```
```java
public class SharedPrinterWithWait {
    private int count = 0;
    private boolean isEven = true;
    private int upperLimit;
    SharedPrinterWithWait(int limit) {
        upperLimit = limit;
    }
    public synchronized int printNextOdd() {
        // Wait until odd is available.
        while (isEven) {
            try {
                wait();
            } catch (InterruptedException e) {}
        }
        count++;
        if (count <= upperLimit) {
            printEven(count);
        }
        // Toggle status.
        isEven = true;
        // Notify even printer for status changed.
        notifyAll();
        return count;
    }
    public synchronized int printNextEven() {
        // Wait until even is available.
        while (!isEven) {
            try {
                wait();
            } catch (InterruptedException e) {}
        }
        count++;
        if (count <= upperLimit) {
            printOdd(count);
        }
        // Toggle status.
        isEven = false;
        // Notify odd printer for status changed.
        notifyAll();
        return count;
    }
    public void printOdd(int num) {
        System.out.println("ODD\t ## " + num);
    }
    public void printEven(int num) {
        System.out.println("EVEN\t ## " + num);
    }
}
```

## Print Odd Even - using semaphore
**Print natural numbers 1 to 20 using two threads using semaphore**  

* A semaphore controls access to a shared resource through the use of a counter. ***If the counter is greater than zero, then access is allowed***. If it is zero, then access is denied.
* Here we have two threads. Both the threads have an object of the SharedPrinter class. **The SharedPrinter class will have two semaphores, semOdd and semEven which will have 1 and 0 permits to start with**. This will ensure that odd number gets printed first.
* To print an odd number, the acquire() method is called on semOdd, and since the initial permit is 1, it acquires the access successfully, prints the odd number and calls release() on semEven.
* Calling **release()** will increment the permit by 1 for semEven, and the even thread can then successfully acquire the access and print the even number.

![semaphores]({{site.cdn}}/java/multi-threading/semaphores.png)

```java
public static void main(String[] args) {
    int max = 15;
    SharedPrinter sp = new SharedPrinter();
    Thread odd = new Thread(new OddRunnable(sp, max), "Odd");
    Thread even = new Thread(new EvenRunnable(sp, max), "Even");
    odd.start();
    even.start();
}
```
```java
public class OddRunnable implements Runnable {
    private SharedPrinter sp;
    private int max;
    OddRunnable(SharedPrinter sp, int max) {
        this.sp = sp;
        this.max = max;
    }
    @Override
    public void run() {
        for (int i = 1; i <= max; i = i + 2) {
            sp.printOddNum(i);
        }
    }
}
```
```java
public class EvenRunnable implements Runnable {
    private SharedPrinter sp;
    private int max;
    EvenRunnable(SharedPrinter sp, int max) {
        this.sp = sp;
        this.max = max;
    }
    @Override
    public void run() {
        for (int i = 2; i <= max; i = i + 2)
            sp.printEvenNum(i);
    }
}
```
```java
public class SharedPrinter {
    private Semaphore semEven = new Semaphore(0);
    private Semaphore semOdd = new Semaphore(1);

    void printEvenNum(int num) {
        try {
            semEven.acquire();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        System.out.println(String.format("%s\t: s", Thread.currentThread().getName(), num));
        semOdd.release();
    }

    void printOddNum(int num) {
        try {
            semOdd.acquire();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        System.out.println(String.format("%s\t: %s", Thread.currentThread().getName(), num));
        semEven.release();
    }
}
```

# Java Runtime

* Java **Runtime** class is used to interact with java runtime environment. 
* Java Runtime class provides methods to execute a process, invoke GC, get total and free memory etc. 
* There is only one instance of java.lang.Runtime class available for one java application. 
* The **Runtime.getRuntime()** method returns the singleton instance of Runtime class.

```java
public class ShutdownCommand {
    public static void main(String[] args) {
        Runtime r = Runtime.getRuntime();
        System.out.println("Total Memory: " + r.totalMemory());
        System.out.println("Free Memory: " + r.freeMemory());
        for (int i = 0; i < 10000; i++) {
            new ShutdownCommand();
        }
        System.out.println("After 10000 instance, Free Memory: " + r.freeMemory());
        System.gc();
        System.out.println("After gc(), Free Memory: " + r.freeMemory());
        System.out.println(r.availableProcessors()); // Number Of Processors
        // will open a new notepad
        try {
            r.exec("notepad");
        } catch (IOException e) {
            e.printStackTrace();
        }
        r.exec("shutdown -s -t 0");
        // -s to shutdown, -r to restart system and -t switch to specify time delay.
    }
}
```

|Method|Description|
---|---
public static Runtime getRuntime()	|returns the instance of Runtime class.
public void exit(int status)	|terminates the current virtual machine.
public void addShutdownHook(Thread hook)	|registers new hook thread.
public Process exec(String command) throws IOException	|executes given command in a separate process.
public int availableProcessors()	|returns no. of available processors.
public long freeMemory()	|returns amount of free memory in JVM.
public long totalMemory()	|returns amount of total memory in JVM.

# Java Concurrency

## volatile Keyword

* Using volatile is yet another way (like synchronized, atomic wrapper) of making class thread safe.
* volatile is used to indicate that a **variable's value will be modified by different threads**.
* Declaring a volatile Java variable means:
  - The value of this variable will ***never be cached thread-locally***: all reads and writes will go straight to "main memory";
  - Access to the variable ***acts as though it is enclosed in a synchronized block***, synchronized on itself.

```java
class SharedObj {
    // Changes made to sharedVar in one thread may not immediately reflect in other thread
    static int sharedVar = 6;
    // static volatile int sharedVar = 6;
}
```

* Suppose that two threads are working on **SharedObj**. If two threads run on different processors each thread may have its own local copy of **sharedVar**.
* If one thread modifies its value the change might not reflect in the original one in the main memory instantly. This depends on the [write policy](https://en.wikipedia.org/wiki/CPU_cache#Write_policies) of cache. Now the other thread is not aware of the modified value which leads to data inconsistency.

![volatile]({{site.cdn}}/java/multi-threading/volatile.png)

### Write Policy
* The timing of writing data from cache to main memory is known as the **write policy**.
  - [write-through](https://en.wikipedia.org/wiki/Cache_(computing)#WRITE-THROUGH) cache, every write to the cache causes a write to main memory.
  - [write-back](https://en.wikipedia.org/wiki/Cache_(computing)#WRITE-BACK) or **copy-back cache**, writes are not immediately mirrored to the main memory, and the cache instead tracks which locations have been written over, marking them as [dirty](https://en.wikipedia.org/wiki/Dirty_bit).
* Note that write of normal variables without any synchronization actions, might not be visible to any reading thread (this behavior is called [sequential consistency](https://en.wikipedia.org/wiki/Sequential_consistency)). 
*	Have only one copy of static variables in main memory. 

### volatile vs synchronized

* Two important features of locks and synchronization.
	1. **Mutual Exclusion**: Only one thread or process can execute a block of code (critical section) at a time.
	2. **Visibility**: It means that changes made by one thread to shared data are visible to other threads.
* **Synchronized**	: both mutual exclusion and visibility
* **Volatile**		: visibility and not atomicity

Characteristic|Synchronized|Volatile
---|---|---|
Type of target variable|Object|Object or primitive
null allowed?|No|Yes
Can block? (hold on to any lock)|Yes|No
All cached variables synchronized with main memory on access?|Yes|Yes
When synchronization happens|When you explicitly enter/exit a synchronized block|Whenever a volatile variable is accessed.
Can be used to make several operations as atomic operation?|Yes|	[Atomic get-set of volatiles](https://www.javamex.com/tutorials/synchronization_concurrency_7_atomic_updaters.shtml)
Used on	|variable, method, class	|variables only

> Read more about [cached variables synchronized](https://www.javamex.com/tutorials/synchronization_concurrency_synchronized2.shtml)

* x++ is a read-modify-write sequence of operations that must execute atomically.
* Because accessing a [volatile](https://www.javamex.com/tutorials/synchronization_volatile.shtml) variable **never holds a lock**, it is **not suitable** for cases where we want to ***read-update-write*** as an atomic operation (unless we're prepared to "miss an update");
* A volatile variable that is an object reference may be null (you're effectively synchronizing on the reference, not the actual object). Attempting to synchronize on a null object will throw a NullPointerException.
* Use of volatile keyword also prevents compiler or JVM from the reordering of code or moving away them from synchronization barrier.
* In Java, reads and writes are [atomic](https://javarevisited.blogspot.com/2012/02/what-is-race-condition-in.html) for all variables declared using [Java volatile keyword](https://javarevisited.blogspot.com/2011/06/volatile-keyword-java-example-tutorial.html) (including long and double variables).
* volatile keyword on variables reduces the risk of memory consistency errors as any write to a volatile variable in Java establishes a happens-before relationship with subsequent reads of that same variable.
* Java volatile keyword doesn't mean atomic, its common misconception that after declaring volatile ++ will be atomic, to make the operation atomic you still need to ensure exclusive access using synchronized method or block in Java.
* If a variable is not shared between multiple threads, you don't need to use volatile keyword with that variable.
volatile is not a replacement of synchronized keyword but can be used as an alternative in certain cases.
* The short time gap in between the reading of the volatile variable and the writing of its new value, creates an [race condition](http://tutorials.jenkov.com/java-concurrency/race-conditions-and-critical-sections.html) where multiple threads might read the same value of the volatile variable, generate a new value for the variable, and when writing the value back to main memory - overwrite each other's values. The situation where multiple threads are incrementing the same counter is exactly such a situation where a volatile variable is not enough.

### When to use Volatile

* You can use Volatile variable if you want to read and write long and double variable atomically. long and double both are 64 bit data type and by default writing of long and double is not atomic and platform dependence. Many platform perform write in long and double variable 2 step, writing 32 bit in each step, due to this its possible for a Thread to see 32 bit from two different write. You can avoid this issue by making long and double variable volatile in Java.
* volatile variable can be used to inform the compiler that a particular field is subject to be accessed by multiple threads, which will prevent the compiler from doing any reordering or any kind of optimization which is not desirable in a multi-threaded environment. Without volatile variable compiler can re-order the code, free to cache value of volatile variable instead of always reading from main memory. like following example without volatile variable may result in an infinite loop without the volatile modifier, it's not guaranteed that one Thread sees the updated value of isActive from other thread. The compiler is also free to cache value of isActive instead of reading it from main memory in every iteration. By making isActive a volatile variable you avoid these issues.

```java
private boolean isActive = true;
public void printMessage() {
    while (isActive)
        System.out.println("Thread is Active");
}
```

* Another place where a volatile variable can be used is to fixing double-checked locking in Singleton pattern. As we discussed in [Why should you use Enum as Singleton](https://javarevisited.blogspot.com/2012/07/why-enum-singleton-are-better-in-java.html) that double checked locking was broken in Java 1.4 environment.

### volatile vs transient

transient	| volatile
---			| ---
used along with instance variables to exclude them from serialization process. if a field is transient its value will not be persisted.	|used to indicate compiler and JVM that always read its value from main memory and follow happens-before relationship on visibility of volatile variable among multiple thread.
can not be used along with static keyword	|can be used along with static.
transient variables are initialized with default value during de-serialization and their assignment or restoration of value has to be handled by application code.||

## atomic variables

* The java.util.concurrent.atomic package defines classes that support atomic operations on single variables.
* All classes have get and set methods that work like reads and writes on volatile variables. 
* set has a happens-before relationship with any subsequent get on the same variable.
* The atomic ***compareAndSet*** method also has these memory consistency features, as do the simple atomic arithmetic methods that apply to integer atomic variables.
* In below example, If two threads try to get and update the value at the same time, it may result in lost updates.

```java
class Counter {
    private int c = 0;
    public void increment() {
        c++;
    }
    public void decrement() {
        c--;
    }
    public int value() {
        return c;
    }
}
```
```java
class SynchronizedCounter {
    private int c = 0;
    public synchronized void increment() {
        c++;
    }
    public synchronized void decrement() {
        c--;
    }
    public synchronized int value() {
        return c;
    }
}
```
* For this simple class, synchronization is an acceptable solution.
* For a more complicated class, we can use atomic wrappers/classes. Example, replace int with ***AtomicInteger***.

## Locks

* One of the ways to manage access to an object is to use locks by using the synchronized keyword.
* The synchronized keyword ensures that only one thread can enter the method at one time.
* Additionally, we need to add the volatile keyword to ensure proper reference visibility among threads.

# Using locks solves the problem. However, performance takes a hit.
* When multiple threads attempt to acquire a lock, one of them wins, while the rest of the threads are either blocked or suspended. The process of suspending and then resuming a thread is very expensive and affects the overall efficiency of the system.
* In a small program, such as the counter, the time spent in context switching may become much more than actual code execution, thus greatly reducing overall efficiency.

```java
import java.util.concurrent.atomic.AtomicInteger;
class AtomicCounter {
    private AtomicInteger c = new AtomicInteger(0);
    public void increment() {
        c.incrementAndGet();
    }
    public void decrement() {
        c.decrementAndGet();
    }
    public int value() {
        return c.get();
    }
}
```
```java
AtomicBoolean
AtomicInteger
AtomicIntegerArray
AtomicIntegerFieldUpdater
AtomicLong
AtomicLongArray
AtomicLongFieldUpdater
AtomicReference
LongAdder
```

## Atomic Operations

* There is a branch of research focused on creating non-blocking algorithms (lock and wait-free algorithms) for concurrent environments. These algorithms exploit low-level atomic machine instructions such as ***compare-and-swap (CAS)***, to ensure data integrity.
* A typical CAS operation works on three operands:
	1. The memory location on which to operate (M)
	1. The existing expected value (A) of the variable
	1. The new value (B) which needs to be set
* ***The CAS operation updates atomically the value in M to B, but only if the existing value in M matches A, otherwise no action is taken***. In both cases, the existing value in M is returned. This combines three steps – getting the value, comparing the value and updating the value – into a single machine level operation.
* When multiple threads attempt to update the same value through CAS, one of them wins and updates the value. **However, unlike in the case of locks, no other thread gets suspended**; instead, they’re simply informed that they did not manage to update the value. The threads can then proceed to do further work and context switches are completely avoided.
* One other consequence is that the core program logic becomes more complex. This is because we have to handle the scenario when the CAS operation didn’t succeed. We can retry it again and again till it succeeds, or we can do nothing and move on depending on the use case.

## Atomic Variables in Action

* The most commonly used atomic variable classes in Java are AtomicInteger, AtomicLong, AtomicBoolean, and AtomicReference. 
* These classes represent an int, long, boolean and object reference respectively which can be atomically updated.

|||
---|---
get()				| gets the value from the memory, so that changes made by other threads are visible; equivalent to reading a volatile variable
set()				| writes the value to memory, so that the change is visible to other threads; equivalent to writing a volatile variable
lazySet() 			| eventually writes the value to memory, may be reordered with subsequent relevant memory operations. One use case is nullifying references, for the sake of garbage collection, which is never going to be accessed again. In this case, better performance is achieved by delaying the null *volatile* write.
compareAndSet() 	| same as described in above section, returns true when it succeeds, else false
weakCompareAndSet()	| same as compareAndSet, but weaker in the sense, that it does not create happens-before orderings. This means that it may not necessarily see updates made to other variables
incrementAndGet()	|
decrementAndGet()	|
getAndDecrement()	| The setters operations are implemented using compareAndSet.
getAndIncrement()	|
getAndAdd(int i)	|
addAndGet()	 		|

```java
public class SafeCounterWithoutLock {
    private final AtomicInteger counter = new AtomicInteger(0);
    public int getValue() {
        return counter.get();
    }
    public void increment() {
        while (true) {
            int existingValue = getValue();
            int newValue = existingValue + 1;
            if (counter.compareAndSet(existingValue, newValue)) { 
                return;
            }
        }
    }
}
```

* We retry the ***compareAndSet*** operation and again on failure, since we want to guarantee that the call to the *increment* method always increases the value by 1.
* When data (typically a variable) can be accessed by several threads, you must synchronize the access to the data to ensure visibility and correctness.
* This version is faster than the synchronized one and is also thread safe.
* This seems to be complicated, but this is the cost of non-blocking algorithms. When we detect collision, we retry until the operation succeeded. This is the common schema for non-blocking algorithms.

```java
public class Stack {
    private final AtomicReference < Element > head = new AtomicReference < Element > (null);
    public void push(String value) {
        Element newElement = new Element(value);
        while (true) {
            Element oldHead = head.get();
            newElement.next = oldHead;
            //Trying to set the new element as the head
            if (head.compareAndSet(oldHead, newElement)) {
                return;
            }
        }
    }
    public String pop() {
        while (true) {
            Element oldHead = head.get();
            if (oldHead == null) {
                return null;
            } //The stack is empty
            Element newHead = oldHead.next;
            //Trying to set the new element as the head
            if (head.compareAndSet(oldHead, newHead)) {
                return oldHead.value;
            }
        }
    }
    private static final class Element {
        private final String value;
        private Element next;
        private Element(String value) {
            this.value = value;
        }
    }
}
```

* To conclude, [atomic variables](https://dzone.com/articles/java-concurrency-%E2%80%93-part-6) classes are a really good way to implement non-blocking algorithms and are also a very good alternative to volatile variables, because they can provide atomicity and visibility.
* The main purpose behind building atomic classes is to implement nonblocking data structures and their related infrastructure classes. Atomic classes do not serve as replacements for java.lang.Integer and related classes. 
* Most java.util.concurrent package classes use atomic variables instead of synchronization, either directly or indirectly. 
Atomic variables also are used to achieve higher throughput, which means higher application server performance.

## Singleton and DCL

> [Double Checked Locking on Singleton Class in Java]((https://javarevisited.blogspot.com/2014/05/double-checked-locking-on-singleton-in-java.html))

* One of the key challenge faced is how to keep Singleton class as Singleton i.e. how to prevent multiple instances of a Singleton due to whatever reasons.
* ***Double checked locking of Singleton*** is a way to ensure only one instance of Singleton class is created through application life cycle. As name suggests, in double checked locking, code checks for an existing instance of [Singleton class](https://javarevisited.blogspot.com/2013/03/difference-between-singleton-pattern-vs-static-class-java.html) twice with and without locking to double ensure that no more than one instance of singleton gets created. By the way, it was broken before Java fixed its memory models issues in JDK 1.5. 

![singleton]({{site.cdn}}/java/multi-threading/singleton.png)

```java
class Singleton {
    private volatile static Singleton _instance;
    private Singleton() {} // private constructor

    /*1st version: creates multiple instance if two thread access*/
    public static Singleton getInstance() {
        if (_instance == null) {
            _instance = new Singleton();
        }
        return _instance;
    }

    /*
    * 2nd version : only creates one instance of Singleton on concurrent environment
    * but unnecessarily expensive due to cost of synchronization at every call.
    */
    public static synchronized Singleton getInstanceTS() {
        if (_instance == null) {
            _instance = new Singleton();
        }
        return _instance;
    }

    /*
    * 3rd version : An implementation of double checked locking of Singleton.
    * Intention is to minimize cost of synchronization and improve performance,
    * by only locking critical section of code, the code which creates instance of Singleton class.
    * By the way this is still broken, if we don't make _instance volatile, as another thread can
    * see a half initialized instance of Singleton.
    */
    public static Singleton getInstanceDC() {
        if (_instance == null) { // Single Checked
            synchronized(Singleton.class) {
                if (_instance == null) { // Double checked
                    _instance = new Singleton();
                }
            }
        }
        return _instance;
    }
}
```

**Why you need Double checked Locking of Singleton Class?**  
* Though synchronized version is thread-safe and solves issue of multiple instance, it's not very efficient.
* cost of synchronization is there every time you call this method, but synchronization is only needed on first class, when Singleton instance is created.

**DCL was broken before Java 5**
* Prior to Java 5 double checked locking was broken due to memory model, but its fixed. 
* Now, with **happens-before guarantee**, all the write will happen on volatile _instance before any read of _instance variable, you can safely assume that this will work. 
* By the way this is not the best way to create thread-safe Singleton, you can use Enum as Singleton, which provides in-built thread-safety during instance creation. Another way is to use ***static holder pattern***.
* The DCL idiom was designed to support lazy initialization, which occurs when a class defers initialization of an owned object until it is actually needed.

**Why would you want to defer initialization?**  
* Perhaps creating a Resource is an expensive operation, and users of SomeClass might not actually call getResource() in any given run. In that case, you can avoid creating the Resource entirely. 
* Delaying some initialization operations until a user actually needs their results can help programs start up faster. 
* Unfortunately, synchronized methods run much slower -- as much as 100 times slower -- than ordinary unsynchronized methods. One of the motivations for lazy initialization is efficiency, but it appears that in order to achieve faster program startup, you have to accept slower execution time once the program starts. That doesn't sound like a great trade-off.

## Java Enum and Singleton Pattern

* Below four things ensure that no instances of an enum type exist beyond those defined by the enum constants.
	1. An enum type has no instances other than those defined by its enum constants. 
	2. It is a compile-time error to attempt to explicitly instantiate an enum type. 
	3. The final clone method in Enum ensures that enum constants can never be cloned, and the special treatment by the serialization mechanism ensures that duplicate instances are never created as a result of deserialization. 
	4. Reflective instantiation of enum types is prohibited.

* Enum Singletons are easy to write
* By default, creation of Enum instance is thread safe but any other method on Enum is programmers responsibility.

```java
/*Singleton pattern example using Java Enum*/
public enum EasySingleton {
    INSTANCE("Sunday Funday", true);

    private String daysGreeting;
    private boolean isWeekend;
    WeekDays(String daysGreeting, boolean isW) {
        this(daysGreeting);
        this.isWeekend = isWeekend;
    }
}
```
```java
/*Singleton pattern example with static factory method*/
public class Singleton {
    //initailzed during class loading
    private static final Singleton INSTANCE = new Singleton();
    private Singleton() {} // private constructor, no other instance 
    public static Singleton getSingleton() {
        return INSTANCE;
    }
}
```
```java
/* Singleton pattern example with Double checked Locking*/
public class DoubleCheckedLockingSingleton{
     private volatile DoubleCheckedLockingSingleton INSTANCE;
     private DoubleCheckedLockingSingleton(){}
     public DoubleCheckedLockingSingleton getInstance(){
         if(INSTANCE == null){
            synchronized(DoubleCheckedLockingSingleton.class){  //double checking Singleton instance
                if(INSTANCE == null){ INSTANCE = new DoubleCheckedLockingSingleton(); }
            }
         }
         return INSTANCE;
     }
}
```

* ***Enum Singletons handled Serialization by themselves***
* Another problem with conventional Singletons are that once you implement [serializable interface](https://javarevisited.blogspot.com/2011/04/top-10-java-serialization-interview.html) they are no longer remain Singleton because readObject() method always return a new instance just like constructor in Java. you can avoid that by using readResolve() method and discarding newly created instance by replacing with Singeton as shwon in below example. 
* This can become even more complex if your Singleton Class maintains state, as you need to make them [transient](https://javarevisited.blogspot.com/2012/03/difference-between-transient-and.html), but with **Enum Singleton**, Serialization is guarnateed by JVM. 

```java
//readResolve to prevent another instance of Singleton
private Object readResolve() {
    return INSTANCE;
}
```

* **Creation of Enum instance is thread-safe**
	- Since creation of Enum instance is thread-safe by default you don't need to worry about double checked locking.
	- In summary, given the ***Serialzation and thraead-safety guaranteed*** and with couple of line of code enum Singleton pattern is best way to create Singleton in Java 5 world.

## DCL - Meet the Java Memory Model

* More accurately, DCL is not guaranteed to work. To understand why, we need to look at the relationship between the JVM and the computer environment on which it runs. 
* Unlike most other languages, Java defines its relationship to the underlying hardware through a formal memory model that is expected to hold on all Java platforms, enabling Java's promise of "Write Once, Run Anywhere." 
* ***When running in a synchronous (single-threaded) environment***, a program's interaction with memory is quite simple, or at least it appears so. Programs store items into memory locations and expect that they will still be there the next time those memory locations are examined. Though we think of programs as executing sequentially -- in the order specified by the program code -- that doesn't always happen. Compilers, processors, and caches are free to take all sorts of liberties with our programs and data, as long as they don't affect the result of the computation. 
* For example, compilers can generate instructions in a different order from the obvious interpretation the program suggests and store variables in registers instead of memory; processors may execute instructions in parallel or out of order; and caches may vary the order in which writes commit to main memory. The JMM says that all of these various reorderings and optimizations are acceptable, so long as the environment maintains **as-if-serial semantics** -- that is, so long as you achieve the same result as you would have if the instructions were executed in a strictly sequential environment.
* ***With multithreaded programs***, the situation is quite different -- one thread can read memory locations that another thread has written. If thread A modifies some variables in a certain order, in the absence of synchronization, thread B may not see them in the same order -- or may not see them at all, for that matter. 
* That could result because 
	- the compiler reordered the instructions or temporarily stored a variable in a register and wrote it out to memory later; 
	- or because the processor executed the instructions in parallel or in a different order than the compiler specified; 
	- or because the instructions were in different regions of memory, and the cache updated the corresponding main memory locations in a different order than the one in which they were written.

Whatever the circumstances, multithreaded programs are inherently less predictable, unless you explicitly ensure that threads have a consistent view of memory by using synchronization.

### What does synchronized really mean?
* Java treats each thread as if it runs on its own processor with its own local memory, each talking to and synchronizing with a shared main memory. 
* Even on a single-processor system, that model makes sense because of the effects of memory caches and the use of processor registers to store variables. When a thread modifies a location in its local memory, that modification should eventually show up in the main memory as well, and the JMM defines the rules for when the JVM must transfer data between local and main memory. 
* The Java architects realized that an overly restrictive memory model would seriously undermine program performance. They attempted to craft a memory model that would allow programs to perform well on modern computer hardware while still providing guarantees that would allow threads to interact in predictable ways.
* Java's primary tool for rendering interactions between threads predictably is the ***synchronized*** keyword. Many programmers think of synchronized strictly in terms of **enforcing a mutual exclusion semaphore (mutex)** to prevent execution of critical sections by more than one thread at a time. Unfortunately, that intuition does not fully describe what synchronized means.
* The semantics of synchronized do indeed include mutual exclusion of execution based on the status of a semaphore, but they also include rules about the synchronizing thread's interaction with main memory. In particular, *the acquisition or release of a lock triggers a **memory barrier** -- a forced synchronization between the thread's local memory and main memory*. (Some processors -- like the Alpha -- have explicit machine instructions for performing memory barriers.) 
* When a thread exits a synchronized block, it performs a **write barrier** -- *it must flush out any variables modified in that block to main memory before releasing the lock*. 
* Similarly, when entering a synchronized block, it performs a **read barrier** -- *it is as if the local memory has been invalidated, and it must fetch any variables that will be referenced in the block from main memory*.
* The proper use of synchronization guarantees that one thread will see the effects of another in a predictable manner. Only when threads A and B synchronize on the same object will the JMM guarantee that thread B sees the changes made by thread A, and that changes made by thread A inside the synchronized block appear atomically to thread B (either the whole block executes or none of it does). 
* Furthermore, the JMM ensures that synchronized blocks that synchronize on the same object will appear to execute in the same order as they do in the program.

```java
Synchronized block = enforcing a mutual exclusion semaphore (mutex) + memory barrier
```

### So what's broken about DCL?
* DCL relies on an unsynchronized use of the resource field. That appears to be harmless, but it is not. 
* To see why, imagine that thread A is inside the synchronized block, executing the statement *resource = new Resource();* while thread B is just entering getResource(). Consider the effect on memory of this initialization. Memory for the new Resource object will be allocated; the constructor for Resource will be called, initializing the member fields of the new object; and the field resource of SomeClass will be assigned a reference to the newly created object.

However, since thread B is not executing inside a synchronized block, it may see these memory operations in a different order than the one thread A executes. It could be the case that B sees these events in the following order (and the compiler is also free to reorder the instructions like this): allocate memory, assign reference to resource, call constructor. Suppose thread B comes along after the memory has been allocated and the resource field is set, but before the constructor is called. It sees that resource is not null, skips the synchronized block, and returns a reference to a partially constructed Resource! Needless to say, the result is neither expected nor desired.

When presented with this example, many people are skeptical at first. Many highly intelligent programmers have tried to fix DCL so that it does work, but none of these supposedly fixed versions work either. It should be noted that DCL might, in fact, work on some versions of some JVMs -- as few JVMs actually implement the JMM properly. However, you don't want the correctness of your programs to rely on implementation details -- especially errors -- specific to the particular version of the particular JVM you use.

Other concurrency hazards are embedded in DCL -- and in any unsynchronized reference to memory written by another thread, even harmless-looking reads. Suppose thread A has completed initializing the Resource and exits the synchronized block as thread B enters getResource(). Now the Resource is fully initialized, and thread A flushes its local memory out to main memory. The resource's fields may reference other objects stored in memory through its member fields, which will also be flushed out. While thread B may see a valid reference to the newly created Resource, but as it didn't perform a read barrier it could still see stale values of resource's member fields.

### Volatile doesn't mean what you think, either
A commonly suggested nonfix is to declare the resource field of SomeClass as volatile. However, while the JMM prevents writes to volatile variables from being reordered with respect to one another and ensures that they are flushed to main memory immediately, it still permits reads and writes of volatile variables to be reordered with respect to nonvolatile reads and writes. That means -- unless all Resource fields are volatile as well -- thread B can still perceive the constructor's effect as happening after resource is set to reference the newly created Resource.

### Alternatives to DCL

* The most effective way to fix the DCL idiom is to avoid it. The simplest way to avoid it, of course, is to use **synchronization**. Whenever a variable written by one thread is being read by another, you should use synchronization to guarantee that modifications are visible to other threads in a predictable manner.
* **Another option** for avoiding the problems with DCL is to drop lazy initialization and instead **use eager initialization**. Rather than delay initialization of resource until it is first used, initialize it at construction. The **class loader**, which synchronizes on the classes' Class object, **executes static initializer blocks at class initialization time**. That means that the effect of static initializers is automatically visible to all threads as soon as the class loads.

## ThreadGroup

* Java provides a convenient way to group multiple threads in a single object. 
* In such way, we can suspend, resume or interrupt group of threads by a single method call. 
* For example, imagine a program in which one set of threads is used for printing a document, another set is used to display the document on the screen, and another set saves the document to a disk file. If printing is aborted, you will want an easy way to stop all threads related to printing. Thread groups offer this convenience.

| 							|Methods of ThreadGroup
---							|---
ThreadGroup(String name)	|creates a thread group with given name.
ThreadGroup(ThreadGroup parent,String name)	|creates a thread group with given parent group and name.
int activeCount()			|returns no. of threads running in current group.
int activeGroupCount()		|returns a no. of active group in this thread group.
void destroy()				|destroys this thread group and all its sub groups.
String getName()			|returns the name of this group.
ThreadGroup getParent()		|returns the parent of this group.
void interrupt()			|interrupts all threads of this group.
void list()					|prints information of this group to standard console.

* Java thread group is implemented by `java.lang.ThreadGroup` class.

```java
ThreadGroup tg1 = new ThreadGroup("Group A");
Thread t1 = new Thread(tg1, new MyRunnable(), "one");
Thread t2 = new Thread(tg1, new MyRunnable(), "two"); //MyRunnable implements Runnable interface
```
Now we can interrupt all threads by a single line of code only.  
`Thread.currentThread().getThreadGroup().interrupt();`

```java
public class ThreadGroupDemo implements Runnable {
    public void run() {
        System.out.println(Thread.currentThread().getName());
    }
    public static void main(String[] args) {
        ThreadGroupDemo runnable = new ThreadGroupDemo();
        ThreadGroup tg1 = new ThreadGroup("Parent ThreadGroup");
        Thread t1 = new Thread(tg1, runnable, "one");
        t1.start();
        Thread t2 = new Thread(tg1, runnable, "two");
        t2.start();
        Thread t3 = new Thread(tg1, runnable, "three");
        t3.start();
        System.out.println("Thread Group Name: " + tg1.getName());
        tg1.list();
    }
}

// Output :  
one two three Thread Group Name: Parent ThreadGroup
java.lang.ThreadGroup[name = Parent ThreadGroup, maxpri = 10]
Thread[one, 5, Parent ThreadGroup]
Thread[two, 5, Parent ThreadGroup]
Thread[three, 5, Parent ThreadGroup]
```

**What is Thread Group? Why it’s advised not to use it?**  
* ThreadGroup is a class which was intended to provide information about a thread group. ThreadGroup API is weak and it doesn’t have any functionality that is not provided by Thread. Two of the major feature it had are to get the list of active threads in a thread group and to set the uncaught exception handler for the thread. But Java 1.5 has added ***setUncaughtExceptionHandler*** (UncaughtExceptionHandler eh) method using which we can add uncaught exception handler to the thread. So ThreadGroup is obsolete and hence not advised to use anymore.

```java
t1.setUncaughtExceptionHandler(new UncaughtExceptionHandler() {
    @Override
    public void uncaughtException(Thread t, Throwable e) {
        System.out.println("exception occured:" + e.getMessage());
    }
});
```

## Java Shutdown Hook

* The shutdown hook can be used to perform cleanup resource or save the state when JVM shuts down normally or abruptly. 
* Performing clean resource means closing log file, sending some alerts or something else. 
* So, if you want to execute some code before JVM shuts down, use shutdown hook.

**When does the JVM shut down?**  
* user presses ctrl+c on the command prompt
* System.exit(int) method is invoked
* user logoff
* user shutdown etc.

The addShutdownHook() method of Runtime class is used to register the thread with the Virtual Machine.

```java
public void addShutdownHook(Thread hook){}
```

The object of Runtime class can be obtained by calling the static factory method getRuntime(). The method that returns the instance of a class is known as factory method.

```java
Runtime r = Runtime.getRuntime();
 
class MyThread extends Thread{ 
    public void run(){ System.out.println("shut down hook task completed.."); }  
}  
 
public class TestShutdown1{  
  public static void main(String[] args)throws Exception {  
     Runtime r = Runtime.getRuntime();  
     r.addShutdownHook(new MyThread());  
     System.out.println("Now main sleeping... press ctrl+c to exit");  
     try{Thread.sleep(3000);}catch (Exception e) {}  
  }  
}
// Output:
Now main sleeping... press ctrl+c to exit
shut down hook task completed..
```
***Note***: The shutdown sequence can be stopped by invoking the halt(int) method of Runtime class.

# Executor API

* The Executor framework is a framework for standardizing invocation, scheduling, execution, and control of asynchronous tasks according to a set of execution policies.
* Creating a lot many threads with no bounds to the maximum threshold can cause application to run out of heap memory. So, creating a ThreadPool is a better solution as a finite number of threads can be pooled and reused. Executors framework facilitate process of creating Thread pools in java.

![threadpool]({{site.cdn}}/java/multi-threading/threadpool.png)

![executor-service]({{site.cdn}}/java/multi-threading/executor-service.png)

## Java Thread Pool

* Java Thread pool represents a fixed-size group of worker threads that are waiting for the job and reused many times.
* It contains a queue that keeps tasks(Runnable Threads) waiting to get executed.
* A thread from the thread pool is pulled out and assigned a job by the ExecutorService. After completion of the job, thread is contained in the thread pool again.

**Advantage**
- Better performance. It saves time because there is no need to create new thread.

**Real time usage**
- Used in Servlet and JSP where container creates a thread pool to process the request.

**How can we create Thread Pool in Java?**  
Executors factory methos can be used to create ThreadPool in java.
 
* The [Reactor pattern](https://en.wikipedia.org/wiki/Reactor_pattern) is used with worker threads to overcome a common scenario in applications: You need to do a lot of work eventually but you don't know which work and when and creating threads is an expensive operation.
* The idea is that you create a lot of threads which don't do anything at first. Instead, they "wait for work". When work arrives (in the form of code), some kind of executor service (the reactor) identifies idle threads from the pool and assigns them work to do.
* That way, you can pay the price to create all the threads once (and not every time some work has to be done). At the same time, your threads are generic; they will do whatever work is assigned to them instead of being specialized to do something specific.

## Runnable vs Callable and Future

### Runnable
- run()
- no parameters no return values
- Executors class provide useful methods to execute Callable in a thread pool.

### Callable
- java.util.concurrent.Callable
- call(), returns generic object <V> and it can throw checked exceptions.    
- Returned value from callable is captured into java.util.concurrent.Future Object.

### Future
- Since callable tasks run in parallel, we have to wait for the returned Object. 
- Using Future we can find out the status of the Callable task and get the returned Object. 
- **get()** - can wait for the Callable to finish and then return the result.
- **cancel()** - to cancel the associated Callable task
- **isDone()** and **isCancelled()** - to find out the current status of associated Callable task.
- **get(2, TimeUnit.SECONDS)** - specify time to wait for result, useful to avoid current thread getting blocked for longer time.

```java
public class MyCallable implements Callable < String > {
    @Override
    public String call() throws Exception {
        Thread.sleep(4000);
        return Thread.currentThread().getName();
    }

    public static void main(String args[]) {
        ExecutorService executorService = Executors.newFixedThreadPool(3);
        List < Future < String >> list = new ArrayList < Future < String >> ();
        Callable < String > callable = new MyCallable();
        for (int i = 0; i < 7; i++) {
            Future < String > future = executorService.submit(callable);
            list.add(future);
        }
        for (Future < String > fut: list) {
            try {
                System.out.println(new Date() + "::" + fut.get(2, TimeUnit.SECONDS));
            } catch (InterruptedException | ExecutionException | TimeoutException e) {
                e.printStackTrace();
            }
        }
        executorService.shutdown();
        while (!executorService.isTerminated()) {}
        System.out.println("Finished all threads");
    }
}
```

## Executor Framework

- The ***Executor framework*** helps to **decouple a command submission from command execution**.
- In the java.util.concurrent package there are three interfaces:
	- **Executor**- Used to submit a new task.
	- **ExecutorService**- subUnterface that adds methods to manage lifecycle of threads used to run the submitted tasks and methods to produce a Future to get a result from an asynchronous computation.
	- **ScheduledExecutorService**- to execute commands periodically or after a given delay.

![executor-service-internal]({{site.cdn}}/java/multi-threading/executor-service-internal.png)

```java
Thread t = new Thread(new MyRunnable());
t.start();
```
```java
Executor executor = ... // Executor creation
executor.execute(new MyRunnable());
executorService.submit(callable);
```

### Executor

- execute(Runnable)
- To create an Executor it is possible to use the factory Executors class.
- **newSingleThreadExecutor** - an ExecutorService with a single thread to execute commands.
	
	```java
	// Creates a single thread ExecutorService
	ExecutorService singleExecutorService = Executors.newSingleThreadExecutor();
	```

- **newSingleThreadScheduledExecutor** - a ScheduledExecutorService with a single thread to execute commands.
	
	```java
	// Creates a single thread ScheduledExecutorService
	ScheduledExecutorService singleScheduledExecutorService = Executors.newSingleThreadScheduledExecutor();
	```

- **newFixedThreadPool** - an ExecutorService that use a fixed length pool of threads to execute commands.
	
	```java
	// Creates an ExecutorService that use a pool of 10 threads
	ExecutorService fixedExecutorService = Executors.newFixedThreadPool(10);
	```

- **newScheduledThreadPool** - a ScheduledExecutorService with a fixed length pool of threads to execute scheduled commands.
	
	```java
	// Creates a ScheduledExecutorService that use a pool of 5 threads
	ScheduledExecutorService fixedScheduledExecutorService = Executors.newScheduledThreadPool(5);
	```

- **newCachedThreadPool** - an ExecutorService with a pool of threads that creates a new thread if no thread is available and reuse an existing thread if they are available. Expandable pool.
	
	```java
	// Creates an ExecutorService that use a pool that creates threads on demand And that kill them after 60 seconds if they are not used
	ExecutorService onDemandExecutorService = Executors.newCachedThreadPool();
	```

- **newWorkStealingPool**(parallelism) – fork and join inplementation

### ExecutorService

- The executor service interface is of course a subinterface of the executor. 
- Responsible for managing the lifecycle of all individual threads, and also of the executor.
- Added method - **submit(Callable)**

|Methods||
---|---
shutdown() | all submitted commands will be executed before stopping the ExecutorService, but no new command is accepted.<br>Doesn’t guarantee that all the task will reach their completion point.<br>shutdown();
shutdownNow()| prevents waiting tasks to be executed and try to stop all currently executing commands and returns List<Runnable> for that were awaiting execution.
awaitTermination()| blocks until all tasks are completed after the shutdown request/time elapses. Current thread is interrupted.<br>awaitTermination(5, TimeUnit.SECONDS);
<T> List<Future<T>> invokeAll(Collection<? extends Callable<T>> tasks)| submits all tasks and executes all.
<T> T invokeAny(Collection<? extends Callable<T>> tasks)|submits all tasks and executes some tasks and as soon as gets first successful response, it cancels rest of the tasks.<br>invokeAny may be used for certain **use cases** where let's say you want a guaranteed delivery system to be implemented okay? You want to send messages and you can post the message as many number of times as you want, but you want an assurance that it definitely gets delivered at least once. (for idempotent operations)

```java
Future<String> resultFromMyCommand2 = executorService.submit(myCommand2);
executorService.shutdown();
// Will throw a RejectedExecutionException because no new task can be submitted
executorService.submit(myCommand3);
```

### ScheduledExecutorService

- ScheduledExecutorService is used to schedule command executions after a given delay or periodically.
- It must be used as a replacement for Timer and TimerTask.
- Output available in ScheduledFuture Object.

```java
ScheduledExecutorService scheduledExecutorService = Executors.newScheduledThreadPool(5);
// Will start command1 after 50 seconds
scheduledExecutorService.schedule(command1, 50L, TimeUnit.SECONDS);
// Will start command 2 after 20 seconds, 25 seconds, 30 seconds ...
scheduledExecutorService.scheduleAtFixedRate(command2, 20L, 5L, TimeUnit.SECONDS);
// Will start command 3 after 10 seconds and if command3 takes 2 seconds to be executed also after 17, 24, 31, 38 seconds...
scheduledExecutorService.scheduleWithFixedDelay(command3, 10L, 5L, TimeUnit.SECONDS);
```

#### Custom Thread Factory
- Implements ThreadFactory
- Overload newThread(Runnable)
- Can be used when you need to have a meaningful thread names for making debugging from Thread dumps.
- Executors.newFixedThreadPool(3, new CustomThreadFactory());

***Use Case***
1. define a user bean to store all user information.
2. DBConnection class.
3. UserDao with method to insert (prepared statement).
4. UserProcessor, callable with userRec as String and Dao. 
5. MainExecutor, read all lines in to list and forEach submit callable.

![custom-thread-factory-usecase]({{site.cdn}}/java/multi-threading/custom-thread-factory-usecase.png)

# Java EE Concurrency API

## Why?
- Every Java Enterprise application always works within an application server, the underlying container, and these containers provide runtime support for application components like Enterprise Java Beans and servlets.
- Very often, Java Enterprise servers provide central resource management, resources like JDBC data sources, transaction management, connection pooling, et cetera.  So, there is this managed environment that is set up by the container, and in such an environment, application integrity is very important.
- it is required that the contextual information of the container is provided to the thread. Contextual information is Java namingand directory interface naming, class loader information, security context. It is very important that the container propagates this information to all the threads executing the jobs for you. 
- If we try to create our own threads using the Java Standard Edition platform, then the container will not be aware or wouldn't have any knowledge of these thread resources, that's exactly why the Java Enterprise Edition concurrency utilities were born.

## Good to Know Java EE Terms

- **JNDI** - Java Naming and Directory Interface is an API in Java to access data tree services. It'll help you to look up data and resources by means of a name and that name is a JNDI name. It'll help you to look up data and resources by means of a name and that name is a JNDI name.
- **Stateless session bean** - This is a type of an Enterprise Java bean which is used to perform independent operations. As the name suggests, it is stateless which means it does not conserve any state of the client. However, yes, it can of course, have its own state present with it. The application server often creates a pool of such stateless session beans so that it can do the request processing operations on those business methods.
- Global transactions – XA Resource for Resource Managers. 
	- When you have a distributed environment, you may have multiple resource managers on which you are trying to do transactions. So those multiple resources could be databases or JMS queues or application servers etc. 
	- XA or extended architecture,is an open standard which is defined for executing a global transaction that accesses more than one backend data tool. 
	- This is the one which will help you define the interactions between the transaction manager and the resource manager. The goal of XA is to allow multiple resources like Database, JMS queues, transactional caches, etc., to be accessed within the same transaction thereby preserving the ACID properties across applications.
- Java transaction API (JTA) – Interfaces for Transaction Mangement.
	- Basically a list of interfaces between a transaction manager and the parties involved in the transaction. 
	- This transaction API has specifications to perform transactions over a distributed network. 
	- The parties involved in transaction processing will be the resource manager, application server, and code.

## Api Components

- **ManagedThreadFactory** – Mostly referenced by @Resource(lookup=”jndi/name”) for field.
- **ManagedExecutorService**
- **ManagedScheduledExecutorService**
- **ContextService** – For Contextual proxies.

- Ways to use environment references of managed resources:
	- Declare in deployment descriptor.
	- look it up in the container or the environment or the network through ***Java Naming and Directory Interface API***. Java Naming and Directory Interfaces is an API in Java which is used to access directory services.
- Additionally, tasks could also optionally implement **ManagedTask** and even register **ManagedTaskListener** to receive lifecycle notifications.
- **ManagedTask** interface is actually used to provide identifying information about the task or maybeto provide additional execution properties.
- **ManagedTaskListener** is basically a listener class used to receive lifecycle notifications - track the stateof your task's future. So whenever the state changes, you can configure this listener and whatever you want as a part of the processing.
- For Example, Glassfish server has Glassfish console with default Concurrent Resources.
- all the four main services that we see, the managed executor, managed scheduled executor, managed thread factory and contact service, these are the interfaces that the specification of JSR has. But, the implementation classes for these are going to be provided by the underlying application server that you are using. In our case, it is GlassFish server, And whenever you are going to change your server, let's say you tomorrow are working on JBoss or maybe WildFly, then these implementation classes will change according to the underlying provider.
- **ManagedScheduledExecutorService** is fetched by jndi lookup name. **shutdown()** not allowed on managed resources.
- Dependency in maven - javax:javaee-api and c3p0

### USE CASE
- Read bank Account Details for all users
- Get All Transaction information and save to file.

![managed-executor-service-usecase]({{site.cdn}}/java/multi-threading/managed-executor-service-usecase.png)

- DataSource object is used here with c3 pooling.
- Datasource.getConnection() gives the connection object.

## ManagedThreadFactory and ThreadPoolExecutor

- **ManagedThreadFactory** is managed by the container. 
- Like your ManagedExecutorService and your ManagedScheduledExecutorService, this API, too, can be injected using the JNDI lookup or the Resource annotation. 
- ManagedThreadFactory can be used with the Java Standard Edition ExecutorService.
- Inside the Java Standard Edition platform there is an API, called java.util.concurrent.ThreadPoolExecutor which allows you to create and execute a service, specifying your own configuration parameters. 
- **Executors class** provide simple implementation of ExecutorService using **ThreadPoolExecutor** but **ThreadPoolExecutor** provides much more feature than that.
- Let's say for the full size, what is a maximum number of thread that can live in the pool, what is a keeper lifetime, how many tasks should be held in the queue, custom ***RejectedExecutionHandlerImpl*** for tasks when queue is full etc.
- when you create the ExecutorService out of a **ThreadPoolExecutor**, you feed the ManagedThreadFactory API to it so that all the threads manufactured this way will run with the container context.

```java
// Here java.util.concurrent. ExecutorService will have have the entire contextual information of the container
ExecutorService executorService = new ThreadPoolExecutor(10, 15, 2, TimeUnit.SECONDS, new ArrayBlockingQueue(2), managedThreadFactory)
```
- Java provides scheduled thread pool implementation through **ScheduledThreadPoolExecutor class** that implements **ScheduledExecutorService interface**.

## ContextService API

- **Contextual object** - any Java object or instance which will have the particular application component's container context associated with it. 
- **Contextual task** - a task submitted to the managed resource.
- When a task instance is submitted to a managed instance of the ExecutorService then the task becomes a contextual task.
- ContextService API allow applications to create contextual objects without a managed executor.
- It gives you a way to capture that context information, store it, so that you can run it at a later point in time. 
- And how does it do that? It uses these ***dynamic proxy capabilities*** that are provided under the java.lang.reflect package to associate the application component's context with the object instance. So this object now becomes a contextual object and whenever a method on the contextual object runs then the method executes with the thread context of that associated application component instance.
- when you talk about ContextService it helps you to create contextual objects, which means these contextual objects will have the context information. And what is that? That's JNDI naming, class loader information, and security context. 

```java
@Override
public void run() {
    system.out.println("Thread" + Thread.currentThread().getName());
    Subject subject = Subject.getSubject(AccessController.getContext());
    system.out.println("Security information from a normal thread: " + subject);
    // uses stored contextual info here
}
```
```java
Runnable proxy = contextService.createContextualProxy(runnable, Runnable.class); // contextual info captured for future use
Thread thread = new Thread(proxy);
thread.start();
```

## Java Transactions API

- Specification that allows applications to perform distributed transactions.
- For distributed environment,  most basic operations like commit, rollback along with concurrent processing is difficult.
- Concurrency utilities rely completely on JTA to perform and support transactions, work with XA Resource.
- Possible with javax.transaction.UserTransaction API, It helps developers to manage transaction boundaries. 
	- I may have the transaction which is spread among different threads, CPU cores, machines, or even networks. But the user transaction API that I have with me will ensure that all of these transactions operating in a single unit will be managed correctly.
- Resource Manager (Drivers) should be XA compatible, which can help you make sure that this global transaction and distributed transaction process works well.
- UserTransaction available through JNDI lookup. 

![java-transactions-api]({{site.cdn}}/java/multi-threading/java-transactions-api.png)

```java
@Resource(lookup=””)
private UserTransaction userTransaction;
```

# Multithreading FAQ

## How can we achieve thread safety in Java?
There are several ways to achieve thread safety in java – synchronization, atomic concurrent classes, implementing concurrent Lock interface, using volatile keyword, using immutable classes and Thread safe classes.

## What is Java Thread Dump, How can we get Java Thread dump of a Program?
Thread dump is list of all the threads active in the JVM, thread dumps are very helpful in analyzing bottlenecks in the application and analyzing deadlock situations. There are many ways using which we can generate Thread dump – Using Profiler, Kill -3 command, jstack tool etc. I prefer jstack tool to generate thread dump of a program because it’s easy to use and comes with JDK installation. Since it’s a terminal based tool, we can create script to generate thread dump at regular intervals to analyze it later on. Read this post to know more about [generating thread dump in java](https://www.journaldev.com/1053/java-thread-dump-visualvm-jstack-kill-3-jcmd).

## What is Deadlock? How to analyse and avoid deadlock situation?
Deadlock is a programming situation where two or more threads are blocked forever, this situation arises with at least two threads and two or more resources.

To analyse a deadlock, we need to look at the java thread dump of the application, we need to look out for the threads with state as BLOCKED and then the resources it’s waiting to lock, every resource has a unique ID using which we can find which thread is already holding the lock on the object.

Avoid Nested Locks, Lock Only What is Required and Avoid waiting indefinitely are common ways to avoid deadlock situation, read this post to learn how to [analyze deadlock in java](https://www.journaldev.com/1058/deadlock-in-java-example) with sample program.

## What is Java Timer Class? How to schedule a task to run after specific interval?
- java.util.Timer is a utility class that can be used to schedule a thread to be executed at certain time in future. Java Timer class can be used to schedule a task to be run one-time or to be run at regular intervals.
- java.util.TimerTask is an [abstract class](https://www.journaldev.com/1582/abstract-class-in-java) that implements Runnable interface and we need to extend this class to create our own TimerTask that can be scheduled using java Timer class.
- [java Timer example](https://www.journaldev.com/1050/java-timer-timertask-example).

## What is Lock interface in Java Concurrency API? What are it’s benefits over synchronization?
> Read more at [Java Lock Example](https://www.journaldev.com/2377/java-lock-example-reentrantlock).

Lock interface provide more extensive locking operations than can be obtained using synchronized methods and statements. They allow more flexible structuring, may have quite different properties, and may support multiple associated Condition objects.

The advantages of a lock are
	- it’s possible to make them fair
	- it’s possible to make a thread responsive to interruption while waiting on a Lock object.
	- it’s possible to try to acquire the lock, but return immediately or after a timeout if the lock can’t be acquired
	- it’s possible to acquire and release locks in different scopes, and in different orders

## What is BlockingQueue? How can we implement Producer-Consumer problem using Blocking Queue?
> Read more about [producer-consumer problem implementation using BlockingQueue](https://www.journaldev.com/1034/java-blockingqueue-example).

* java.util.concurrent.BlockingQueue is a Queue that supports operations that wait for the queue to become non-empty when retrieving and removing an element, and wait for space to become available in the queue when adding an element.
* BlockingQueue doesn’t accept null values and throw NullPointerException if you try to store null value in the queue.
* BlockingQueue implementations are thread-safe. All queuing methods are atomic in nature and use internal locks or other forms of concurrency control.
* BlockingQueue interface is part of [java collections framework](https://www.journaldev.com/1260/collections-in-java-tutorial) and it’s primarily used for implementing producer consumer problem.

## What is FutureTask Class?
FutureTask is the base implementation class of Future interface and we can use it with Executors for asynchronous processing. Most of the time we don’t need to use FutureTask class but it comes real handy if we want to override some of the methods of Future interface and want to keep most of the base implementation. We can just extend this class and override the methods according to our requirements. Check out [Java FutureTask Example](https://www.journaldev.com/1650/java-futuretask-example-program) post to learn how to use it and what are different methods it has.

## What are Concurrent Collection Classes?
> Read more about [how to avoid ConcurrentModificationException when using iterator](https://www.journaldev.com/378/java-util-concurrentmodificationexception)

* Java Collection classes are fail-fast which means that if the Collection will be changed while some thread is traversing over it using iterator, the iterator.next() will throw ConcurrentModificationException.
* Concurrent Collection classes support full concurrency of retrievals and adjustable expected concurrency for updates.
* Major classes are ConcurrentHashMap, CopyOnWriteArrayList and CopyOnWriteArraySet.

## What is Executors Class?
* Executors class provide utility methods for Executor, ExecutorService, ScheduledExecutorService, ThreadFactory, and Callable classes.
* Executors class can be used to easily create Thread Pool in java, also this is the only class supporting execution of Callable implementations.

## What are some of the improvements in Concurrency API in Java 8?
Some important concurrent API enhancements are:
- ConcurrentHashMap compute(), forEach(), forEachEntry(), forEachKey(), forEachValue(), merge(), reduce() and search() methods.
- CompletableFuture that may be explicitly completed (setting its value and status).
- Executors newWorkStealingPool() method to create a work-stealing thread pool using all available processors as its target parallelism level.

## Differences between concurrency vs. parallelism?
In Short,
- Concurrency means multiple tasks which start, run, and complete in overlapping time periods, in no specific order. Parallelism is when multiple tasks OR several part of a unique task literally run at the same time, e.g. on a multi-core processor.
- Remember that Concurrency and parallelism are NOT the same thing.

**Differences between concurrency vs. parallelism**
- Now let’s list down remarkable differences between concurrency and parallelism.
- Concurrency is when two tasks can start, run, and complete in overlapping time periods. Parallelism is when tasks literally run at the same time, eg. on a multi-core processor.
- Concurrency is the composition of independently executing processes, while parallelism is the simultaneous execution of (possibly related) computations.
- Concurrency is about dealing with lots of things at once. Parallelism is about doing lots of things at once.
- An application can be concurrent – but not parallel, which means that it processes more than one task at the same time, but no two tasks are executing at same time instant.
- An application can be parallel – but not concurrent, which means that it processes multiple sub-tasks of a task in multi-core CPU at same time.
- An application can be neither parallel – nor concurrent, which means that it processes all tasks one at a time, sequentially.
- An application can be both parallel – and concurrent, which means that it processes multiple tasks concurrently in multi-core CPU at same time.

# CountDownLatch and CyclicBarrier and Phaser

![mutual-exclusion]({{site.cdn}}/java/multi-threading/mutual-exclusion.png)

![countdownLatch-cyclicBarrier-phaser]({{site.cdn}}/java/multi-threading/countdownLatch-cyclicBarrier-phaser.png)

## CountDown Latch

- Latch that is released only after the given number of events occur; count given on initialization. 
- Each time one of those events occur count is decremented, for that **countdown()** method is used. 
- Thread(s) that are waiting for the latch to release (count zero) are blocked using **await()** method.
- It is useful in the scenario when you want one or more threads to wait until one or more events being performed in other threads complete.

**For, new CountDownLatch(N). Do we need to have 3 threads madatorily?**  
No, thread can wait until N threads complete some action, or that action has been completed N times.

![countdown-latch]({{site.cdn}}/java/multi-threading/countdownLatch.png)

```java
public class CountdownlatchDemo {
    public static void main(String[] args) {
        CountDownLatch cdl = new CountDownLatch(3);
        // Initializing three threads to read 3 different files.
        Thread t1 = new Thread(new FileReader("thread-1", "file-1", cdl));
        Thread t2 = new Thread(new FileReader("thread-2", "file-2", cdl));
        Thread t3 = new Thread(new FileReader("thread-3", "file-3", cdl));
        t1.start();
        t2.start();
        t3.start();
        try {
            // main thread waiting till all the files are read
            cdl.await();
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        System.out.println("Files are read ... Start further processing");
    }
}
```
```java
class FileReader implements Runnable {
    private String threadName;
    private String fileName;
    private CountDownLatch cdl;
    FileReader(String threadName, String fileName, CountDownLatch cdl){
        this.threadName = threadName;
        this.fileName = fileName;
        this.cdl = cdl;        
    }
    @Override
    public void run() {
        System.out.println("Reading file " + fileName + " thread " + threadName);
        // do countdown here
        cdl.countDown();
    } 
}
```

## Cyclic Barrier

- Used when you need threads to wait for each other to reach a common barrier point.
- After reaching barrier point, thread calls await() on the CyclicBarrier object and gets itself suspended.
- Once all specified threads have called await(), it will trip the barrier and all threads can resume operation.
- The barrier is called cyclic because it can be re-used after the waiting threads are released.

```java
public int await(long timeout, TimeUnit unit)
```
- lies dormant until one of the following things happens:
	- The last thread arrives; or
	- The specified timeout elapses; (In case of second form) or
	- Some other thread interrupts the current thread; or
	- Some other thread interrupts one of the other waiting threads; or
	- Some other thread times out while waiting for barrier; or
	- Some other thread invokes reset() on this barrier.
- await() method returns int which is the arrival index of the current thread, where index (Number of specified threads - 1) indicates the first to arrive and zero indicates the last to arrive.

### BrokenBarrierException
- **reset()** - resets barrier to initial state. If any parties are currently waiting at the barrier, they will return with a ***BrokenBarrierException***.
- CyclicBarrier uses all-or-none breakage model, If any thread leaves a barrier point prematurely due to interruption, failure, or timeout, all other threads waiting at that barrier point will also leave abnormally via BrokenBarrierException (orInterruptedException if they too were interrupted at about the same time).

![cyclic-barrier]({{site.cdn}}/java/multi-threading/cyclic-barrier.png)

|CountDownLatch	|CyclicBarrier|
---|---
Main thread waits for other threads to be executed.	| Each worker thread waits for each other to be executed.
Cannot be reused. | Can be reused by resetting barrier, once barrier is broken.
No such action is available. | Can provide barrierAction, to be executed once all threads reached barrier point, but before any thread is released.

```java
public class CyclicBarrierDemo {
    public static void main(String[] args) {
        CyclicBarrier cb = new CyclicBarrier(3, new AfterAction());
        // Initializing three threads to read 3 different files.
        Thread t1 = new Thread(new TxtReader("thread-1", "file-1", cb));
        Thread t2 = new Thread(new TxtReader("thread-2", "file-2", cb));
        Thread t3 = new Thread(new TxtReader("thread-3", "file-3", cb));
        t1.start();
		t2.start();
		t3.start();        
        System.out.println("Done ");
    }
}
```
```java
class AfterAction implements Runnable {
    @Override
    public void run() {
        System.out.println("In after action class, start further processing as all files are read");
    }
}
```
```java
class TxtReader implements Runnable {
    private String threadName;
    private String fileName;
    private CyclicBarrier cb;
    TxtReader(String threadName,String filename,CyclicBarrier cb){
        this.threadName = threadName;
        this.fileName = fileName;
        this.cb = cb;        
    }
    @Override
    public void run() {
        System.out.println("Reading file "+fileName+" thread "+threadName);    
        try{
            // calling await so the current thread suspends
            cb.await();           
        } catch (InterruptedException e) {
            System.out.println(e);
        } catch (BrokenBarrierException e) {
            System.out.println(e);
        }
    }
}
```

## Phaser
- suitable for use where it is required to synchronize threads over one or more phases of activity. 
- Can be used to synchronize a single phase also, in that case it acts more like a CyclicBarrier.
- Phaser is reusable (like CyclicBarrier) and more flexible in usage.
- Tasks may register(), bulkRegister(int), arriveAndDeregister() themselves hence number of parties can vary.
- phaser is a synchronization barrier so we have to make phaser wait until all registered parties finish a phase. That waiting can be done using **arrive()**.
- number of arrivals is equal to the parties which are registered that phase is considered completed and it advances to next phase (if there is any), or terminate.
- each generation of a phaser has an associated phase number starting from 0 which wraps around to 0 after Integer.MAX_VALUE.

|Methods|	|
|---	|---|
resgister()|Adds a new unarrived party to phaser. returns the arrival phase number for registration.
arrive()| Arrives at this phaser, without waiting for others to arrive. Note that arrive() method does not suspend execution of the calling thread. Returns the arrival phase number, or a negative value if terminated. Note that this method should not be called by an unregistered party.
arriveAndDeregister()| Arrives at this phaser and deregisters from it without waiting for others to arrive. Returns the arrival phase number, or a negative value if terminated.
arriveAndAwaitAdvance()| This method awaits other threads to arrives at this phaser. Returns the arrival phase number, or the (negative) current phase if terminated. If you want to wait for all the other registered parties to complete a given phase then use this method.
bulkRegister(int parties)| Used to register perties in bulk. Given number of new unarrived parties will be registered to this phaser.
onAdvance(int phase, int registeredParties)| If you want to perform some action before the phase is advanced you can override this method. Also used to control termination.

# Fork Join Framework

- fork-join framework allows to break a certain task on several workers and then wait for the result to combine them.
- Used to leverage multi-processor machine's capacity
- fork/join framework uses a pool of threads called the ***ForkJoinPool***, which manages worker threads of type ***ForkJoinWorkerThread***.

|||
|---|---|
Fork | process where task splits itself into smaller and independent sub-tasks that can be executed concurrently.
Join | process where task join results from all sub-tasks after their execution, otherwise it keeps waiting.
ForkJoinPool | special thread pool designed to work with fork-and-join task splitting, implementation of the ExecutorService.
RecursiveAction | a task which does not return any value, extends ForkJoinTask. 
RecursiveTask | a task which returns a value, extends ForkJoinTask.

- Worker threads execute 1 task at the time, but **ForkJoinPool** doesn’t create a separate thread for every single subtask.
- Each thread in pool has its own double-ended queue (or [deque](https://en.wikipedia.org/wiki/Double-ended_queue), pronounced deck) which stores tasks.
- This architecture is vital for balancing the thread’s workload with the help of the ***work-stealing algorithm***.
- ***free threads try to “steal” work from deques of busy threads hence minimizes the possibility that threads will compete for tasks***.

```java
// pool will use 2 processor cores, degree of parallelism.
public static ForkJoinPool forkJoinPool = new ForkJoinPool(2);
```

![fork-join-pool]({{site.cdn}}/java/multi-threading/fork-join-pool.png)

```java
class Writer extends RecursiveAction {
   @Override
   protected void compute() { }
}
```
```java
class Sum extends RecursiveTask<Long> {
   @Override
   protected Long compute() { return null; }
}
```
```java
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveTask;
public class TestThread {
   public static void main(final String[] arguments) throws InterruptedException, ExecutionException {
      int nThreads = Runtime.getRuntime().availableProcessors();
      System.out.println(nThreads);      
      int[] numbers = 1 to 1000;
      ForkJoinPool forkJoinPool = new ForkJoinPool(nThreads);
      Long result = forkJoinPool.invoke(new Sum(numbers,0,numbers.length));
      System.out.println(result);
   }  

   static class Sum extends RecursiveTask<Long> {
      int low;
      int high;
      int[] array;
      Sum(int[] array, int low, int high) {         
		  this.array = array;
		  this.low   = low;
		  this.high  = high;
		}
      protected Long compute() {         
         if(high - low <= 10) {
            long sum = 0;            
            for(int i = low; i < high; ++i) 
               sum += array[i];
             return sum;
         } else {            
            int mid = low + (high - low) / 2;
            Sum left  = new Sum(array, low, mid);
            Sum right = new Sum(array, mid, high);
            left.fork();
            long rightResult = right.compute();
            long leftResult  = left.join();
            return leftResult + rightResult;
         }
      }
   }
}
```
```java 
forkJoinPool.execute(customRecursiveTask);
int result = customRecursiveTask.join();
int result = forkJoinPool.invoke(customRecursiveTask);
```

* **invokeAll()** - submit a sequence of ForkJoinTasks to the ForkJoinPool. forks them returns a collection of Future objects in the order in which they were produced.

```java
ForkJoinTask.invokeAll(createSubtasks());
```

* The *fork()* method submits a task to a pool, but it doesn’t trigger its execution. The *join()* method is be used for this purpose.

Using the fork/join framework can speed up processing of large tasks, but there are guidelines should be followed:
- ***Use as few thread pools as possible*** – in most cases, it is best to use one thread pool per application or system
- ***Use the default common thread pool***, if no specific tuning is needed
- ***Use a reasonable threshold*** for splitting *ForkJoingTask* into subtasks
- ***Avoid any blocking in your ForkJoingTasks***

# Java Memory Model

> Read more about [Java Memory Model (JMM)](http://tutorials.jenkov.com/java-concurrency/java-memory-model.html)

- Java memory model(JMM) - specifies how the Java virtual machine works with the computer's memory (RAM).
- JMM specifies how and when different threads can see values written to shared variables, and how to synchronize access to shared variables when necessary.

## Internal Java Memory Model

- JMM is used internally in JVM
- It divides memory between thread stacks and the heap.
- Each thread running in the JVM has its own thread stack
	- contains info of methods called to reach the current point of execution. (call stack)
	- contains all local variables for each method being executed (on the call stack). 
- A thread can only access its own thread stack and each thread has its own version of each local variable.
- Local variables
	- primitive type, its totally kept on the thread stack. (not visible to other threads)
	- reference to an object, reference stored on the thread stack, but the object itself if stored on the heap.
- An object's member variables are stored on the heap along with the object itself.
- Static class variables are also stored on the heap along with the class definition.
- 2 threads calling same method of object at the same time, both will have access to the object's member variables, but each thread will have its own copy of the local variables.

![jmm]({{site.cdn}}/java/multi-threading/jmm.png)

## Hardware Memory Architecture

- Modern computer often has 2 or more CPUs in it. 
- Some CPU may have multiple cores hence more than 1 thread can run. 
- Consider, each CPU can run 1 thread at a time.
- Each CPU contains a set of registers in-CPU memory and CPU cache memory.
- Some CPUs may have multiple cache layers (Level 1 and Level 2) also.
- All CPUs can access the main memory area of computer (RAM).
- CPU will read part of main memory into its CPU cache and may even read part of the cache into its internal registers and then perform operations on it. 
- For write operations, result will flush from internal register to cache memory, and at some point, flushed back to main memory.
- values from cache memory are typically flushed back to main when the CPU needs to store something else in the cache.
- CPU cache can have data written to part of its memory at a time, and flush part of its memory at a time. 
- It does not have to read / write the full cache each time it is updated. 
- Cache is updated in smaller memory blocks called "**cache lines**". One or more cache lines may be read into the cache memory, and one or more cache lines may be flushed back to main memory.

![hardware-memory-architecture]({{site.cdn}}/java/multi-threading/hardware-memory-architecture.png)

## Bridging the Gap Between JMM And Hardware Memory Architecture

- JMM and the hardware memory architecture are different.
- Hardware memory architecture does not distinguish between thread stacks and heap as both the thread stack and the heap are located in main memory. Parts of the thread stacks and heap may sometimes be present in CPU caches and in internal CPU registers.

![jmm-hardware-mapping]({{site.cdn}}/java/multi-threading/jmm-hardware-mapping.png)

- When objects and variables can be stored in various different memory areas in the computer, certain problems may occur. 
- The two main problems are:
	- Visibility of thread updates (writes) to shared variables.
	- Race conditions when reading, checking and writing shared variables.

## Visibility of Shared Objects

- Without ***volatile declarations*** or ***synchronization***, updates to shared object by 1 thread may not be visible to others and each thread may end up having its own copy of the shared object sitting in its CPU cache.
- ***Solution*** - use [volatile keyword](http://tutorials.jenkov.com/java-concurrency/volatile.html), makes sure that the shared variable is read directly from main memory, and always written back to main memory when updated.

![shared-object-visibility-default]({{site.cdn}}/java/multi-threading/shared-object-visibility-default.png)
![shared-object-visibility-volatile]({{site.cdn}}/java/multi-threading/shared-object-visibility-volatile.png)

## Race Conditions

- If more than one thread updates variables in that shared object, [race conditions](http://tutorials.jenkov.com/java-concurrency/race-conditions-and-critical-sections.html) may occur.
- Example, 2 threads incrementing count concurrently without proper synchronization. updated value will only be 1 higher than the original value, despite the two increments.
- **Solution** – use [synchronized block](http://tutorials.jenkov.com/java-concurrency/synchronized.html) which guarantees 
	- only one thread can enter a given critical section of code at any given time 
	- all variables accessed inside the synchronized block will be read directly from main memory
	- when thread exits synchronized block, all updated variables will be flushed back to main memory again, regardless of whether the variable is declared volatile or not.

# TODO

- Difference between multitasking, multithreading and multiprocessing
- [top-50-java-multithreading-interview-questions-answers](https://javarevisited.blogspot.com/2014/07/top-50-java-multithreading-interview-questions-answers.html)
- [50-programmer-phone-interview-questions-answers.html](https://javarevisited.blogspot.com/2015/02/50-programmer-phone-interview-questions-answers.html)
- [ArrayBlockingQueue](https://netjs.blogspot.com/2016/02/arrayblockingqueue-in-java-concurrency.html)
- [Semaphore](https://netjs.blogspot.com/2016/02/semaphore-in-java-concurrency.html)
- [Exchanger](https://netjs.blogspot.com/2016/02/exchanger-in-java-concurrency.html)
- [Concurrency interview](https://netjs.blogspot.com/2016/05/java-concurrency-interview-questions.html)
- [Phaser](https://netjs.blogspot.com/2016/01/phaser-in-java-concurrency.html)
