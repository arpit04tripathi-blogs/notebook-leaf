---
layout: page
title: Generics
permalink: /java/generics
---

- TOC
{:toc}

---

# What are Generics?

* ***parameterized types***. (generic class or generic method)
* creating classes, interfaces, and methods that will work in a type-safe manner with various kinds of data. 
* **all type-casts are automatic and implicit.**
* Many algorithms are same irrespective of data type, stack is same for **Integer, String, Object**, or **Thread**. 
* **collection classes can now be used with complete type safety.**
* Java compiler creates only one **Gen** and substitutes necessary casts, to behave as specific version of **Gen** were created. 
* process of removing generic type information is called **erasure**.

```java
class Gen<T> {
    T ob;
    Gen(T o) {ob = o;}
    T getob() {return ob;}
    void showType() {
        sysout(ob.getClass().getName());
    }
}
Gen<Integer> iOb = new Gen<Integer>(88);
iOb = new Gen<Double>(88.0); // Error!
```

## Generics Work Only with Reference Types
* cannot use a primitive type, **int** or **char**. 
* **iOb** and **strOb** of type **Gen\<T>**, but not type compatible with each other.

# How Generics Improve Type Safety – What if we use Object
* First, **explicit casts** must be employed to retrieve the stored data. 
* Second, many kinds of type **mismatch errors cannot be found until run time**.

```java
int v = (Integer) iOb.getob();
iOb = strOb; // compiles, conceptually wrong!
v = (Integer) iOb.getob(); // run-time error!
```
```java
class_name<type_arg_list>
var_name = new class_name<type_arg_list>(constructor_arg_list);
```
```java
class TwoGen<T,V>{
    T ob1;
    V ob2;
    TwoGen(T o1, V o2) {
        ob1 = o1;
        ob2 = o2;
    }
}
TwoGen<Integer,String> tgObj = new TwoGen<Integer,String>(88, "Generics");
TwoGen<String,String> x = new TwoGen<String,String>("A", "B");
```

# Bounded Types

```java
class Stats<T extends Number> {     // Number or its subclass
    T[] nums;                       // array of Number or subclass
    Stats(T[] o) { nums = o; }
    double average() {              // Return type double in all cases.
        double sum = 0.0;
        for (int i = 0; i < nums.length; i++)
            sum += nums[i].doubleValue();
        return sum / nums.length;
    }
}
```

* limit or bound types that can be passed to type parameter. 
* For example, to calculate average of an array of numbers, any type of number (***integers, float, double***).
* ***\<T extends superclass> sets upper limit***

```java
Double dnums[] = { 1.1, 2.2, 3.3, 4.4, 5.5 };
Stats<Double> dob = new Stats<Double>(dnums);
System.out.println("dob average() - " + dob.average());
Integer inums[] = { 1, 2, 3, 4, 5 };
Stats<Integer> iob = new Stats<Integer>(inums);
System.out.println("iob average() - " + iob.average());
```

## Multiple Bounds

```java
<T extends superClassName & Interface>
```
```java
class Bound<T extends A & B> { 
  private T objRef; 
  public Bound(T obj){ this.objRef = obj; }    
  public void doRunTest(){ this.objRef.displayClass(); } 
}

public class BoundedClass { 
  public static void main(String a[]) { 
    Bound<A> bea = new Bound<A>(new A()); 
    bea.doRunTest();
  } 
}
```

* Multiple Bounds allowed.
  * A and B – both interface
  * A is class then B, C should be interfaces.

```java
interface B {
    public void displayClass();
}
class A implements B {
    public void displayClass() {
        sysout("Inside super class A");
    }
}
```

# Using Wildcard Arguments
* example, **Stats** class has a method **sameAvg()** to find if two **Stats** have arrays with same average, any numeric type.
boolean sameAvg(Stats<?> ob)

```java
boolean sameAvg(Stats<T> ob) {      // This won't work!
  if(average() == ob.average())     // this object (type T), ob is also type T. Will not work for int/long/double combination
    return true;
  return false;
}
// Not feasible with current method definition as both iob and dob needs to be of same types
System.out.println("iob sameAvg(dob) - " + iob.sameAvg(dob));
```
* Problem with code here, work only with other **Stats** of same type as the invoking object.
* To make a generic **sameAvg()** method, use the *wildcard argument*, **?**, representing unknown type.
* **wildcard does not affect what type of Stats objects can be created; this is governed by the extends clause.**

```java
boolean sameAvg(Stats<? extends Number> ob) {
    if(average() == ob.average())     // Will work for int/long/double combination
        return true;
    return false;
}
```

## Bounded Wildcards
* Wildcard arguments can be bounded.
* upper bound - **extends** (<? extends superclass>) 
* lower bound - **super**  (<? super subclass>)
* call to **showXZY( )** on **Coords<TwoD>** reference will give compile-time error, thus ensuring type safety.

```java
class TwoD {  int x, y; }
class ThreeD extends TwoD {   int z;  }
class FourD extends ThreeD {  int t;  }
class Coords<T extends TwoD> {	
      T[] coords;
      Coords(T[] o) { coords = o; }
}
static void showXY(Coords<?> c) {...}                     // Valid for all 2D,3D,4D
static void showXYZ(Coords<? extends ThreeD> c) {...}     // Valid for 3D,4D
```

# Generic Methods

* can have generic method that uses one or more type parameters of its own.
* **can create a generic method enclosed within a non-generic class, type parameters are declared before the return type.**
* **Generic methods can be either static or non-static.**

```java
class GenMethDemo { // Non-Generic Class with Generic method
    // Determine if an object is in an array.
    static <T extends Comparable<T> , V extends T> boolean isIn(T x, V[] y) {
        for (int i = 0; i < y.length; i++)
            if (x.equals(y[i]))
                return true;
        return false;
    }

    public static void main(String args[]) {
        Integer nums[] = { 1, 2, 3, 4, 5 };
        if (isIn(2, nums))
            System.out.println("2 is in nums");
        String strs[] = { "one", "two", "three" };
        if (isIn("two", strs))
            System.out.println("two is in strs");
        // if(isIn("two", nums))                    // Oops! Won't compile! Types must be compatible.
    }
}
```
* **types of the arguments** are automatically discerned, but **can also be explicitly specified**.

```java
GenMethDemo.<Integer, Integer>isIn(2, nums)
```

# Generic Constructors

* It is possible to **have generic constructors, even if their class is not**.

```java
class GenCons {
    private double val;
    <T extends Number> GenCons(T arg) {
        val = arg.doubleValue();
    }
    void showval() {
        System.out.println("val: " + val);
    }
}
class GenConsDemo {
    public static void main(String args[]) {
        GenCons test1 = new GenCons(100)        test1.showval(); // 100.0
        GenCons test2 = new GenCons(123.5F);    test2.showval();
    }
}
```

# Generic Interfaces

* Generic interfaces are specified just like generic classes.

```java
interface MinMax<T extends Comparable<T>> {
    T min();    T max();
}
class MyClass<T extends Comparable<T>> implements MinMax<T> {   // No need to define upper bound twice
    T[] vals;
    MyClass(T[] o) {
        vals = o;
    }
    public T min() {        // return type T
        T min = vals[0];
        for (int i = 1; i<vals.length; i++)
            if (vals[i].compareTo(min) < 0)
                min = vals[i];
        return min;
    }
}
```

* Once type parameter defined, it is passed to interface without modification.

```java
class MyClass<T extends Comparable<T>> implements MinMax<T> {
class MyClass<T extends Comparable<T>> implements MinMax<T extends Comparable<T>> {// wrong!
```
* ***If class implements generic interface, then class must also be generic. It should takes a type parameter to pass to interface.***

```java
class MyClass implements MinMax<T> {            // Wrong!   MyClass doesn’t have a type parameter, cannot pass any to interface
class MyClass implements MinMax<Integer> {      // OK       but of no use as it’s no more generic
```

* **Generic interface offers two benefits:**
	- First, it can be implemented for different types of data.
	- Second, it allows you to put constraints (that is, bounds) on the types of data.

# Raw Types and Legacy Code

* Pre-generics code must be compatible with generics. 
* **For transition to generics, Java allows a generic class to be used without any type arguments.**
* This creates a **raw type** for the class compatible with legacy code, having no knowledge of generics. 
* The main drawback to using the **raw type** is that the **type safety of generics is lost**.
* Due to potential errors, **javac gives *unchecked warnings* on use of raw type** as it might jeopardize type safety.

```java
class Gen<T> {
    T ob;
    Gen(T o) { ob = o; }
    T getob() { return ob; }
}

class RawDemo {
    public static void main(String args[]) {
        Gen<Integer> iOb = new Gen<Integer>(88);
        Gen<String> strOb = new Gen<String>("Generics Test");
        Gen raw = new Gen(new Double(98.6));
        double d = (Double) raw.getob(); // Cast here is necessary because type is unknown.
        // int i = (Integer) raw.getob();     // run-time error
        strOb = raw; // OK, but potentially wrong
        // String str = strOb.getob();        // run-time error
        raw = iOb; // OK, but potentially wrong
        // d = (Double) raw.getob();          // run-time error
    }
}
```
* No type arguments, this creates a **Gen** object whose type **T** is replaced by **Object**.

# Generic Class Hierarchies

## Generic Superclass
```java
class Gen<T> {
  T ob;    
  Gen(T o) { ob = o; }
  T getob() { return ob; }
}
```
```java
class Gen2<T> extends Gen<T> {      // defines type T
   Gen2(T o) { super(o); }
}
```
```java
class Gen2<T, V> extends Gen<T> {   // defines type T and V both.
  V ob2;
  Gen2(T o, V o2) {
      super(o);                     // Type arguments needed by generic superclass
      ob2 = o2;
  }
  V getob2() { return ob2; }
}
```

* **Gen2** does not use the type parameter **T** except to support the **Gen** superclass.
* **A generic class can act as a superclass or be a subclass.**
* **Type arguments needed by a generic superclass must be passed up the hierarchy by all subclasses.**
* **Constructor arguments must be passed up a hierarchy.**

## Generic Subclass 
* Non-generic class can have generic subclass.

```java
class NonGen {
  int num;
  NonGen(int i) { num = i; }
  int getnum() { return num; }
}

class Gen<T> extends NonGen {
  T ob;                 // declare an object of type T
  Gen(T o, int i) {
	super(i);           // super constructor as 1st statement
	ob = o;
  }
  T getob() { return ob; }
}

// main() method
Gen<String> w = new Gen<String>("Hello", 47);
System.out.print(w.getob() + " ");
System.out.println(w.getnum());
```

## Run-Time Type Comparisons Within a Generic Hierarchy

**instanceof** - returns true if an object is of the specified type or can be cast to the specified type.

```java
class Gen<T> {
  T ob;
  Gen(T o) { ob = o; }
  T getob() { return ob; }
}

class Gen2<T> extends Gen<T> {
  Gen2(T o){super(o);}
}

class HierDemo3 {
public static void main(String args[]) {.
 Gen<Integer> iOb = new Gen<Integer>(88);
 Gen2<Integer> iOb2 = new Gen2<Integer>(99);
 Gen2<String> strOb2 = new Gen2<String>("Generics Test");

 if(iOb2 instanceof Gen2<?>)   {sysout("iOb2 is instance of Gen2");}        // true
 if(iOb2 instanceof Gen<?>)    {sysout ("iOb2 is instance of Gen");}        // true
 if(strOb2 instanceof Gen2<?>) {sysout ("strOb2 is instance of Gen2");}     // true
 if(strOb2 instanceof Gen<?>)  {sysout ("strOb2 is instance of Gen");}      // true
 if(iOb instanceof Gen2<?>)    {sysout ("iOb is instance of Gen2");}        // false
 if(iOb instanceof Gen<?>)     {sysout ("iOb is instance of Gen");}         // true
 // if(iOb2 instanceof Gen2<Integer>)   sysout ("iOb2 is instance of Gen2<Integer>");
 // can't be compiled, generic type info does not exist at run time.
}
```
* wildcard enables instanceof to determine if iOb2 is an object of any type of Gen2.

## Casting
* can cast one instance of a generic class into another only if the two are compatible and their type arguments are the same.

```java
(Gen<Integer>) iOb2     // legal - because iOb2 includes an instance of Gen<Integer>.
(Gen<Long>) iOb2        // illegal - is not legal because iOb2 is not an instance of Gen<Long>.
```

## Overriding Methods in a Generic Class
```java
class Gen<T> {
    T ob;
    Gen(T o) { ob = o; }
    T getob() {
        sysout("Gen's getob():");
        return ob;
    }
}

class Gen2<T> extends Gen<T> {
    Gen2(T o) { super(o); }
    T getob() {
        sysout("Gen2's getob(): ");
        return ob;
    }
}
```

## Type Inference with Generics
* **<>, diamond operator**, to tell the compiler to infer the type arguments needed by the constructor in the new expression.

```java
MyClass<Integer,String> mcOb = new MyClass<Integer,String>(98, "A String");
MyClass<Integer,String> mcOb = new MyClass<>(98, "A String");
boolean isSame(MyClass<T,V> o) {
    return (ob1 == o.ob1 && ob2 == o.ob2) ? true : false;
}
if (mcOb.isSame(new MyClass<>(1, "test")))
    System.out.println("Same");
```

# Erasure

* compatibility with preexisting, non-generic code, is achieved through ***erasure***.

## How erasure works?
* On compilation, all generic type information is removed (erased). 
* replaces type parameters with their bound type, **Object** by default, and apply appropriate casts. 
* No type parameters exist at run time. They are simply a source-code mechanism.

## Bridge Methods
* Needed for situation where type erasure in superclass and subclass does not produce same erasure method. 
* A method is generated that uses type erasure of superclass, and calls the method with subclass type erasure. 
* bridge methods only occur at the ***bytecode level, are not seen by you, and are not available for your use***.

```java
class Gen<T> {   // situation creating a bridge method.
  T ob; 
  Gen(T o) { ob = o; }
  T getob() { return ob; }
}
class Gen2 extends Gen<String> {
 Gen2(String o) { super(o); }
 String getob() {  return ob;   }
}

class BridgeDemo {
 public static void main(String args[]) {
  Gen2 strOb2 = new Gen2("Generics Test");
  System.out.println(strOb2.getob());
 }
}
```
* Due to type erasure, the expected form of getob( ) will be
Object getob() { // ...
* compiler generates a bridge method that calls the String version. 
* examine class file Gen2 by javap, you see below methods:

```java
class Gen2 extends Gen<java.lang.String> {
   Gen2(java.lang.String);
   java.lang.String getob();
   java.lang.Object getob();  // bridge method
}
```
Normally, same signature would cause an error, but because this does not occur in your source code, it does not cause a problem and is handled correctly by the JVM.

## Ambiguity Errors

* Due to erasure, two distinct generic declarations resolve to same erased type, causing a conflict.

```java
class MyGenClass<T, V> {
 T ob1;      V ob2;
 // ambiguous, will not compile.
 void set(T o) { ob1 = o; }
 void set(V o) { ob2 = o; }
}
```
* There are two ambiguity problems here:
	- T and V can be of same types. 
        - MyGenClass<String, String> obj = new MyGenClass<>()
        - both versions of set( ) identical, an error.
	- type erasure of set( ) reduces both versions to the following: 
        - void set(Object o) { // ... both set() are inherently ambiguous.

```java
class MyGenClass<T, V extends Number> { // almost OK!
MyGenClass<String, Number> x = new MyGenClass<String, Number>();
MyGenClass<Number, Number> y = new MyGenClass<Number, Number>();
```
* Better to use two separate method names, rather than trying to overload **set()**. 
* Often, ambiguity can be resolved by restructuring the code as it generally means a conceptual error in your design.

# Generics Restrictions

## Type Parameters Can’t Be Instantiated
- T is a placeholder, not well-defined type.

```java
class Gen<T> {
    T ob;
    Gen() { ob = new T(); }     // Illegal!!!
}
```

## Restrictions on Static Members
- No static member can use a type parameter declared by the enclosing class, static are class level but T is at instance level.

```java
class Wrong<T> {
   static T ob;                     // Wrong, no static variables of type T.
   static T getob() { return ob; }  // Wrong, no static method can use T.
   // generic static method with its own type param is OK
   static <T extends Comparable<T>, V extends T> boolean isIn(T x, V[] y){...}
}
```

## Generic Array Restriction
* cannot instantiate an array of type parameter. 
* cannot create an array of type-specific generic references.

```java
class Gen<T extends Number> {
    T ob;
    T[] vals;
    Gen(T o, T[] nums) {
        ob = o;
        vals = nums;
        // vals = new T[10];   // can't create an array of T
    }
}

public static void main(String args[]) {
    Integer n[] = { 1, 2, 3, 4, 5 };
    Gen<Integer> iOb = new Gen<Integer>(50, n);
    // Gen<Integer> gens[] = new Gen<Integer>[10];  // Wrong!
    // Gen<Long> gensLong[] = new Gen<Long>[10];  // Wrong!
    // gens[0] = gensLong[0];  // Wrong! this is why generic array of type is not allowed
    Gen<?> gens[] = new Gen<?>[10];                 // OK
}
```
* No direct type casting of arrays on type-erasure.  `(int[]) Object[]`
* You can create an array of references to a generic type if you use a wildcard.

## Generic Exception Restriction
* A generic class ***cannot extend Throwable***.
* you ***cannot create generic exception classes***.

