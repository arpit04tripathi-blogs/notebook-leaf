---
layout: page
title: Spring AOP
permalink: /spring/aop
---

- TOC
{:toc}

---

# What is AOP

- **Aspect-oriented programming (AOP)** separates cross-cutting concerns from the business logic.
  - DI helps you decouple application objects from each other.
  - AOP helps you decouple cross-cutting concerns from the objects they affect.
- **cross-cutting concern**
  - functionality that affects multiple points of an application.
  - Security - many methods in an application can have security rules applied to them.
  -	Logging, security, and transaction management are such aspects.
-	Application objects should focus on the business domain problems.
- ***Aspect***
  - Core of AOP, encapsulates behaviors that can affect multiple classes into reusable modules.
  - Aspects offer an alternative to inheritance and delegation that can be cleaner in many circumstances.

![]({{site.cdn}}/spring/spring-aop/aop.png)

## Benefits
- Centralized logic for each concern
  - declaratively define how and where this functionality is applied without modifying the class.
-	your service modules are cleaner because they only contain code for core functionality.

## Concern vs Cross-cutting Concerns

![]({{site.cdn}}/spring/spring-aop/cross-cutting-vs-concern.png)

![]({{site.cdn}}/spring/spring-aop/aspects.png)

## Key Terms

- **Aspects**
  - Merger of advice and pointcuts.
  - `what + when` + `where`
  - Aspects have a purpose - a job they’re meant to do.
- **Advice** - defines ***what and when*** of an aspect.
- **Join Points**
  - All the ***points*** within the execution flow of the application ***that are candidates to have advice applied.***
  - This point could be
    - a method being called
    - an exception being thrown
    - a field being modified.
- **Pointcuts**
  - define the ***where*** of an aspect.
  - ***Pointcuts define which join points get advised.***
- **Introductions** - allows you to add new methods or attributes to existing classes.
- **Weaving**
  - process of applying aspects to a target object to create a new proxied object.
  - The aspects are woven into the target object at the specified join points.

## Declarative programming through aspects

- With AOP, you can then cover your core application with layers of functionality.
- These layers are applied declaratively without your core application even knowing they exist.
- It keeps the security, transaction, and logging concerns from littering the application’s core business logic.

![]({{site.cdn}}/spring/spring-aop/cross-cutting-concerns.png)

# Spring AOP features

- Spring ***advises objects at runtime***.
- aspects are woven into Spring-managed beans at runtime ***by wrapping them with a proxy class***.
- proxy class poses as the target bean, intercepting advised method calls and forwarding those calls to the target bean. 
  - `intercept method call --> performs the aspect logic --> invokes target bean’s method`
- ***Lazy Loading*** - Spring doesn’t create a proxied object until that proxied bean is needed by the application.
- For ApplicationContext, proxied objects created when it loads all the beans from the BeanFactory.
- As Spring creates proxies at runtime, ***you don’t need a special compiler to weave aspects in Spring’s AOP***.

**Spring only supports method join points**
- Only method pointcuts.
- No field pointcuts, can't apply advice when field is updated.
- No constructor pointcuts, can't apply advice when a bean is instantiated. 
- If you need field or constructor pointcuts, use AspectJ with Spring AOP.

**What do you mean by Proxy in Spring Framework?**  
- **Proxy** - object created after applying advice to a target object.
- In case of client objects the target object and the proxy object are the same.

**In Spring, what is Weaving?** 
- The process of creating advised object (proxy) by applying advice is called **Weaving**.
- In Spring AOP, ***weaving is performed at runtime***.

![]({{site.cdn}}/spring/spring-aop/aop-proxy.png)

## Types of Weaving

The **weaving** can take place at several points in the target object’s lifetime:

|Weaving Types||
|---|---|
|**Compile time** | Aspects are woven in when the target class is compiled. <br>This requires a special compiler. <br>AspectJ’s weaving compiler weaves aspects this way.|
|**Class load time** | Aspects are woven in when the target class is loaded into the JVM. <br>This requires a special ClassLoader that enhances the target class’s bytecode before the class is introduced into the application. <br>AspectJ 5’s load-time weaving (LTW) support weaves aspects this way.|
|**Runtime** | Aspects are woven in sometime during the execution of the application. <br>Typically, an AOP container dynamically generates a proxy object that delegates to the target object while weaving in the aspects. <br>This is how Spring AOP aspects are woven. <br>Slowest of all.|

![]({{site.cdn}}/spring/spring-aop/aop-implementation.png)

# Creating annotated aspects

## Writing pointcuts

![]({{site.cdn}}/spring/spring-aop/joinPoint.png)

```java
package concert;
public interface Performance {
    public void perform();
}
```
- within() - confine pointcut to only specific packager.

```java
execution(* concert.Performance.perform()) and bean('woodstock')
execution(* concert.Performance.perform()) and !bean('woodstock')
```
```
"||" or "or" - OR relationship
"!" or "not" – negate
```

### AspectJ pointcut expression language

- Pointcuts are used to pinpoint where an aspect’s advice should be applied.
  - In Spring AOP, pointcuts are defined using AspectJ’s pointcut expression language.
- Attempting to use any of AspectJ’s other designators cause IllegalArgumentException.
- execution is the primary designator you’ll use in every pointcut definition you write.
  - You’ll use the other designators to constrain the pointcut’s reach.

|AspectJ Designator|	Description|
|---|---|
|**execution()**|	Matches join points that are method executions|
|args()|	Limits join-point matches to the execution of methods whose arguments are instances of the given types|
|@args()|	Limits join-point matches to the execution of methods whose arguments are annotated with the given annotation types|
|this()|	Limits join-point matches to those where the bean reference of the AOP proxy is of a given type|
|target()|	Limits join-point matches to those where the target object is of a given type|
|@target()|	Limits matching to join points where the class of the executing object has an annotation of the given type|
|within()|	Limits matching to join points within certain types|
|@within()|	Limits matching to join points within types that have the given annotation|
|@annotation |	Limits join-point matches to those where the subject of the join point has the given annotation|

### Types of Advices

|Type|Annotation||
|---|---|---|
|Before         |@Before        |Advice functionality takes place before the advised method is invoked.|
|After-returning|@AfterReturning|Advice functionality takes place after the advised method successfully completes.|
|After-throwing |@AfterThrowing |Advice functionality takes place after the advised method throws an exception.|
|After          |@After         |Advice functionality takes place after advised method completes, regardless of outcome.|
|Around         |@Around	    |Advice wraps the advised method, providing some functionality before and after the method is invoked.|

## Defining an aspect

```java
@Configuration
@EnableAspectJAutoProxy
@ComponentScan
public class ConcertConfig {
 @Bean
 public Audience audience() { return new Audience(); }
}
```

- We use AspectJ annotations, but it is still Spring’s proxy-based aspects.
  - we are still limited to proxying method invocations.
- **@Aspect** - Defines Aspect class. 
-	**@Pointcut** - reusable pointcut within an @Aspect aspect.
- **@AfterThrowing**
  - We are only reading the exception, exception will propogate as usual.
  - If you want to stop the exception propogation, use **@Around** advice.
- **@After**
  - works as finally method, will run on completion of advised method.
  - @After doesn't have access to exception thrown, u will need to use @AfterThrowing in that case.
  - @After will run after the @AfterThrowing or @AfterReturning.
- **@Around**
  - can be used to measure execution time.
  - wraps the advised method - (before + after) advice in a single advice method.
  - **ProceedingJoinPoint**
    - mandatory parameter
    - to invoke the advised method from within your advice.
    - to pass control to the advised method, call ProceedingJoinPoint’s proceed().
    - Use Cases
      - You can omit a proceed() method to block access to the advised method
      - You can invoke it multiple times, say, to implement retry logic.

```java
package concert;

import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

@Aspect
public class Audience {

    @Pointcut("execution(** concert.Performance.perform(..))")
    public void performance() {}

    @Pointcut("execution(** concert.Performance.get*(..))")
    public void getter() {}

    @Pointcut("execution(** concert.Performance.set*(..))")
    public void setter() {}
    // combining pointcuts Using AspectJ Expression
    @Pointcut("performance() && !(getter() || setter())")
    public void performanceNoGetterSetter() {}

    @Before("performance()") // using pointcut rather than expression
    @Before("execution(** concert.Performance.perform(..))") // using aspectj expression
    public void silenceCellPhones() {
        System.out.println("Silencing cell phones");
    }

    @Before("performance()")
    public void takeSeats(JoinPoint joinPoint) {
        System.out.println("Taking seats");
        MethodSignature mSign = (MethodSignature) joinPoint.getSignature(); // get method signature
        System.out.println("Method : " + mSign);
        Object[] args = joinPoint.getArgs(); // get method arguments
        for (Object arg: args)
            System.out.println(arg);
    }

    @AfterReturning(pointcut = "performance()", returning = "response")
    public void applause(JoinPoint joinPoint, List < Account > response) {
        // AfterReturning with response object
        System.out.println("CLAP CLAP CLAP!!!");
    }

    @AfterThrowing(pointcut = "performance()", throwing = "exception")
    public void demandRefund(JoinPoint joinPoint, Throwable exception) {
        System.out.println("Demanding a refund");
    }

    @After("performance()")
    public void takeSeats(JoinPoint joinPoint) {
        System.out.println("Perforamnce is complete.");
    }

    @Around("performance()")
    public void watchPerformance(ProceedingJoinPoint jp) {
        try {
            System.out.println("Silencing cell phones");
            System.out.println("Taking seats");
            jp.proceed();
            System.out.println("CLAP CLAP CLAP!!!");
        } catch (Throwable e) {
            System.out.println("Demanding a refund");
        }
    }
}
```
```java
private Map < Integer, Integer > trackCounts = new HashMap < Integer, Integer > ();

@Pointcut("execution(* soundsystem.CompactDisc.playTrack(int)) && args(trackNumber)")
public void trackPlayed(int trackNumber) {}

@Before("trackPlayed(trackNumber)")
public void countTrack(int trackNumber) {
    trackCounts.put(trackNumber, getPlayCount(trackNumber) + 1);
}

public int getPlayCount(int trackNumber) {
    return trackCounts.containsKey(trackNumber) ? trackCounts.get(trackNumber) : 0;
}
```

### Parameters in advice

![]({{site.cdn}}/spring/spring-aop/advice-with-parameters.png)

- The args(trackNumber)
  - indicates that any int argument passed to playTrack() should also be passed into the advice.
  - parameter name (trackNumber), same in pointcut method signature and actual method sugnature.

### Ordering Aspects

- If multiple Aspect apply on same pointcut, order is undefined by default.
  - refactor aspects in multiple Aspect classes and use `@Order` annotation.
- Order can also be a negative integer.
- Aspects with same order have undefined order among them.

# AOP Introduction

- **Introduction** - aspects can attach new methods to Spring beans.
- Aspects are proxies that implement the same interfaces as the beans they wrap.
- Proxy can also be exposed through some new interface.
  - advised bean will appear to implement the new interface, even if its underlying implementation class doesn’t.
- When a method on the introduced interface is called,
  - proxy delegates the call to some other object that provides the implementation of the new interface.
  - Effectively, this gives you one bean whose implementation is split across multiple classes.

![]({{site.cdn}}/spring/spring-aop/aop-introduction.png)

```java
package concert;
public interface Encoreable {
 void performEncore();
}
```
```java
package concert;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.DeclareParents;

@Aspect
public class EncoreableIntroducer {
  @DeclareParents(value="concert.Performance+", defaultImpl=DefaultEncoreable.class)
  public static Encoreable encoreable;
}
```
- Here, EncoreableIntroducer aspect doesn’t provide before, after, or around advice.
- **@DeclareParents** annotation is made up of three parts:
  - **value**
    - types of beans t be introduced with interface.
    - Here, anything that implements the Performance interface.
      - `+` sign at the end specifies any subtype of Performance, as opposed to Performance itself.
  -	**defaultImpl** - class providing default implementation.
  - **static property**
    - annotated by @DeclareParents
    - specifies interface to be introduced.
    - Here, Encoreable interface.

```xml
<bean class=”concert.EncoreableIntroducer” />
```

- When Spring discovers a bean annotated with @Aspect, it will automatically create a proxy.
- proxy delegates calls to either the target bean or interface implementation
  - depending on whether the method called belongs to the proxied bean or to the introduced interface.

# Eliminating boilerplate code with aspects

- **Boilerplate code** - code write over and over again to accomplish common and otherwise simple tasks.
- JDBC, JMS, JNDI, consumption of REST services.
- Spring eliminate boilerplate code by encapsulating it in templates.

**JDBC Template**
```java
public Employee getEmployeeById(long id) {
    String query = "select id, firstname, lastname, salary " + "from employee where id=?";
    RowMapper<Employee> rowMapper = new RowMapper<Employee>() {
        public Employee mapRow(ResultSet rs, int rowNum) throws SQLException {
            Employee employee = new Employee();
            employee.setId(rs.getLong("id"));
            employee.setFirstName(rs.getString("firstname"));
            employee.setLastName(rs.getString("lastname"));
            employee.setSalary(rs.getBigDecimal("salary"));
            return employee;
        }
    }
    return jdbcTemplate.queryForObject(query, RowMapper, id);
}
```

The template’s queryForObject() method is given the SQL query, a RowMapper (for mapping result set data to a domain object), and zero or more query parameters. What you don’t see in getEmployeeById() is any of the JDBC boilerplate from before. Everything is handled inside the template.

But how do those files get loaded? And what are they loaded into? Let’s look at the Spring container, the place where your application’s beans reside.

```java
@AfterReturning(pointcut="args(name)", returning="returningString")
public void returnStringforStringArgsMethod(String name, String returningString){...}

@AfterThrowing(pointcut="args(name)", throwing="ex")
public void returnStringforStringArgsMethod(String name, Exception ex){...}
```

**Normal JDBC Code**
```java
public Employee getEmployeeById(long id) {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    try {
        conn = dataSource.getConnection();
        stmt = conn.prepareStatement("select id,firstname,
            lastname, salary from "+"
            employee where id = ? ");
            stmt.setLong(1, id);
            rs = stmt.executeQuery();
            Employee emp = null;
            if(rs.next()) {
                emp = new Employee();
                emp.setId(rs.getLong("id"));
                emp.setFirstName(rs.getString("firstname"));
                emp.setLastName(rs.getString("lastname"));
                emp.setSalary(rs.getBigDecimal("salary"));
            }
            return employee;
        }
        catch (SQLException e) {
            Sysout(e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {}
            }
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {}
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {}
            }
        }
        return null;
    }
}
```

# Declaring aspects in XML

If need to declare aspects without annotating the advice class, then use XML configuration, ie. For 3rd party libraries.

|AOP configuration element|	Purpose|
|---|---|
|\<aop:advisor>|	Defines an AOP advisor.|
|\<aop:after>|	Defines an AOP after advice (regardless of whether the advised method returns successfully).|
|\<aop:after-returning>|	Defines an AOP after-returning advice.|
|\<aop:after-throwing>|	Defines an AOP after-throwing advice.|
|\<aop:around>|	Defines an AOP around advice.|
|\<aop:aspect>|	Defines an aspect.|
|\<aop:aspectj-autoproxy>|	Enables annotation-driven aspects using @AspectJ.|
|\<aop:before>|	Defines an AOP before advice.|
|\<aop:config>|	The top-level AOP element. Most \<aop:*> elements must be contained within \<aop:config>.|
|\<aop:declare-parents>|	Introduces additional interfaces to advised objects that are transparently implemented.|
|\<aop:pointcut>|	Defines a Pointcut|

```java
public class Audience {
  public void silenceCellPhones() {System.out.println("Silencing cell phones");}
  public void takeSeats() { System.out.println("Taking seats");}
  public void applause() {System.out.println("CLAP CLAP CLAP!!!");}
  public void demandRefund() {System.out.println("Demanding a refund");}
}
```
```xml
<aop:config>
 <aop:aspect ref="audience">
  <aop:before pointcut="execution(** concert.Performance.perform(..))"
      method="silenceCellPhones"/>
   ….
 </aop:aspect>
</aop:config>
```

![]({{site.cdn}}/spring/spring-aop/advice-example-xml.png)

```java
public class Audience {
    public void watchPerformance(ProceedingJoinPoint jp) {
        try {
            System.out.println("Silencing phones");
            System.out.println("Taking seats");
            jp.proceed();
            System.out.println("CLAP CLAP CLAP!!!");
        } catch (Throwable e) {
            System.out.println("Demanding a refund");
        }
    }
}
```
```xml
<aop:config>
 <aop:aspect ref="audience">
 <aop:pointcut id="performance"  
     expression="execution(** concert.Performance.perform(..))" />
 <aop:around pointcut-ref="performance"
            method="watchPerformance"/>
 </aop:aspect>
</aop:config>
```
In xml, use and keyword instead of && (because ampersands are interpreted as the beginning of an entity in XML).
```xml
<aop:aspect>
   <aop:declare-parents types-matching="concert.Performance+"  
   implement-interface="concert.Encoreable" 
   default-impl="concert.DefaultEncoreable"/>
</aop:aspect>
```
```xml
<aop:aspect>
    <aop:declare-parents types-matching="concert.Performance+"
     implement-interface="concert.Encoreable"
     delegate-ref="encoreableDelegate"/>
</aop:aspect>
```

The delegate-ref attribute refers to a Spring bean as the introduction delegate. This assumes that a bean with an ID of encoreableDelegate exists in the Spring context:
```xml
<bean id="encoreableDelegate" class="concert.DefaultEncoreable" />
```
The difference between directly identifying the delegate using default-impl and indirectly using delegate-ref is that the latter will be a Spring bean that itself may be injected, advised, or otherwise configured through Spring.
