---
layout: page
title: Exception in Java
permalink: /java/exceptions
---

- TOC
{:toc}

---

# Introduction

* **Exception** - erroneous event happened during the execution of a program disrupting normal flow.
    - **causes** - wrong data entered by user, hardware failure, network connection failure etc.

## Exception Hierarchy

> Read articel on [Exception Hierarchy Tutorial](https://www.benchresources.net/exception-hierarchy-in-java/){:target="_blank"}

![exception-hierarchy)]({{site.cdn}}/java/java-exceptions/exception-hierarchy-in-java.png "exception-hierarchy")

* `java.lang.Throwable` - **root class for exception and error**
* `java.lang.Exception`
	* super class for all types of Exception, extends Throwable 
	* **due to programmatic logic (recoverable)**.
    * used to create your own custom exception types.
	* checked exception and unchecked exception
    * CheckedExceptions examples - SQLException, IOException (FileNotFoundException).
    * UncheckedExceptions examples - RuntimeException (ArithmeticException, NullPointerException).
* `java.lang.Error`
	- super class for all types of Error.
	- **due to lack of system resources at run-time, non-recoverable**.
	- **errors are unchecked exception, not expected to be caught by your program**.
	- ex. VirtualMachineError (StackOverflowError, OutOfMemoryError), AssertionError, ExceptionInInitializerError.
* RuntimeException
    - subclass of Exception.
    - automatically defined for programs.
    - ex. division by zero, invalid array indexing.

# Checked vs Unchecked Exceptions

* **RuntimeExceptions** 
    - Also called ***Unchecked Exceptions***.
    - **Not check by compiler**, no need to mention in throws list.
    - **example** : NullPointerException, ClassCastException, etc.
    - **Custom Unchecked Exceptions - extend RuntimeException**.
* **Checked exceptions**
    - must be included in **throws** list.
    - should be **explicitly catched** (... throws MyException)
    - **example** : IOExceptions, etc.
    - **Custom Checked Exception - extend Exception**. There's no need to extend Throwable.

## java.lang Checked and Unchecked (RuntimeException) Exceptions

|Checked Exceptions             |   |    |
|---                            |---|---|
|ClassNotFoundException 	    |CloneNotSupportedException 	|InterruptedException	|       
|NoSuchFieldException	        |IllegalAccessException         |InstantiationException |
|ReflectiveOperationException   |NoSuchMethodException          |                       | 

|Unchecked RuntimeException |   |   |
|---                        |---|---|
| IndexOutOfBoundsException | ArrayIndexOutOfBoundsException    | StringIndexOutOfBounds            |
| ArithmeticException       | NumberFormatException             |
| NullPointerException      | UnsupportedOperationException     | EnumConstantNotPresentException   |
| SecurityException         | IllegalMonitorStateException      |
| TypeNotPresentException   | ClassCastException                | IllegalArgumentException          |
| IllegalStateException     | IllegalThreadStateException       |
| ArrayStoreException       | NegativeArraySizeException        |

# Custom Exceptions

* Exception class – adds no new methods, inherit those provided by Throwable. 
* Your subclasses **don’t need to actually implement anything – their existence in the type system makes them exceptions**.

```java
public class MyException extends Exception {
    private static final long serialVersionUID = 4664456874499611218 L;
    private String errorCode = "Unknown_Exception";
    public MyException(String message, String errorCode) {
        super(message);
        this.errorCode = errorCode;
    }
    public String getErrorCode() {
        return this.errorCode;
    }
}
```

|Methods Defined by Throwable|||
|---|---|---|
|**Throwable getCause( )** 	    | **Throwable initCause(Throwable causeExc)**   |
|**String getMessage( )** 	    | String getLocalizedMessage( )                 |
|**void printStackTrace( )**    | void printStackTrace(PrintStream stream)      | void printStackTrace(PrintWriter stream) |
|**String toString( )**         | **StackTraceElement[ ] getStackTrace( )**     |

# Exception Handling

* For runtime error, exception object is created and **JRE** tries to find exception handler for the exception. *(here, in general runtime error is referred, not runtime exception)*
    - **handler found**, exception object **passed to the handler**, known as **catching the exception**. 
    - **no handler found**, then **application throws the exception to JRE and terminates the program**.
* Exception handling can be used to **handle runtime errors only not compile time errors**.

![exception-handling]({{site.cdn}}/java/java-exceptions/exception-handling.png)

* Any uncaught exception will eventually be processed by default handler displaying description and stack trace.
* stack trace shows the sequence of method invocations that led up to the error.

## Chained Exceptions
* Associate one exception with another, 2nd exception describes the cause of the first exception.
* example, ArithmeticException (divide by zero), but actually caused by I/O.
* handles such situations in which layers of exceptions exist.
* `initCause()` - associates causeExc after exception has been created, can be set only once.
  * ***initCause( ) can be called only once for each exception object. If cause set by a constructor, you can’t call.***
* initCause( ) is used for legacy exception classes that don’t support two additional constructors described earlier.

## Exception Handling Keywords

### throw
to throw explicitly.
```java
throw new NullPointerException("demo");
```

### throws
unhandled checked exception thrown by a method.
```java
type method-name(parameter-list) throws exception-list{
  ... body of method ...
}
```

### try-catch
- multiple **catch** 
- **catch exception subclasses should be before catch for any of their superclasses**, else ***unreachable code*** compile-time-error.
- **No matching catch, JRE system will handle the exception**.
- Unhandled method exception must be declared in ***throws*** clause, so caller can guard themselves against that exception.

```java
try{
    ...
} catch (ExceptionType1 exOb) {
    ...
} catch (ExceptionType2 exOb) {
    ...
} finally {
    ...
}
```

### finally 
* execute **irrespective of an exception** after try block.
* exception thrown, **finally executes even for no matching catch**.
* useful for **closing resources allocated in the method**. 
* finally clause is **optional**. 
* minimum **try-catch** or **try-finally**.

### Returning value from method having try-catch-finally blocks

* **Case 1**:  return after try-catch-finally blocks ie. just before end of method.
* **Case 2**:  return inside both try block & catch block.
* **Case 3**:  return as last statement in finally block only.
	- **Reason**: finally block always be executed except when ***System.exit(0);*** is invoked explicitly.
	- **Error**: any statement after finally block will result in compile-time error stating “Unreachable code”
* **Case 4.A**:  return inside try block & at the end of method
* **Case 4.B**: return inside both try block & finally block; but no statement after finally block
* **Case 5.A**: return inside catch block & at the end of method.
* **Case 5.B**: return inside both catch block & finally block; but no statement after finally block.
* **Case 6**: return inside try, catch & finally ; but return value will be overridden by return statement in the finally block

```java
public static int divide() {
    try {
        int d = 10 / 5;
        d = 10 / 0;
        System.out.println("want to return 0");
        return 0;
    } catch (Exception e) {
        System.out.println("Exception Caught.");
        return -1;
    } finally {
        // return value is always overridden
        System.out.println("finally Block");
        return 100;
    }
}
```
```
Hello World
Exception Caught.
finally Block
Divide Result : 100
```

|superclass method|subclass method|
|---|---|
|no exception        | No exception or unchecked exceptions *(but strictly no checked exception)*|
|unchecked exception | No exception or unchecked exceptions *(but strictly no checked exception)*|
|checked exception   | No exception or unchecked exceptions or same/subclass of checked exception|

These hold true, even if combination of both checked & unchecked exception is declared in parent class method.

# JDK8 Exception Features

## try-with-resources
automates the process of releasing a resource, such as a file, when it is no longer needed.
```java
try (BufferedReader br = new BufferedReader(new FileReader(path))) {
   System.out.println("MyResource created in try-with-resources");
} catch (Exception e) {
    e.printStackTrace();
}
```

## multi-catch
* `catch(ArithmeticException | ArrayIndexOutOfBoundsException e)`
    - 2 or more exceptions in single catch.
    - Each multi-catch parameter is implicitly **final**.
* final rethrow or more precise rethrow
    - restricts the type of exceptions that can be rethrown to only those checked exceptions that the associated **try** block throws, that are not handled by a preceding **catch** clause, and that are a subtype or supertype of the parameter.

# Best Practices for Exception Handling

|Exception Handling Best Practices|   |
|---|---|
|Use Specific Exceptions|Even JDK has specific Exception: IOException with further sub-classes as FileNotFoundException, EOFException etc.<br>so that caller will easily know the root cause, this makes debugging easy.|
|Throw Early or Fail-Fast|throw exceptions as early as possible to make stack trace shorter and readable.|
|Catch Late|catch exception only if we can handle it appropriately otherwise throw exceptions back to the caller to handle it.|
|Closing Resources|close all resources in finally block or use try-with-resources.|
|Logging Exceptions|always log exception messages and give clear message when throwing.<br>[x] Avoid empty catch blocks|
|Single catch block for multiple exceptions|single catch block reduces code size.|
|Using Custom Exceptions|create a custom exception with error code and caller program can handle these error codes.<br>Its also a good idea to create a utility method to process different error codes and use it.|
|Naming Conventions and Packaging|class name ends with Exception.|
|Use Exceptions Judiciously|Many times it is required to see if some operation worked, return Boolean in that case.|
|Document the Exceptions Thrown|Use javadoc @throws, useful when providing as interface to other applications.|

# Exceptions - FAQ

## What is difference between final, finally and finalize in Java?
* final : keyword 
* finally : related to exception handling
* finalize() : method is executed by Garbage Collector before object is destroyed.

## What is OutOfMemoryError in Java? How did you solved that?
* subclass of java.lang.VirtualMachineError thrown by JVM when it ran out of heap memory.
* when not enough space on heap to allocate that object.
* due to system's limitation (memory) rather than programming.
* Might also be caused by a **memory leak**.

Types of OutOfMemoryError in Java
* The java.lang.OutOfMemoryError: Java heap space
* The java.lang.OutOfMemoryError: PermGen space

```java
$>java MyProgram -Xms1024m -Xmx1024m -XX:PermSize=64M -XX:MaxPermSize=256m
```
This is also a chance to impress interviewer by showing your advanced technical knowledge related to finding memory leaks, profiling and debugging.

## What are different scenarios causing “Exception in thread main”?
* UnsupportedClassVersionError: jdk difference
* NoClassDefFoundError
* NoSuchMethodError: run class without main
* ArithmeticException

## Why do you think Checked Exception exists in Java, since we can also convey error using RuntimeException?
* design decision influenced by experience in programming language prior to Java.
* **checked exceptions** – superclass is **Exception**.
* **unchecked exceptions** – superclass are **RuntimeException** and **Error**.
* Checked exceptions - error scenarios not caused by program, ex. FileNotFoundException
* Unchecked exceptions - caused by poor programming, ex. NullPointerException.
* **checked exceptions in java.io package**, must handle when requested resource not available hence checked Exception. 
* To ensure that system resources are released as soon as you are done with that using catch or finally block.

# Fix the Code

## Fix the code - Q1
```java
public class TestException {
    public static void main(String[] args) {
        try {
            testExceptions();
        } catch (FileNotFoundException | IOException e) {
            e.printStackTrace();
        }
    }
    public static void testExceptions() throws IOException, FileNotFoundException {}
}
```
**Compilation error**
* exception FileNotFoundException is already caught by the alternative IOException
* FileNotFoundException is subclass of IOException

**Fix**
* Keep only IO Exception
* Catch first FileNotFoundException and then IOException 

## Fix the code - Q2
```java
public class TestException1 {
  public static void main(String[] args) {
    try {go();}
    catch (IOException e) { e.printStackTrace();}
    catch (FileNotFoundException e) { e.printStackTrace();}
    catch (JAXBException e) { e.printStackTrace(); }
  }
  public static void go() throws IOException, JAXBException, FileNotFoundException{}
}
```
**Compilation Error**
* Unreachable catch block for FileNotFoundException. It is already handled by the catch block for IOException

## Fix the code - Q3
```java
public class TestException2 {
  public static void main(String[] args) {
    try {foo();}
    catch (IOException e) { e.printStackTrace();}
    catch(JAXBException e){ e.printStackTrace();}
    catch(NullPointerException e){ e.printStackTrace();}
    catch(Exception e){ e.printStackTrace(); }
  }
  public static void foo() throws IOException{}
}
```
**Compilation error**
* “Unreachable catch block for JAXBException. This exception is never thrown from the try statement body”
* JAXBException is a checked exception, must be in throws.
catching NullPointerException is valid, unchecked exception

**Fix**
* remove the catch block of JAXBException

## Fix the code - Q4
```java
public class TestException3 {
  public static void main(String[] args) {
    try{bar();    }
    catch(NullPointerException e){ e.printStackTrace();}
    catch(Exception e){ e.printStackTrace();}
    foo();
  }
  public static void bar(){}
  public static void foo() throws NullPointerException{}
}
```
* trick question, there is no problem with the code and it will compile successfully.
* can always catch Exception or any unchecked exception even if it’s not in the throws

## Fix the code - Q5
```java
public class TestException4 {
	public void start() throws IOException{    }
	public void foo() throws NullPointerException{}
}
class TestException5 extends TestException4{
	public void start() throws Exception{}
	public void foo() throws RuntimeException{}
}
```
**Compilation Error**
* won’t compile, start() signature is not same in subclass.
* IOException => Exception not allowed, can be restrictive checked exception only.

**Fix**
* either change method signature to be same superclass
* remove throws clause from subclass.

## Fix the code - Q6
```java
public class TestException6 {
    public static void main(String[] args) {
        try {
            foo();
        } catch (IOException | JAXBException e) {
            e = new Exception("");
            e.printStackTrace();
        } catch (Exception e) {
            e = new Exception("");
            e.printStackTrace();
        }
    }
    public static void foo() throws IOException, JAXBException {}
}
```
**Compilation Error**
* **object in catch block is final, can’t change it’s value**.
* The parameter e of a multi-catch block cannot be assigned.

## Fix the code - Q7
```java
public static void start() {
    System.out.println("Programmers");
}
public static void main(String args[]) {
    try {
        start();
    } catch (IOException ioe) {
        ioe.printStackTrace();
    }
}
```
**Compilation error**
* IOException is a checked Exception and start() method doesn't throw IOException
* Exception java.io.IOException is never thrown in body of corresponding try statement

## Fix the code - Q8
```java
public class SuperClass {
    public void start() throws IOException {
        throw new IOException("Not able to open file");
    }
}
public class SubClass extends SuperClass {
    public void start() throws Exception {
        throw new Exception("Not able to start");
    }
}
```
**Compilation Error**
* Override, checkedException a subclass of it
* IOException or any sub class of IOException but not super class of it e.g. Exception.

## Fix the code - Q9
```java
public static void start() throws IOException, RuntimeException {
    throw new RuntimeException("Not able to Start");
}
public static void main(String args[]) {
    try {
        start();
    } catch (Exception ex) {
        ex.printStackTrace();
    } catch (RuntimeException re) {
        re.printStackTrace();
    }
}
```
**Compilation error**
* exception java.lang.RuntimeException has already been caught.
* Exception is super class of RuntimeException.

