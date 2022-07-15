---
layout: page
title: Microservices
permalink: /microservices
---

- TOC
{:toc}

---

# References
- [12 Factor App](https://12factor.net/){:target="_blank"}
- [microservices.io]( http://microservices.io/)
- [Microservices Design Patterns - Microservices Architecture Patterns - Edureka](https://www.youtube.com/watch?v=xuH81XGWeGQ)
- [Circuit Breaker Pattern - Fault Tolerant Microservices](https://www.youtube.com/watch?v=ADHcBxEXvFA)
-	[top-29-microservices-interview-questions-for-2019](https://dzone.com/articles/top-29-microservices-interview-questions-for-2019)
-	[top-microservices-interview-questions-for-2019-par](https://dzone.com/articles/top-microservices-interview-questions-for-2019-par)
-	[microservices-interview-quesions](https://www.javainuse.com/spring/microservices-interview-quesions)

# Software Architecture Evolution

![evolution-software-architecture]({{site.cdn}}/webservices/microservices/evolution-software-architecture.png)

**How SOA, monolithic, and Microservices Architectures are different from each other?**
-	**SOA (Service-Oriented Architecture)**: This is a wide collection of services that could communicate together.
-	**Monolithic**: This is highly similar to the big container where all software components of an application are assembled and packed together.
-	**Microservices**: Microservices can be defined as the architectural style that structures an application as a collection of small autonomous services that are modeled around a business domain.

In SOA, 
- we build services for reusability but we don't have clarity of probable usages or applications while in microservices it is part of application and we are aware of the use cases for microservice.
- SOA have very strict contract as clients are not known and changes should not break the old consumer code.

## Microservices Architecture Components

-	**Clients**: Different users will send requests from different devices.
-	**Identity Providers**: They will authenticate user details and offer service tokens to users.
-	**API Gateway**: This gateway handles multiple requests together.
-	**Static Content**: It helps in storing all the content of a system for longer time.
-	**CDNs**: The content delivery network is a distributed network of proxy servers and their respective data centers.
-	**Management**: it will balance the services over nodes and identifies failures as well.
-	**Service Discovery**: it will find the route how different Microservices communicate together.
-	**Remote Services**: it will enable the remote access to information stored on a network or other IT devices.

![microservices-architecture]({{site.cdn}}/webservices/microservices/microservices-architecture.png)

# Introduction

- Microservices is an architectural style
  - application is structured as a collection of small autonomous services.
    - services are modeled around a business domain.
  - Services are connected but independent in its own way.
    - Can be scaled independently .
    - Failure Isolation.

**When Monolith is broken down to modular microservices, you are exchanging one set of problems with other set of problems.**
- Problems Solved
  - big chunk of code
  - scalability
  - modularity of deployments
- New Problem Set
  - Due to modularity, make sure release process is fine.
  - With Scalability, make sure you have multiple copies and still make your application work.

- Here, Problems to be solved for Monolith Architecture are very specific to your application.
- While for Microservices problem sets are more generic, example load balancing etc.
  - For common problems we have common solution
    - *patterns* - Make microservices work well together like service discovery.
    - *technologies* - Libraries and framworks to solve common problems like eureka, spring cloud.

**Note**: RestTemplate is depricated, now you need to use WebClient which needs reactive programming for providing asynchronous capabilities.

![microservices.png]({{site.cdn}}/webservices/microservices/microservices.png)

## Monolithic vs Microservices

- **Monolithic architecture** is like a big container in which all the software components of an application are clubbed inside a single package.
- **Microservice Architecture** is an architectural development style which builds an application as a collection of small autonomous services developed for a business domain.
  - large-scale websites : Twitter, Netflix, Amazon.

|Microservices|	Monolithic Architecture|
|---|---|	
|Service Startup is fast|	Service startup takes time|
|Loosely coupled architecture.|	Mostly tightly coupled.|
|Changes done in a single data model does not affect other Microservices.|	Any changes in the data model affect the entire database|
|Microservices  focuses  on products, not projects|	Monolithic put emphasize over the whole project|

## Microservices Features

**Disadvantages of Monolithic Application**
- One small change will need you to compile and deploy the whole application.
- Scaling up needs you to make copies of whole application.
- Separation of concern is not present.
- Same coding language throughout.

**Advantages of Microservices**
- Focus on single capability only.
- Each microservice is an individual component (deployable units).
  - Frequent Independent deployments.
  - Easy to scale
-	Technology diversity i.e. can use different libraries, databases, frameworks etc.
- It gives maximum security to each of the services.
- Smaller code base is easy to maintain.
- Fault isolation i.e. a process failure should not bring whole system down.
- Better support for smaller and parallel team.
  - possible developing and deploying multiple services together.

**Disadvantages of Microservices**
-	Distributed System so hard to debug and trace the issues
-	It will increase delays due to remote calls.
-	Difficult to achieve strong consistency across services
-	ACID transactions do not span multiple processes.
-	Greater need for end to end testing
-	Required cultural changes in across teams like Dev and Ops working together even in same team.

### Features
* Independent and Autonomous services - 
* Scalability - 
* Decentralization - Decentralized Governance
* Real Time Load Balancing - 
* Availability - 
* Continuos delivery through DevOps Integration - Infrastructure automation
* Seamless API Integration and Continuos Monitoring - 
* Isolation from Failures - Design for failure
* **Fault Tolerance** - How does system behave when there is a fault, impact of fault.
* **Resilience** - How many faults can system tolerate.
* Auto-Provisioning - 
* Essential messaging frameworks
* **Low Coupling** - Coupling is the measurement of strength between the dependencies of a component.
* **High Cohesion** - degree to which how components bind together within a module is called the Cohesion.

### Best Practices to Design Microservices
- Specific business problem (capability) for each Microservice.
- Specific data store for each Microservice (table).
- Decoupled microservices.
- The code should be arranged at a similar level of maturity.
- A separate build should be designed for each Microservice.
  - Each build should be deployed into containers.
- The server should always be treated as stateless.
- Each microservice can use tools and technology as per suitability of its problem statement.
- Fault Isolation.

**Common Mistakes Made While Transitioning to Microservices**  
- Not only on development, but mistakes also often occur on the process side.
- Often the developer fails to outline the current challenges.
- Rewriting the programs that are already existing.
- Responsibilities, timeline, and boundaries not clearly defined.
- Failing to implement and figure out the scope of automation from the very beginning.

## Shared Objects in Microservices

Suppose we have class A defined in microservice A and microservice B is calling an endpoint to get this as response, should we have replica of class definition in microservice B or use a shared library among them?
- Preferred is to use replica of class definition in microservice B.
- If we use shared library, microservices become coupled hence purpose of independent service is defeated, ie. changing the definition requires both microservices to recompile and restart.
- Also shared library will have class definition from all the microservices, suppose we have an ecosystem of 100 microservices and microservice A talks to only 4-5 of them. Why should it have all the 100 microservices class definition?
- **We use SDK**

# Service Discovery

Microservices might be running on different servers, then how to keep track of them?   
Here, Service Discovery is used.

**Why Hardcoded URLs are bad?**
- Changes require code update
- Dynamic URLs in cloud
- Load Balancing
- Multiple Environments

![service-discovery.png]({{site.cdn}}/webservices/microservices/service-discovery.png)

## Tools

- When service A starts up. It registers itself to some service discovery tool (discovery server) telling I am Service A running on this ip address using this port.
- We can add versions, username-password.
- Most of these service discovery tools are using key value pairs.

**Some Service Discovery Tools**
- Eureka, by Netflix
- Zookeeper, by Apache
- Consul, by HashiCorp
- etcd, by CoreOs
- SkyDNS(built on top of etcd)
- Smartstack, by AirBnB

***Spring Cloud uses client side service discovery.***

Technology used for service discovery by Spring Cloud is Eureka.

## Types


```java
@LoadBalanced
private RestTemplate restTemplate;
```

- Client Microservice sends **heart beats** to Discovery Server (Service Registry) to keep the entry alive.

![]({{site.cdn}}/webservices/microservices/service-discovery-eureka.png)

![]({{site.cdn}}/webservices/microservices/service-discovery-types.png)

## Netflix Eureka

- When we start a project, we usally have all the configurations in the properties file.
  - As more and more services are developed and deployed, adding and modifying these properties become more complex.
  - Some services might go down, while some the location might change.
  - This manual changing of properties may create issues.
- Eureka Service Registration and Discovery helps in such scenarios.
  - As all services are registered to the Eureka server and lookup done by calling the Eureka Server.
    - any change in service locations is taken care of automatically.
- Eureka is also known as the ***Netflix Service Discovery Server***.

### Overview of Netflix components
- **Spring Cloud** provides Netflix OSS integrations for Spring Boot apps through autoconfiguration and binding.
- With **annotations** you can configure the common patterns inside your application and build large distributed systems with battle-tested Netflix components.

|Netflix Component Name|	Functionality|
|---      |---|	
|Eureka   |	Service Registration and Discovery|
|Hystrix  |	Circuit Breaker|
|Zuul     |	Server Side Load Balancing<br>Edge Server, Intelligent Routing |
|Ribbon   |	Dynamic Routing and Load Balancer (Client Side Load Balancing)|

> [Microservice Registration and Discovery with Spring cloud using Netflix Eureka](https://www.javainuse.com/spring/spring_eurekaregister){:target="_blank"}

**How Can You Set Up Service Discovery?**  
1. **Client Configuration**
   - can be done easily by using the property files.
   - In the classpath, Eureka searches for eureka-client.properties.
   - It also searches for overrides caused by the environment in property files which are environment specific.
2. **Server Configuration**
  - you have to configure the client first.
  - Once that is done, the server fires up a client which is used to find other servers.
  - The Eureka server, by default, uses the Client configuration to find the peer server.

# Load Balancing

- In Cloud computing, load balancing improves the distribution of workloads across multiple computing resources.
  - such as computers, a computer cluster, network links, central processing units, or disk drives.
- increase reliability and availability through redundancy.
- Load balancing usually involves dedicated software or hardware, such as a multilayer switch or a Domain Name System server process.
- avoid overload of any single resource.
- optimize resource use
- maximize throughput
- minimize response time

## Server Side Load Balancer - Netflix Zuul
**How to achieve server side load balancing using Spring Cloud?**  
- ***Server side load balancing*** can be achieved using ***Netflix Zuul***.
- Zuul is a JVM based router.
- known as server side load balancer by Netflix.
- We can
  - integrate Zuul with other Netflix projects
    - Hystrix for fault tolerance 
    - Eureka for service discovery
  - use it to manage routing rules, filters, and load balancing across your system.
- It provides a single entry to our system, which allows a browser, mobile app, or other user interface to consume services from multiple hosts without managing cross-origin resource sharing (CORS) and authentication for each one.

## Client Side Load Balancer - Netflix Ribbon

- Ribbon is a client-side load balancer that gives you a lot of control over the behavior of HTTP and TCP clients.
- Feign already uses Ribbon `@FeignClient`.
- group ID `org.springframework.cloud`, artifact ID `spring-cloud-starter-netflix-ribbon`.
- A central concept in Ribbon is that of the named client.
- Netflix Ribbon, it provide several algorithm for Client-Side Load Balancing.
- Spring provide smart RestTemplate for service discovery and load balancing by using `@LoadBalanced` annotation with **RestTemplate** instance.

**References**
- [Spring Cloud- Netflix Eureka + Ribbon Simple Example](https://www.javainuse.com/spring/spring_ribbon)
- [Client Side Load Balancer: Ribbon](https://cloud.spring.io/spring-cloud-netflix/multi/multi_spring-cloud-ribbon.html)

## Declarative REST Client - Netflix Feign

- [Netflix Feign - Declarative REST Client](https://cloud.spring.io/spring-cloud-netflix/multi/multi_spring-cloud-feign.html){:target="_blank"}


- Feign is a declarative web service client. It makes writing web service clients easier.
- Spring Cloud integrates Ribbon and Eureka to provide a load balanced http client when using Feign.
- group `org.springframework.cloud` and artifact id `spring-cloud-starter-openfeign`.

```java
@SpringBootApplication
@EnableFeignClients
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

```java
@FeignClient("stores")
public interface StoreClient {

    @RequestMapping(method = RequestMethod.GET, value = "/stores")
    List<Store> getStores();

    @RequestMapping(method = RequestMethod.POST, value = "/stores/{storeId}", consumes = "application/json")
    Store update(@PathVariable("storeId") Long storeId, Store store);
}
```

**What is Netflix Feign? What are its advantages?**  
Feign is a java to http client binder inspired by Retrofit, JAXRS-2.0, and WebSocket. Feign's first goal was reducing the complexity of binding Denominator uniformly to http apis regardless of restfulness. Previous examples in the employee-consumer we consumed the REST services exposed by the employee-producer using **REST Template**.

![]({{site.cdn}}/webservices/microservices/netflix-feign.png)

But we had to write a lot of code to perform following-
-	For Load balancing using Ribbon.
-	Getting the Service instance and then the Base URL.
-	Make use of the REST Template for consuming service.

The previous code was as below
```java
@Controller
public class ConsumerControllerClient {	
	@Autowired
	private LoadBalancerClient loadBalancer;
	
	public void getEmployee() throws RestClientException, IOException {		
		ServiceInstance serviceInstance=loadBalancer.choose("employee-producer");		
		System.out.println(serviceInstance.getUri());		
		String baseUrl=serviceInstance.getUri().toString();		
		baseUrl=baseUrl+"/employee";		
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<String> response=null;
		try{
			response=restTemplate.exchange(baseUrl, HttpMethod.GET, getHeaders(),String.class);
		}catch (Exception ex){
			System.out.println(ex);
		}
		System.out.println(response.getBody());
	}
```

The previous code, there are chances of exceptions like NullPointer and is not optimal. We will see how the call is made much easier and cleaner using Netflix Feign. If the Netflix Ribbon dependency is also in the classpath, then Feign also takes care of load balancing by default.

> [Spring Cloud- Netflix Feign Simple Example](https://www.javainuse.com/spring/spring-cloud-netflix-feign-tutorial)

# Fault Tolerance and Resilience

- **Fault Tolerance** - How does system behave when there is a fault, impact of fault.
- **Resilience** - How many faults can system tolerate.

**Movie Catalog API Ecosystem**
![]({{site.cdn}}/webservices/microservices/movie-catalog-api.png)

## Issues with Microservices

- A Microservice goes down?
  - run multiple instances.
- A Microservice instance is slow.
  - An unrelated service call also becomes slow, this is caused by servlet thread pool being exhausted.
  - **Solution 1** - apply timeout.
    - This solves the solution partly, breaks if requests per seconds exceeds timeout capacity.
  - **Solution 2** - Use `Circuit Breaker Pattern`
    - Detect something is wrong.
    - Take temporary steps to avoid the situation from getting worse.
    - Deacivate the "problem component" so that it doesn't affect the downstream components.
    - circuit breaker can be reset (manually or programatically) to resume normal operation.
  - **Solution 3** - `BulkHead Pattern`

### Servlet thread pool Exhaused (in spring boot)

***Immediate Failures***
- can be handled by try catch
- User will continuously keep sending the request without any knowledge of service being down.
- already 10 times failed, why call for 11th time

***Timeout Failures***
- All threads of the pool are exhausted ie. service overloaded. (Service resource exhausted)
- User keeps waiting for longer time, hence bad user experience.
- can cause cascading failures in other microservices.
    * A --> B and uses up all servlet threads then, C --> B will also fail.
- **Solution** : Circuit Breaker Pattern
    * Stop calling the overloaded service and allow it to recover.
    * Add request interceptor to immediately return default response for recovery period.
    * interceptor status flag changed once service is up again.
    * failure threshold is monitored to change status in interceptor service.
    * Status - `OPEN`, `CLOSED`, `HALF-OPEN`
    * track % of calls failing is the best approach for last N calls.
    * after expected recovery time for service is over, service can be made HALF_OPEN(partially allow).
    * Implementation - Hystrix, resilience4j
        - Implemented using decorator pattern

![]({{site.cdn}}/webservices/microservices/circuit-breaker-check.png)

## Circuit Breaker Pattern

**When does a circuit trips?**
- Last n requests to be considered for decision.
- How many of those requests are failing.
- timeout duration to define failure.

**When does circuit becomes normal?**
- How long after a circuit trip to try again? `sleep window`

**What to do for requests when circuit trips?**
- This is called Fallback Mechanism.
- Throw an error. (not recommended)
- Return a fallback default response. (not recommended)
- Save previous responses (cache), use it when possible.

**Key Features of Circuit Breaker Pattern**
- Failing Fast.
- Fallback Functionality.
- Automatic Recovery.
- Technology Available - Hystrix

* [Circuit Breaker Pattern - Fault Tolerant Microservices](https://www.youtube.com/watch?v=ADHcBxEXvFA)
* Used to stop the process of request and response if a service is not working.
* client invokes remote service via proxy, proxy behaves as barrier.

### Hystrix

- Open source library created by Netflix.
- Implements Circuit Breaker pattern so you don't have to.
- Hystrix is a latency and fault tolerance library.
- Designed for complex distributed systems where failure is inevitable
  - isolate points of access to remote systems, services and 3rd party libraries
  - stop cascading failure
  - enable resilience
- We will be using two features of Hystrix-
  -	Circuit Breaker
  -	Fallback method - Can return default response or cached response.
- Give it the configuration and it does the work.
  - Works well with SpringBoot.
- **References**
  - [Spring Cloud- Circuit Breaker using Netflix Hystrix Simple Example](https://www.javainuse.com/spring/spring_hystrix_circuitbreaker){:target="_blank"}
  - [Spring Cloud- Netflix Hystrix Fallback method Simple Example](https://www.javainuse.com/spring/spring_hystrix){:target="_blank"}

#### Adding Hystrix to SpringBoot
- Add dependency `spring-cloud-starter-netflix-hystrix`
- `@EnableCircuitBreaker` to application class
- `@HystrixCommand` to methods that need circuit breaker.
- Configure Hystrix behavior.

If the exceptions keep on occuring in the firstPage method() then the Hystrix circuit will break and the employee consumer will skip the firtsPage method all together and directly call the fallback method.

The purpose of circuit breaker is to give time to the first page method or other methods that the firstpage method might be calling and is causing the exception to recover. It might happen that on less load the issue causing the exceptions have better chance of recovering.

```java
@HystrixCommand(fallbackMethod="getFallbackCatalog")
getCatalog(@PathVariable String userId){}

getFallbackCatalog(@PathVariable String userId){
  // parameters should be same
  // should return harcoded response or response from cache, no complicated logics here
  // Why no complicated logic? Because we don't want fallback to have exception and another fallback
}
```

![]({{site.cdn}}/webservices/microservices/hystrix-microservices.png)
	
![]({{site.cdn}}/webservices/microservices/hystrix-service-consumer.png)

![]({{site.cdn}}/webservices/microservices/hystrix-fallback.png)

![]({{site.cdn}}/webservices/microservices/hystrix-circuitbreaker.png)

#### How does Hystrix Work?

Creates a Hystrix Proxy object.

![]({{site.cdn}}/webservices/microservices/hystrix-proxy.png)

For Movie Catalog API Ecosystem, we should not put @HystrixCommand on getUserMovieRatingCatalog(userId) method but on getRatings and getMovieInfo methods, Why?
- **Case 1**
  - get ratings is failing, but get movie info is working
  - take default response of ratings response and call the working movie info service
- **Case 2**
  - get ratings is working, get movie info is failing
  - take response from get ratings and default response from get movie info
  - It is acceptable to get all movie ratings with few movies missing details due to default response.

Here, even if you refractor the code to make these 2 calls as separate methods we will get error due to Hystrix Proxy Class.
- When there is a bean with annotations like @HystrixCommand, we are holding the Proxy instance of the class rather than the actual instance.
- This Proxy instance intercepts the call.

**What changed by refactoring**
- Before refactoring, @HystrixCommand on getUserMovieRatingCatalog
  - Spring Framework was calling the method on the Hystrix Proxy instance hence Hystrix was able to intercept the call and execute the fallback method.
- On refactoring
  - @HystrixCommand methods are being called from a method inside the hystrix proxy instance, hence Hystrix has no say to intercept the call here.
  - Solution - Move the methods to a separate bean class so that getUserMovieRatingCatalog calls these methods on hystrix proxy object and fallback method works fine.

### Hystrix Configuration Parameters

![]({{site.cdn}}/webservices/microservices/hystrix-config-parameters.png)

### Hystrix Dashboard

- Add dependency `spring-cloud-starter-netflix-hystrix-dashboard`
- `@EnableHystrixDashboard` to application class
- `management.endpoints.we.exposure.include=hystrix.stream` to application.properties
- `localhost:8080/hystrix`

## BulkHead Pattern

![]({{site.cdn}}/webservices/microservices/bulkhead-pattern.png)

![]({{site.cdn}}/webservices/microservices/bulkhead-properties.png)

# Microservices Configuration

- Separating code from configuration
  - properties
  - yaml
  - json
- Example Configurations
  - Database Connections
  - Credentials
  - Feature Flags
  - Business Logic Configuration parameters
  - Scenario Testing (A/B Testing)
  - SpringBoot Configuration
- Externalized - Externalize the property file
  - Add application.properties in the same folder as jar.
  - command line argument
- Environment Specific
- Consistent across all the instances
- Version History
- Real Time Management
- List all properties
  - Actuator - /configprops gives all properties

```
java -jar jarname-0.0.1-SNAPSHOT.jar --key="value"
```
For Local Server, user default value of properties
```java
@Value("${a:default}")
private String value;
```

## Profile Based Config

you can also select beans based on active profile.
- `application-<profile-name>.properties`
- `application-<profile-name>.yaml`
- **default profile is always active.**

```
java -jar jar-name.jar --spring.profiles.active=dev
```
```java
@Autowired
Environment env;

env.getXXX();
```

![]({{site.cdn}}/webservices/microservices/config-env-specific.png)

## Config as a Microservice

- Technology Options 
  - Apache Zookeeper
  - ETCD - Distributed Key-Vaule Store
  - Hashicorp Consul
  - Spring Cloud Configuration Service

![]({{site.cdn}}/webservices/microservices/spring-cloud-config-server.png)

**Spring Cloud Configuration Service**
- Add `Config Server` Dependency
- `@EnableConfigServer`
- application.properties -> `spring.cloud.config.server.git.uri=<url of file in git repo>`
- get localhost:8080/\<filname-without-ext>/\<profile>
  - get 'localhost:8080/application/default'

**Spring Cloud Configuration Client**
- Add `Config Client` Dependency
- `spring-cloud-starter-config` in pom.xml
- Additional dependency management section in pom.xml
- application.properties -> `spring.cloud.config.uri=http://localhost:8080/` 

**Microservice Specific Properties**
- Create microservice-name.yml file
- spring.application.name

**Refresh Properties in Real Time**
- `@RefreshScope` on spring components using properties
- POST /actuator/refresh

## Configuration Strategies

|Specificity|Type|Where|
|---|---|---|
|Microservice Specific|Changing - No|Property File|
|Microservice Specific|Changing - Yes|Config Server|
|Microservice Specific|Environment Config|System Variable with Alias|
|Microservice Specific|Changing - Yes|Config Server|

```properties
<!-- system properties -->
host.env.port=8080          // provider A
host.environment.port=8080  // provider B

<!-- microservice properties -->
env.port=${host.env.port}   // single place to change (alias)
server.port=${env.port}
```

## Configuration Security

- Config Server + Spring Security
- Use Encryption to secure configuration
  - save encrypted values in properties.
  - Using Java Cryptography Extension (JCE).

![]({{site.cdn}}/webservices/microservices/config-secure.png)

# Microservice Design Patterns

## Microservice Architecture Design Principles

**What are Reactive Extensions in Microservices?**
- Reactive Extensions is also called Rx.
- It is a design pattern which allows collecting results by calling multiple services and then compile a combined response.
- Rx is a popular tool in distributed systems which works exactly opposite to legacy flows.

[9 Fundamentals to a Successful Microservice Design]( https://dzone.com/articles/9-fundamentals-to-a-successful-microservice-design)

**Fundamentals of Microservices Design**
- Define a scope
- Loose coupling
- High cohesion
- Seamless API Integration
- A unique source of Identification for every service
- Create a unique service which will act as an identifying source, much like a unique key in a database table.
- Creating the correct API and taking special care during integration.
- Restrict access to data and limit it to the required level.
- Real-Time Traffic Management - Maintain a smooth flow between requests and response.
- Automate most processes to reduce time complexity.
- Isolated data storage for each microservice
  - Keep the number of tables to a minimum level to reduce space complexity.
  - Classification of data based on the users is important and can be achieved through the Command and Query Responsibility Segregation (CQRS)
- Performing constant monitoring over external and internal APIs
  - Monitor the architecture constantly and fix any flaw when detected.
- Data stores should be separated for each microservice
  - Minimizing data tables to optimize load
- For each microservice, there should be an isolated build.
- Deploy microservices into containers.
- Servers should be treated as stateless.
- **Decentralization** – The first and foremost principle to design microservice architecture is the ability to break down the monolithic architecture into separate individual entities. These entities are known as microservices. These microservices work independent of the other system functions and all users to edit, delete or employ any functionality without affecting the system performance.
- **Scalability** – Microservices are built with an aim in mind: Performance and efficiency. In real-world problem solving, expansion and large-scale systems are crucial to the performance of any microservice ecosystem. Scalability is crucial to design microservice architecture. With the possibility of multiple fragments functioning on multiple technologies, working with larger amounts of data can be a challenge. But, proper implementation and use of Application Controllers can make scalability with microservice architecture possible.
- **Continuous delivery through DevOps Integration** – Those working in DevOps often receive microservice architecture well because of the ease of accessibility and integration of multiple technologies. To design microservice architecture one needs to focus on increasing performance and efficiency of the system. This motivates DevOps to deliver solutions faster. It also offers certain advantages over a traditional monolithic design such as ease of deployability, reliable solutions, scalability, and management. Hence, it forms a major part of the basic principles of design.

- [Reference - Microservices Design and Architecture Patterns - Edureka](https://www.youtube.com/watch?v=xuH81XGWeGQ){:target="_blank"}

## For Effective Collaboration

### Aggregator Pattern

- Multiple microservices, fetching the output and combining it for the end-user is necessary.
- For a user to combine the data, will require immense internal knowledge of the system.
- The solution can be forwarded to the end-user through two major components.
  - The first one is a composite microservice followed by API gateways.
  - Either of them will aggregate the data and forward it to the user.
  - But, in case business capabilities are used in decomposing the system, composite microservice should be preferred.
- Collects related items of data and displays them.
- Based on DRY Principle.

![]({{site.cdn}}/webservices/microservices/aggregator-pattern.png)

### Branch Pattern

- Extend Aggregator design patterns - here request not passed sequentially.
- You can simultaneously process the request and response from 2 mutually exclusive chains of microservices.
- Offers flexibility to summon separate multiple chains or even a single chain in accordance to your business needs.
- used to retrive data from multiple sources.
- In case of an eCommerce website or web application we may need to retrieve data from multiple sources belonging to different microservices. This is where Branch Microservice Design Pattern plays an effective role.

### API Gateway

- Backend for Front-End/ API Gateway
- Fetching user-owned resources from multiple microservices using a single UI can be very tricky.
- API gateway acts as a single entry point for all interactions that takes place within the architecture.
  - can act as a proxy server to route requests to microservices 
  - aggregate results from multiple services and send the output to the user.
  - It can handle multiple protocol requests and convert whenever required. (eg. HTTPS to AMQP and vice versa)
- API gateway also helps to establish security by client authorization and exposing relevant APIs with respect to the client.

## For Performance Monitoring

### Log Aggregation

Monitoring the performance
- helps calculate the efficiency 
- understand drawbacks slowing the system down
- ensuring robustness

**Who creates logs**
- application is consisting a number of microservices.
- run independently and simultaneously
- runs multiple instances
- Every service generates an entry in the logs regarding its execution.

**How can you keep a track for numerous service related logs?**
- This is where log aggregation steps in.
- Best practice to prevent from chaos, have a master logging service.
- This master logging service should be responsible for aggregating the logs from all the microservice instances.
- This centralized log should be searchable, making it easier to monitor.

### Semantic Monitoring

- Synthetic Monitoring a.k.a Semantic Monitoring
- With simultaneous execution of hundreds of services it becomes troublesome to pinpoint the root area responsible for the failure in log registry.
- When you perform automated test then synthetic monitoring helps to regularly map the results in comparison to the production environment.
- User gets alerted if a failure is generated.
- Using Semantic Monitoring you can aim for 2 things
  - Monitoring automated test cases.
  - Detecting Production failures in terms of business requirements.

### API Health Check

- APIs serve as the building blocks of an online connectivity.
- It is imperative to keep a health check on your APIs on regular basis to realize any roadblock.
- It is often observed that a microservice is up and running yet incapacitated for handling requests. This can be due to many factors:
  - Server Loads
  - User Adoption
  - Latency
  - Error Logging
  - Market Share
  - Downloads
- A service registry periodically appeals to the health check API endpoint to perform a health scan.
  - `HTTP /health`
- health check would provide information
  1. A logic that is specific to your application.
  2. Status of the host.
  3. Status of the connections to other infrastructure or connection to any service instance.

## For Breaking down to Business Capability (Decomposition Patterns)

### Microservice per Business Capability

Successful microservice
- loose coupling
- high cohesion - keeping the function of similar interests together
- ***Define the scope of a microservice to support a specific business capability.***
- **For Example** - Separate services for Orders, Products and Customers

### Around similar Business Capability

- Despite segregating on the basis of business capabilities, microservices often come up with a greater challenge.
- What about the common classes among the services? Well, decomposing these classes known as ‘God Classes’ needs intervention.
  - For example, in case of an e-commerce system, the order will be common to several services such as order number, order management, order return, order delivery etc. 
- To solve this issue, we turn to a common microservice design principle known as Domain-Driven Design (DDD).
- In Domain-Driven Design, we use subdomains.
- These subdomain models have defined scope of functionality which is known as bounded context.
- This bounded context is the parameter used to create each microservice thus overcoming the issues of common classes.

### Strangler Vine Pattern

- Struggle of converting a monolithic system to design microservice architecture.
  - Without hampering the working, converting can be extremely tough.
- To solve this problem we have the strangler pattern, based on the vine analogy.
- Strangler pattern is extremely helpful in case of a web application where breaking down a service into different domains is possible.
- Since the calls go back and forth, different services live on different domains. So, these two domains exist on the same URI.
- Once the service has been reformed, it **‘strangles’** the existing version of the application.
- This process is followed until the monolith doesn’t exist.

## For Optimizing Database Storage

### Individual Database per Service

- Usually applied in Domain Driven Designs.
- One database per service articulates the entire database to a specific microservice.
- Due to the challenges and lack of accessibility, a single database per service needs to be designed.
- This data is accessible only by the microservice.
- This database has limited access for any outside microservices.
- The only way for others to access this data is through microservice API gateways.

### Shared Database per Service

- In Domain Driven Design, a separate database per service is feasible, but in an approach where you decompose a monolithic architecture to microservice, using a single database can be tough.
- So while the process of decomposition goes on, implementing a shared database for a limited number of service is advisable.
- This number should be limited to 2 or 3 services.
- This number should stay low to allow deployment, autonomy, and scalability.
- Drawbacks
  - Duplication of data and consistency.
  - transaction requires query data from multiple services.
  - Denormalization of data is not easy.

### Event Sourcing Design Pattern

- How can you rely on the architecture to make a change or publish a real-time event with respect to the changes in state of the application?
- Event sourcing helps to come up from this situation by appending a new event to the list of the events every time a business entity changes its state.
- Entities like Customer may consist of numerous events.
- It is thus advised that an application saves a screenshot of the current state of an entity in order to optimize the load.
- Creates events regarding the changes in the application state.

### Command Query Responsibility Segregation (CQRS)

- In a database-per-service model, the query cannot be implemented because of the limited access to only one database.
- For a query, the requirements are based on joint database systems. But how do we query then?
- Based on the CQRS, to query single databases per service model, the application should be divided into two parts: Command and Query.
- In this model, command handles all requests related to create, update and delete while queries are taken care of through a materialized view.
- These views are updated through a stream of events.
- These events, in turn, are created using an event sourcing pattern which marks any changes in the data. These changes eventually become events.

## For Seamless Deployment

### Service Discovery

- The use of containers leads to dynamic allocation of the IP address.
- This means the address can change at any moment causing a service to break.
- In addition to this, the users have to bear the load of remembering every URL for the services, which become tightly coupled.
- To solve this problem and give users the location of the request, a registry needs to be used.
- While initiation, a service instance can register in the registry and de-register while closing.
- This enables the user to find out the exact location which can be queried.
- In addition, a health check by the registry will ensure the availability of only working instances.
- This also improves the system performance.

### Blue-Green Deployment

- In a microservice design pattern, there are multiple microservices.
- Whenever updates are to be implemented or newer versions deployed, one has to shut down all the services.
- This leads to a huge downtime thus affecting productivity.
- To avoid this issue, when you design microservice architecture, you should use the blue-green deployment pattern.
- In this pattern, two identical environments run parallelly, known as blue and green.
- At a time only one of them is live and processing all the production traffic.
- For example, blue is live and addressing all the traffic.
- In case of new deployment, one uploads the latest version onto the green environment, switches the router to the same and thus implement the update.

## Chain of responsibility

* produces a single output which is combination of mltiple chanied outputs.
* Use synchronous http request or response for messaging.
* Disadvantage - No output till all services in chain gives response, also cascading failures hence client waits for long without any response.

### Asynchronous Messaging Pattern

* All services can communicate with each other, but they don't have to communicate with each other sequencially.
* Fixes disadvantage for "Chain of responsibility", Client doesn't wait for long.
* Service A sends call to Service B and C through queue.

## SAGA Transaction Pattern

- [Microservices Using the Saga Pattern](https://dzone.com/articles/microservices-using-saga-pattern#:~:text=The%20Saga%20Pattern%20is%20as,perform%20the%20next%20local%20transaction.){:target="_blank"}

- The Saga Pattern is as microservices architectural pattern to implement a transaction that spans multiple services.
- A saga is a sequence of local transactions.
- Each service in a saga performs its own transaction and publishes an event.
- The other services listen to that event and perform the next local transaction.
- If one transaction fails for some reason, the saga also executes compensating transactions to undo the impact of the preceding transactions.

### Types
- **Orchestration-Based Saga**
  - In this approach, there is a Saga orchestrator that manages all the transactions and directs the participant services to execute local transactions based on events. This orchestrator can also be though of as a Saga Manager.
- **Choreography-Based Saga**
  - In this approach, there is no central orchestrator. Each service participating in the Saga performs their transaction and publish events. The other services act upon those events and perform their transactions. Also, they may or not publish other events based on the situation.

## Service Mesh (Sidecar Pattern) - Control Plane and sidecar plane

# Microservices Authentication

**What Is OAuth?**  
Open Authorization Protocol, otherwise known as OAuth, helps to access client applications using third-party protocols like Facebook, GitHub, etc., via HTTP. You can also share resources between different sites without the requirement of credentials.
OAuth allows the account information of the end user to be used by a third-party like Facebook while keeping it secure (without using or exposing the user’s password). It acts more like an intermediary on the user’s behalf while providing a token to the server for accessing the required information.

**What Are the Different Types of Two-Factor Authentication?**  
There are three types of credentials required for performing two-factor authentication.
1.	A thing that you know – like password or pin or screen lock pattern.
2.	A physical credential that you have – like OTP or phone or an ATM card, in other words, any kind of credential that you have in an external or third-party device.
3.	Your physical identity – like voice authentication or biometric security, like a fingerprint or eye scanner.

**What Is a Client Certificate?**  
This is a type of digital certificate usually used by client systems for making a request that is authenticated by a remote server. It plays an important role in authentication designs that are mutual and provides strong assurance of the identity of a requester. However, you should have a fully configured backend service for authenticating your client certificate.

# Microservices Testing

**Explain three types of Tests for Microservices?**  
In Microservice architecture tests are divided into three broad categories:
-	At the bottom level test, we can perform a general test like performance and unit tests. These kinds of tests are entirely automated.
-	At the middle level, we can perform exploratory tests like the stress tests and usability tests.
-	At the top level, we can conduct acceptance tests which are mostly fewer in numbers. It also helps stakeholders to know about different software features.

**What Are Some Major Roadblocks for Microservices Testing?**  
Talking about the cons, here is another one of the microservices interview questions you may be ready for, will be around the [challenges faced while testing microservices](https://www.lambdatest.com/blog/testing-challenges-related-to-microservice-architecture/).
-	Testers should have a thorough understanding of all the inbound and outbound processes before they start writing the test cases for integration testing.
-	When independent teams are working on different functionalities, collaboration can prove to be quite a struggling task. It can be tough to find an idle time-window to perform a complete round of [regression testing]( https://www.lambdatest.com/blog/regression-testing-strategies-of-mobile-web-pages/).
-	With an increasing number of microservices, the complexity of the system also increases.
-	During the transition from monolithic architecture, testers must ensure that there is no disruption between the internal communication among the components.

**How Would You Perform Security Testing on Microservices?**  
Before answering this microservices interview question, explain to the interviewer that microservices cannot be tested as a whole. You will need to test the pieces independently. There are three common procedures:
-	**Code scanning** – To ensure that any line of code is bug-free and can be replicated.
-	**Flexibility** – The security solution should be flexible so that it can be adjusted as per the requirements of the system.
-	**Adaptability** – The security protocols should be flexible and updated to cope up with the new threats by hackers or security breaches.
You can also check out this article explaining the [influence of Microservices architecture on security]( https://www.lambdatest.com/blog/does-microservices-architecture-influence-security-testing/).

# Domain Driven Design

**Define Domain Driven Design**  
The main focus is on the core domain logic. Complex designs are detected based on the domain’s model. This involves regular collaboration with domain experts to resolve issues related to the domain and improve the model of the application. While answering this microservices interview question, you will also need to mention the core fundamentals of DDD. They are:
-	DDD focuses mostly on domain logic and the domain itself.
-	Complex designs are completely based on the domain’s model.
-	To improve the design of the model and fix any emerging issues, DDD constantly works in collaboration with domain experts.

**Why there is a need for DDD (Domain Driven Design)?**  
A domain-driven design is necessary for the following reasons.
-	Maintainability and Testability
-	Reducing Complexity
-	Knowledge-Rich Designs
-	More focused on context
-	Following the ubiquitous language
-	Mapping with domains.
-	Bringing business and domains together.

**What Do You Mean by Bounded Context?**  
A central pattern is usually seen in domain driven design. Bounded context is the main focus of the strategic design section of DDD. It is all about dealing with large teams and models. DDD works with large models by disintegrating them into multiple bounded contexts. While it does that, it also explains the relationship between them explicitly.

**What Is Conway's Law?**
Conway’s Law states, “organizations which design systems … are constrained to produce designs which are copies of the communication structures of these organizations.”

Now question is, how is Conway's Law related to microservices. Well, some loosely coupled APIs form the architecture of microservices. The structure is well suited to how a small team is implementing components which are autonomous. This architecture makes an organization much more flexible in restructuring its work process.

**How can you define the Ubiquitous Language for Microservices?**  
This is a specific language that can be used by developers or users to define every domain in detail. This is a crystal-clear language that brings all the team members together on the same page and translated so well that a machine can understand quickly.

# Microservice Architecture - Sample Application

![]({{site.cdn}}/webservices/microservices/microservices-virtual-network.png)

![]({{site.cdn}}/webservices/microservices/microservices-architecture-example-1.png)

![]({{site.cdn}}/webservices/microservices/microservices-architecture-example-2.png)

# Monitoring

**Why Would You Need Reports and Dashboards in Microservices?**  
Reports and dashboards are mainly used to monitor and upkeep microservices. There are multiple tools that help to serve this purpose. Reports and dashboards can be used to:
-	Find out which microservices expose what resources.
-	Find out the services which are impacted whenever changes in a component occur.
-	Provide an easy point which can be accessed whenever documentation is required.
-	Versions of the components which are deployed.
-	To obtain a sense of maturity and compliance from the components.

**Explain the term ‘Continuous Monitoring’?**  
Continuous monitoring is a method which is used for searching compliance and risk issues associated with a company’s operational and financial environment. It contains human, processes, and working systems which support efficient and actual operations.

**What Is Semantic Monitoring?**  
-	It combines monitoring of the entire application along with automated tests. The primary benefit of Semantic Monitoring is to find out the factors which are more profitable to your business.
-	Semantic monitoring along with service layer monitoring approaches monitoring of microservices from a business point of view. Once an issue is detected, they allow faster isolation and bug triaging, thereby reducing the main time required to repair. It triages the service layer and transaction layer to figure out the transactions affected by availability or poor performance.

**How Will You Monitor Multiple Microservices For Various Indicators Like Health?**  
Spring Boot provides actuator endpoints to monitor metrics of individual microservices. These endpoints are very helpful for getting information about applications like if they are up, if their components like database etc are working good. But a major drawback or difficulty about using actuator enpoints is that we have to individually hit the enpoints for applications to know their status or health. Imagine microservices involving 50 applications, the admin will have to hit the actuator endpoints of all 50 applications. To help us deal with this situation, we will be using open source project located at Built on top of Spring Boot Actuator, it provides a web UI to enable us visualize the metrics of multiple applications.

# Spring Cloud

-	Spring Cloud, in microservices, is a system that provides integration with external systems. 
-	It is a short-lived framework that builds an application, fast. 
-	Being associated with the finite amount of data processing, it plays a very important role in microservice architectures.

For typical use cases, Spring Cloud provides the out of the box experiences and a sets of extensive features mentioned below:
-	Versioned and distributed configuration.
-	Discovery of service registration.
-	Service to service calls.
-	Routing.
-	Circuit breakers and load balancing.
-	Cluster state and leadership election.
-	Global locks and distributed messaging.

**What Are The Advantages Of Using Spring Cloud?**  
When developing distributed microservices with Spring Boot we face the following issues-
-	Complexity associated with distributed systems- This overhead includes network issues, Latency overhead, Bandwidth issues, security issues.
-	Service Discovery- Service discovery tools manage how processes and services in a cluster can find and talk to one another. It involves a directory of services, registering services in that directory, and then being able to lookup and connect to services in that directory.
-	Redundancy- Redundancy issues in distributed systems.
-	Loadbalancing- Load balancing improves the distribution of workloads across multiple computing resources, such as computers, a computer cluster, network links, central processing units, or disk drives.
-	Performance issues- Performance issues due to various operational overheads.
-	Deployment complexities- Requirement of Devops skills.

# Spring Cloud Bus

**What is Spring Cloud Bus? Need for it?**

![]({{site.cdn}}/webservices/microservices/spring-cloud-bus.png)

Consider the scenario that we have multiple applications reading the properties using the Spring Cloud Config and the Spring Cloud Config in turn reads these properties from GIT.

Consider the below example where multiple employee producer modules are getting the property for Eureka Registration from Employee Config Module. 

What will happen if suppose the eureka registration property in GIT changes to point to another Eureka server. In such a scenario we will have to restart the services to get the updated properties. There is another way of using Actuator Endpoint **/refresh**. But we will have to individually call this url for each of the modules. 

For example if Employee Producer1 is deployed on port 8080 then call **http://localhost:8080/refresh**. Similarly for Employee Producer2 **http://localhost:8081/refresh** and so on. This is again cumbersome. This is where Spring Cloud Bus comes into picture. 

The Spring Cloud Bus provides feature to refresh configurations across multiple instances. So in above example if we refresh for Employee Producer1, then it will automatically refresh for all other required modules. This is particularly useful if we are having multiple microservice up and running. This is achieved by connecting all microservices to a single message broker. Whenever an instance is refreshed, this event is subscribed to all the microservices listening to this broker and they also get refreshed. The refresh to any single instance can be made by using the endpoint **/bus/refresh**.

**What is Spring Cloud Bus? Need for it?**  
Consider the scenario that we have multiple applications reading the properties using the Spring Cloud Config and the Spring Cloud Config in turn reads these properties from GIT.

Consider the below example where multiple employee producer modules are getting the property for Eureka Registration from Employee Config Module. 

# Spring Cloud Data Flow

**What is Spring Cloud Data Flow? Need for it?**  
Spring Cloud Data Flow is a toolkit to build real-time data integration and data processing pipelines by establishing message flows between Spring Boot applications that could be deployed on top of different runtimes.

Long lived applications require Stream Applications while Short lived applications require Task Applications.

In this example we make use of Stream Applications. Previously we had already developed Spring Cloud Stream applications to understand the concept of [Spring Cloud Stream Source](https://www.javainuse.com/spring/cloud-stream-rabbitmq-1) and [Spring Cloud Sink](https://www.javainuse.com/spring/cloud-stream-rabbitmq-2) and their benefit. 

![]({{site.cdn}}/webservices/microservices/spring-cloud-data-flow.png)

Pipelines consist of Spring Boot apps, built using the Spring Cloud Stream or Spring Cloud Task microservice frameworks. SCDF can be accessed using the REST API exposed by it or the web UI console.

We can make use of metrics, health checks, and the remote management of each microservice application Also we can scale stream and batch pipelines without interrupting data flows. With SCDF we build data pipelines for use cases like data ingestion, real-time analytics, and data import and export. SCDF is composed of the following Spring Projects.

![]({{site.cdn}}/webservices/microservices/spring-cloud-data-flow-modules.png)

## Distributed Transactions

**How will you define the Distributed Transactions?**  
This is the situation where a single event results in the mutation of two or more sources of separate data that cannot be committed automatically.

# Pivotal Cloud Foundry(PCF)

**What is Pivotal Cloud Foundry(PCF)?**  
Some time back all the IT infrastructure was on premises. There we in house servers managed by an IT resource personnel or a service provider.

Then with advent of cloud services these software and hardware services are now delivered over the internet rather than being on premises.

![]({{site.cdn}}/webservices/microservices/spring-cloud.png)

Cloud Foundry is an open source, multi-cloud application platform as a service governed by the Cloud Foundry Foundation. The software was originally developed by VMware and then transferred to Pivotal Software, a joint venture by EMC, VMware and General Electric.

It is a service (PaaS) on which developers can build, deploy, run and scale applications.   
Many Organizations provide the cloud foundry platform separately. For example following are some cloud foundry providers-
-	Pivotal Cloud Foundry
-	IBM Bluemix
-	HPE Helion Stackato 4.0
-	Atos Canopy
-	CenturyLink App Fog
-	Huawei FusionStage
-	SAP Cloud Platform
-	Swisscom Application Cloud

**How to deploy Spring Boot Application to PCF?**  
[Deploying Spring Boot Application to PCF](https://www.javainuse.com/pcf/pcf-hello)

**How to deploy Spring Boot + MySQL Application to PCF?**  
[Pivotal Cloud Foundry Tutorial - Deploying Spring Boot + MySQL Application to PCF](https://www.javainuse.com/pcf/pcf-sql)

**How to deploy Spring Boot + RabbitMQ Application to PCF?**  
[Pivotal Cloud Foundry Tutorial - Deploying Spring Boot + RabbitMQ Application to PCF](https://www.javainuse.com/pcf/pcf-rabbitmq)
