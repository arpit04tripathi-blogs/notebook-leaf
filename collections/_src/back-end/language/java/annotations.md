---
layout: page
title: Annotation in Java
permalink: /java/annotation
---

- TOC
{:toc}

---

# Annotations

* To embed supplemental information into a source file, it does not change the actions of a program. 
* An annotation is created through a mechanism based on the **interface**.
* consist solely of method declarations with no bodies as java provides implementation.
* methods act much like fields.

```java
@interface MyAnno {
  String str() default "Testing";
  int val() default 100;
}
```
* An annotation cannot include an **extends** clause as they automatically extend the **Annotation** interface. 
* package - **java.lang.annotation**.
* overrides **hashCode( ), equals( )**, and **toString( )** defined by **Object**.
* **annotationType()** - returns a **Class** object that represents the invoking annotation.
* *classes, methods, fields, parameters, **enum** constants and even annotation can be annotated.*
* the annotation precedes the rest of the declaration.

```java
@MyAnno(str = "Annotation Example", val = 100)
public static void myMeth() { // …
```
* When an annotation member is given a value, only its name is used. Thus, annotation members look like fields in this context.

## Specifying a Retention Policy

* Retention policy - determines when an annotation is discarded. 
* **java.lang.annotation.RetentionPolicy** enum - **SOURCE, CLASS**, and **RUNTIME**.
    - SOURCE – annotation is retained only in the source file and is discarded during compilation.
    - CLASS – retained till **.class** during compilation, discarded by JVM during run time.
    - RUNTIME - available for JVM runtime also. greatest annotation persistence.
* An annotation on a local variable declaration is not retained in the .class file.

# Get Annotations at Run Time by Use of Reflection

* Annotations with **RUNTIME** retention policy can be queried at run time using *reflection*.
* Reflection - feature to get info about a class at run time. (java.lang.reflect package)
* Class object – obtain by .getClass( ) of Object.

```java
final Class<?> getClass( )
```
* getMethod( ), getField( ), and getConstructor( ) return objects of type Method, Field, and Constructor.

```java
Method getMethod(String methName, Class<?> ... paramTypes)    // NoSuchMethodException can be thrown
```
* Class, Method, Field, or Constructor object - getAnnotation( ) obtains a specific annotation associated with that object.

```java
<A extends Annotation> getAnnotation(Class<A> annoType)    // null if not found
```
```java
import java.lang.annotation.*;
import java.lang.reflect.*;
@Retention(RetentionPolicy.RUNTIME)
@interface MyAnno {
    String str();
    int val();
}
class Meta {
    @MyAnno(str = "Annotation Example", val = 100) // Annotate a method.
    public static void myMeth() {
        Meta ob = new Meta();
        try {
            Class < ? > c = ob.getClass();
            Method m = c.getMethod("myMeth");
            // Method m = c.getMethod("myMeth", String.class, int.class);
            // myMeth(String str, int i){}
            MyAnno anno = m.getAnnotation(MyAnno.class); // get single annotation
            System.out.println(anno.str() + " " + anno.val());
            Annotation annos[] = ob.getClass().getAnnotations(); // get all annotations
            System.out.println("All annotations for myMeth:");
            for (Annotation a: annos) {
                System.out.println(a);
            }
        } catch (NoSuchMethodException exc) {
            System.out.println("Method Not Found.");
        }
    }
    public static void main(String args[]) {
        myMeth();
    }
}
// Output
All annotations for myMeth:
@What(description = An annotation test method)
@MyAnno(str = Testing, val = 100)
```

# AnnotatedElement Interface

## java.lang.reflect.AnnotatedElement`
* `getAnnotation()`
* `getAnnotations()`
* Annotation[ ] `getDeclaredAnnotations()` - all non-inherited annotations
* `isAnnotationPresent(Class<? extends Annotation> annoType)`

* JDK 8 adds `getDeclaredAnnotation()`, `getDeclaredAnnotationsByType()`, and `getAnnotationsByType()`. 
* Last two automatically work with a repeated annotation.

## Marker Annotations
* contains no members, used to mark an item. And check it using `isAnnotationPresent()`.
* @MyMarker() and @MyMarker both are valid.
* @MyMarker is used without parenthesis due to no members present.

## Single-Member Annotations
* Only one member or all other with default values.
* Allows shorthand representation - @MySingle(100)

# Built-in Annotations

## java.lang.annotation
* ***used with other annotations only***.
* **@Retention** - used only as an annotation to another annotation to specify retention policy.
* **@Documented** - marker annotation that tells a tool that an annotation is to be documented. 
* **@Inherited** - marker annotation. Makes the annotation inheritable to a subclass.
* **@Target** - types of items allowed for annotation and takes one argument, array of constants of the ElementType enumeration.
* If you don't use @Target, all are allowed except type parameters.

![annotations-target.png]({{site.cdn}}/java/reflection/annotations-target.png)

```java
@Target( { ElementType.FIELD, ElementType.LOCAL_VARIABLE } )
```

## java.lang
* **@Override** - marker annotation for methods. ensure methods are overridden not simply overloaded, compile-time error caused.
* **@Deprecated** - marker annotation that a declaration is obsolete and has been replaced by a newer form.
* **@FunctionalInterface** - marker annotation(JDK 8) for interfaces. Indicates an interface with only one abstract method. 
    - Functional interfaces are used by lambda expressions.
    - It is purely informational, not mandatory. It becomes only by definition of exactly one abstract method.
* **@SafeVarargs** - marker annotation for methods and constructors. 
	- It indicates that no unsafe actions related to a varargs parameter occur and suppress unchecked warnings.
	- It must be applied only to vararg methods or constructors that are static or final.
* **@SuppressWarnings**
    - specifies warnings that might be issued by the compiler are to be suppressed. The warnings to suppress are specified by name, in string form.

# Type Annotations – JDK8

* With JDK 8, annotations can be used in new places which were originally allowed only on declarations.
* can annotate return type of method, type of **this** in a method, a cast, array levels, an inherited class, and a **throws** clause.
* can also annotate generic types, including generic type parameter bounds and generic type arguments.
* type annotation must include **ElementType.TYPE_USE** as a target.
* For example, assuming some type annotation called **@TypeAnno**, the following is legal:

```java
void myMeth() throws @TypeAnno NullPointerException { // ...
```
* You can also annotate the type of **this** (called the *receiver*).
	- this is an implicit argument to all instance methods and it refers to the invoking object. 
	- To annotate its type requires a new JDK 8 feature where you can explicitly declare this as 1st param to a method.
	- In this declaration, the type of this must be the type of its class.
```java
int myMeth(@TypeAnno SomeClass this, int i, int j) { // …
```
  - It is not necessary to declare **this** unless you are annotating it. 
	- If **this** is not declared, it is still implicitly passed. JDK 8 does not change **this** fact.
	- Also, explicitly declaring **this** does not change the method’s signature because **this** is implicitly declared, by default.

![annotations-type]({{site.cdn}}/java/reflection/annotations-type.png)

* **@EmptyOK, @Recommended, @What** - not type annotations, included for comparison purposes.
* **@What** - used to annotate a generic type parameter declaration.

```java
// Demonstrate several type annotations.
import java.lang.annotation.*;
import java.lang.reflect.*;
// Marker Annottions
@Target(ElementType.TYPE_USE)
@interface TypeAnno { }
@Target(ElementType.TYPE_USE)
@interface NotZeroLen {}
@Target(ElementType.TYPE_USE)
@interface Unique { }
@Target(ElementType.TYPE_USE)
@interface MaxLen {int value();}
@Target(ElementType.TYPE_PARAMETER)
@interface What {String description();}
@Target(ElementType.FIELD)
@interface EmptyOK { }
@Target(ElementType.METHOD)
@interface Recommended { }

class TypeAnnoDemo<@What(description = "Generic data type") T> {                // type parameter.
  public @Unique TypeAnnoDemo() {}                                              // type on a constructor
  @TypeAnno String str;                                                         // Annotate the type (here, String), not the field.
  @EmptyOK String test;                                                         // Annotates field.
  public int f(@TypeAnno TypeAnnoDemo<T> this, int x) {  return 10;  }          // Annotate this
  public @TypeAnno Integer f2(int j, int k) {  return j+k;}                     // Annotate the return type
  public @Recommended Integer f3(String str) {return str.length() / 2;}         // Annotate method declaration
  public void f4() throws @TypeAnno NullPointerException {...}                  // Type annotation on throws clause
  String @MaxLen(10) [] @NotZeroLen [] w;                                       // Annotate array levels
  @TypeAnno Integer[] vec;                                                      // Annotate array element
  public static void myMeth(int i) {
    TypeAnnoDemo<@TypeAnno Integer> ob = new TypeAnnoDemo<@TypeAnno Integer>(); //Annotate type argument
    @Unique TypeAnnoDemo<Integer> ob2 = new @Unique TypeAnnoDemo<Integer>();    // type annotation with new.
    Object x = new Integer(10);
    Integer y;
    y = (@TypeAnno Integer) x;                                                  // type annotation on a cast.
  }
  public static void main(String args[]) {  myMeth(10);  }
  class SomeClass extends @TypeAnno TypeAnnoDemo<Boolean> {}                    // type annotation with inheritance clause.
}
```

# Repeating Annotations

* JDK 8 annotation - enables annotation to be repeated on the same element, must be annotated with the **@Repeatable**.
* **value** field specifies the container type for the repeatable annotation, an array of the repeatable annotation type.

```java
// Make MyAnno repeatable.
@Retention(RetentionPolicy.RUNTIME)
@Repeatable(MyRepeatedAnnos.class)
@interface MyAnno {String str() default "Testing"; int val() default 9000;}
// This is the container annotation.
@Retention(RetentionPolicy.RUNTIME)
@interface MyRepeatedAnnos { MyAnno[] value(); }
```
* In **getAnnotation()**, use the container annotation, not the repeatable annotation.

```java
The output is shown here:
@MyRepeatedAnnos(value=[@MyAnno(str=First annotation, val=-1),
@MyAnno(str=Second annotation, val=100)])
```
repeated annotations are separated by a comma. They are not returned individually.
* **getAnnotationsByType()** and **getDeclaredAnnotationsByType()**.

```java
Annotation[] annos = m.getAnnotationsByType(MyAnno.class);
for(Annotation a : annos){ System.out.println(a); }
```

# Annotaions Restrictions

* No annotation can inherit another.
* all methods declared by an annotation must be without parameters. 
* they must return one of the following:
	- A primitive type, such as **int** or **double**
	- An object of type **String** or **Class**
	- An **enum** type
	- Another annotation type
	- An array of one of the preceding types
* Annotations cannot be generic, cannot take type parameters. 
* annotation methods cannot specify a **throws** clause.

