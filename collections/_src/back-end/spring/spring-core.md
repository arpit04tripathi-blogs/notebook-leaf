---
layout: page
title: Spring Core
permalink: /spring/core
---

- TOC
{:toc}

---

# Introduction to Spring

- Framework to write Enterprise java applications.
- Open source lightweight framework. 
- Provides support to various frameworks - Hibernate, Struts, Tapestry, EJB, JSF etc.
- makes it possible to use plain-vanilla JavaBeans to achieve things that were previously only possible with EJB.
- Key Points: Simplicity, testability, and loose coupling.

## Advantages of Spring Framework

- Predefined Templates
    - Provides templates for JDBC, Hibernate, JPA etc. and hides the basic steps of these technologies.
    - JdbcTemplate
      - No need to write the code for exception handling, creating connection, creating statement, committing transaction, closing connection etc.
      - You need to write the code of executing query only. 
    - Eliminating boilerplate code with aspects and templates.
- Loose Coupling/ Inversion of control (IOC): 
    - The objects give their dependencies instead of creating or looking for dependent objects.
- Easy to test
  - Easy to test due to loose coupling
- Lightweight
    - lightweight because of its POJO implementation. 
    - Spring Framework doesn't force to inherit any class or implement any interface. That is why it is said non-invasive.
- Declarative support
    - through aspects and common conventions
    - provides support for caching, validation, transactions and formatting.
- Transaction Management
    - Generic abstraction layer for transaction management is provided by the Spring Framework. 
    - Spring’s transaction support can be also used in container less environments.
- JDBC Exception Handling: 
    - The JDBC abstraction layer of the Spring offers an exception hierarchy, which simplifies the error handling strategy.

![]({{site.cdn}}/spring/spring-core/spring-core-example.png)

# Spring Framework Architecture

As of Spring 4.0, there are 20 distinct modules in the Spring Framework distribution, with three JAR files for each module (the binary class library, the source JAR file, and a JavaDoc JAR file).

![]({{site.cdn}}/spring/spring-core/spring-framework-architecture.png)

|Core Container||
|---|---|
|Core |	provides the fundamental parts of the framework, including the IoC and DI features.|
|Bean |	provides BeanFactory, which is a sophisticated implementation of the factory pattern.|
|Context |	builds on the solid base provided by the Core and Beans modules and it is a medium to access any objects defined and configured. The ApplicationContext interface is the focal point of the Context module.|
|SpEL |	provides a powerful expression language for querying and manipulating an object graph at runtime.|

In addition to the bean factory and application context, this module also supplies many enterprise services such as email, JNDI access, EJB integration, and scheduling.

|Data Access/Integration||
|---|---|
|JDBC |	Provides a JDBC-abstraction layer that removes the need for tedious JDBC related coding.|
|ORM |	Provides integration layers for popular object-relational mapping APIs, including JPA, JDO, Hibernate, and iBatis.|
|OXM |	Provides an abstraction layer that supports Object/XML mapping implementations for JAXB, Castor, XMLBeans, JiBX and XStream.|
|JMS |	Contains features for producing and consuming messages.|
|Transaction |	Supports programmatic and declarative transaction management for classes that implement special interfaces and for all your POJOs.|
	
|Web||
|---|---|
|Web|	Provides basic web-oriented integration features such as multipart file-upload functionality and the initialization of the IoC container using servlet listeners and a web-oriented application context.|
|Web-MVC |	Contains Spring's Model-View-Controller (MVC) implementation for web applications.|
|Web-Socket |	Provides support for WebSocket-based, two-way communication between the client and the server in web applications.|
|Web-Portlet |	Provides the MVC implementation to be used in a portlet environment and mirrors the functionality of Web-Servlet module.|

|Miscellaneous||
|---|---|
|AOP |	Provides an aspect-oriented programming implementation allowing you to define method-interceptors and pointcuts to cleanly decouple code that implements functionality that should be separated.|
|Aspects| 	Provides integration with AspectJ, which is again a powerful and mature AOP framework.|
|Instrumentation |	Provides class instrumentation support and class loader implementations to be used in certain application servers.|
|Messaging |	Provides support for STOMP as the WebSocket sub-protocol to use in applications. It also supports an annotation programming model for routing and processing STOMP messages from WebSocket clients.|
|Test |	Supports the testing of Spring components with JUnit or TestNG frameworks.|

# POJO vs Java Beans vs EJB

## POJO (Plain Old Java Object) 
- Ordinary Java Object, not a special object.
- POJO should not have to
  - Extend prespecified classes, as in public class Foo extends javax.servlet.http.HttpServlet { ...
  - Implement prespecified interfaces, as in public class Bar implements javax.ejb.EntityBean { ...
  - Contain prespecified annotations, as in @javax.ejb.Entity public class Baz{ ...

## JavaBean
-	reusable software components that can be injected by IOC container.
-	They are used to encapsulate many objects into a single object (the bean), so that they can be passed around as a single bean object instead of as multiple individual objects. 
-	must obey certain conventions
    -	public default no-argument constructor.
    -	accessor methods and mutator methods, following a standard naming convention.
    -	class should be serializable.

## EJB (Enterprise JavaBean)
-	They are some objects whose life cycle is managed by a container (the EJB container), so you don’t “new Xxxx()” them - instead you “request” for an instance and who offer certain out of the box functionalities, like security, transactionality, persistence (although in newer versions of EJB the persistence part became a separate standard - JPA), thread-safety, remote-calling, etc.
-	They only reside in application servers that handle EJBs (Tomcat doesn't hold EJBs). There are 3 types of EJBs:
  -	**Session**: Usually contain some business logic.
  -	**Entity**: Usually interface with a data store, such as a database.
  -	**Message-Driven**: Receives messages from JMS.

# IOC Container

In a Spring-based application, your application objects live in the Spring container.  
Spring container uses DI to manage components that make up an application. These objects support reuse and are easy to unit test.

**Responsibilities of the Spring Container**
- Creates the objects (Spring Beans)
- Wires them together (associations)
- Configures them, and 
- Manages their complete lifecycle

![]({{site.cdn}}/spring/spring-core/spring-container.png)

- Container gets its instructions on what objects to instantiate, configure, and assemble by reading the configuration metadata provided. 
- Configuration metadata - XML, Java annotations, or Java code. 
- The Spring IoC container makes use of Java POJO classes and configuration metadata to produce a fully configured and executable system or application.

## IOC Container Types

1. Bean factories (org.springframework.beans.factory.BeanFactory)
    - Simplest of containers, providing basic support for DI. 
2. Application contexts  (o.s.context.ApplicationContext) 
    - Build on the top of a bean factory.
    - Extra functionality
      - simple integration with Spring's AOP, application-framework services, such as the ability to resolve text messages from a properties file (for I18N) 
      - ability to publish application events to interested event listeners and application layer specific context (e.g. WebApplicationContext) for web application. 

|BeanFactory|ApplicationContext|
|---|---|
|It is an interface defined in org.springframework.beans.factory.BeanFactory	|It is an interface defined in org.springframework.context.ApplicationContext|
|It uses Lazy initialization	|It uses Eager/ Aggressive initialization|
|It explicitly provides a resource object using the syntax	|It creates and manages resource objects on its own|
|It doesn’t supports internationalization	|It supports internationalization |
|It doesn’t supports annotation based dependency | It supports annotation based dependency|

```java
// IOC Containers
/* Bean Factory */
Resource resource=new ClassPathResource("applicationContext.xml");
BeanFactory factory=new XmlBeanFactory(resource);

/* ApplicationContext */
ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
ApplicationContext context = new FileSystemXmlApplicationContext("c:/knight.xml");
ApplicationContext context = new AnnotationConfigApplicationContext(com.KnightConfig.class);
```
```java
// Context methods
context.getBean(Knight.class);              // Type Safe
context.getBean(Knight.class, "knight");
context.getBeansOfType(Knight.class)        // No Type Safety, Map is not parameterized
(Knight) context.getBean("knight");
```

### Application Context

**Why Prefer ApplicationContext over BeanFactory?**  
- Application contexts are preferred over bean factories.
- BeanFactory can still be used for lightweight applications like mobile devices or applet-based applications where data volume and speed is significant.

```java
Interface ApplicationContext 
extends ListableBeanFactory, HierarchicalBeanFactory, MessageSource, ApplicationEventPublisher, ResourcePatternResolver.
```

An ApplicationContext provides:
-	Bean factory methods for accessing application components, inherited from ListableBeanFactory.
-	The ability to resolve messages (internationalization), Inherited from the MessageSource  interface.
-	The ability to publish events to registered listeners. Inherited from the ApplicationEventPublisher interface.
-	The ability to load file resources in a generic fashion. Inherited from the ResourceLoader interface.
-	Inheritance from a parent context.
    -	Definitions in a descendant context will always take priority.
    -	A single parent context can be used by an entire web application, while each servlet has its own child context that is independent of that of any other servlet.

Apart from standard BeanFactory lifecycle capabilities, ApplicationContext implementations detect and invoke ApplicationContextAware beans as well as ResourceLoaderAware, ApplicationEventPublisherAware and MessageSourceAware beans.

#### Application Context Types

|ApplicationContext Types||
|---|---|
|AnnotationConfigApplicationContext|	Loads Spring application context from one or more Java-based configuration classes rather than xml.|
|ClassPathXmlApplicationContext|	Loads a context definition from one or more XML files located in the classpath (including JAR files), treating context-definition files as classpath resources.|
|FileSystemXmlApplicationContext|	Loads a context definition from one or more XML files in the filesystem (specific location).|
|AnnotationConfigWebApplicationContext|	Loads a Spring web application context from one or more Java-based configuration classes.|
|XmlWebApplicationContext (Default)|	Loads context definitions from one or more XML files contained in a web application. |

- In a Spring application, an **application context** loads bean definitions and wires them together.
- Spring application context is fully responsible for the creation of and wiring of the objects that make up the application.
- With an application context in hand, you can retrieve beans from the Spring container by calling the context’s getBean() method.

`BeanFactory 	<--   ApplicationContext	<--   WebApplicationContext`

- ***ApplicationContext***
  - **AnnotationConfigApplicationContext** – For Java-based configurations, Spring offers.
  - **ClassPathXmlApplicationContext**
    - This Spring context implementation loads the Spring context from one or more XML files located in the application’s classpath.
    - Used when the beans are declared in xml.
  - **FileSystemXmlApplicationContext**
- ***WebApplicationContext***
  - AnnotationConfigWebApplicationContext
  - XmlWebApplicationContext (Default)

```java
org.springframework.context.support.ClassPathXmlApplicationContext;
public class KnightMain {
    public static void main(String[] args) throws Exception {
        ClassPathXmlApplicationContext ctx =
            new ClassPathXmlApplicationContext("META-INF/spring/knight.xml");
        Knight knight = ctx.getBean(Knight.class);
        knight.embarkOnQuest();
        ctx.close();
    }
}
```

**If i instantiate two ApplicationContext in one java application (both in main body), are these two interfaces to one central container?**  
```java
ApplicationContext context1 = new ClassPathXmlApplicationContext("Beans.xml");
ApplicationContext context2 = new ClassPathXmlApplicationContext("Beans.xml");
```
you can have multiple instances of ApplicationContexts, in that case, they will be completely isolated, each with its own configuration.

# Spring Beans

## Lifecycle of Bean

![]({{site.cdn}}/spring/spring-core/bean-lifecycle.png)

-	Spring ***instantiates*** the bean.
-	Spring injects values and bean references into the ***bean’s properties***.
-	BeanNameAware, Spring passes the bean’s ID to the ***setBeanName()*** method.
-	BeanFactoryAware, Spring calls the ***setBeanFactory()***, passing in the bean factory itself.
-	ApplicationContextAware, Spring calls the ***setApplicationContext()***, passing in a reference to the enclosing application context.
-	*BeanPostProcessor*, Spring calls its ***postProcessBeforeInitialization()*** method.
-	InitializingBean, Spring calls its ***afterPropertiesSet()*** method. 
-	***init()*** method of bean, specified initialization method is called.
-	*BeanPostProcessor*, Spring calls ***postProcessAfterInitialization()***.
-	At this point, the bean is ***ready to be used*** by the application and remains in the application context until the application context is destroyed.
-	DisposableBean, Spring calls ***destroy()***.
-	If the bean was declared with a ***custom destroy-method***, the specified method is called.

But an empty container isn’t much good by itself; it doesn’t contain anything unless you put something in it.  
To achieve the benefits of Spring DI, you must wire your application objects into the Spring container.
```xml
<beans>
   <bean id = "beanTeamplate" abstract = "true">
      <property name = "message1" value = "Hello World!"/>
      <property name = "message2" value = "Hello Second World!"/>
   </bean>
   <bean id = "helloIndia" class = "com.tutorialspoint.HelloIndia" parent = "beanTeamplate">
      <property name = "message1" value = "Hello India!"/>
   </bean>   
</beans>
```

***lifecycle of a prototype bean***
- In contrast to the other scopes, Spring does not manage the complete lifecycle of a prototype bean.
- The container instantiates, configures, and otherwise assembles a prototype object, and hands it to the client, with no further record of that prototype instance.
- Thus, although initialization lifecycle callback methods are called on all objects regardless of scope, in the case of prototypes, configured destruction lifecycle callbacks are not called.
  - The client code must clean up prototype-scoped objects and release expensive resources that the prototype bean(s) are holding.
- Solution - implement the DisposableBean interface and provides the destroy() method.
  - `@PostConstruct` and `@PreDestroy`

## Bean Definition Metadata

Bean definition contains the information called configuration metadata, which is needed for the container to know the following −
- How to create a bean
- Bean's lifecycle details
- Bean's dependencies

```java
@Bean("accountService")
@Scope(value = ConfigurableBeanFactory.SCOPE_PROTOTYPE)
@Scope(value=WebApplicationContext.SCOPE_SESSION, proxyMode=ScopedProxyMode.INTERFACES)
```

|||
|---|---|
|class|	Mandatory attribute to specify the bean class used to create the bean.|
|name|	Specifies bean identifier uniquely. In XMLbased configuration metadata, you use the id and/or name attributes to specify the bean identifier(s).|
|scope|	Specifies the scope of the objects created from a particular bean definition.|
|constructor-arg|	This is used to inject the dependencies.|
|properties|	This is used to inject the dependencies.|
|autowiring mode|	This is used to inject the dependencies.|
|lazy-initialization mode |	A lazy-initialized bean tells the IoC container to create a bean instance when it is first requested, rather than at the startup.|
|initialization method|	A callback just after all necessary properties of bean have been set by container.|
|destruction method|	A callback to be used when the container containing the bean is destroyed.|

Following are the three important methods to provide configuration metadata to the Spring Container
- XML based configuration file.
- Annotation-based configuration
- Java-based configuration

## @Bean and @Configuration

- method-level annotation, analogous of the XML <bean/> element.
- Spring's [lifecycle Callbacks](https://docs.spring.io/spring/docs/2.5.x/reference/beans.html#beans-factory-nature) are fully supported.
- If a bean implements InitializingBean, DisposableBean, or Lifecycle, their respective methods will be called by the container.

```java
@Configuration
public class AppConfig {
    @Bean
    public TransferService transferService() {
        return new TransferServiceImpl();
    }
}
```
```java
public class Foo {
    public void init() { /* initialization logic */ }
}

public class Bar {
    public void cleanup() { /* destruction logic */ }
}

// Creating Bean using @Bean attributes
@Configuration
public class AppConfig {
    @Bean(initMethodName="init")
    public Foo foo() { return new Foo();}

    @Bean(destroyMethodName="cleanup")
    public Bar bar() {return new Bar();}
}
```

### @Bean Attributes
- [init-method](https://docs.spring.io/spring/docs/2.5.x/reference/beans.html#beans-factory-lifecycle-initializingbean){:target="_blank"}
- [destroy-method](https://docs.spring.io/spring/docs/2.5.x/reference/beans.html#beans-factory-lifecycle-disposablebean){:target="_blank"}
- [autowiring](https://docs.spring.io/spring/docs/2.5.x/reference/beans.html#beans-factory-autowire){:target="_blank"}
- [lazy-init](https://docs.spring.io/spring/docs/2.5.x/reference/beans.html#beans-factory-lazy-init){:target="_blank"}
- [dependency-check](https://docs.spring.io/spring/docs/2.5.x/reference/beans.html#beans-factory-dependencies){:target="_blank"}
- [depends-on](https://docs.spring.io/spring/docs/2.5.x/reference/beans.html#beans-factory-dependson){:target="_blank"}
- [scope](https://docs.spring.io/spring/docs/2.5.x/reference/beans.html#beans-factory-scopes){:target="_blank"}

### Supported Interfaces
- [BeanFactoryAware](https://docs.spring.io/spring/docs/2.5.x/reference/beans.html#beans-factory-aware-beanfactoryaware){:target="_blank"}
- [BeanNameAware](https://docs.spring.io/spring/docs/2.5.x/reference/beans.html#beans-factory-aware-beannameaware){:target="_blank"} - SetBeanName
- [MessageSourceAware](https://docs.spring.io/spring/docs/2.5.x/reference/beans.html#context-functionality-messagesource){:target="_blank"}
- [ApplicationContextAware](https://docs.spring.io/spring/docs/2.5.x/reference/beans.html#context-functionality-events){:target="_blank"} - setApplicationContext

## Bean Scopes

Spring supports 5 scopes, 3 of which are available only if you use a web-aware ApplicationContext.  
***By default, all beans in Spring are singletons.***

```java
@Bean(scope = DefaultScopes.PROTOTYPE)
@Bean(scope = DefaultScopes.SESSION)
@ScopedProxy
```

|bean scopes||
|---|---|
|**singleton**|single instance per Spring IoC container (**default**).<br>To return the same bean instance each time one is needed|
|session|	Scopes a bean definition to an HTTP session. (web-aware ApplicationContext).|
|request|	Scopes a bean definition to an HTTP request. (web-aware ApplicationContext).|
|prototype|Scopes a single bean definition to have any number of object instances.<br>To force Spring to produce a new bean instance each time one is needed.|
|global-session|	Scopes a bean definition to a global HTTP session. (web-aware ApplicationContext).|

- Most of the time, singleton beans are ideal.
  - cost of instantiating and garbage collecting instances of objects that are only used for small tasks can’t be justified when an object is stateless and can be reused over and over again in an application.
- But sometimes you may find yourself working with a mutable class that does maintain some state and therefore isn’t safe for reuse.

**what is globalSession**
- globalSession is something which is connected to Portlet applications.
- When your application works in Portlet container it is built of some amount of portlets.
- Each portlet has its own session, but if your want to store variables global for all portlets in your application than you should store them in globalSession.
- This scope doesn't have any special effect different from session scope in Servlet based applications.

### Working with request and session scope

-	In a web app, you may need to instantiate a bean that’s shared within the scope of a request or session. 

**Example** - shopping cart bean of a user in a e-commerce application
-	If singleton, then all users will be adding products to the same cart. 
-	If prototype-scoped, then products added to cart in one area of the application may not be available in another part of the application where a different prototype-scoped shopping cart was injected.
-	In the case of a shopping cart bean, session scope makes the most sense, because it’s most directly attached to a given user.

```java
@Component
@Scope(value=WebApplicationContext.SCOPE_SESSION, proxyMode=ScopedProxyMode.INTERFACES)
public ShoppingCart cart() { ... }
```
-	This tells Spring to create an instance of the ShoppingCart bean for each session in a web application. 
-	There will be multiple instances of the ShoppingCart bean, but only one will be created for a given session.
- **@Scope** also has a proxyMode attribute set to **ScopedProxyMode.INTERFACES**.
  - This attribute addresses a problem encountered when injecting a session- or request-scoped bean into a singleton-scoped bean.

```java
@Component
public class StoreService {
  @Autowired
  public void setShoppingCart(ShoppingCart shoppingCart) {
    this.shoppingCart = shoppingCart;
  }
  ...
}
```

![scoped-proxies]({{site.cdn}}/spring/spring-core/scoped-proxies.png)

-	StoreService singleton bean created when Spring application context is loaded. 
- Upon creation, Spring will attempt to inject ShoppingCart into the setShoppingCart() method.
- But ShoppingCart bean being session scoped, doesn’t exist yet.
  - There won’t be an instance of ShoppingCart until a user comes along and a session is created.
- Moreover, there will be many instances of ShoppingCart: one per user.
  - You don’t want Spring to inject just any single instance of ShoppingCart into StoreService.
  - You want StoreService to work with the ShoppingCart instance for whichever session happens to be in play when StoreService needs to work with the shopping cart.
- Instead of injecting the actual ShoppingCart bean into StoreService, Spring should inject a proxy to the ShoppingCart bean.
  - This proxy will expose the same methods as ShoppingCart so that for all StoreService knows, it is the shopping cart.
  - But ***when StoreService calls methods on ShoppingCart, the proxy will lazily resolve it and delegate the call to the actual session-scoped ShoppingCart bean***.
  - **Scoped Proxy**
- proxyMode is set to **ScopedProxyMode.INTERFACES**
  - indicating that the ***proxy should implement*** the ShoppingCart **interface** and delegate to the implementation bean.
  - interface-based proxy.
  - This is fine (and the most ideal proxy mode) as long as ShoppingCart is an interface and not a class.
- proxyMode set to **ScopedProxyMode.TARGET_CLASS**
  - to indicate that the proxy should be generated as an extension of the target class.
  - class-based proxy.
  - when ShoppingCart is a concrete class, there’s no way Spring can create an interface-based proxy.

Request-scoped beans pose the same wiring challenges as session-scoped beans. Therefore, request-scoped beans should also be injected as scoped proxies.

### Declaring scoped proxies in XML
```xml
<bean id="cart" class="com.myapp.ShoppingCart" scope="session"> 
    <aop:scoped-proxy proxy-target-class="false" />
</bean>
```
-	By default, \<aop:scoped-proxy> uses CGLib to create a target class proxy.

## Mixing configurations - Java and Xml (@Import)

Autowiring considers all beans in the Spring container, regardless they were declared in JavaConfig or XML or picked up by component scanning.

```java
@Configuration
public class CDConfig {
    @Bean
    public CompactDisc compactDisc() { return new SgtPeppers(); }
}
```
```java
@Configuration
@Import(CDConfig.class)
public class CDPlayerConfig {
    @Bean
    public CDPlayer cdPlayer(CompactDisc compactDisc) {
            return new CDPlayer(compactDisc);
    }
}
```
You can leave @Import out of CDPlayerConfig and instead create a higher-level SoundSystemConfig that uses @Import to bring both configurations together.
```java
@Configuration
@Import({CDPlayerConfig.class, CDConfig.class})
public class SoundSystemConfig {}
// 2nd level - (java + java config import)
```
```java
@Configuration
@Import(CDPlayerConfig.class)
@ImportResource("classpath:cd-config.xml")
 public class SoundSystemConfig {} 
// 2nd level - (java + xml config import)
```

# Referencing JavaConfig in XML configuration
```xml
<import resource="cd-config.xml" />
<bean id="cdPlayer" class="soundsystem.CDPlayer" c:cd-ref="compactDisc" />
```
The \<import> element only works to import other XML configuration files, and there isn’t an XML element whose job it is to import JavaConfig classes. There is, however, an element you already know that can be used to bring a Java configuration into an XML configuration: the \<bean> element.
```xml
<bean class="soundsystem.CDConfig" />
<bean id="cdPlayer" class="soundsystem.CDPlayer" c:cd-ref="compactDisc" />

<bean class="soundsystem.CDConfig" />
<import resource="cdplayer-config.xml" />
```
Whether using JavaConfig or XML wiring, often create a root configuration, as I’ve shown here, that brings together two or more wiring classes and/or XML files. It’s in this root configuration that I’ll also usually turn on component scanning (with either \<context:component-scan> or @ComponentScan).

# Dependency Injection - DI (Loose coupling)

**What do you mean by Dependency Injection?**  
-	Dependency Injection (DI) is a design pattern that removes the dependency from the programming code so that it can be easy to manage and test the application. 
- Dependency Injection makes our programming code loosely coupled
  - objects are given their dependencies at creation time by some third party that coordinates each object in the system.
  - Objects aren’t expected to create or obtain their dependencies.
- `@Autowired` is used, IoC container will wire them up together.

**Dependency Lookup**
- approach where we get the resource after demand. 
- There can be various ways to get the resource for example:
  -	`A obj = new AImpl();`
  -	`A obj = A.getA();`
- Here are mainly two problems of dependency lookup :
  - **Tight coupling** – makes the code tightly coupled, resource change needs a lot of code modification
  - **Not easy for testing** – troublesome black box testing.

## Types Of Dependency Injection

- constructor injection - for hard dependencies
- field injection - any optional dependencies.

|Dependency Injection||
|---|---|
|Constructor Injection|	Dependencies are provided as **constructor parameters**.|
|Setter Injection     |	Dependencies are assigned through **setter methods**.   |
|Field injection      |	Using annotations on fields and parameters.             |
|Interface Injection  | Clients implements interface that exposes a setter method that accepts the dependency.      |

```java
// Interface Injection
public interface EngineMountable {
    void mount(Engine engine);
}

public class Car implements EngineMountable {
    private Engine engine;
    
    //dependency injection
    @Override
    public void mount(Engine engine){
        this.engine = engine;
    }
}
```

### Constructor vs Setter Injection

|Constructor Injection                                      |	Setter Injection|
|---                                                        |---|	
|There is no partial injection.                             |	partial dependency can be injected|
|doesn’t override the setter property.                   |	overrides the constructor property.|
|It will create a new instance if any modification is done. |	It will not create new instance if any modification is done.|
|It works better for many properties.                       |	It works better for few properties.|

**When will you use “Constructor Injection” and “Setter Injection”?**
- **Constructor Injection**
  - allows you to hide immutable fields from users of your class.
  - Immutable classes don’t declare setter methods.
    - This also enforces that you have the valid objects at the construction time.
    - It also prompts you to rethink about your design when you have too many constructor parameters.
- **Setter Injection**
  - constructors may get a lot of parameters
    - hence needing a lot of overloaded constructors for all possible ways of object creation.

# Wiring Beans

- Objects aren’t responsible for finding or creating the other objects that they need to do their jobs. 
- Container gives them references to the objects that they collaborate with. 
- Act of creating these associations between application objects in DI is called as wiring.
- **Spring container** - responsible to create beans and coordinate relationships between those objects via DI. 
- **Developer** - responsible to tell Spring which beans to create and how to wire them together. 
- Spring offers three primary wiring mechanisms:
  - Explicit configuration in XML
  - Explicit configuration in Java
  - Implicit bean discovery and automatic wiring

Spring’s configuration styles are mix-and-match, so you could choose XML to wire up some beans, use Spring’s JavaConfig for other beans, and let other beans be automatically discovered by Spring.

## Automatic Wiring (@ComponentScan)

***Why bother explicitly wiring beans together if Spring can be configured to automatically do it for you?***
- Spring attacks automatic wiring from two angles:
  - **Component scanning** - Spring automatically discovers beans to be created in the application context.
  - **Autowiring** - Spring automatically satisfies bean dependencies.

**Creating Discoverable Beans**
- **@Component** - identifies as a component class and serves as a clue to Spring that a bean should be created for the class.
- Component scanning isn’t turned on by default.
  - You’ll still need to write an explicit configuration to tell spring to seek out classes annotated with @Component and to create beans from them. 
- With no further configuration, **@ComponentScan** will default to scanning the same package as the configuration class.

```java
// ComponentScan
@Configuration
@ComponentScan(basePackages= {"soundsystem", "video"})
public class CDPlayerConfig {}

@Configuration
@ComponentScan(basePackageClasses={CDPlayer.class, DVDPlayer.class})
public class CDPlayerConfig {}
```

**Naming a Component-Scanned Bean**
- All beans in a Spring application context are given an ID, derived from its class name by lowercasing the first letter of the class name.
- Spring supports the @Named annotation as an alternative to @Component.

```java
@Component("lonelyHeartsClub")
public class SgtPeppers implements CompactDisc {}

import javax.inject.Named;
@Named
public class CDPlayer {}
```

**Setting Base Package for component Scanning**
- For setting the base packages, values are expressed as String which is not very type-safe.
- If you were to refactor the packagenames, the specified base packages would be wrong.

**Annotating beans to be automatically wired**
- ***Autowiring*** - Letting Spring automatically satisfy a bean’s dependencies by finding other beans in the application context that are a match to the bean’s needs.
- `@Autowired` or `@Inject` indicates that autowiring should be performed.
- @Autowired can also be applied on any method on the class.
- Assuming that one and only one bean matches, that bean will be wired in.
  - If there are no matching beans, Spring will throw an exception as the application context is being created. 
  -	To avoid that exception, you can set the required attribute on @Autowired to false. 
    - Leaving the property unwired could lead to NullPointerExceptions if you don’t check for null in your code.
- In the event that multiple beans can satisfy the dependency, Spring will throw an exception indicating ambiguity in selecting a bean for autowiring.

```java
// Constructor Injection
@Autowired(required=false)
public CDPlayer(CompactDisc cd){ this.cd = cd;}

import javax.inject.Inject;
@Inject
public CDPlayer(CompactDisc cd){  this.cd = cd;}
```

### Autowiring Modes

**Autowiring**
-	Autowiring enables you to inject the object dependency implicitly. 
-	It internally uses setter or constructor injection.
-	Autowiring can't be used to inject primitive and string values. It works with reference only.
- **Advantage** - requires less code as need not to write code to inject the dependency explicitly.
- **Disadvantage** - No control of programmer. It can't be used for primitive and string values.
- **@Autowired** - First checks byType. If conflict, uses byName.

| Autowiring Modes ||
|---|---|
|no|	It is the default autowiring mode. It means no autowiring by default.|
|byName|	injects the object dependency according to name of the bean. <br>Property/bean name must be same. It internally calls setter method.|
|byType|	injects the object dependency according to type. <br>So, property name and bean name can be different, but only 1 bean of that type should be there.<br>It internally calls setter method.|
|constructor|	injects the dependency by calling the constructor of the class. <br>It calls the constructor having largest number of parameters. (0,1,2 args constructor --> 2args called)|

#### byName autowire mode
```java
public class B {  
 B(){System.out.println("b is created");}  
 void print(){System.out.println("hello b");}  
} 
```
```xml
<bean id="b" class="org.sssit.B"></bean>  
<bean id="a" class="org.sssit.A" autowire="byName">
```
```java
public class A {  
 B b;  
 A(){System.out.println("a is created");}  
 // getter setter
 void print(){System.out.println("hello a");}
 void display(){ print();  b.print();}  
}
```

#### byType autowiring mode
```xml
<bean id="b1" class="org.sssit.B"></bean>  
<bean id="a" class="org.sssit.A" autowire="byType"></bean> 
```
If multiple bean of one type, it will not work and throw exception. Let's see the code where are many bean of type B.
```xml
<bean id="b1" class="org.sssit.B"></bean>  
<bean id="b2" class="org.sssit.B"></bean>  
<bean id="a" class="org.sssit.A" autowire="byName"></bean>  
```

#### constructor autowiring mode
```xml
<bean id="b" class="org.sssit.B"></bean>  
<bean id="a" class="org.sssit.A" autowire="constructor"></bean> 
```

#### no autowiring mode
```xml
<bean id="b" class="org.sssit.B"></bean>  
<bean id="a" class="org.sssit.A" autowire="no"></bean> 
```

* ApplicationEvent
* ApplicationEventPublisher
* ApplicationEventPublisherAware

## Ambiguity In Autowiring

-	Autowiring only works when exactly one bean matches the desired result. 
-	When there’s more than one matching bean, the ambiguity prevents Spring from autowiring the property, constructor argument, or method parameter.
-	When spring doesn’t have a single, unambiguous choice, it throws **NoUniqueBeanDefinitionException**.

```java
@Autowired
public void setDessert(Dessert dessert) {
  this.dessert = dessert;
}
```
```java
nested exception is org.springframework.beans.factory.NoUniqueBeanDefinitionException:
No qualifying bean of type [com.desserteater.Dessert] is defined: expected single matching bean but found 3: cake,cookies,iceCream
```
```java
@Component 
public class Cake implements Dessert { ... }

@Component 
public class Cookies implements Dessert { ... }

@Component 
public class IceCream implements Dessert { ... }
```
-	You can declare one of the candidate beans as the primary choice.
-	You can use qualifiers to help Spring narrow its choices to a single candidate.

### @Primary

-	You might declare the @Component-annotated IceCream bean as the primary choice
-	Or, you can declare the IceCream bean explicitly in Java configuration (@Bean method )
-	You can configure your beans in XML, <bean> element has a primary attribute.
- When more than one bean is designated as primary, there are no primary candidates.


```java
@Autowired
public void setDessert(Dessert dessert) {
  this.dessert = dessert;
}
```
```java
@Component 
@Primary
public class Cake implements Dessert { ... }

@Component 
public class Cookies implements Dessert { ... }

@Component 
public class IceCream implements Dessert { ... }
```

### @Qualifier

- Limitation of @Primary - doesn’t limit choices to a single unambiguous option, it only designates a preferred option.
- @Qualifier - can be used with @Autowired or @Inject to specify which bean you want to be injected. 
- @Qualifier parameter is the ID of the bean that you want to inject.

```java
@Autowired
@Qualifier("iceCream")
public void setDessert(Dessert dessert) {this.dessert = dessert;}
```
- Due to harcoded bean id in @Qualifier, basing qualification on the default bean ID qualifier is simple but can pose some problems.
- What do you suppose would happen if you refactored the IceCream class, renaming it Gelato? Autowiring would fail.

#### Custom Qualifiers

```java
@Component
@Qualifier("cold")
public class IceCream implements Dessert {..}

@Bean
@Qualifier("cold")
public Dessert iceCream() {
    return new IceCream();
}
```
```java
@Autowired
@Qualifier("cold")
public void setDessert(Dessert dessert) {
    this.dessert = dessert;
}
```

- Instead of relying on the bean ID as the qualifier, you can assign your own qualifier to a bean.
- When defining custom @Qualifier values, it’s a good practice to use a trait or descriptive term for the bean, rather than using an arbitrary name.
- In this case, I’ve described the IceCream bean as a “cold” bean.
- At the injection point, it reads as “give me the cold dessert,” which happens to describe IceCream.
- Similarly, I might describe Cake as “soft” and Cookies as “crispy.”

### Create custom Qualifier - @Cold

```java
@Component
@Qualifier("cold")
public class Popsicle implements Dessert { ... }
```

- Java doesn’t allow multiple annotations of the same type to be repeated on the same item.
- Here, you can create custom qualifier annotations to represent the traits you want your beans to be qualified with. 
- All you have to do is create an annotation that is itself annotated with @Qualifier. Rather than use @Qualifier("cold"), you can use a custom @Cold annotation that’s defined like this:

```java
@Target({ElementType.CONSTRUCTOR, ElementType.FIELD, ElementType.METHOD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Qualifier
public @interface Cold { }
```
```java
@Component
@Cold 
public class IceCream implements Dessert { ... }
```

**NOTE** : Java 8 allows repeated annotations, as long as the annotation is annotated with @Repeatable. Even so, Spring’s @Qualifier annotation isn’t annotated with @Repeatable.

- With custom qualifier annotations, you can use multiple qualifiers together without any complaints from the Java compiler.
- Your custom annotations are more type-safe than raw @Qualifier annotation with qualifier as a String.

## Wiring Beans with Java - 3rd party classes

- When need to wire components from some third-party library where you cannot annotate its classes with @Component and @Autowired. Then you must turn to explicit configuration (Java or XML). 
- JavaConfig is preferred for explicit configuration - more powerful, type-safe, and refactor-friendly.
- JavaConfig is often set apart in a separate package from the rest of an application’s.

### Create a Configuration Class
- **@Configuration**
  - Identifies as a configuration class.
  - It’s expected to contain details on beans that are to be created in the Spring application context.
- **@Bean** 
  - Tells Spring that returned object should be registered as a bean in the Spring application context.
  - By default, the bean will be given an ID that is the same as the @Bean-annotated method’s name.
  - By default, all beans in Spring are singletons, Spring will intercept any calls to @Bean method to return same instance again.

```java
public class Foo {
    public void init() { /* initialization logic */ }
}

public class Bar {
    public void cleanup() { /* destruction logic */ }
}

// Creating Bean using @Bean attributes
@Configuration
public class AppConfig {
    @Bean(initMethodName="init")
    public Foo foo() { return new Foo();}

    @Bean(destroyMethodName="cleanup")
    public Bar bar() {return new Bar();}
}
```

# Conditional Beans

If you want one or more beans to be configured 
-	only if some library is available in the application’s classpath. 
-	only if a certain other bean is also declared.
-	only if a specific environment variable is set.

```java
@Bean
@Conditional(MagicExistsCondition.class)
public MagicBean magicBean() {
    return new MagicBean(); 
}
```
```java
public class MagicExistsCondition implements Condition {
 public boolean matches(ConditionContext context, AnnotatedTypeMetadata metadata) {
    Environment env = context.getEnvironment();
    return env.containsProperty("magic");
 }
}
```
matches() true, @Conditional-annotated beans are created otherwise not.

**ConditionContext**, you can do the following:
-	Check for bean definitions via the BeanDefinitionRegistry returned from getRegistry().
-	Check for the presence of beans, and even dig into bean properties via the ConfigurableListableBeanFactory returned from getBeanFactory().
-	Check the presence and values of environment variables via the Environment retrieved from getEnvironment().
-	Read and inspect the contents of resources loaded via the ResourceLoader returned from getResourceLoader().
-	Load and check for the presence of classes via the ClassLoader returned from getClassLoader().

**AnnotatedTypeMetadata** offers a chance to inspect annotations that may also be placed on the @Bean method.
```java
public interface AnnotatedTypeMetadata {
  boolean isAnnotated(String annotationType);
  Map<String, Object> getAnnotationAttributes(String annotationType);
  Map<String, Object> getAnnotationAttributes(String annotationType, boolean classValuesAsString);
  MultiValueMap<String, Object> getAllAnnotationAttributes(String annotationType);
  MultiValueMap<String, Object> getAllAnnotationAttributes(String annotationType, boolean classValuesAsString);
}
```

The @Profile annotation looks like this:
```java
@Retention(RetentionPolicy.RUNTIME)
@Target({
    ElementType.TYPE,
    ElementType.METHOD
})
@Documented
@Conditional(ProfileCondition.class)
public @interface Profile {
    String[] value();
}
```
```java
class ProfileCondition implements Condition {
    public boolean matches(ConditionContext context, AnnotatedTypeMetadata metadata) {
        if (context.getEnvironment() != null) {
            MultiValueMap < String, Object > attrs = metadata.getAllAnnotationAttributes(Profile.class.getName());
            if (attrs != null)
                for (Object value: attrs.get("value"))
                    if (context.getEnvironment().acceptsProfiles((String[]) value))
                        return true;
            return false;
        }
        return true;
    }
}
```
Here, ProfileCondition fetches all the annotation attributes for the @Profile annotation from AnnotatedTypeMetadata. With that, it checks explicitly for the value attribute, which contains the name of the bean’s profile. It then consults with the Environment retrieved from the ConditionContext to see whether the profile is active (by calling the **acceptsProfiles()** method).

## Configuring profile beans

- Environment-specific choices for Application, DB config, encryption algo, and integration with external systems.
  - rebuilt for each environment - configure each bean in a separate configuration class (or XML file) and make a build-time decision using profiles about which to compile into the deployable application.
  - Use Spring Profiles
- Rather than making that decision at build time, Spring waits to make the decision at runtime. 
- Consequently, the same deployment unit (perhaps a WAR file) will work in all environments without being rebuilt.
- You can use @Profile at the class and method level, alongside the @Bean annotation to specify the profile. 
- Any bean that isn’t given a profile will always be created, regardless of what profile is active.
- All the configuration XML files are collected into the deployment unit (likely a WAR file), but only those whose profile attribute matches the active profile will be used.


```java
@Configuration
public class DataSourceConfig {
 @Bean(destroyMethod="shutdown")
 @Profile("dev")
 public DataSource embeddedDataSource() {...}
}
```

### Activating profiles

- Spring provides two separate properties when determining which profiles are active: 
  - `spring.profiles.active`
  - `spring.profiles.default`
- If neither is set, then only those beans that aren’t defined as being in a profile are created. 
- There are several ways to set these properties :
  - As initialization parameters on DispatcherServlet
  - As context parameters of a web application
  - As JNDI entries
  - As environment variables
  - As JVM system properties
  - Using the `@ActiveProfiles` annotation on an integration test class
- You can activate multiple profiles at the same time by listing the profile names, separated by commas.
  - It probably doesn’t make much sense to enable both dev and prod profiles at the same time, but you could enable multiple orthogonal profiles simultaneously.

# Property value - runtime injection

- Spring offers two ways of evaluating values at runtime:
  -	Property placeholders
  -	The Spring Expression Language (SpEL)

### Injecting external values
The simplest way to resolve external values in Spring is to declare a property source and retrieve the properties via the Spring Environment.

```properties
# /resource/app.properties
disc.title=Sgt. Peppers Lonely 
disc.artist=The Beatles
```
```java
@Configuration
@PropertySource("classpath:/resource/app.properties")
public class ExpressiveConfig {
  @Autowired
  Environment env;

  @Bean
  public BlankDisc disc() {
    return new BlankDisc(env.getProperty("disc.title"), env.getProperty("disc.artist"));
  }
}
```
- This properties file is loaded into Spring’s Environment, from which it can be retrieved later.
- Meanwhile, in the disc() method, a new BlankDisc is created; its constructor arguments are resolved from the properties file by calling getProperty().
-	If either the disc.title property or the disc.artist property is undefined, an **IllegalStateException** will be thrown.

```java
int connectionCount = env.getProperty("db.connection.count", Integer.class, 30);
boolean titleExists = env.containsProperty("disc.title");
Class<CompactDisc> cdClass = env.getPropertyAsClass("disc.class", CompactDisc.class);
```
-	If you want to check for the existence of a property, you can call containsProperty() on Environment.
-	If you need to resolve a property into a Class, you can use the getPropertyAsClass() method.
-	Spring also offers the option of wiring properties with placeholder values that are resolved from a property source.

### Methods offered by Environment
```java
String getProperty(String key)                            // overloaded 4 ways
String getProperty(String key, String defaultValue)
T getProperty(String key, Class<T> type)
T getProperty(String key, Class<T> type, T defaultValue)

// Environment also offers some methods for checking which profiles are active
String[] getActiveProfiles()                  // Returns an array of active profile names
String[] getDefaultProfiles()                 // Returns an array of default profile names
boolean acceptsProfiles(String... profiles)   // Returns true if the environment supports the given profile(s)
```

## Resolving Property Placeholders

-	@Value annotation in much the same way as you might use the @Autowired annotation. 

```java
public BlankDisc(@Value("${disc.title}") String title,  @Value("${disc.artist}") String artist){
	this.title = title;
  this.artist = artist;
}
```
```xml
<context:property-placeholder />
<bean id="sgtPeppers" class="soundsystem.BlankDisc" c:_title="${disc.title}" c:_artist="${disc.artist}" />
```
-	You must configure either a **PropertyPlaceholderConfigurer** or **PropertySourcesPlaceholderConfigurer** bean in order to use placeholder values. 
-	PropertySourcesPlaceholderConfigurer is preferred because it resolves placeholders against the Spring Environment and its set of property sources.
-	Resolving external properties is one way to defer value resolution until runtime, but its focus is finely tuned on resolving properties, by name, from Spring’s Environment and property sources.

### Issue with  Spring 4.2 (propertySourcesPlaceHolderConfigurer) 
I am running the code for Java Configuration and injecting values from props file. However, I'm getting:
```java
${foo.email}
${foo.team}
```
**Instead of the actual property values. How can I resolve this?**
This is an issue with Spring versions. If you are using Spring 4.2 and lower, you will need to add
```java
// add support to resolve ${...} properties
@Bean
public static PropertySourcesPlaceholderConfigurer propertySourcesPlaceHolderConfigurer() {
  return new PropertySourcesPlaceholderConfigurer();
}
```

## Wiring with the Spring Expression Language

Spring Expression Language (SpEL), way of wiring values into a bean’s properties or constructor arguments using expressions that are evaluated at runtime.
-	The ability to reference beans by their IDs
-	Invoking methods and accessing properties on objects
-	Mathematical, relational, and logical operations on values
-	Regular expression matching
-	Collection manipulation

The first thing to know is that SpEL expressions are framed with #{ ... }, much as property placeholders are framed with ${ ... }. T() operator evaluates java.lang.System as a type to invoke staticcurrentTimeMillis().
```
#{sgtPeppers.artist}                  #{9.87E4}       #{false}
#{systemProperties['disc.title']}     #{'Hello'}      #{T(System).currentTimeMillis()}
```

```java
public BlankDisc(@Value("#{systemProperties['disc.title']}") String title, @Value("#{systemProperties['disc.artist']}") String artist) {
  this.title = title;
  this.artist = artist;
}
```
```xml
<bean id="sgtPeppers" class="soundsystem.BlankDisc"  
	c:_title="#{systemProperties['disc.title']}"
 	c:_artist="#{systemProperties['disc.artist']}" />
```

### Referencing beans, properties, and methods
```
#{sgtPeppers}       #{sgtPeppers.artist}        #{artistSelector.selectArtist()}
#{artistSelector.selectArtist().toUpperCase()}
#{artistSelector.selectArtist()?.toUpperCase()}
```
**?. Operator** - Makes sure the item to its left isn’t null before accessing the thing on its right. So, if selectArtist() returns null, then SpEL won’t even try to invoke toUpperCase(). The expression will evaluate to null.

### Working with types in expressions

-	The key to working with class-scoped methods and constants in SpEL is to use the T() operator. 
-	The result of the T() operator is a Class object that represents java.lang.Math. 
-	You can even wire it into a bean property of type Class, if you want. But the real value of the T() operator is that it gives you access to static methods and constants on the evaluated type.
```
#{T(java.lang.Math).PI * circle.radius ^ 2}         #{disc.title + ' by ' + disc.artist}
#{counter.total eq 100}                             #{counter.total == 100}
#{scoreboard.score > 1000 ? "Winner!" : "Loser"}
```

|Operator type|	Operators|
|---|---|
|Arithmetic|+, -, *, /, %, ^|
|Comparison| <, lt, >, gt, ==, eq, <=, le, >=, ge|
|Logical |and, or, not, \| |
|Conditional| ?: (ternary), ?: (Elvis)|
|Regular expression| matches|

Ternary operator - to check for a null value and offer a default value in place of the null. For example, the following expression evaluates to the value of disc.title if it isn’t null. If disc.title is null, then the expression evaluates to “Rattle and Hum”.
```
#{disc.title ?: 'Rattle and Hum'}
```

### Evaluating regular expressions

```xml
#{admin.email matches '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.com'}
#{'This is a test'[3]} <!-- This references the fourth (zero-based) character in the String, or s. -->
```
SpEL also offers a selection operator (.?[]) to filter a collection into a subset of the collection. 
```
#{jukebox.songs.?[artist eq 'Aerosmith']}
```
SpEL also offers two other selection operations: 
-	.^[] for selecting the first matching entry
-	.$[] for selecting the last matching entry.

```
#{jukebox.songs.^[artist eq 'Aerosmith']}
#{jukebox.songs.![title]} - collection of all the song titles.
#{jukebox.songs.?[artist eq 'Aerosmith'].![title]}
```
SpEL offers a projection operator (.![]) to project properties from the elements in the collection onto a new collection.

# @Order

- `@Order` annotation defines the sorting order of an annotated component or bean.
- `Ordered.LOWEST_PRECEDENCE` is lowest (Default).
- `Ordered.HIGHEST_PRECEDENCE` is highest.

```
@Component
@Order(Ordered.LOWEST_PRECEDENCE)
```

For details, [click here](https://www.baeldung.com/spring-order){:target="_blank"}

