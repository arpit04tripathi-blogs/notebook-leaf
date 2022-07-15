---
layout: page
title: OOP and OOD
permalink: /java/oop-and-ood
---

- TOC
{:toc}

---

# Object Oriented Programming (OOP)

```
PROGRAMMING PARADIGM :   Computer Program = code + data.
```

**Object-oriented vs Object-based programming language?**
* Object based programming language --> OOP except Inheritance.
* Example = JavaScript and VBScript.

![oop]({{site.cdn}}/java/oop-and-ood/oops-concept.jpg)

- **Class**
  - Templates for creating objects. (Logical Entity)
  - Define custom data types and methods.
- **Object**
  - Entity with state and behaviour.
  - Memory is allocated.
  - example: chair, pen, table etc. (physical or logical).
- **Inheritance**
  - Parent Child concept, child acquires properties and behaviour of parent object.
  - Used for runtime polymorphism.
- **Abstraction**
  - Concept of hiding internal details and describing in simple terms.
  - Achieved by encapsulation and inheritance.
- **Encapsulation**
  - Wrapping code and data into single unit just like a capsule.
  - access restriction to class members and methods.
  - Achieved by access-modifiers (private, protected, public).
- **Polymorphism**
  - Concept where an object behaves differently in different situations.
  - ***Compile time polymorphism***
    - Method overloading (same name but different arguments)
    - when we have `“IS-A” relationship` between objects.
    - Working in terms of superclass, actual implementation class decided at runtime.
  - ***Runtime polymorphism***
    - Method overriding or dynamic method dispatch (subclass override superclass method)
- **Association**
  - Defines the multiplicity between independent objects. (One-To-Many)
  - **Aggregation**
    - `HAS-A relationship` with ownership, employee has an address.
  - **Composition**
    - More restrictive form of aggregation, `HAS-A relationship` but can’t exist on its own.
    - Example - House has-a Room. Here room can’t exist without house.

## Object-oriented vs Process-oriented

|Object-oriented programming|Process-oriented model|
|---|---|
|Program around “who is being affected” (data).|Program around “what is happening” (code).|
|Data controlling access to code.|Characterizes program as a series of linear steps (code).|
|easier development and maintenance|Problems when programs grow larger and more complex.|
|can simulate real-world event more effectively.|Such emulation not easy.|
|Eg. Java, .Net etc.|Procedural languages such as C (code acting on data)|


### Why Java is not a purely Object-Oriented Language?
No, Java is not purely Object Oriented due to following points :
- ***static keyword*** :  When we declare a class as static then it can be used without the use of an object in Java.
- **Primitive Data Type** : Even wrapper uses primitives for operations via autoboxing and unboxing.

Pure Object-Oriented Language has *strictly* all of the following features :
- Abstraction
- Encapsulation/Data Hiding
- Inheritance
- Polymorphism
- All predefined types are objects
- All user defined types are objects
- All operations on objects by exposed methods only.

# OOD (Object Oriented Design)

Process of planning a system of interacting objects for the purpose of solving a software problem.

1. Gather Requirements – could Do vs Must Do
2. Describe the App – Use Case vs User Story
3. Identify the main objects
4. Describe the interactions – Behavior, sequence diagram
5. Create class diagram

* Using design patterns to solve common problems is the best practice.
    - *Observer* – change in one object leads to change in many other objects
    - *Memento* – object changed by a lot of other objects and now you want to undo last changes.
* **User Story** - As a (type of user) I want (goal) so that (reason)
* **Use Case** - Title > actor > steps > preconditions > outcome

# FURPS+

> [Read Article on FURPS+](https://www.ibm.com/developerworks/rational/library/3975.html){:target="_blank"}

- Functional Requirement
- Usability Requirements
- Reliability – Disaster Recovery
- Performance
- Supportability
- Design
- Implementation
- Interface
- Physical

# Object Oriented Design Principles
> Read full article on [OOP Design Principles](https://javarevisited.blogspot.com/2018/07/10-object-oriented-design-principles.html){:target="_blank"}

## DRY (Don't repeat yourself)
- Use Abstraction to abstract common things in one place.
- extract method - if using same code block in more than two places.
- public final constant - if using hard-coded value more than once.

## Delegation principles

* Don't do all stuff by yourself,  delegate it to the respective class.
* Example - [equals() and hashCode() method in Java](http://javarevisited.blogspot.com/2011/02/how-to-write-equals-method-in-java.html).
  * To compare two objects for equality, we ask the class itself to do comparison instead of Client class doing that check.
  * The key benefit of this design principle is no duplication of code and pretty easy to modify behavior.

## KISS
* “Keep It Simple, Stupid”.

## YAGNI
* “You Ain’t Gonna Need It”. 
* `If you run into a situation where you are asking yourself, “What about adding extra (feature, code, …etc.) 

## Encapsulate What Changes
* encapsulate the code you expect or suspect to be changed in future.
* It's easy to test and maintain proper encapsulated code.
* Making variable and methods private by default and increase access step by step e.g. from private to protected and not public.
* Example - Factory design pattern encapsulates object creation code and provides flexibility to introduce a new product later with no impact on existing code.

## Favor Composition over Inheritance

* Always favor composition over inheritance, if possible. Some of you may argue this, but I found that 
* Composition is a lot more flexible than Inheritance.
* Composition allows changing the behavior of a class at run-time by setting property during run-time and by using Interfaces to compose a class.
  * We use polymorphism which provides flexibility to replace with better implementation any time.

![composition-vs-inheritance]({{site.cdn}}/java/oop-and-ood/composition-vs-inheritance.png)

## Programming for Interface not implementation

* Always ***program for the interface and not for implementation*** this will lead to flexible code which can work with any new implementation of the interface.
* So use interface type on variables, return types of method or argument type of methods in Java.

![intercepting-filter-pattern]({{site.cdn}}/java/oop-and-ood/intercepting-filter-pattern.png)
![intercepting-filter-pattern-class-diagram]({{site.cdn}}/java/oop-and-ood/intercepting-filter-pattern-class-diagram.png)

# General Responsibility Assignment Software Patterns (GRASP)

- GRASP tends to take a responsibility focus, like who creates this object, who is in charge of how these objects talk to each other, who takes care of passing all messages received from a user interface?  etc.
- Now SOLID and GRASP don’t conflict with each other, they are not competing sets, you might choose to use one or both or neither.

|GRASP                  |   |
|---                    |---|
|Information Expert     |Problem    |What is a basic principle by which to assign responsibilities to objects?|
|                       |Solution   |Assign responsibility to the class that has the information needed to fulfill it.|
|                       |Example    |Cutomer and Order class, Order should get list of all the orders placed by the customer|
|Creator                |Problem    |Who creates object A?|
|                       |Solution   |class B, if it has the initializing information (4 questions)|
|                       |Example    |Factory Design Pattern|
|Controller             |Problem    |Who should be responsible for handling an input system event?|
|                       |Solution   |use case controller to deal with all system events of a use case. Create/Delete User can have  UserController, instead of two separate use case controllers.|
|                       |Example    |Model View Controller (MVC)|
|Indirection            |Problem    |Where to assign responsibility, to avoid direct coupling between two (or more) things? How to de-couple objects so that low coupling is supported and reuse potential remains higher?|
|                       |Solution   |Assign the responsibility to an intermediate object to mediate between other components or services so that they are not directly coupled.|
|                       |Example    |Introduction of a controller component for mediation between data (model) and its representation (view) in the model-view control pattern. This ensures that coupling between them remains low.|
|Low Coupling           |           |lower dependency between the classes, change in one class having a lower impact on other classes.|
|High Cohesion          |           |Have a class that has relevant and focused responsibilities|
|Polymorphism           |Problem    |How to handle alternatives based on type? How to create pluggable software components?|
|                       |Solution   |When related alternatives or behaviors vary by type (class), assign responsibility for the behavior—using polymorphic operations—to the types for which the behavior varies.|
|Protected Variations   |Problem    |How to design objects, subsystems, and systems so that the variations or instability in these elements does not have an undesirable impact on other elements?|
|                       |Solution   |Identify points of predicted variation or instability; assign responsibilities to create a stable interface around them.|
|Pure Fabrication       |           |A class that does not represent a concept in the problem domain, specially made up to achieve low coupling, high cohesion|

***Creator***
* You try to answer these 4 question:
    - Who is responsible for creating the objects?, or, how those objects are created in the first place?
    - Does one object contain another (composition relationship)?
    - Does one object very closely use another, 
    - Will one object know enough to make another object?

***Low Coupling***  
- Coupling is a measure of how strongly one element is connected to, has knowledge of, or relies on other elements.
- lower dependency between the classes,
- change in one class having a lower impact on other classes,
- higher reuse potential.
* Now low coupling does not mean no coupling. Objects do need to know about each other, but as much as possible they should do what they can with the minimum of dependencies.

***High Cohesion***
* The more you have a class that has relevant and focused responsibilities, the higher cohesion you will have.
* You try to make the responsibilities of your classes relevant, related as much as you can.
* You may need to break a class into some classes and distribute the responsibilities, instead of having a single class that does everything.

***Polymorphism***
* Having an object that can take the shape of several different objects. This allows us to trigger the correct behavior.
* If, for example, we have an interface that’s implemented by several classes, you can assign or pass an instance of any of the sub classes to a reference variable that has the interface as it’s type. This will allow you to trigger the right methods, for the implementing class.

***Protected Variations***
* How to design a system so that changes and variations have the minimum impact on what already exists.
* Identify the parts of the system that are more likely to change, separate them from what stays the same, and then, encapsulate every part that vary in the system.
* Most of the concepts we have been exploring are simply way of doing this, things like encapsulation and data-hiding, making your attributes private.
* Interfaces are another area where we can wrap the unstable parts with an interface, and using polymorphism to create various implementations of this interface.
* The Liskov substitution principle, where the child classes should always work when treated as their parent classes is another way.
* The open/closed principle that we can add, but we try not to change code that works already is yet another.

***Pure Fabrication***
* What if there’s something that needs to exist in the application that doesn’t announce itself as an obvious class or real-world object?. What if you have behavior that doesn’t naturally fit in existing classes?
* Well, rather than force that behavior into an existing class where it doesn’t belong, which means we are decreasing cohesion, we instead invent, we fabricate a new class.
* That class might not have existed in our conceptual model, but it needs to exist now. And there’s nothing wrong with creating a class that represents pure functionality as long as you know why you’re doing it.
* A pure fabrication is a class that does not represent a concept in the problem domain, specially made up to achieve low coupling, high cohesion, and the reuse potential thereof derived (when a solution presented by the information expert pattern does not). This kind of class is called a "service" in domain-driven design.

# Code Smell
*  Code Smells are a great term for when reading code, the code may be valid, it may work, but there is something about it that just doesn’t smell right.
*  It’s often a clue, a warning sign of a deeper problem, that there is a part in the code indicates violation of fundamental design principles and negatively impact design quality.
* And here are just a few examples of what we mean by a code smell.
    - **Long Method** - One would be the idea of a long method. We open up a method to read it, it has got many lines. This is the kind of thing that really needs to be split up into much smaller methods.
	- **Identifiers** - Working with very short or very long identifiers. Aside from using letters like ‘i’ for indexes and iteration, we shouldn’t be expecting to see variables called A and B and C in real code.
	- **Comments** - Another clue would be pointless comments. Yes, code should be commented and code should be well-written so that it’s readable and the code comments itself. We do want comments, but we don’t want comments where the comment is actually longer than the code that it’s describing.
	- **The God Object** - This is where you have one master object that tries to do everything in the program, or at least one object that seems to be doing very different responsibilities that have nothing to do with each other.It’s a clue that this needs to be revisited and broken apart into the right kind of objects.
	- **Feature Envy** - And then there’s feature envy. If a class seems to do very little except it uses all the methods of one other class, it’s another sign that you need to rethink the roles of one or the other.

# SOLID Principles

![]({{site.cdn}}/java/oop-and-ood/solid.png)

- **Single Responsibility Principle**
  - A class should always have only one reasonability.
- **Open Closed Principle**
  - Software components should be open for extension, but closed for modification.
  - Goal - Adding new functionality only than your code should be tested.
- **Liskov Substitution Principle**
  - Derived types must be completely substitutable for their base types.
  - Derived class or subclass must enhance functionality, but not reduce them.
  - Example - Square is a Rectangle.
- **Interface Segregation Principle**
  - Clients should not be forced to implement unnecessary methods which they will not use.
- **Dependency Injection or Inversion**
  - Depends on Abstraction, not on concretion.
  - Don't ask for dependency it will be provided to you by the framework. (Spring framework)
  - Makes it easy to test with mock objects as object creation code is centralized  in the framework.

