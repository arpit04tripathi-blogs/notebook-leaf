---
layout: page
title: Core Java
permalink: /java/core
---

- TOC
{:toc}

---

# Java’s Magic - The ByteCode

![bytecode]({{site.cdn}}/java/core-java/bytecode.png)

- **Bytecode**
  - highly optimized set of instructions executed by JVM.
  - Java compiler creates bytecode rather than executable code.
- **JVM**
  - originally designed as an *interpreter for bytecode*.
  - JVM is implemented for each platform hence portability of bytecode.
- **JIT compiler**
  - selected portions of bytecode are compiled into executable code, on a piece-by-piece demand basis.
  - JIT compiles code as it is needed, during execution. 
  - Entire Java program not compile to executable code all at once, as various run-time checks happen.
  - Not all sequences of bytecode are compiled, only those that will benefit from compilation, remaining code is simply interpreted.

# PATH vs CLASSPATH

- **NoClassDefFoundError** and **ClassNotFoundException** both occur when class is not found at runtime.
- Due to incorrect/misconfigured CLASSPATH.

**PATH**
* JDK_HOME/bin added to PATH env variable. 
* can’t be overridden by any Java settings. 
* OS finds binary and command typed in shell. Example - java, javac.
* Windows - set PATH=%PATH%; C:\Program Files\Java\JDK1.6.20\bin
* UNIX/Linux - export PATH = ${PATH}:/opt/Java/JDK1.6.18/bin

**CLASSPATH**
* Used by classloader to find bytecodes stored as .class. 
* Inicludes all directories with .class and JAR file required by your Java application. 
* can be overridden by command line: -classpath or -cp to both "java" and "javac" or by using ClassPath attribute in Manifest file inside JAR archive.
* Windows         - set CLASSPATH = %CLASSPATH%;C:\ProgramFiles\Java\JDK1.6.20\lib
* UNIX/Linux     - export CLASSPATH=${CLASSPATH}:/opt/Java/JDK1.6.18/lib

## ClassNotFoundException
- Occurs when you try to load a class at runtime using Class.forName() or loadClass() methods and requested classes are not found in classpath.
- This is a checked Exception derived from java.lang.Exception class and you need to provide explicit handling for it.
- Common Scenario - We try to run application without updating classpath with JAR files.
- This exception also occurs when you have two class loaders and if a ClassLoader tries to access a class which is loaded by another classloader in Java.
- **Java ClassLoader** is a part of Java Runtime Environment that dynamically loads Java classes in JVM(Java Virtual Machine). The Java Runtime System does not need to know about files and files system because of classloaders.

## NoClassDefFoundError
- Occurs when class was present during compile time and program was compiled and linked successfully but class was not present during runtime.
- It is error which is derived from **LinkageError**.
  - Linkage error occurs when a class has some dependencies on another class and latter class changes after compilation of former class. NoClassFoundError is the result of implicit loading of class because of calling a method or accessing a variable from that class.
- This error is more difficult to debug and find the reason why this error occurred. So in this case you should always check the classes which are dependent on this class.

## ClassNotFoundException Vs NoClassDefFoundError
- ClassNotFoundException is an exception while NoClassDefFoundError is an error.
- ClassNotFoundException occurs when classpath is does not get updated with required JAR files while error occurs when required class definition is not present at runtime.

# Public vs Private 

**JRE** environment, bunch of directories with Java-related files:
* /bin - executable programs java and javaw
* /lib - supporting files: jars, config files, property files, fonts, sounds, icons etc. 
	- most important is **rt.jar** containing "java API".

![public-vs-private-jre]({{site.cdn}}/java/core-java/public-vs-private-jre.png)

* JDK installation brings private JRE and optionally a public copy.
* **private JRE**
	- is required to run the tools included with the JDK and have no registry settings.
	- is contained entirely in a jre directory whose location is known only to the JDK. 
* **public JRE**
	- used by other Java apps, outside the JDK 
	- it is registered with the Windows registry (at HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft), 
	- can be removed using Add/Remove Programs, 
	- might be registered with browsers, 
	- might have the java.exe file copied to the Windows system directory.
	- (C:\Program Files\Java\jre1.7.0)

# Java Buzzwords

* ***Object-Oriented*** - Object model is easy to extend, while primitive types are kept as high-performance non-objects.
* ***Multithreaded*** - supports multithreaded programming.
* ***Architecture-Neutral*** – portability. OS/Processor/Core upgrades don’t affect the code. (“Write once; run anywhere, forever”.)
* ***Robust*** - Strictly typed language (compile and run-time checks). 
* ***Interpreted, High Performance and cross-platform*** - compiled to bytecode, JVM implementation executes it.
* ***Distributed*** - designed for distributed env as it handles TCP/IP protocols, supports Remote Method Invocation (RMI).

**Que. What are the main reasons for Program Failure?**
* **Memory Management** - Java manages memory allocation/deallocation (deallocation fully automatic, by garbage collector).
* **Exception Handling** - such as division by zero, “file not found,”. These run-time errors should be managed by program.

**Que. Why Java Doesn’t Support Pointers?**
* They provide to illegal access of data (exact address of the data) and arithmetic operation can be done on it.
* Due to leading lack of security pointers concept was removed from java.
* reference variables are used to avoid illegal access. It prints **packagename.classname@hexadecimal** rather than address.
* JVM implicitly does all pointer related manipulations and only references are used by the program.
* Pointers would have made garbage collection impossible.
* **main( )** - simply a starting place for your program, in some cases not needed example – web apps.

# Datatypes

## Identifiers

* **valid identifiers** - AvgTemp, count, a4, $test, this_is_ok
* **Invalid identifier** - 2count, high-temp, Not/ok
* **Java Keywords**: 50 keywords,
	- cannot be used as identifiers.
	- const, goto reserved but not used.

|identifiers|||||
|---|---|---|---|---|
package     | import 	| 
interface   | abstract  | class     | extends   | implements    |
private 	| default   | protected | public    | 
final       | static    | transient | volatile  | synchronized  |
return      | new       | void      | 
if          | else      | switch    | case      |
do          | while     | for       | continue  | break         |
short       | byte      | int       | long      | double        |
boolean     | strictfp  | float     | char      |
try         | catch     | finally   | throw     | throws        |
assert      | const 	| instanceof|
this        | super
goto 		| native 	| enum      |

## Primitive Datatype

* 8 primitive types represent single values, used for efficiency.
* Wrapper objects degrade performance for basic operations.
* Due to portability requirement, all data types have a strictly defined range.
  * example, int always 32 bits on all platform.
* **Integers** : byte, short, int, long
* **Floating-point** : float, double
* **Characters** : char
* **Boolean** : boolean

Name	| bytes | bits	| Range (From)					| Range (To)                | Deafult   | Note
---		|---    |---	| ---							| ---                       | ---       | ---
byte 	| 1     | 8 	| –128							| 127                       | 0         |
short 	| 2     | 16 	| –32,768						| 32,767                    | 0         |
int 	| 4     | 32 	| –2,147,483,648				| 2,147,483,647             | 0         | 2x10^9                        |
long 	| 8     | 64 	| –9,223,372,036,854,775,808	| 9,223,372,036,854,775,807 | 0         | 9x10^18                       |
float	| 4     | 32	| 1.4e–045						| 3.4e+038                  | 0.0f      | 6-7 significant decimal digits
double	| 8     | 64	| 4.9e–324						| 1.8e+308                  | 0.0d      | 15 significant decimal digits
char	| 2     | 16    | 0                             | 65,536                    | '\u0000'  | unsigned
boolean	|       |       | true or false                 |                           | false     | 

* *byte*, *short*, *int*, and *long*. All of these are signed, positive and negative values. 
* Java, highorder-bit managed by adding **unsigned right shift** (`>>>`) operator, need for unsigned integer eliminated.

|Integers||
---     |---
byte    | for stream of data from a network or file. 
int     | used to control loops and indexes in arrays. For expression evaluation - byte/short promoted to int.
long    | used when large values as result. ex. Speed_of_light, lightyear.
float   | Single precision with less space, used for a fractional component, but not require a large degree of precision.
double  | when need accuracy over many iterative calculations.

* Java uses **16-bit Unicode** for characters, for global portability ranging 0 to 65,536.
	- ASCII are 0 to 127, extended 8-bit character set, ISO-Latin-1, ranges from 0 to 255. 
	- can also be used as an integer type to perform arithmetic operations. example, add two chars or increment value.

## Type Wrappers

Type wrappers - encapsulate a primitive type within an object.

|Type Wrapper|  |Get Primitive|
|---        |---|---|
|Boolean    | Boolean(boolean boolValue) , Boolean(String boolString)   |
|Double     |                                                           | double doubleValue( ) |
|Integer    | Integer(int num) , Integer(String str)	                | int intValue( )       |
|Float      |                                                           | float floatValue( )   |
|Short      |                                                           | short shortValue( )   |
|Long       |                                                           | long longValue( )     |
|Byte       |                                                           | byte byteValue( )     |
|Character  | Character(char ch)                                        | char charValue( )     |

* If str is not a valid numeric value, NumberFormatException.
* Byte, Short, Integer, Long, Float, Double - inherit the abstract class Number.
* boxing – primitive to Object
* unboxing – Object to primitive

```java
Integer iOb = new Integer(100);
int i = iOb.intValue();
```

* **Autoboxing** - automatically primitive to Object (wrapper, encapsulated, boxed).
* **Auto-unboxing** - boxed object value is automatically extracted (unboxed). No need to call intValue(), doubleValue() etc.

```java
Integer iOb = 100; 	// autobox an int
int i = iOb;   		// auto-unbox
++iOb;         		// unboxes iOb,performs the increment, and then Reboxes the result back into iOb.
Double a, b, c;    	// A bad use of autoboxing/unboxing!
a = 10.0; b = 4.0; 	// far less efficient than what could be written using double
c = Math.sqrt(a*a + b*b);
```

## Literal Representation

|Representation||
---         |---
Octal       | leading zero, normal decimal numbers cannot have a leading zero.
Hexadecimal | leading zero-x, (0x or 0X).
Long        | 0x7ffffffffffffffL or 9223372036854775807L is the largest long.
Binary      | prefix the value with 0b or 0B.

```java
int x = 123_456_789;            // the value given to x will be 123,456,789.
int x = 0b1101_0101_0001_1010;  // underscores discarded on compile
```

### Floating-Point Literals
* suffix that specifies a power of 10 - 6.022E23, 314159E–05, and 2e+100.
* A floating-point literal is of type float if it ends with the letter F or f.
* otherwise its type is double and it can optionally end with the letter D or d .
* Hexadecimal floating-point literals - 0x12.2P2(=72.5).
  * P is called **binary exponent**, power-of-two to be multiplied.

![octal-decimal-computation]({{site.cdn}}/java/core-java/octal-decimal-computation.png)

### Character Literals
* directly as 'a', 'z', and '@'. 
* octal notation, ' \141' is the letter 'a'. 
* hexadecimal, '\u0061' is 'a'.

Escape Sequence	| Description
---|---
\r 		| Carriage return
\n 		| New line (line feed)
\f 		| Form feed
\t 		| Tab
\b 		| Backspace
\ddd 	| Octal character (ddd)
\uxxxx 	| Hexadecimal Unicode (xxxx)
\' 		| Single quote
\" 		| Double quote
\\ 		| Backslash

## Type Casting

* compatible types, implicit conversion, assign int value to a long variable. (***widening***)
* incompatible types, use a cast for explicit conversion between incompatible types. (***narrowing***)

### Automatic Type Promotion in expression
```java
byte b = 50;
b = b * 2; // Error! Cannot assign an int to a byte!
b = (byte) b * 2;
double result=(f*b)+(i/c)-(d*s);
```

- boolean --> int
- byte --> int
- char --> int
- short --> int
- int --> int
- long --> long
- float --> float
- double --> double
- reference --> reference
- returnAddress --> returnAddress

## Arrays in Java

- **Array** : common name for homogeneous collection accessible by index.
- ***length*** - array capacity to hold elements, not element count.

```java
// month_days is an array variable, no array actually exists
int month_days[];
// Links with an actual, physical array of integers. Memory allocated.
month_days = new int[12];
// array initializer
int month_days[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
```

### Multidimensional arrays 
* arrays of arrays. 
* new statement - ***leftmost dimension required mandatorily***.
* default value for new    : 
	- zero (for numeric types)
	- false (for boolean)
	- null (for reference types)

```java
int twoD[][] = new int[4][];        // leftmost dimension required
System.out.println(twoD.length);    // prints 4
System.out.println(twoD[0]);        // prints null
twoD[0] = new int[5];
twoD[1] = new int[5];
twoD[2] = new int[5];
twoD[3] = new int[5];
```

![2d-array]({{site.cdn}}/java/core-java/2d-array.png)

### Irregular array – sparsely populated 2D array

```java
char twod1[][] = new char[3][4];
char[][] twod2 = new char[3][4];
```

# Java Operators

![operator-priority]({{site.cdn}}/java/core-java/operator-priority.png)

## Bitwise Operators
* Java uses ***2’s complement for zero crossing issue.***
* 0 is 00000000, while 1’s complement 11111111 which is -ve 0.
* left shift on a byte or short value will be an int, bits not lost till they get past 31st.
* **negative byte/short are sign-extended when promoted to int**, higher order filled as 1. This is why need to discard higher order bits by type-casting result back.

![bit-operator]({{site.cdn}}/java/core-java/bit-operator.png)

## Right Shift
* msb (most significant bits) filled with previous content ie. sign extension to preserve sign.

```java
00100011 (35) >> 2      // 00001000 which is 8
11111000 (-8) >> 1      // 11111100 which is –4
int a = -1;             // 11111111 11111111 11111111 11111111 –1 in binary as an int
a = a >>> 24;           // 00000000 00000000 00000000 11111111 255 in binary as an int
```

## Short-Circuit Logical Operators
* **OR**    : true when A is true, no matter what B is.
* **AND**   : false when A is false, no matter what B is.

```java
int x, y, z;
x = y = z = 100;                // set x, y, and z to 100
ratio = (d==0) ? 0 : num/d;
```

# Control Statements

## Switch
* Duplicate case values are not allowed.
* each value must be compatible with the type of expression.
* default statement is optional. 
* **break for each case in switch to terminate a statement sequence.**
* break statement is optional. 
* **omit break, execution will continue on into the next case.**
* **switch can test for equality only.**
* switch **more efficient** than nested if **as its pre-compiled because compiler prepares a jump-table**.

```java
switch (expression) {
	case value1:        // statement sequence
		break;
	case value2:        // statement sequence
		break;
	...
	case valueN :       // statement sequence
		break;
	default:            // default statement sequence
		break;
}
```

## While Loop
```java
while(condition) {
    // body of loop
}
```
```java
do {
    // body of loop
    // useful when you process a menu selection.
} while (condition);     
```

## For Loop
```java
for(int n=10; n>0; n--){
    System.out.println("tick " + n);
}
for( ; ; ) {...}  // infinite loop
for(int i=0, j=0 ; i<n, j<n ; i++,j++){} // double loop variables
```

## For-Each
```java
for(int x: nums){ sum += x; }
for(int x: nums) { x = x * 10;}    // no effect on nums
```

## Iterating Over Multidimensional Arrays
```java
for (int x[]: nums) {
    for (int y: x)
        System.out.println("Value is: " + y);
    sum += y;
}
```
```java
int sum = 0;
int nums[][] = new int[3][5];
for (int i = 0; i < 3; i++)
    for (int j = 0; j < 5; j++)
        nums[i][j] = (i + 1) * (j + 1);
```

## Jump Statements
* Statements that change the flow of execution.
	- break, continue, and return. 
	- exception handling.

```java
// Using break as a civilized form of goto.
class Break {
    public static void main(String args[]) {
        boolean t = true;
        first: {
            second: {
                third: {
                    System.out.println("Before the break.");
                    if (t) break second;                        // break out of second block
                    System.out.println("This won't execute");
                }
                System.out.println("This won't execute");
            }
            System.out.println("This is after second block.");
        }
    }
}
```
Since the loop labeled **one** does not enclose the **break** statement, it is not possible to transfer control out of that block.
```java
// This program contains an error.
class BreakErr {
    public static void main(String args[]) {
        one: for (int i = 0; i < 3; i++) {
            System.out.print("Pass " + i + ": ");
        }
        for (int j = 0; j < 100; j++) {
            if (j == 10) break one;                 // WRONG
            System.out.print(j + " ");
        }
    }
}
```
## Continue 
* continue loop but skip further processing for this particular iteration. 
* For while and do-while loops, continue gives control to conditional expression of the loop. 

## Return
* explicitly return from a method to transfer back to the caller of the method. 
* return statement immediately terminates the method. 

# Classes

* Defines a new data type, works as a template. 	
* class is logical construct while object has physical reality.
  * object occupies space in memory.
* variables defined within a class are called ***instance variables***.
* ***constructor*** used for initialization on creation.

```java
ClassName(){ }
```

## Assigning Object reference variables
![assign-object]({{site.cdn}}/java/core-java/assign-object.png)

## Constructors

* Constructors has no return type, not even **void**, because implicit return type is the class type itself.
* default constructor initializes all instance variables to their default values. (0, null, false).

**Why Java Static Constructor is not allowed?**
- ***Static Belongs to Class, Constructor to Object.***
  - Constructor is not class property, it makes sense that it’s not allowed to be static.
- ***Static Block/Method can’t access non-static variables***
  - while constructors are used to initialize instance variables.
  - this - Cannot use this in a static context.
- ***Static Constructor will break inheritance***
  - In java class hierarchy, subclass constructor calls superclass constructor using super() method (JVM calls implicitly).
  - super() method, it’s not static. So if the constructor becomes static, we won’t be able to use it and that will break inheritance in java.

**Java Static Constructor Alternative**
- To initialize some static variables in the class, you can use static block.
- We can’t pass arguments to the static block, so if you want to initialize static variables then you can do that in the normal constructor too.

## Variables and scopes

* **Variables**
	- basic unit of storage. (type+Identifier+optional initializer).
	- Have scope(visibility) and a lifetime.
* **Scope** - section of code where var is acessible. 
* **Lifetime** - time duration till var in a valid state, even if out of scope.

|variable scopes||
|---|---|
protected | when inheritance is involved.
public | accessible by any other code. 
private | accessed by other members of its class.
default | no access modifier, cannot be accessed outside of its package. 

* Now you can understand why **main( )** has always been preceded by the **public** modifier.
  * It is called by code that is outside the program—that is, by the Java run-time system.
* In most real-world classes, you will need to allow operations on data only through methods (getX and setX).

## Object Class

* Object - superclass of all classes.
* reference variable of type Object can refer to any object, even to an array.
* getClass(), notify(), notifyAll(), and wait() are declared as final. You may override the others.

### Methods for class : Object

|Object Class Methods||
|---|---|
Object clone( ) 	        |final void notify( ) 
int hashCode( ) 	        |final void notifyAll( ) 
boolean equals(Object obj) 	|final void wait( ), void wait(long milliseconds)
void finalize( ) 	        |final void wait(long milliseconds, int nanoseconds)
String toString( )	        |final Class<?> getClass()

### Ways to create Object

1. Using the new keyword
2. Using Class.newInstance() from class Class, It calls the no-arg constructor to create the object.
3. newInstance() method of Constructor class
4. Using clone() method
5. Using deserialization

```java
Employee.class.newInstance(); OR
(Employee) Class.forName("org.package.Emp").newInstance();
```

```java
Constructor<Emp> constructor = Emp.class.getConstructor(); 
Emp emp3 = constructor.newInstance();
```

```java
(Employee) emp3.clone();
```

```java
ObjectInputStream in = new ObjectInputStream(new FileInputStream("data.obj")); 
Employee emp5 = (Employee) in.readObject();
```

In above bytecodes all 4 methods call get converted to invokevirtual (object creation is directly handled by these methods) except the first one which got converted to two calls one is new and other is invokespecial (call to the constructor).

|Class.newInstance()|java.lang.reflect.Constructor.newInstance()|
|---|---|
|can only invoke the no-arg constructor|Can invoke any constructor, regardless of the number of parameters.|
|requires that the constructor should be visible|Can also invoke private constructors under certain circumstances.|
|throws any exception (checked or unchecked) thrown by the constructor|Always wraps the thrown exception with an InvocationTargetException.|

* Due to above reasons **Constructor.newInstance() is preferred over Class.newInstance()**, that’s why used by various frameworks and APIs like Spring, Hibernate, Struts, Guava, Zookeeper, Jackson, Servlet etc.
  * Both newInstance() methods are known as reflective ways to create objects.
  * In fact newInstance() method of Class class internally uses newInstance() method of Constructor class.
* Whenever we call clone() on any object JVM actually creates a new object for us and copy all content of the previous object into it. 
  * Creating an object using clone method does not invoke any constructor.
  * To use clone() method on an object we need to implements Cloneable and define clone() method in it.
* Whenever we serialize and then deserialize an object JVM creates a separate object for us.
  * In deserialization, JVM doesn’t use any constructor to create the object.
  * To deserialize an object we need to implement the Serializable interface in our class.

## Math class - Math.pow

## Inner class

* define class within a class, ***nested classes***. 
* It is a member of its enclosing class.
  * scope is bounded by the scope of its enclosing class. 
* B defined within A, then B ***does not exist independently*** of A.
* **nested class can access even private members of the container class but not vice-versa**. 
* They are **particularly helpful when handling events**.

### Static nested class
* cannot refer to non-static members of its enclosing class directly, so they are seldom used.

### Inner class
* inner class is a **non-static nested class**.
* has access to all of the variables and methods of its outer class, including private also.
* instance of **Inner** created only in context of **Outer** class otherwise compile-time error.
* can define a nested class within a method block or even in the body of a **for loop**.

## Anonymous Inner class

- Inner class without a name.
   - for which only a single object is created.
- Useful when making an instance of an object with certain “extras” such as overloading methods of a class or interface, without having to actually subclass a class.
- Application - In writing implementation classes for listener interfaces in graphics programming.

### Types of anonymous inner class
**Anonymous Inner class that extends a class**
```java
class MyThread { 
	public static void main(String[] args){ 
		Thread t = new Thread(){ 
			public void run() { 
				System.out.println("Child Thread"); 
			} 
		}; 
		t.start(); 
		System.out.println("Main Thread"); 
	}
} 
```

**Anonymous Inner class that implements a interface**
```java
class MyThread { 
	public static void main(String[] args){ 
		Runnable r = new Runnable(){ 
			public void run(){ 
				System.out.println("Child Thread"); 
			} 
		}; 
		Thread t = new Thread(r);
		t.start(); 
		System.out.println("Main Thread"); 
	} 
} 
```

**Anonymous Inner class that defines inside method/constructor argument**
```java
class MyThread {
    public static void main(String[] args) {
        Thread t = new Thread(new Runnable() {
            public void run() {
                System.out.println("Child Thread");
            }
        });
        t.start();
        System.out.println("Main Thread");
    }
}
```

## Class vs Anonymous Inner class

- **Normal class**
  - Can extend a class and implement any number of interface simultaneously.
  - Can write any number of constructors
- **Anonymous Inner class**
  - can either extend a class or implement an interface, but not both at a time.
  - Cant write any constructor

## Immutable Class

### Create Immutable
* Declare the class as **final** so it can’t be extended.
* Make all **fields private** so that direct access is not allowed.
* **Don’t provide setter** methods for variables
* Make **all mutable fields final** so that it’s value can be assigned only once.
* **Initialize all the fields via a constructor performing deep copy**.
* Perform **cloning** of objects **in the getter methods to return a copy** rather than returning the actual object reference.

### Types of Immutabilty

- **Technically Immutable**
  * state doesn't change after construction, includes primitive wrapper classes.
  * only inlined compile time constants are effectively immutable in true sense.
  * ***even this immutable object can be changed using reflection, however that is usually ignored for the purposes of discussing immutability***.

```java
public class Integer {
    private final int value;
}
```

- **Logically Immutable**
  * A class is logically immutable provided the exposed interface never changes.
  * internal state can change to cache calculated values but does not change the result of any combination of methods (though the timing of those methods could change).
  * **field hash** - can change, but the class is logically immutable as the only change is to cache a derived result and there is no way the caller can tell the difference using normal methods calls.

```java
public final class FinalClassExample {
    private final int id;
    private final String name;
    private final HashMap<String,String> testMap;

    public int getId() {
        return id;
    }
    public String getName() {
        return name;
    }
    /*Accessor function for mutable objects*/
    public HashMap<String,String> getTestMap() {
        return (HashMap<String,String>) testMap.clone();
    }
    /*Constructor performing Deep Copy*/
    public FinalClassExample(int i, String n, HashMap<String,String> hm) {
        System.out.println("Performing Deep Copy");
        this.id = i;
        this.name = n;
        /* Shallow Copy */
        this.testMap = hm;
        /* Deep Copy */
        this.testMap = deepcopy(hm);
    }

    private HashMap<String,String> deepcopy(HashMap<String,String> hm){
        HashMap<String,String> tempMap = new HashMap<String,String>();
        String key;
        Iterator<String> it = hm.keySet().iterator();
        while (it.hasNext()) {
            key = it.next();
            tempMap.put(key, hm.get(key));
        }
        return tempMap;
    }
}
```
For a Date Field,
```java
public Date getDate() {
    return this.date;                       // This will make your class mutable.
    return new Date(this.date.getTime());   // date field cannot be changed.
}
```

### String Class (final)
```java
public final class String {
    /*Cache the hash code for the string */
    private int hash;          // Default to 0
    public int hashCode() {
        int h = hash;
        int len = count;
        if (h == 0 && len > 0) {
            int off = offset;
            char val[] = value;
            for (int i = 0; i < len; i++)
                h = 31*h + val[off++];
            hash = h;
        }
        return h;
    }
}
```

# Methods

## Passing Argument

* ***call-by-value***
  * copies the value of an argument into the formal parameter.
  * Changes have no effect on the argument.
* ***call-by-reference***
  * a reference to an argument is passed. 
  * Changes made affects the actual argument.
* call-by-value and call-by-reference
	- primitive type ==> passed by value. 
	- object ==> effectively call-by-reference.

## VarArgs - Variable Length Arguments

### Using Command-Line Arguments
* variable number of arguments to methods. (varargs method)
* A variable-length argument is **specified by three periods (…)**.
* Example - command-line arguments stored as String[] are passed to main() when you run the app.

```java
static void vaTest(String msg, int...v) {
    for (int x: v) System.out.print(x + " ");
}
vaTest("hi");
vaTest("hi", 1, 2, 3);
int doIt(int a, int b, int...vals, boolean stopFlag) {
    // Error!
}
```

### Restrictions
* vararg should be the last.
* Only one vararg parameter is allowed

### varargs method overloading
* Different type of vararg parameter - vaTest(int ...) and vaTest(boolean ...).
* add 1 or more normal parameters.

### Varargs and Ambiguity
```java	
static void vaTest(int ... v) { 
static void vaTest(boolean ... v) {
static void vaTest(String msg, int ... v) {
vaTest(); // Error: Ambiguous!
```
```java
static void vaTest(int ... v) { // ...
static void vaTest(int n, int ... v) { // ...
vaTest(1)
```

## Method Overloading

* Method overloading = **compile-time polymorphism**
* ***type and number of arguments*** used to identify the version in use. 
* ***may have different return types.***
* In C, abs( ) - integer, labs( ) - long, fabs( ) - floating-point value.
* Sometimes, **automatic type conversions can help in overload resolution.**

```java
class OverloadDemo {
    void test() {}
    void test(int a, int b) {}
    void test(double a) {}
    
    public static void main(String args[]) {
        OverloadDemo ob = new OverloadDemo();
        int i = 88;
        ob.test(i);     // this will invoke test(double)
    }
}
```

### Overloading vs Overriding

#### What is Overloading?
* two methods with same name but different method signature.
* Overloaded in the same class.
* Overloaded methods binded by [static binding](https://javarevisited.blogspot.com/2012/03/what-is-static-and-dynamic-binding-in.html) at compile time. 
* During compilation, method calls binded to actual methods.
* Overloaded methods are **fast due to this compile-time binding as no check or binding required during runtime**.
* **Two overloaded methods must have a different signature.**
* **Method signature** in Java consist of:
	* number of arguments.
	* Type of argument.
	* Order of argument.
	* ***return type is not*** part of method signature.

#### What is Overriding?
* You can only override method in sub class, not in the same class.
* method with same name and signature in super and sub class or interface and implementation. 
* **can not override private, static and final method** in Java as they are binded at **compile time (static binding)**.
* **private and static method can be hidden (method hiding)**, same name and signature in sub class.
* Overridden method is **binded at runtime, dynamic binding**.
* override all abstract method unless your class is not abstract if you are extending abstract class or implementing interface.
* **@Override** while overriding a method.
  * **annotation not compulsary, but highly recommended**. 
  * It helps prevent the case when you write a function that you think overrides another one but you misspelled something and you get completely unexpected behavior.

#### Method hiding in Java
```java
Parent parent = new Child();
Child child = new Child();
parent.staticMethod();	        // Parent Static Method is called
parent.nonStaticMethod          // Child's Non Static Method is called
child.staticMethod              // Child's Static Method is called
```

### Rules of overriding (restricting is allowed)

- **Access Modifier**
  * can increase accessibility, but cannot reduce.
  * **can not** reduce accessibility. `public ==> protected [x]`
  * **can** increase accessibility.   `protected ==> protected or public`
- **Exception - Checked Exception**
  * can change to throw subtype of checked exception but not the supertype.
  * **can not** throw checked Exception which is higher in hierarchy. `IOException ==> java.lang.Exception [x]`
    * Above rule **doesn't apply to RuntimeException** as it’s not needed to be declared in throws clause.
  * **change the number of exceptions** - Yes, exceptions must be compatible with throws clause of super
- **Exception - Unchecked Exception**
  * **unchecked to checked** – **No** `[x]`
  * **checked to unchecked** – Yes, reverse is not possible. 
    * SQLException to NumberFormatException - Yes
  * **Without throws clause to with throws** – Yes, Unchecked only.

### Overriding FAQ

#### What is co-variant method overriding?
* original method returns class X, then overridden method **can return sub class** of X.
* this removes casting at client end.
* Example, clone() method originally returns Object, but with co-variant overriding clone return **java.util.Date**.

#### Can you prevent overriding a method without using final modifier?
Yes, private constructor. 
* Now, its not possible to extend that class because its constructor will not be accessible in sub class, which is automatically invoked by sub class constructor.
* used in Singleton design pattern, private constructor and static getInstance() to access singleton instance. 
* Use Modifiers – final / static / private

#### Questions
* **Can we override a non-static method as static in Java?** - No, compile time error.
* **How do you call super class version of an overriding method in sub class?** - super.parentMethod().
* **Can we override constructor in Java?** - No, constructor are not inherited.
* **Can you overload or override main() method in Java?**
	- **cannot override**, static method.
	- **can overload**, but still JVM will always call `public static void main(String args[])`.

# Keywords

## this

```java
Box(double w, double h, double d) {
    this.width = w;
    this.height = h;
    this.depth = d;
}
```

* **this** - refer to the object that invoked it.
* **Instance Variable Hiding** - local variable with same name as an instance variable, hides the instance variable.

## static

* static (methods and variable), are **class level** and **can be accessed without reference to any object**. ex. main()
* **main()** is declared as **static** because it **must be called before any objects exist**.
* static variables are **shared among all instances of the class**.
* When objects of its class are declared, **no copy of a static variable is made**.

**static methods restrictions**
* Can call only other static methods.
* Can only access static data. 
* cannot refer to this or super in any way.

**static block**
> Read full article on [static block](https://docs.oracle.com/javase/tutorial/java/javaOO/initial.html){:target="_blank"}.

* executed before the main() at class load time, 
* used to do computation for initializing your static variables.
* **Static initialization blocks** are executed when the class is loaded, and you can initialize static variables in those blocks.
* A class can have any number of static initialization blocks, and they can appear anywhere in the class body.  
* The runtime system guarantees that static initialization blocks are called in the order that they appear in the source code.

```java
static {
    // whatever code is needed for initialization goes here
}
```

Alternative to static blocks
- you can write a **private static method**.
- **Advantage** : can be reused later if you need to reinitialize the class variable.

```java
class Whatever {
    public static varType myVar = initializeClassVariable();
    private static varType initializeClassVariable() {
        // initialization code goes here
    }
}
```

**Static class**
* can use only with inner class. 
* nested class which is a static member of the outer class.
* Accessed as OuterClass.*
* static nested class does not have access to the instance variables and methods of the outer class.

## final

* final in java are by **default read-only**.
* class, method, and variables. 
* static final constant.
* **Cannot change reference after assigning (compile error)**.
* final member variable must be **initialized on declaration or via constructor**.
* Only final variable is accessible inside anonymous class in Java. (Anonymous Inner Class without a name)
* **interface variables are implicitly final**.

### final variables in Java

```java
public static final String LOAN = "loan";
LOAN = new String("loan")                   //invalid compilation error
```

* final reference variable of collection means **only reference can not be changed but you can update** the same collection.

```java
private final List loans = new ArrayList();
loans.add("home loan");                     //valid
loans.add("personal loan");                 //valid
loans = new Vector();                       //not valid
```

### final method in Java
* can not be overridden.
* when method is complete and its behavior should remain constant in sub-classes. 
* final methods are faster than non-final methods because they are not required to be resolved during run-time.
* final methods are bonded **during compile time** also called **static binding**.

```java
class PersonalLoan{
    public final String getName(){return "personal loan";}
}
```
```java
class CheapPersonalLoan extends PersonalLoan{
    @Override
    public final String getName(){ return "cheap personal loan";}
    //compilation error: overridden method is final
}     
```

* Inlining is an option only with final methods. 
* Normally, **methods calls are dynamically resolved at run time**, called **late binding**. 
* As final methods cannot be overridden, method call can be **resolved at compile time**, called **early binding**.
* Here, Compiler is free to inline calls to final methods as they cannot be overridden by a subclass.
* When a small final method is called, often the **Java compiler can copy the bytecode for the subroutine directly inline with the compiled code of the calling method**, thus eliminating the costly overhead associated with a method call.

### final Class in Java
* **cannot be inherited**.
* example: **String, Integer and other wrapper classes**.
* **methods of final class are implicitly final**. 

```java
final class PersonalLoan {}
class CheapPersonalLoan extends PersonalLoan {
    //compilation error: cannot inherit from final class
}
```

### Benefits of final keyword 
* final keyword improves performance.
* JVM and application can cache final variable.
* **Safe to share in [multi-threading](https://javarevisited.blogspot.com/2011/02/how-to-implement-thread-in-java.html) environment without additional synchronization overhead**.

### final and Immutable Class in Java
* can not be modified once created. Example – **String**. 
* required to **make a class immutable** in java.
* Immutable classes are read-only and safely shared in between multiple threads without any synchronization overhead.

# Packages

* containers for classes, **makes namespace compartmentalized to avoid name collisions**.
* naming and visibility control mechanism. 
* default package has no name, not advisable.
* file system directories used to store packages.
* package java.awt.image;         // stored in java\awt\image

## Finding Packages and CLASSPATH
* Java run-time system, by default, uses current working directory and subdirectories as its starting point.
* CLASSPATH environmental variable - specify directory path or paths.
* -classpath option with java and javac.

## Importing Packages
* import statement **brings certain classes, or entire packages, into visibility**.
* **can use Class names (instead of fully qualified names)**.
* 2 class of same name for 2 packages, use fully qualified for one of them.

# Interfaces

* Specifies the set of methods to be implemented, it defines what a class must do, but not how it does it.
* class can implement more than 1 interface, but ***can only inherit a single superclass due to Diamond Problem***.
* designed to support dynamic method resolution at run time. 
* `class classname [extends superclass] [implements interface [,interface...]] { // class-body }`
* declared methods have no bodies, **essentially abstract methods**.
* All variables are implicitly ***public static final*** (cannot be changed and must be initialized). 
* All methods are implicitly ***public***.
* method signature must remain same in implementing class as in ***interface***.

```java
access interface name {
  return-type method-name1(parameter-list);
  return-type method-name2(parameter-list);
  type final-varname1 = value;
  type final-varname2 = value;
  //...
  return-type method-nameN(parameter-list);
  type final-varnameN = value;
}
```

## Accessing Implementations via Interface References
* interface references for any instance of implementation, method to be executed is looked up dynamically at run time.
* interface reference variable knows only about methods declared by **interface** declaration.
* class must be declared as **abstract** if all methods of interface are not implemented. 

## Nested Interfaces
* as a member of class or another interface, a member interface or a nested interface. 
* A nested interface can be declared as **public**, **private**, or **protected**.
* differs from a top-level interface, which must either be **public** or **default**.
* Outside defining parent class/interface, its name must be fully qualified.

```java
class A {
    public interface NestedIF {
        boolean isNotNegative(int x);
    }
}

// B implements the nested interface.
class B implements A.NestedIF {
    public boolean isNotNegative(int x) {
        return x < 0 ? false : true;
    }
}

class NestedIFDemo {
    public static void main(String args[]) {
        A.NestedIF nif = new B();
        if (nif.isNotNegative(10))
            sysout("10 is not negative");
    }
}
```

## Practical Example
* Stack interface, **push()** and **pop()**, implementation can be fixed size or growable using array, linked list, binary tree etc.

## Variables in Interfaces
* to import shared constants into multiple implementation classes.
* Interface with no methods, class are importing constant fields as **final** variables. 

## Default Methods in Interface 
* From JDK 8, default methods **enabled interfaces to expand without breaking the existing code**.
* to specify methods that are optional, depending on how the interface is used. 
* example, interface of sequence may support both modifiable and nonmodifiable, then **remove()** is optional.
* does not change a key aspect of **interface**: its inability to maintain state information via instance variable.
* **difference** - a class can maintain state information, but an interface cannot.

```java
interface IntStack {
 void push(int item); // store an item
 int pop(); // retrieve an item
 default void clear() {  sysout("clear() not implemented.");   }
}
```

- The default method gives you
  * a way to gracefully evolve interfaces over time, and
  * a way to provide optional functionality without placeholder implementation.

## Diamond Problem - Multiple Inheritance Issues
* Diamond Problem. For example,
  * Interfaces - Alpha and Beta 
  * class - MyClass.
  * Default Method- reset().

## Rules that resolves conflicts:
* class implementation takes priority over an interface default implementation. 
* two interfaces with same default method but no override, then an error will result.
* one interface inherits another, child’s implementation takes precedence. 
  * Beta extends Alpha, then Beta’s version of reset() will be used.
* super - to explicitly refer default implementation of parent interface in child.
  * `InterfaceName.super.methodName()` - `Alpha.super.reset()`;
* class/interface can invoke a default method of an interface that is explicitly mentioned in implements/extends clause.
* cannot invoke a default method provided by an interface that is not directly implemented (or extended) by the caller.

Q. Java does not support the multiple inheritance of classes. Now that an interface can include default methods, you might be wondering if an interface can provide a way around this restriction?  **No**
 
## Use static Methods in an Interface
* From JDK 8, interface can define one or more static methods.
* `InterfaceName.staticMethodName`
* static interface methods are not inherited by either an implementing class or a sub-interface.

```java
interface NewInterface {
    static void hello() { // static method
        System.out.println("Hello, New Static Method Here");
    }
    void overrideMethod(String str); // Public and abstract method of Interface
}
```

## Abstract Class vs Interface

|Interface|Abstract Class|
---|---
Variables - public static final.|Variables - private, protected etc.
Can’t store state|Can store state
methods - public or public static|methods – can be private and protected too
establishes relation for unrelated classes.|establishes relation for interrelated objects.
Use interfaces when full implementation required i.e. to define the role that classes can play, regardless of their position in the inheritance tree.|when you want partial pieces for your design (for reusability) i.e. a template for a group of sub-classes, with some implementation code.
implements keyword – multiple|extends keyword - only one
set of methods without concrete implementations.|Subclasses provide implementations, or become  abstract.
provides IS-A relationship.|purpose is to provide superclass that can be inherited to share a common design.
Example-Comparable or Cloneable.|Example- AbstractMap ==> HashMap, TreeMap, ConcurrentHashMap (Methods - get, put, isEmpty, containsKey, containsValue)

# Enums - Enumeration

* list of named constants. `enum Apple {Jonathan, GoldenDel, RedDel, Winesap, Cortland}`
* Each is implicitly declared as a **public static final** member of Apple **with type as Apple**. (self-typed)
* Variable of type enumeration can be created. 
* **enum** not instantiated using **new**.
* declare and use an enumeration variable same as primitive types.
* compared by using ==.
* Can be used in **switch**.
* System.out.println(Apple.Winesap); ==> **Winesap**.
* All enumerations have two predefined methods: **values( )** and **valueOf( )**.
	- `public static enum-type [ ] values()` – array with all enumeration constants.
	- `public static enum-type valueOf(String str)` - Apple.valueOf("Winesap") prints Winesap.

## Java Enumerations Are Class Types
* can have constructors, instance variables and methods, and even implement interfaces.
* Each enumeration constant is an object of its enumeration type.
* constructor for **enum** is called for each enumeration constant upon creation.

```java
enum Apple {
    Jonathan(10), GoldenDel(9), RedDel(12), Winesap(15), Cortland(8);
    private int price;          // member
    Apple() { price = -1; }     // constructor
    Apple(int p) { price = p; }
    int getPrice() { return price; }
}
```

## Restrictions on enumerations:
* An enumeration can’t inherit another class.
* An enum cannot be a superclass.

## Enumerations Inherit Enum
* all enumerations inherit **java.lang.Enum**, hence cannot inherit any other class.

## Methods in java.lang.Enum: 
- **final int ordinal( )** – enum’s position in list of constants, begins at zero.
- **final int compareTo(enum-type e)** – [a minus e]
- **equals()** - true if both refer to same constant of same enumeration, can also use ==.
	* having same ordinal values will not guarantee **equals( )** as enums can be from different enumerations.

# Inheritance

![inheritance]({{site.cdn}}/java/core-java/inheritance.png)

* For hierarchical classifications. 	
* superclass and subclass.
* extends keyword.  class B extends A {}
* No multiple inheritance - diamond problem. 
* No class can be a superclass of itself.

## Member Access and Inheritance 
* subclass cannot access **private** members of superclass.
* superclass reference variable can point to to subclass object.
* ***type of reference variable, not the object, determines what members can be accessed.***
* Can access only those member var of object that are defined by the superclass.

## super Keyword
* To refer immediate superclass. 
* To access superclass member vars hidden in subclass.
* Call superclass’ constructor - **super() must always be the first statement in subclass constructor**.
* ***In a class hierarchy, constructors execute in order of derivation, from superclass to subclass***. 
* If super() is not used, then the default or parameterless constructor of each superclass will be executed.

## Method Overriding
* subclass method with same name and type signature as in superclass. 
* method called from subclass refers to subclass’s implementation. 
* super – to call hidden superclass method.
* “one interface, multiple methods” aspect of polymorphism.

## Dynamic Method Dispatch
* mechanism for run-time polymorphism, resolve overridden method. 
* superclass reference var for subclass object is used to resolve calls to overridden methods at run time.
* ***type of object being referred, not reference variable, determines the overridden version to be executed.***

```java
A a = new B();      // r refers to a B object
a.callme();         // calls B's version of callme
```

## Using Abstract Classes
* defines only a generalized form to be shared by all of its subclasses, where each subclass takes care of details.
* Has 1 or more **abstract method**. Hence cannot be instantiated with **new** keyword.
* Subclass must implement the abstract method or declare itself as abstract.
* abstract classes can not be used to create object references.
* Member variables are inherited by subclasses.

## Types of Inheritance

![inheritance-types]({{site.cdn}}/java/core-java/inheritance-types.png)

# Garbage Collection

* Java provides automatic deallocation via *garbage collection*. 
* **Objects with no references are eligible for collection by GC which occurs sporadically (if at all)**.
* De-referenced objects will **not be immediately garbage collected, remains on heap until next garbage collector cycle**.
* JVM runs garbage collector based on several predefined algorithms.
* *Advantage* - makes java **memory efficient** and done by the garbage collector (JVM) with **no extra coding efforts**.
 
**How can an object be unreferenced?**

```java
employee = null;
e1 = e2;                // object referred earlier by e1 is available for garbage collection
new Employee();         // anonymous object
Object being out of scope
```

## finalize() method
* Invoked each time **before the object is garbage collected**. 
* Can be used **to perform cleanup processing** ex. release resources, close DB connection, close sockets etc. 
* It is not called immediately when an object goes out-of-scope.
	- you cannot know when or even if **finalize( )** will be executed.
	- program should not rely on finalize( ) for normal program operation like realeasing resource etc. 
* class java.lang.Object : `protected void finalize(){}`

## gc() method
* used to invoke the garbage collector forcefully to perform cleanup processing. 
* Doesn’t guarantee that Garbage Collector will run immediately. 
* gc() is found in **System** and **Runtime** classes.
* **public static void gc(){}**

**Note:**
* Garbage collection is performed **by a daemon thread called Garbage Collector (GC)**. 
* Neither finalization nor garbage collection is guaranteed. 
* **GC collects objects created by new keyword only**.

```java
public class TestGC {
    public void finalize() {
        System.out.println("object is garbage collected");
    }
    public static void main(String args[]) {
        TestGC s1 = new TestGC();
        TestGC s2 = new TestGC();
        s1 = null;
        s2 = null;
        System.gc();
    }
}
// Output :
object is garbage collected
object is garbage collected
```
**`Memory Leaks => Memory Shortage => Out of memory Error`**
