---
layout: page
title: Reflection
permalink: /java/reflection
---

- TOC
{:toc}

---

# Introduction

* **Java Reflection** is a process of examining or modifying the run time behavior of a class at run time.
* java.lang and java.lang.reflect packages provide classes for java reflection. 
* With java reflection we can inspect a class, interface, enum, get their structure, methods and fields information at runtime even though class is not accessible at compile time. 
* We can also use reflection to instantiate an object, invoke it’s methods, change field values.

## Where it is used
**Reflection** in Java is a very powerful concept and it’s of little use in normal programming but it’s the backbone for most of the Java, J2EE frameworks. Some of them are:
* JUnit – uses reflection to parse @Test annotation to get the test methods and then invoke it. 
* Spring – dependency injection, read more at Spring Dependency Injection
* Tomcat web container to forward the request to correct module by parsing web.xml files and request URI.
* Eclipse auto completion of method names 
* Struts
* Hibernate

The list is endless and they all use java reflection because all these frameworks have no knowledge and access of user defined classes, interfaces, their methods etc.

|*Drawbacks*||
---|---
**Poor Performance**	    |resolves the types dynamically, it involves processing like scanning the classpath to find the class to load, causing slow performance.
**Security Restrictions**	|Reflection requires runtime permissions that might not be available for system running under security manager. This can cause you application to fail at runtime because of security manager.
**Security Issues**	        |Using reflection, we can access part of code that we are not supposed to access, for example we can access private fields of a class and change it’s value. This can be a serious security threat and cause your application to behave abnormally.
**High Maintenance**	    |Reflection code is hard to understand and debug, also any issues with the code can’t be found at compile time because the classes might not be available, making it less flexible and hard to maintain.

# Reflection for Classes

## java.lang.Class 
* java.lang.Class is the entry point for all the reflection operations. 
* For every type of object, JVM instantiates an immutable instance of java.lang.Class that provides methods to examine the runtime properties of the object and create new objects, invoke its method and get/set object fields.

The java.lang.Class class performs mainly two tasks:
* provides methods to get the metadata of a class at run time.
* provides methods to examine and change the run time behavior of a class.

|Method	| Description|
---|---
String getName()|returns the class name
static Class forName(String className) throws ClassNotFoundException|loads the class and returns the reference of Class.
newInstance() throws InstantiationException ,IllegalAccessException|creates new instance.
boolean isInterface()	|checks if it is interface.
boolean isArray()	    |checks if it is array.
boolean isPrimitive()	|checks if it is primitive.
Class getSuperclass()	|returns the superclass class reference.
Field[] getDeclaredFields() throws SecurityException|returns the total number of fields of this class.
Method[] getDeclaredMethods() throws SecurityException|returns the total number of methods of this class.
Constructor[] getDeclaredConstructors() throws SecurityException|returns total number of constructors of this class.
Method getDeclaredMethod(String name,Class[] parameterTypes) throws NoSuchMethodException,SecurityException	|returns the method class instance.
public void setAccessible(boolean status) throws SecurityException	|sets the accessibility of the method.

**How to get the object of Class class?**
* forName()
    - is used to load the class dynamically, returns the instance of Class class.
    - To be used to know the fully qualified name of class. Cannot be used for primitive types.
    - Class c=Class.forName("com.example.ClassA");
* getClass() of Object class	
    - it can be used with primitives.
	- Class c=obj.getClass()
* .class	
    - It can be used for primitive data type also.
	- MyClass.class boolean.class

## newInstance() 
* newInstance() method of Class  and Constructor are used to create a new instance of the class. 
* newInstance() method of Class can invoke zero-argument constructor.
* newInstance() method of Constructor can invoke any number of arguments. So, Constructor is preferred over Class.
* public Object invoke(Object method, Object... args) throws IllegalAccessException, IllegalArgumentException, InvocationTargetException is used to invoke the method.

## getCanonicalName() 
* returns the canonical name of the underlying class. 
* java.lang.Class uses Generics, helps frameworks in making sure that the Class retrieved is subclass of framework Base Class.

## getSuperclass() 
* returns the super class of the class. 
* If this Class represents either of the Object class, an interface, a primitive type, or void, then null is returned. 
* If this object represents an array class then the Class object representing the Object class is returned.

## getClasses() 
* returns an array containing Class objects representing all the public classes, interfaces and enums that are members of the class represented by this Class object. This includes public class and interface members inherited from superclasses and public class and interface members declared by the class. This method returns an array of length 0 if this Class object has no public member classes or interfaces or if this Class object represents a primitive type, an array class, or void. 
* `Class<?>[] classes = concreteClass.getClasses();`

## How to call private method from another class in java

```java
class A {
    private void message() {
        System.out.println("hello java");
    }
    private void cube(int n) {
        System.out.println(n * n * n);
    }
}
class M {
    public static void main(String args[]) throws Exception {
        Class c = A.class;
        Object obj = c.newInstance();
        Method m1 = c.getDeclaredMethod("message", null);
        Method m = c.getDeclaredMethod("cube", new Class[] {
            int.class
        });
        m1.setAccessible(true);
        m.setAccessible(true);
        m1.invoke(o, null);
        m.invoke(obj, 4);
    }
}
```

## Example in eWMS

```java
Class - PullSeqDateGeneratorImpl
Method - buildPullSeqDate
public void buildPullSeqDate(String detailCode, String formulaeValue, Map < Integer, String > pullSeq, String receivingYear) throws CodeDateServiceException {
    try {
        // load the PullSeqFormulaeMethod at runtime
        Class << ? > pullSeqFormulaeMethod = Class.forName("com.service.PullSeqFormulaeMethod");
        Object pullSeqFormulaeMethodObj = pullSeqFormulaeMethod.newInstance();
        Method pullSeqMap = pullSeqFormulaeMethod.getDeclaredMethod("setValueOfFormulaeCode" + detailCode, String.class, Map.class, String.class);
        pullSeqMap.invoke(pullSeqFormulaeMethodObj, formulaeValue, pullSeq, receivingYear);
    }
}
```

## javap tool
* The **javap command** disassembles a class file. The javap command displays information about the fields, constructors and methods present in a class file.
* **javap fully_class_name**
* examples
    - javap java.lang.Object
	- javap -c Simple

|Option	    | Description |
---|---
-help	    | prints the help message.
-l	        | prints line number and local variable
-c	        | disassembles the code, relects bytecode.
-s	        | prints internal type signature
-sysinfo	| shows system info (path, size, date, MD5 hash)
-constants	| shows static final constants
-version	| shows version information

## getDeclaredClasses()

```java
//getting all of the classes, interfaces, and enums that are explicitly declared in ConcreteClass
Class<?>[] explicitClasses = Class.forName("com.a04t.ConcreteClass").getDeclaredClasses();
System.out.println(Arrays.toString(explicitClasses));
```

## getDeclaringClass()
* returns the Class object representing the class in which it was declared.

```java
Class<?> innerClass = Class.forName("com.a04t.ConcreteClass$ConcreteClassDefaultClass");
System.out.println(innerClass.getDeclaringClass().getCanonicalName());
System.out.println(innerClass.getEnclosingClass().getCanonicalName());
```

## getPackage() 
* returns the package for this class. The class loader of this class is used to find the package. 

```java
System.out.println(Class.forName("com.a04t.BaseInterface").getPackage().getName());
```

## getModifiers() 
* returns the int representation of the class modifiers, 
* can use java.lang.reflect.Modifier.toString() method to get it in the string format as used in source code.

```java
System.out.println(Modifier.toString(concreteClass.getModifiers()));
System.out.println(Modifier.toString(Class.forName("com.journaldev.reflection.BaseInterface").getModifiers()));
```

## getTypeParameters()
* returns the array of TypeVariable if there are any Type parameters associated with the class. 
* The type parameters are returned in the same order as declared.

```java
TypeVariable<?>[] typeParameters = Class.forName("java.util.HashMap").getTypeParameters();
for(TypeVariable<?> t : typeParameters)
	System.out.print(t.getName()+",");
```

## getGenericInterfaces()
* Get Implemented Interfaces
* returns array of interfaces implemented by the class with generic type information. 
* can also use getInterfaces() to get the class representation of all the implemented interfaces.

```java
Type[] interfaces = Class.forName("java.util.HashMap").getGenericInterfaces();
//prints "[java.util.Map<K, V>, interface java.lang.Cloneable, interface java.io.Serializable]"
System.out.println(Arrays.toString(interfaces));
//prints [interface java.util.Map,interface java.lang.Cloneable,interface java.io.Serializable]
System.out.println(Arrays.toString(Class.forName("java.util.HashMap").getInterfaces()));
```

## getMethods()
* Get All Public Methods
* returns the array of public methods of the Class including public methods of it’s superclasses and super interfaces.

```java
Method[] publicMethods = Class.forName("com.journaldev.reflection.ConcreteClass").getMethods();
//prints public methods of ConcreteClass, BaseClass, Object
System.out.println(Arrays.toString(publicMethods));
```

## getConstructors()
* Get All Public Constructors 
* method returns the list of public constructors of the class reference of object.

```java
//Get All public constructors
Constructor<?>[] publicConstructors = Class.forName("com.journaldev.reflection.ConcreteClass").getConstructors();
//prints public constructors of ConcreteClass
System.out.println(Arrays.toString(publicConstructors));
```

## getFields()
* Get All Public Fields
* returns the array of public fields of the class including public fields of it’s super classes and super interfaces.

```java
//Get All public fields
Field[] publicFields = Class.forName("com.journaldev.reflection.ConcreteClass").getFields();
//prints public fields of ConcreteClass, it's superclass and super interfaces
System.out.println(Arrays.toString(publicFields));
```

## getAnnotations()
* Get All Annotations
* returns all the annotations for the element, we can use it with class, fields and methods also.
* only annotations available with reflection are with retention policy of RUNTIME.

```java
java.lang.annotation.Annotation[] annotations = Class.forName("com.journaldev.reflection.ConcreteClass").getAnnotations();
//prints [@java.lang.Deprecated()]
System.out.println(Arrays.toString(annotations));
```

# Reflection for Methods

## getMethod()
* Get Public Method 
* need to pass the method name and parameter types of the method. 
* If the method is not found in the class, reflection API looks for the method in superclass.

```java
Method method = Class.forName("java.util.HashMap").getMethod("put", Object.class, Object.class);
//get method parameter types, prints "[class java.lang.Object, class java.lang.Object]"
System.out.println(Arrays.toString(method.getParameterTypes()));
//get method return type, return "class java.lang.Object", class reference for void
System.out.println(method.getReturnType());
//get method modifiers
System.out.println(Modifier.toString(method.getModifiers())); //prints "public"
```

## invoke()
* Invoking Public Method
* If the method is static, we can pass NULL as object argument.

```java
Method method = Class.forName("java.util.HashMap").getMethod("put", Object.class, Object.class);
Map<String, String> hm = new HashMap<>();
method.invoke(hm, "key", "value");
System.out.println(hm); // prints {key=value}
```

## getDeclaredMethod()
* Invoking Private Methods
* can use to get the private method and then turn off the access check to invoke it.

```java
//invoking private method
Method method = Class.forName(com.journaldev.reflection.BaseClass.getDeclaredMethod("method3", null);
method.setAccessible(true);
method.invoke(null, null); // prints "Method3"
```

# Reflection for Fields

## Get Public Field
* to get specific public field of a class through getField() method. 
* look for the field in the specified class reference and then in the super interfaces and then in the super classes.
* NoSuchFieldException, if no field found.

```java
Field field = Class.forName("com.journaldev.reflection.ConcreteClass").getField("interfaceInt");
```

## getDeclaringClass()
* Field Declaring Class

```java
try {
    Field field = Class.forName("com.journaldev.reflection.ConcreteClass").getField("interfaceInt");
    Class << ? > fieldClass = field.getDeclaringClass();
    System.out.println(fieldClass.getCanonicalName());
    //prints com.journaldev.reflection.BaseInterface
} catch (NoSuchFieldException | SecurityException e) {
    e.printStackTrace();
}
```

## getType()
* Get Field Type
* returns the Class object for the declared field type.
* If field is primitive type, it returns the wrapper class object.

```java
Field field = Class.forName("com.journaldev.reflection.ConcreteClass").getField("publicInt");
Class<?> fieldType = field.getType();
System.out.println(fieldType.getCanonicalName()); //prints int
```

## Get/Set Public Field Value
* We can get and set the value of a field in an Object using reflection.

```java
Field field = Class.forName("com.journaldev.reflection.ConcreteClass").getField("publicInt");
ConcreteClass obj = new ConcreteClass(5);
System.out.println(field.get(obj)); //prints 5
field.setInt(obj, 10); //setting field value to 10 in object
System.out.println(field.get(obj)); //prints 10
```

* get() method return Object, so if field is primitive type, it returns the corresponsing Wrapper Class.
* If the field is static, we can pass Object as null in get() method.
* There are several set*() methods to set Object to the field or set different types of primitive types to the field. 
* We can get the type of field and then invoke correct function to set the field value correctly. 
* If the field is final, the set() methods throw java.lang.IllegalAccessException.

## Get/Set Private Field Value
* We know that private fields and methods can’t be accessible outside of the class but using reflection we can get/set the private field value by turning off the java access check for field modifiers.

```java
Field privateField = Class.forName("com.journaldev.reflection.ConcreteClass").getDeclaredField("privateString");
//turning off access check with below method call
privateField.setAccessible(true);
ConcreteClass objTest = new ConcreteClass(1);
System.out.println(privateField.get(objTest)); // prints "private string"
privateField.set(objTest, "private string updated");
System.out.println(privateField.get(objTest)); //prints "private string updated"
```

# Reflection for Constructors

## getConstructor()
* Get Public Constructor
* to get specific public constructor.

```java
Constructor<?> constructor = Class.forName("com.journaldev.reflection.ConcreteClass").getConstructor(int.class);
//getting constructor parameters
System.out.println(Arrays.toString(constructor.getParameterTypes())); // prints "[int]"
Constructor<?> hashMapConstructor = Class.forName("java.util.HashMap").getConstructor(null);
System.out.println(Arrays.toString(hashMapConstructor.getParameterTypes())); // prints "[]"
```

## newInstance()
* Instantiate Object using Constructor
* use method on the constructor object to instantiate a new instance of the class.

```java
Constructor<?> constructor = Class.forName("com.journaldev.reflection.ConcreteClass").getConstructor(int.class);
//getting constructor parameters
System.out.println(Arrays.toString(constructor.getParameterTypes()));
// prints "[int]"
Object myObj = constructor.newInstance(10);
Method myObjMethod = myObj.getClass().getMethod("method1", null);
myObjMethod.invoke(myObj, null); 
//prints "Method1 impl."
Constructor<?> hashMapConstructor = Class.forName("java.util.HashMap").getConstructor(null);
System.out.println(Arrays.toString(hashMapConstructor.getParameterTypes())); 
// prints "[]"
HashMap<String,String> myMap = (HashMap<String,String>) hashMapConstructor.newInstance(null);
```

# Reflection for Annotations

* Reflection API was also extended to provide support to analyze the annotations at runtime.
* Using reflection API we can analyze annotations whose retention policy is Runtime.