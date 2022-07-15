---
layout: page
title: Java 8
permalink: /java/8
---

- TOC
{:toc}

---

# Introduction

## Why do we need change to Java again?
* To Utilize Current Multi-Core CPUs Efficiently in order to develop Highly Concurrently and Highly Scalable applications.
* To Utilize Functional Programming Features

## How is Java 8 different from previous Java versions?
* **Lambda Expressions** − a new language feature allowing treating actions as objects
* **Method References** − enable defining Lambda Expressions by referring to methods directly using their names
* **Optional** − special wrapper class used for expressing optionality
* **Functional Interface** – an interface with maximum one abstract method, can be implemented using a Lambda Expression
* **Default methods** − give us the ability to add full implementations in interfaces besides abstract methods
* **Nashorn, JavaScript Engine** − Java-based engine for executing and evaluating JavaScript code
* **Stream API** − a special iterator class that allows processing collections of objects in a functional manner
* **Date and Time API** − an improved, immutable JodaTime-inspired Date API
* Spliterator
* Collections API Enhancements
* Concurrency Utils Enhancements
* Fork/Join Framework Enhancements
* Internal Iteration
* Parallel Array and Parallel Collection Operations
* Optional
* Type Annotations and Repeatable Annotations
* Method Parameter Reflection
* Base64 Encoding and Decoding
* IO and NIO2 Enhancements
* javac Enhancements
* JVM Changes
* Java 8 Compact Profiles: compact1,compact2,compact3
* JDBC 4.2
* JAXP 1.6
* Java DB 10.10
* Networking
* Security Changes

Along with these new features, lots of feature enhancements are done under-the-hood, at both compiler and JVM level.

# Interface Default Method

- Interface default method - to add new functionalities without breaking the existing implementation of the interface.
- Usually, for a new interface method, all classes need to implement it. This problem has been solved by the use of default method.
- Example, forEach() in Collection interface. default implementation provided for all classes of collection.

```java
public interface MyInterface {
    public void existingMethod();
    default public void newDefaultMethod() {
        System.out.println("New default method added.");
    }
}
```

**Is it possible to implement two interfaces having default method with same name and signature? Explain with example.**  
Here the compiler gives an error saying that “Duplicate Default Methods”. Hence it is not possible to implement two interfaces with the same name and signature.
```java
public class HelloJava8 implements Interface1, Interface2 {
  public static void main(String[] args){
    DefaultMethodInterface defMethIn = new HelloJava8();
    defMethIn.defaultMethod();
  }
}
```

**What is the purpose of a Static method in an Interface in Java 8?**  
A Static method in an Interface is utility or helper method. 
* **Single Class**: no need to create a separate Utils class for utility or helper methods.
* **Encapsulation**: With Static methods, complete behavior of a Class is encapsulated in same class.
* **Extension**: It is easier to extend a Class/API. example extend ArrayList, we get all the methods. No need to extend Collections class also.

**How does Java 8 solve Diamond problem of Multiple Inheritance?**  
* When a class extends 2 or more classes with different implementations of same method then it causes Diamond problem.
* **ChildClass** gives compile time error, compiler cannot decide which display method should it invoke in ChildClass.

```java
public interface BaseInterface{    default void display() { /*code*/} }
public interface BaseOne extends BaseInterface { }
public interface BaseTwo extends BaseInterface { }
public class ChildClass implements BaseOne, BaseTwo { }
// Solution
BaseOne.super.display(); solves the Diamond problem as it resolves the confusion for compiler.

public interface A{     default void display() { /*code*/} }
public interface B extends A{ }
public interface C extends A{ }
public class D implements B,C{
  default void display() { B.super.display(); }
}
```

**Can we have default method in an interface without marking it with default keyword?**  
No, compile time error.

**Can a class implement two Interfaces with default methods of same name and signature?**  
No, Diamond Problem.

**What are the main differences between an interface with default method and an abstract class in Java 8?**

||Interface	| Abstract Class|
---|---|---
Instance variable	| No            | Yes
Constructor	        | No            | Yes
Concrete Method     | Only default  | Yes
Lambda	            | Functional Interface can be used with lambda  | Cannot be used with Lamda

# Method References

* Used for referencing a method without invoking it ie. for treating methods as Lambda Expressions. 
* They only work as syntactic sugar to reduce the verbosity of some lambdas.
* a double colon separating a class or object name and the name of the method. 

```java
(o) -> o.toString(); // === Object::toString();
p -> System.out.println(p); // === System.out::println

// Method Reference can be used in below example case
() -> method()
p -> method(p)
```

|Method References                  |                   |
|---                                |---                |
|constructor reference              | String::new;      |
|Static method reference            | String::valueOf;  |
|Bound instance method reference    | str::toString;    |
|Unbound instance method reference	| String::toString; |

# Optional

* Wrapper class to make a field optional, it may or may not have values.
* Used to represent a value is present or absent.
* **Optional.empty()** value instead of wrapped null, used to get rid of **NullPointerException**.
* Optional is not to be used as a member of an entity classes, because it is ***not Serializable***.

|Advantage of Java8 Optional|Disadvantages of using Optional|
|---|---|
Optional: Null checks are not required. | Not serializable making it useless for many cases.
No more Boilerplate code | Optional is a wrapper which means if you use it, you'll now have two object references where you used to have one.
No more NullPointerException at run-time. | In Some cases, it makes the debugging even worse nightmare.
Clean and neat APIs can be developed | 

|||
---|---
isPresent() | return true 
get()       | return the value. 
orElse()    |  
ifPresent() | executes a block of code if the value is present.

```java
Employee employee = new Employee(); 
Optional<Employee> op = Optional.of(employee);  //ofNullable
Optional<Employee> employee = Optional.empty();
```

## Why Optional?
**Without Optional**
```java
if (project != null) {
    ApplicationType applicationType = project.getApplicationType();
    if (applicationType != null) {
        String typeDirName = applicationType.getTypeDirName();
        if (typeDirName != null)
            System.out.println(typeDirName);
    }
}
```

**With Optional**
```java
Optional < String > optionalTypeDirName = optionalProject.flatMap(project - > project.getApplicationTypeOptional())
    .flatMap(applicationType - > applicationType.getTypeDirNameOptional());
optionalTypeDirName.ifPresent(typeDirName - > System.out.println(typeDirName));
```

```java
int min1 = Arrays.stream(new int[]{1, 2, 3, 4, 5}).min().orElse(0);
int min2 = Arrays.stream(new int[]{}).min().orElse(0);
// Stream.min() calculates the minimum value, for empty stream it returns Optional rather than null or exception.
```

## Optional Class Methods

|Optional Methods |   |
|---              |---|
|empty()	| empty Optional instance.|
|equals(Object obj) ||
|filter(Predicate<? super T> predicate) | value present and predicate ture, return Optional otherwise empty.|
|flatMap(Function<? super T ,Optional<U>> mapper) | value present, apply mapping, return result otherwise empty Optional.|
|get() | value present, returns value otherwise NoSuchElementException.|
|ifPresent(Consumer<? super T> consumer) | value present, invoke consumer otherwise do nothing.|
|isPresent()	| true if value present.|
|map(Function<? super T,? extends U> mapper)	| value present, apply mapping. and if result non-null, return Optional.|
|of(T value)	| Optional of non-null value.|
|ofNullable(T value)	| Optional of non-null value, otherwise empty Optional.|
|orElse(T other)	| return value, if present, otherwise return other.|
|orElseGet(Supplier<? extends T> other) | return value, if present, otherwise invoke other and return result.|
|orElseThrow(Supplier<? extends X> exceptionSupplier) | return value if present, otherwise throw exception to be created by the provided supplier.|
|toString() | non-empty string representation of Optional suitable for debugging.|

# Functional Programming

- Code in OOP
  - Everything is an object, except primitives everything in java existed as objects.
  - All code-blocks/methods/functionas are associated with classes and object, they did not exist independently by itself.
- There was no way of passing a method as argument or returning a method body for that instance.
- With Java 8 functional programming, we can make use of anonymous functions. 

## Why Functional Programming?  
- Doesn't provide any extra capabiltiy as compared to Object Oriented Programming.
- Enables you to write more readable and maintanable code.
- To be used when you need one piece of functionality but not the object.

```java
public void greet(Greeting greeting){
    // Here, Greeting is an interface and implementation decides the behavior
    greeting.perform();
}
```
Here we are not paasing the behavior but a thing (Greeting Implementation) that has the behavior.
- Lambda allows you to pass the action.

```java
public void greet(action){
    action();
}
```

# Lambda Expressions

- a function that can be referenced and passed around as an object.
- Anonymous function, not belong to any class ie. Lambda functions can exist in isolation.
- Declarative coding and code maintainability as well.
- Allows users to pass methods as arguments, helps remove a lot of boilerplate code. (create 1 time classes and interfaces)
- These functions can be treated as values ie. assign a block of code to variable rather than the execution output of the block of code.
- Lambda Functions have no access modifiers (private, public or protected), no return type declaration and no name.
- `->` is called **Lambda arrow**.
- lambda expressions are a natural replacement for anonymous classes as method arguments.

## Why Lambdas ?
- enable functional programming
- readable and concise code
- Easier-to-use API and libraries
- Enables support for parallel processing
- No separate class created as opposed to anonymous class, reduced memory footprint in jar thus improved performance.

```java
aBlockOfCode = () - > System.out.println("Hello World!");

doubleNumberFunction = (int a) - > a * 2;

addFunction = (int a, int b) - > a + b;
addFunction = (a, b) - > a + b;
// above is also valid as Functional Interface have only 1 method and argument type can be inferred

safeDivideFunction = (int a, int b) - > {
    if (b == 0) return 0;
    return a / b;
};

(Comma separated Arguments) - > expression body
Runnable runnable = () - > System.out.println("Running thread by Lambda");
```

## Lambda Expression Rules

- parentheses are compulsory, when zero or more than two arguments. 
- curly braces are compulsory, when lambda expressions has more than 1 line. 
- Usually, do not have more line of code in lambda expression due to readability. (call function from expression body)
- ***return statement is optional in lambda***.
    - ***That means (a, b) – > {return a+b;} and (a, b) – > {a+b;} are both valid.***
- lambda expression must have same parameter type as the parameter in the function of the interface.
- It must also return a type compatible with the return type of function.

```java
(a,b)->System.out.println(a,b);
a -> return a*2;
()->System.out.println(“Method Called”);

a->{   a = a*2+5;   System.out.println(a);  }
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
numbers.forEach(t -> System.out.println(t));
```

**(int x, y) -> x + y; is this a valid lambda expression?**  
No

**(int x, int y) -> x+y; or (x, y) -> x + y; which one of these is a valid lambda expression?**  
Both of them are valid lambda expressions if used in a correct context.
* (int x, int y) -> x+y;     parameters must be of type int.
* (x, y) -> x + y;         in correct context, type can be inferred for the lambda expression.

**What is block lambda expression?**  

```java
(num) -> {  int fact = 1; return fact; } // Block or multiline Lambda.
(String s1, String s2) -> s1+s2;         // single expression lambda.
```

## Return Type of Lambda

The type of a lambda expression depends on the context it is being used.
- Return type of Lambda Function is Fucntional Interface.
- Lambda is used to implement the functional interfaces as well.
- When method argument is a Functional interface, lambda expression automatically detects and implements the functional interface as anonymous function given number of arguments matched for lambda and functional interface.

```java
MyLambda myLambdaFunction = () -> System.out.println("Hello World!");
// interface
interface MyLambda{
    void foo();
}
```
```java
// Here you create a impl class
MyLambda myLambda = new MyLambdaImpl();
// Here only function is created
MyLambda myLambdaFunction = () -> System.out.println("Hello World!");
// kind of Anonymous interface
// its somewhat similar to Anonymous inner class, except reduced memory footprint in jar
MyLambda innerMyLambda = new MyLambda(){
    public void perform(){
        System.out.println("Hello World!");
    }
};
```

## Type Inference

- Determining the Type by compiler at compile-time.
- Available before Java 7 too.

```java
String str[] = { "Java 7", "Java 8", "Java 9" };                  // Before Java 7
Map<String,List<Customer>> customerInfoByCity = new HashMap<>();  // Java 7, Right Side Diamond Operator
ToIntBiFunction<Integer,Integer> add = (a,b) -> a + b;            // determines type of parameters in lambda
```
Here Java Compiler observes the type definition available at left-side and determines the type of Lambda Expression parameters a and b as Integers.

### Why lambda expression is called a poly expression?
* type of a lambda expression is inferred from the target. 
* same lambda expression could have different types in different contexts.
* Example - concat and sum.

## Thread as Lambda

```java
// new Thread - anonymous class (inline class)
Thread th = new Thread(new Runnable() {
    @Override
    public void run() {
        System.out.println("Running new thread");
    }
});

// new Thread as Lambda, Runnable is also Functional Interface
th = new Thread(() - > System.out.println("Running in new thread"));
th.start();
System.out.println("Main thread running");
```

## Effectively final and variable capture in Java 8

* When a lambda expression uses an assigned local variable from its enclosing space there is an important restriction. 
* A lambda expression may only use local variable whose value doesn’t change; restriction is called as ***"variable capture"***.
* local variables that a lambda expression may use are known as "effectively final". 
* An effectively final variable is one whose value does not change after it is first assigned.

Any local variable, formal parameter, or exception parameter used but not declared in a lambda expression must either be declared final or be effectively final, or a compile-time error occurs where the use is attempted.
* Local variables in Java have until now been immune to race conditions and visibility problems because they are accessible only to the thread executing the method in which they are declared. 
* With lambda can be passed to any thread, hence other thread would be able to mutate local variables.
* Even the ability to read the value of mutable local variables from a different thread would introduce the necessity for synchronization or the use of volatile in order to avoid reading stale data.
* Within Lambda expressions you can use effectively final variables from the surrounding scope. Effectively means that it is not mandatory to declare variable final but make sure you do not change its state within the lambda expresssion.

```java
int sum = 0;
list.forEach(e -> { sum += e.size(); });    // illegal; local variable 'sum' is not effectively final
```
The restriction of capture to effectively immutable variables is intended to direct developers’ attention to more easily parallelizable, naturally thread-safe techniques.
```java
int sum = list.map(e -> e.size()).reduce(0, (a, b) -> a+b);
```
The restriction on local variables helps to direct developers using lambdas aways from idioms involving mutation; it does not prevent them. Mutable fields are always a potential source of concurrency problems if sharing is not properly managed.

## Exception Handling in Lambda

**Can lambda expression throw exception? Is there any restriction in lambda expression exception handling?**  
lambda expression can throw exception compatible with the throws clause of functional interface method.

```java
public static void main(String[] args){
  int[] numbers = {1,2,3,4,5,6};
  int key = 0;
  process(numbers, key, (v,k)-> System.out.println(v/k));
  // we can put try catch around the lambda expression
  // but it will not be concise and readable anymore, hence not recommended
}

private static void process(int[] numbers, int key, BiConsumer<Integer, Interger> biConsumer){
  for(int i: numbers)
    biConsumer.accept(i, key);
    // here biConsumer is divide operation causing ArithmeticException
    // but biConsumer can be any operation making list of catch very long
    // hence not recommended to do exception handling here
}
```
Recommended way is to wrap the lambda and handle the exception there.
```java
// passing wrapperLambda rather than original lambda
process(numbers, key, wrapperLambda((v,k)-> System.out.println(v/k)));

private static Biconsumer<Integer, Integer> wrapperLambda(Biconsumer<Integer, Integer> biConsumer){
  return (v,k) -> {
    try{
      biConsumer.accept(v,k);
    } catch(ArithmeticException e){
      e.printStackTrace();
    }
  }
}
```

## this Keyword in Lambda Expression

- In Anonymous inner class, `this` refers to the instance of anonymous inner class even inside the static void main method.

```java
public class MyClass {
    public void doProcess(int i, Process p) {
        p.process(i);
    }

    public static void main(String[] str) {
        MyClass m = new MyClass();
        m.doProcess(10, new Process() {
            @Override
            public void process(int i) {
                System.out.println(i);
                System.out.println(this); // prints instance value of anonymous inner class
            }

            @Override
            public String toString() {
                "Inside Anonymous Inner Class";
            }
        });
    }
}
```
For Lambda, `this` is not overriden as opposed to the case of Anonymous Inner Class.
```java
public class MyClass {
    public void doProcess(int i, Process p) {
        p.process(i);
    }

    public static void main(String[] str) {
        MyClass m = new MyClass();
        m.doProcess(10, (i) - > {
            System.out.println(i);
            System.out.println(this); // compilation error
        });
    }
}
```

# Functional Interface

* Frequently used classes **Runnable**, **Comparator**, **Callable** etc have only one method declared to be implemented, called Single Abstract Method (SAM). 
* It is normally implemented using anonymous class.

### Functional Interface
* can have exactly one abstract method.
* any number of default or static methods.
* Can even override Object class method.
* public Object methods are considered implicit members of functional interface as they are automatically implemented by an instance of functional interface.
* If interface extends a Functional interface without adding any new abstract method, then it is also a Functional interface.

**Can we have a generic functional interface?**  
No
* Lambda expression doesn't have type parameters of its own so it can't be generic. 
* But functional interface specifying the target type of lambda expression can be generic.

```java
@FunctionalInterface
interface GenInterface<T, U, R> {R addValues(T t, U u);}
```

**Is it mandatory to mark @FunctionalInterface?**  
* Not mandatory to mark @FunctionalInterface annotation.
* Exclusively annotated, Java Compiler forces to use one and only one abstract method for that interface.

**Why do we need Functional Interfaces?**  
Type of Lambda Expression is a Functional Interface. Using lambda expressions means using Functional Interfaces.

**Is it possible to define our own Functional Interface? Explain the rules to define a functional interface.**  

```java
@FunctionalInterface
public interface MyComparator {
  public boolean compareMyValues(int a, int b);
}

MyComparator mycomp = (a,b) -> a>b;
System.out.println("Is 4 > 5: "+ mycomp.compareMyValues(4, 5));
```

**Will the below code compiles without error?**

```java
@FunctionalInterface
public interface Function2<T, U, V> {
  public V apply(T t, U u);
  default void count() {
    // increment counter
  }
}
```
Yes
* only a single abstract method.
* Other method is default method.

**Describe some of the functional interfaces in the standard library.**  
package - java.util.functionConsumer – it takes one argument and returns no result (represents a side effect)
* Predicate – it takes one argument and returns a boolean 
* Function – it takes one argument and returns a result
* BiFunction – it takes two arguments and returns a result
* Supplier – it takes not argument and returns a result
* Consumer - 
* BiConsumer - 
* UnaryOperator – it is similar to a Function, taking a single argument and returning a result of the same type
* BinaryOperator –similar to BiFunction, two arguments and result are all of the same types

**What is the difference between a normal and functional interface in Java?**  

|Normal Interface	| Functional Interface|
---|---
|Any number of abstract methods|Exactly 1
||wrap function as an interface, function is represented by the single abstract method|

**Comparator is functional interface but has a lot of other methods, how is it a Single Abstract method interface?**  
* Allowed interface to have default methods and static methods.
* Only one abstract method.
* Override Object class public methods too, as they are consider implicit methods.

**How can we write comparator as lambda expression?**

```java
// Option 1
Collections.sort(personList, new Comparator<Person>() {
   public int compare(Person a, Person b) {
     return a.getFirstName().compareTo(b.getFirstName());
   }
});

// Option 2
Collections.sort(personList, (Person a, Person b) -> a.getFirstName().compareTo(b.getFirstName()));

// Option 3
Comparator<Person> multiComparator = Comparator.comparing(Person::getFirstName);
multiComparator = multiComparator.thenComparing(Comparator.comparing(Person::getLastName));
Collections.sort(persons, multiComparator);
```

**How can we write runnable as lambda expression?**

```java
// Before Lambda
Thread th = new Thread(new Runnable() {
    @Override
    public void run() {
        System.out.println("Run thread");
    }
});
```
```java
// Using Lambda
Runnable r = () - > System.out.println("Run new thd");
Thread th = new Thread(r);
th.start();
```
**How can we write callable as lambda expression?**

```java
ExecutorService es = Executors.newFixedThreadPool(2);
getLength(es, "executor");
public static void getLength(ExecutorService es, final String str){
 // callable implemented as lambda expression
 Callable<String> callableObj = () -> {
   StringBuffer sb = new StringBuffer();
   return (sb.append("Length of string ").append(str).append(" is ")
	.append(str.length())).toString();
 };
 Future<String> f = es.submit(callableObj);
 try {  System.out.println("" + f.get());}
 catch (InterruptedException | ExecutionException e) {e.printStackTrace();}
}
```
**What are the differences between Predicate, Supplier and Consumer in Java 8?**  
* ***Predicate*** - accepts one argument and returns a boolean.
* ***Supplier***  - accepts no argument and returns a result.
* ***Consumer***  - accepts one argument and returns no result.

## Predicate

* boolean-valued function of one argument, used with stream filter.
* method - test()
* java.util.function

|Methods	          | Description |
|---                |---          |
|boolean test(T t)	| evaluates predicate on given argument.|
|default Predicate<T> and(Predicate<? super T> other)	| AND (short-circuit)|
|default Predicate<T> negate()	| predicate which is logical negation of this predicate.|
|default Predicate<T> or(Predicate<? super T> other)	|OR (short-circuit)|
|static <T> Predicate<T> isEqual(Object targetRef)	|tests if two arguments are equal, Objects.equals(Object, Object).|

```java
public class PredicateInterfaceExample {
    public static void main(String[] args) {
        Predicate < Integer > pr = a - > (a > 18);
        System.out.println(pr.test(10));
    }
}

public class PredicateInterfaceExample {
    static Boolean checkAge(int age) {
        return (age > 17 ? true : false);
    }
    public static void main(String[] args) {
        Predicate < Integer > predicate = PredicateInterfaceExample::checkAge;
        System.out.println(predicate.test(25));
    }
}
```

**What is the difference between Predicate and Function?**  
* Predicate - single argument function, returns either true or false.
* Function<T,R>   (T input, R result) - single argument function, returns an object. 
* Both can be used as an assignment target for lambda expressions or method references.

## Function

* Function<T, R> in java.util.function. 
* for mapping scenarios i.e when an object of a type is taken as input and it is converted(or mapped) to another type. 
* Common usage - streams .map() converts type of stream.

```java
@FunctionalInterface
public interface Function < T, R > {
    R apply(T t);
    default < V > Function < V, R > compose(Function << ? super V, ? extends T > before) {
        Objects.requireNonNull(before);
        return (V v) - > apply(before.apply(v));
    }
    default < V > Function < T, V > andThen(Function << ? super R, ? extends V > after) {
        Objects.requireNonNull(after);
        return (T t) - > after.apply(apply(t));
    }
    static < T > Function < T, T > identity() {
        return t - > t;
    }
}
```

## Supplier

* Similar to factory method or new() which return an object.
* get() - no argument and return an object.
* **Primitive**: IntSupplier getAsInt(), LongSupplier getAsLong(), DoubleSupplier getAsDouble(), BooleanSupplier getAsBoolean()

```java
public interface Supplier {  T get();  } 
Supplier < Person > supplier = () - > { return new Person("Varun", 30, "Programmer");  };
Person p = supplier.get();
names.stream().forEach( (item) ->  {  printNames( () -> item ); }  )
private static void main printNames(Supplier<String> supplier){  System.out.println(supplier.get());  }
```

## Consumer

* Represents an operation that accepts a single input argument and returns no result.
* abstract method accept(T t) and default method andThen(Consumer<? super T> after)
* Primitive: 
	- IntConsumer accept(int), 
	- DoubleConsumer accept(double), 
  - LongConsumer accept(long)

```java
Consumer<String> consumer = ConsumerTest::pritName;
Consumer.accept(“Java”);
Consumer.accept(“Java8”);
pritName(String name){  System.out.println(name); }
```

```java
@FunctionalInterface
public interface Consumer<T> {
  void accept(T t);
  default Consumer < T > andThen(Consumer << ? super T > after) {
        Objects.requireNonNull(after);
        return (T t) - > { accept(t);    after.accept(t);  };
  }
}

Consumer < String > consumer1 = arg -> {System.out.println(arg + "OK");};
consumer1.accept("TestConsumerAccept - ");
Consumer < String > consumer2 = (x) - > { System.out.println(x + "OK!!!");};
consumer1.andThen(consumer2).accept("TestConsumerAfterThen - ");
```

## Bi-Consumer

```java
// BiConsumer to compare 2 lists of integers 
BiConsumer < List < Integer > , List < Integer >> equals = (list1, list2) - > {
    if (list1.size() != list2.size()) {
        System.out.println("False");
    } else {
        for (int i = 0; i < list1.size(); i++)
            if (list1.get(i) != list2.get(i)) {
                System.out.println("False");
                return;
            }
        System.out.println("True");
    }
};
```
```java
// BiConsumer to print 2 lists 
BiConsumer < List < Integer > , List < Integer > > disp = (list1, list2) - > {
    list1.stream().forEach(a - > System.out.print(a + " "));
    System.out.println();
    list2.stream().forEach(a - > System.out.print(a + " "));
    System.out.println();
};

// Using addThen() method 
equals.andThen(disp).accept(lista, listb);
```

# Streams

* Stream - It is an iterator that allows a single run over the collection.
* can use streams to perform functional operations like, filer or map/reduce.
* can run sequentially or parallely.
* Parallel mode makes use of fork/join framework and can leverage power of multiple cores.
* Java stream doesn't store data. It operates on the source data structure and produce pipelined data.
* Streams - Sequence of elements supporting sequencial and parallel aggregate operations.

![]({{site.cdn}}/java/java8/streams.png)

```java
List<Integer> numbers = Arrays.asList(1,2,3,4,5,6,7,8,9,10);
numbers.stream().filter(e -> e%2 ==0).forEach(e -> System.out.println(e));
System.out.println(numbers.stream().filter(e -> e%2 ==0).mapToInt(e -> e *2).sum());
```
If our input is large, we can use parallel stream as well as shown below:
```java
System.out.println(numbers.parallelStream().filter(e -> e%2 ==0).mapToInt(e -> e *2).sum());        // multi-core power
```

**What is stream pipelining in Java 8?**  
* Concept of Pipelining data and chaining operations together.
* Done by splitting operations that can work with streams. (intermediate and terminal operations)
* Each intermediate operation returns an instance of a stream when it runs.
* There must be a terminal operation which will return a final value and will terminate the pipeline.

**What do you mean by saying Stream is lazy?**  
Without terminal operation, stream won’t start processing just because of Stream pipeline.

**When do we go for Java 8 Stream API? Why do we need to use Java 8 Stream API in our projects?**  
When you want to perform the following operations:
* Database like Operations such as groupby, orderby etc.
* perform operations Lazily.
* write Functional Style programming.
* perform Parallel Operations.
* use Internal Iteration
* perform Pipelining operations.
* to achieve better performance, parallelstream().

## Stream vs Collections

* source of data - Collection or Arrays. 
* Stream keeps the order of the data as it is in the source.

|COLLECTION API	| STREAM API|
---|---
in-memory data structure to hold values	|doesn't store data, work on a view but elements are actually stored by Collection or array
Collection Object is constructed Eagerly.	|Stream Object is constructed Lazily.
all the values should have been populated before using.	|data structure that is computed on-demand
||operates on the source data structure, produce pipelined data that we can use and perform specific operations.
Changes are reflected on collection	|changes made on Stream not reflect on original collection.
||parallelStream() to take advantage of multiple-cores. This will takes care of all the threading issues which will make our code more robust.
External iterator	|Internal iterator
We can use both Spliterator and Iterator to iterate elements. 	|We can’t use Spliterator or Iterator to iterate elements.
to store limited number of Elements.	|to store either Limited or Infinite Number of Elements.
We can iterate and consume elements from a Collection Object at any number of times.|	We can iterate and consume elements from a Stream Object only once.

### How It Can Be Created?

```java
Stream<Integer> stream = null;
stream = Stream.of(new Integer[]{1,2,3,4,5,6,7,8,9}); // from Array
stream = Stream.of(1,2,3,4,5,6,7,8,9);
stream = arrayList.stream();   // or parallelStream() // from some list
IntStream stream = "12345_abcdefg".chars(); // Using String chars or String tokens
Stream.generate(new Random()::nextInt).limit(5).forEach(System.out::println);    // Stream.generate()    // 5 random int
IntStream.iterate(0, i -> i + 1).limit(5).forEach(System.out::println);        // Stream.iterate()    // 1 to 5
new Random().ints().forEach(System.out::println); // Infinite Stream of integers
```

# Stream Operations

* Stream operations can either be executed sequential or parallel.

![intermediate-operations]({{site.cdn}}/java/java8/intermediate-operations.png)
![stream-operations]({{site.cdn}}/java/java8/stream-operations.png)

|Intermediate Operations	| Terminal Operations|
---|---
Return Stream itself, you can do chaining.|return a result of a certain type
Lazy, not executed until a result of a processing is needed.|Eager, traversal of the Stream doesn’t begin until the terminal operation of the pipeline is executed.
filter(), map(), flatMap(), distinct(), sorted(), peek(), limit(), skip()|forEach(), forEachOrdered(), toArray(), reduce(), collect(), min(), max(), count(), anyMatch(), allMatch(), noneMatch(), findFirst(), findAny()

```java
List<Integer> list = Arrays.asList(4, 0, 6, 2); 
boolean answer = list.stream().noneMatch(num -> num < 0);
```

## Intermediate Operations

### map()

* transform the elements in a stream of different type using the provided function.

```java
numbers.parallelStream().filter(e -> e%2 ==0).mapToInt(e -> e *2).sum()
Stream.of ("one", null, "three").map(s-> ((s == null) ? "[unknown]" : s)).collect (Collectors.toList ());
```

* Example - List of String to List of Integer, you can use map() to do so.
* Just supply a function to convert String to Integer e.g. parseInt() to map() and it will apply that to all elements of List and give you a List of Integer. In other words, the map can convert one object to other.

### flatmap()

* extension of the map function. Apart from transforming one object into another, it can also flatten it.
* transform each element into zero or more elements by a way of another stream.
* For example, if you have a list of the list but you want to combine all elements of lists into just one list. In this case, you can use flatMap() for flattening. At the same time, you can also transform an object like you do use map() function.

```java
long uniqueWords = java.nio.file.Files.lines(Paths.get(file.toURI()), Charset.defaultCharset())
                    .flatMap(line -> Arrays.stream(line.split(" .")))
                    .distinct()
                    .count();
```

### flatmap() vs map()

|map	|flatmap|
|---|---|
|used for transformation only	|used for both transformation and flattening|
|returns Optional\<String> for string Stream map function	|returns String type for string Stream map function|
| |After mapping, unwrap to retrieve value|
|Function in map() returns a single value	|function returns a stream of values|
|applies a function on each element of stream and stores the value returned by the function into a new Stream.	|flatMap “flattens” the Stream of Stream of values into Stream of values. (list of the list, can convert it to a big list.)|

```java
Map<String, List<String>> people = new HashMap<>();
people.put("John", Arrays.asList("555-1123", "555-3389"));
people.put("Mary", Arrays.asList("555-2243", "555-5264"));
people.put("Steve", Arrays.asList("555-6654", "555-3242"));
List<String> phones = people.values().stream().flatMap(Collection::stream).collect(Collectors.toList());
```

### filter()

to filter elements which satisfy a certain condition.

```java
numbers.stream().filter(e -> e%2==0).forEach(e -> System.out.println(e));
```

### sorted()

returns a sorted view of the stream, elements are sorted in natural order unless you pass a custom Comparator.

```java
numbers.stream().sorted().forEach(e -> System.out.println(e));
```

### distinct()

```java
// int to Integer
List<Integer> distinctIntegers = IntStream.of(5, 6, 6, 6, 3, 2, 2)
                                  .distinct()
                                  .boxed()
                                  .collect(Collectors.toList());
```

### limit()

to limit the number or truncate elements to be processed in the stream.

### skip()

skip n number of elements in stream.

### peek()

* used for debugging the issues related to lambda expression and Stream processing.
* can peek through each step and print meaningful messages on the console.
* *peek()* expects a *Consumer<T>* as its only argument
* the snippet below produces no output as peek is an intermediate operation.

```java
Stream<String> nameStream = Stream.of("Alice", "Bob", "Chuck");
nameStream.peek(System.out::println);

Stream.of("one", "two", "three", "four").filter(e -> e.length() > 3)
      .peek(e -> System.out.println("Filtered value: " + e))
      .map(String::toUpperCase)
      .peek(e -> System.out.println("Mapped value: " + e))
      .collect(Collectors.toList());
```
Alternatively, we could have used map(), but peek() is more convenient since we don’t want to replace the element.

## Terminal operations

* return a result of a certain type, Stream.forEach or IntStream.sum
* After the terminal operation is performed, the stream pipeline is considered consumed, and can no longer be used.
* If you need to traverse the same data source again, you must return to the data source to get a new stream.
* Generally, terminal operations are eager. Only the terminal operations *iterator()* and *spliterator()* are not eager. 

### forEach()

* for iterating over all elements of a stream and perform some operation on each of them.

```java
listPersons.stream().filter(p -> p.getGender().equals(Gender.FEMALE)).forEach(System.out::println);
```

### match()

* check whether a certain predicate matches the stream.
* anyMatch()
* allMatch()
* noneMatch()

```java
boolean isTrue = numbers.stream().anyMatch(e -> e==2);
```

### count()

* Count is a terminal operation returning the number of elements in the stream as a long.

```java
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10,1,2,3,1,1,1);
System.out.print(numbers.stream().filter(e -> e==1).count());
```

### findAny() and findFirst()

*	**findAny()** - can return any value, most of the time it returns the first value but not guaranteed. Used with paralleSrteam().
*	**findFirst()** - first element of the stream.

### max() and min()

```java
Optional<Person> min = listPersons.stream().min((p1, p2) -> p1.getAge() - p2.getAge());
Optional<Person> min = listPersons.stream().max((p1, p2) -> p1.getAge() - p2.getAge());
```

### average() and sum()

```java
Arrays.stream(array).mapToInt(Integer::intValue).sum();
Arrays.stream(array).average().orElse(Double.NaN);
```

### reduce()

```java
Optional<String> reducedValue = listPersons.stream().map(p -> p.getFirstName()).reduce((name1, name2) -> name1 + ", " + name2);
int sum = Arrays.stream(numbers).reduce(0, (x, y) -> (x + y));
int sum = Arrays.stream(numbers).reduce(0, (x, y) -> (x + y), Integer::sum);
```

```java
U reduce(U identity, BiFunction<U,? super T,U> accumulator, BinaryOperator<U> combiner)
```
* The identity element is both an initial seed value for the reduction and a default result if there are no input elements.
* The accumulator function takes a partial result and the next element, and produces a new partial result
* The combiner function combines two partial results to produce a new partial result (it is necessary in parallel reductions).

#### What are Reduction Operations in Java Stream API?
* terminal operations (average, sum, min, max, count) that return one value by combining the contents of a stream.
* called reduction operations because these operations reduce the stream to a single non-stream value.

#### What is a mutable reduction operation?
An operation that accumulates input elements into a mutable result container, such as a Collection or StringBuilder.

### collect()

collect() method used to receive elements from a stream and store them in a collection and mentioned in parameter function.
```java
numbers.parallelStream().filter(e -> e%2 ==0).mapToInt(e -> e *2).collect(Collectors.toList());
List<String> listEmails = listPersons.stream().map(p -> p.getEmail()).collect(Collectors.toList());
Set<String> setEmails = listPersons.stream().map(p -> p.getEmail()).collect(Collectors.toCollection(TreeSet::new));
Map<Gender, List<Person>> byGender = listPersons.stream().collect(Collectors.groupingBy(p -> p.getGender()));
// output
{
  FEMALE=[Alice Brown, Carol Hill, Isabell Hill, Jane Smith], 
  MALE=[Bob Young, David Green, Gibb Brown, Henry Baker]
}

String firstNames = listPersons.stream().map(p -> p.getFirstName()).collect(Collectors.joining(", "));   // Alice, Bob, Carol, David
```

number of products being sold for each currency
```java
Map<String, Integer> totalProductByCurrency = 
pList.stream().collect(Collectors.groupingBy(Product::getCurrency, Collectors.reducing(0, 1L, Integer::sum)));
```
	
sum of all the product quantity grouped by currency
```java
Map<String, Integer> totalProductByCurrency = 
pList.stream().collect(Collectors.groupingBy(Product::getCurrency, Collectors.reducing(0, Product.getQuantity(), Integer::sum)));
```
	
average of the product quantity based on Currency
```java
Map<String, Integer> totalProductByCurrency = 
pList.stream().collect(Collectors.groupingBy(Product::getCurrency, Collectors.averagingInt(Product::getQuantity)));
```

### Stateless and Stateful Operations

**What are Stateless and Stateful operations in Java stream?**  
Intermediate operations are further divided into stateless and stateful operations.
* ***Stateless operations***, such as filter and map, retain no state from previously seen element when processing a new element, each element can be processed independently of operations on other elements.
* ***Stateful operations***, such as distinct and sorted, may incorporate state from previously seen elements when processing new elements. Stateful operations may need to process the entire input before producing a result. For example, one cannot produce any results from sorting a stream until one has seen all elements of the stream.

```java
Optional<Person> min = listPersons.stream().min((p1, p2) -> p1.getAge() - p2.getAge());
Optional<Person> min = listPersons.stream().max((p1, p2) -> p1.getAge() - p2.getAge());
```

# Primitive Type Streams

* Streams primarily work with collections of objects and not primitive types.
* IntStream, LongStream, and DoubleStream.
* Primitive streams are limited mainly because of boxing overhead and because creating specialized streams for other primitives isn’t’ that useful in many cases.

```java
int[] integers = new int[] {20, 98, 12, 7, 35};
int min = Arrays.stream(integers).min().getAsInt();  // returns 7
double avg = IntStream.of(20, 98, 12, 7, 35).average().getAsDouble(); // returns 34.4
int sum = IntStream.range(1, 10).sum();       // returns 45
int sum = IntStream.rangeClosed(1, 10).sum(); // returns 55    last element included
IntStream.rangeClosed(1, 5).parallel().forEach(System.out::println);
```

* As helpful as these fancy loops are, it’s still better to use the traditional for-loops instead of the functional one for simple iterations because of simplicity, readability, and performance in some cases.

```java
Arrays.stream(integers).asDoubleStream().forEach(e->System.out.print(e + " "));
Arrays.stream(integers).asLongStream().forEach(e->System.out.print(e + " "));
```

## Boxed and Unboxed

```java
List<Integer> evenInts = IntStream.rangeClosed(1, 10).filter(i -> i % 2 == 0).boxed().collect(Collectors.toList());
int sum = Arrays.asList(33,45).stream().mapToInt(i -> i).sum();
```
We can always use ***mapToXxx*** and ***flatMapToXxx*** methods to create primitive streams.

### String to Stream of chars
```java
String testString = “String”;
IntStream intStream = testString.chars();
Stream<Character> characterStream = testString.chars().mapToObj(c -> (char) c);
Stream<Character> characterStream2 = testString.codePoints().mapToObj(c -> (char) c);
Stream<String> stringStream = testString.codePoints().mapToObj(c -> String.valueOf((char) c));
```
* codePoints() - to get an instance of IntStream from a String. 
* Advantage of codepoint - Unicode supplementary characters can be handled effectively.
* Supplementary characters are represented by Unicode surrogate pairs and will be merged into a single codepoint. 

# Iterate over array
```java
// getEvenIndexedStrings
List<String> evenIndexedNames = IntStream.range(0, names.length)
                                  .filter(i -> i % 2 == 0)
                                  .mapToObj(i -> names[i])
                                  .collect(Collectors.toList());
```

# Merging Streams

```java
Stream<Integer> stream1 = Stream.of(1, 3, 5);
Stream<Integer> stream2 = Stream.of(2, 4, 6);
Stream<Integer> resultingStream = Stream.concat(stream1, stream2);
```

# Parallel Streams

**What is the parallel Stream? How can you get a parallel stream from a List?**  
* A parallel stream can parallely execute stream processing task. 
* When a stream executes in parallel, the Java runtime partitions the stream into multiple sub-streams.
* parallelStream() can parallelize execution but there is significant overhead or parallelism which only pays off if you are doing bulk data operation.
* example, filter order worth more than 1 lacs in a parallel stream of 1 million orders.
* Unlike sequential Stream, the parallel stream can launch multiple threads to search for those orders on the different part of Stream and then combine the result.
* Collection.stream() and Collection.parallelStream()
* Read more about parallel stream [here](https://netjs.blogspot.com/2017/01/parallel-stream-in-java-stream-api.html).

**What is the benefit of using parallel stream?**  
* When parallel stream is used the Java runtime partitions the stream into multiple sub-streams. 
* This parallel execution of data, with each sub-stream running in a separate thread, will result in increase in performance.

# Internal and External Iterator

## External Iterators
* active iterator or explicit iterator. 
* control over iteration is with programmer, define when and how the next element of iteration is called.

# Internal Iterators
* passive iterator, implicit iterator or callback iterator.
* control over iteration of elements lies with the iterator itself, JVM decides the implementation of iteration.
* programmer only tells the iterator "What operation is to be performed on the elements of the collection".
* ***Disadvantage*** – Developer does not get any control over iteration.
* **Usecases**
	- In applications requiring high performance, parallel processing, fast iteration and bulk operations support.
	- other features like parallel processing are important than having control over iteration.

```java
for (String item : items) {System.out.println(item);}    //Traditional java for-each iterator which is an External Iterator.
items.forEach(item -> System.out.println(item));        //Java 8 forEach iterator which is an Internal Iterator.
map.forEach((key,value)->{
	System.out.println(key);
	System.out.println(value);
});
```

**What are the main advantages of Internal Iterator over External Iterator in Java 8?**  
Some of the main advantages of Internal Iterator are:
* Internal Iterator is based on Functional programming; therefore, it can work on declarative style code.
* There is no need to sequentially iterate elements in Internal Iterator.
* Code is more readable and concise.
* supports concurrency and parallel processing.

# Collection Improvements

## Array Method Improvements
**What is the new method family introduced in Java 8 for processing of Arrays on multi core machines?**  
* Arrays class methods to use power of multi core machines.
* `Arrays.parallelSetAll()`, `Arrays.parallelSort()` etc.

## Spliterator
> Read more about Spliterator in Java [here](https://netjs.blogspot.com/2017/01/spliterator-in-java.html){:target="_blank"}.

**What is Spliterator in Java SE 8?**  
* Spliterator stands for Splitable Iterator.
* Like Iterator and ListIterator, it is also one of the Iterator interfaces.
* Spliterators, like iterators, are for traversing the elements of a source.
* Spliterator can split the source and iterate the splitted parts in parallel. That way a huge data source can be divided into small sized units that can be traversed and processed parallely.
* You can also use spliterator even if you are not using parallel execution.

**Differences between Iterator and Spliterator in Java SE 8?**  

|	Spliterator	| Iterator |
|---|---
|It is introduced in Java SE 8.|It is available since Java 1.2.|
|Splitable Iterator	|Non-Splitable Iterator|
|It is used in Stream API.	|It is used for Collection API.|
|It uses Internal Iteration concept to iterate Streams.	|It uses External Iteration concept to iterate Collections.|
|We can use Spliterator to iterate Streams in Parallel and Sequential order.	|We can use Iterator to iterate Collections only in Sequential order.|
|We can get Spliterator by calling spliterator() method on Stream Object.	|We can get Iterator by calling iterator() method on Collection Object.|
|Important Method: tryAdvance()	|Important Methods: next(), hasNext()|

# Date and Time API

**Why new Date and Time API in Java 8**  
* existing java.util.Date and SimpleDateFormatter aren’t thread-safe, leading to potential concurrency issues for users.
* Poor API design of old Java Data API, years in java.util.Date start at 1900, months at 1, days at 0 which is not very intuitive.
* These issues made third-party date and time libraries, such as Joda-Time.
* A new date and time API, free of these problems, added in package ***java.time***.

**How can we get duration between two dates or time in Java 8?**  
* new class Duration that provides the utility of computing duration between two dates.
* Duration.between(date1, date2) to get the time period in hours, mins, days etc. between date1 and date2.

**How can we get current time by using Date/Time API of Java 8?**  
* Clock class to get the current time, instead of System.currentTimeMillis()
* create a Clock object and call millis() to get the current time in milliseconds.
* instant() on Clock object to get the current time in a readable format.

# Java8 FAQ

## MetaSpace Diagram?
![metaspace]({{site.cdn}}/java/java8/metaspace.png)

# What is MetaSpace in Java8? How does it differ from PermGen Space?
* With JDK8, the permGen Space has been removed. 
* So where will the metadata information be stored now?
  - This metadata is now stored in a native memory are called as "**MetaSpace**".
  - This memory is not a contiguous Java Heap memory. It allows for improvements over PermGen space in Garbage collection, auto tuning, concurrent de-allocation of metadata.

## What are the new JVM arguments introduced by Java 8?
* In Java 8, PermGen space of ClassLoader is removed.  It has been replaced with MetaSpace.
* Now we can set the initial and maximum size of MetaSpace.
* The JVM options -XX:PermSize and –XX:MaxPermSize are replaced by -XX:MetaSpaceSize and -XX:MaxMetaspaceSize respectively in Java 8.

## What is Nashorn in Java?
* This is the new Java processing [engine for Java platform](https://www.educba.com/cheat-sheet-java/) which is shipped in Java 8. 
* Until JDK 7 Java platform used Rhino as the processing engine. It was a Javascript processing engine. 
* Nashorn provides better compliance with the ECMA normalized [JavaScript specification](https://www.educba.com/uses-of-javascript/).
* It also provides better runtime performance than its previous versions.

## What is jjs?
In Java 8, jjs is the new executable or command line tool used to execute Javascript code at the console.

## What are the popular annotations introduced in Java 8?
Some of the popular annotations introduced in Java 8 are:
* ***@FunctionalInterface***: This annotation is used to mark an interface as Functional Interface. As mentioned earlier, A FunctionalInterface can be used for lambda expressions.
* ***@Repeatable***: This annotation is used for marking another annotation. It indicates that the marked annotation can be applied multiple times on a type.

## What is StringJoiner?
* StringJoiner - util method to construct different strings separated with desired delimiters. 
* StringJoiner(CharSequence delimiter), StringJoiner(CharSequence delimiter, CharSequence prefix, CharSequence suffix).

```java
StringJoiner strJoiner = new StringJoiner(".");
strJoiner.add("Buggy").add("Bread");
System.out.println(strJoiner);         // prints Buggy.Bread
```
