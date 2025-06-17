---
layout: page
title: Webservices
permalink: /webservices
---

- TOC
{:toc}

---

# References
[Web Services Interview Questions]( http://www.softwaretestinghelp.com/web-services-interview-questions){:target="_blank"}

# Introduction

- Any service that is available over the Internet or private (intranet) networks.
- Uses open standards like **XML**(for data tagging), **SOAP**(for message transferring) and **WSDL**(to denote service availability).
- Is not tied to any one operating system or programming language.
- Is self-describing via a common XML grammar.
- Is discoverable via a simple find mechanism.
- Works on client server model where web services are easily accessible to client applications over the network.

**Advantages of web services?**
- **Interoperability** - By the help of web services, an application can communicate with other application developed in any language.
- **Reusability** - We can expose the web service so that other applications can use it.
- **Modularity** - By the help of web service, we can create a service for a specific task such as tax calculation etc.

# SOA - Service Oriented architecture

SOA is a software development model for distributed application components that incorporates discovery, access control, data mapping and security features.

![soa]({{site.cdn}}/webservices/webservices/soa.png)

## Major objectives of SOA
- To structure procedures or software components as loosely coupled services.
- To provide a mechanism for publishing available services, which includes their functionality and input/output (I/O) requirements.
- To control the use of these individual services to avoid security and governance problems.

## SOA Key principles
- Standardized service contract with all the description of the services.
- Loose coupling between the web services and the client.
- Service Abstraction rule, service should not expose the functionality implementation to client application.
- Services should be reusable in order to work with various application types.
- Services should be stateless having the feature of discoverability.
- Services break big problems into little problems and allow diverse subscribers to use the services.

# WS and WSDL Model

WS model of SOA uses
- WSDL to connect interfaces with services.
- SOAP to define procedure or component APIs.

WS principles were used to link applications via an enterprise service bus (ESB), which helped businesses integrate their applications, ensure efficiency and improve data governance.

## Web Service Components
**SOAP - Simple Object Access Protocol**
- XML-based protocol for accessing web services, hence platform and language independent.
- W3C recommendation for communication between applications.

**WSDL - Web Services Description Language**
- XML document containing information about web services such as method name, method parameter and how to access it.
- Acts as an interface between web service applications.
- pronounced as wiz-dull.
- Part of UDDI.

**UDDI - Universal Description, Discovery and Integration**
- XML based framework for describing, discovering and integrating web services.
- Directory of web service interfaces described by WSDL, containing information about web services.
- Contains a list of available web services.

## WSDL (Web service Description Language)

- Simple XML document under Service Description layer of Web Service Protocol Stack.
- Describes the technical details or locates the user interface to web service.
- Few of the important information present in WSDL document are
  * Method name
  * Port types
  * Service end point
  * Method parameters
  * Header information
  * Origin, etc

### WSDL operation response types
- **One-way**: Receives a message but does not return response.
- **Request-Response**: Receives a request and return a response. (most common)
- **Solicit-Response**: Sends a request and wait for a response.
- **Notification**: Sends a message but does not wait for a response.

### Different elements of WSDL documents?
* **Types**: message data types in form of XML schema, used by the web services.
* **Message**: data elements for each operation where messages could be the entire document or an argument that is to be mapped.
* **Port Type**: There are multiple services present in WSDL. Port type defines the collection of operations that can be performed for binding.
* **Binding**: Determines and defines the protocol and data format for each port type.
* **Operations**: defines the operations performed for a message to process the message.

### `<message>` element
- Describes the data that has been exchanged between the consumer and the web service providers.
- Every web service consists of two messages and each message has zero or more `<part>` parameters.
  - Input: Describes the parameter for the web service.
  - Output: Describes the return data from the web service.

### `<definition>` element
root of WSDL document which defines the name of the web service as well as act as a container for all the other elements.

### `<Port>` element
Every port element is related to a specific binding by defining an individual endpoint. Attributes are :
- **Name**:provides the unique name within the WSDL document.
- **Binding**: refers to the process of binding which has to be performed as per the linking rules defined by WSDL.

**What are the points that should be considered by ports while binding?**  
- WSDL allows extensibility elements which are used to specify binding information.
- A port must not
  - Specify more than one address.
  - Specify any binding information other than address information.

**Is binding between SOAP and WSDL possible?**  
- Yes, it is possible to bind WSDL to SOAP by basically two attributes
  - **Name**: Defines the name of the binding.
  - **Type**: Defines the port for the binding.
- For SOAP binding, two attributes need to be declared
  - **Transport**: Defines the SOAP protocol to be used i.e. HTTP.
  - **Style**: This attribute can be ‘rpc’ or ‘document’.

[WSDL Tutorial: Web Services Description Language with Example](https://www.guru99.com/wsdl-web-services-description-language.html)

# How Web Service Works

A web service enables communication among various applications by using open standards such as HTML, XML, WSDL, and SOAP.

A web service takes the help of
* XML to tag the data.
* SOAP to transfer a message.
* WSDL to describe the availability of service.

|Abbrevations|  |
---|---
SOA     |Service Oriented Architecture
SOAP	|Simple Object Access Protocol
WSDL	|Web Services Description Language
WS	    |Web Service
XML	    |Extensible Markup Language
UDDI	|Universal Description, Discovery and Integration

![how-webservices-work]({{site.cdn}}/webservices/webservices/how-webservices-work.png)

- Service Description is published in a directory by all the service providers.
  - Service description is written in a special language called WSDL (Industry accepted).
- Services talk to the directory using SOAP (Industry Standard).
- Consumer service reads the description from the WSDL directory and creates a corresponding request in XML.

## UDDI (Universal Description, Discovery and Integration)

- XML-based standard in the service discovery layer of web service protocol stack.
- Used for publishing and finding web services over the web as it acts like a directory.
- Uses the language known as WSDL (Web Service Description Language).

**UDDI features**
- It is an open framework and is platform independent.
- SOAP, COBRA, and Java RMI protocols are used for communication.
- It helps businesses to discover each other and enable interaction between them over the internet.
- It acts as a database containing all WSDL files.

# Types of Web Services

Web Services are the services available over the web.

|SOAP|REST|
---|---
Simple Object Access Protocol (SOAP)|Representational State Transfer (REST)|
|serves as a standard XML-based protocol for web service creation.| An architectural style for web service creation.
Medium – HTTP (POST), even get, delete etc are done via POST|Medium – HTTP (POST, GET, PUT, DELETE)
Data Format – XML|Data Format – HTML,XML, JSON, Plain Text
SOAP can't use REST because it is a protocol.|REST can use SOAP web services because it is a concept and can use any protocol like HTTP, SOAP.
SOAP uses services interfaces to expose the business logic.|REST uses URI to expose business logic.
JAX-WS is the java API for SOAP WS.|JAX-RS is the java API for RESTful WS.
SOAP defines standards to be strictly followed.|REST does not define too much standards like SOAP and is loosely coupled.
SOAP requires more bandwidth and resource than REST.|REST requires less bandwidth and resource than SOAP.
SOAP defines its own security.|RESTful web services inherits security measures from the underlying transport.
SOAP is less preferred than REST.|REST more preferred than SOAP.
W3C recommendation for communication between two applications.||

## Soap Web Services
**Advantages**
* WS Security: SOAP defines its own security.
* Language and Platform independent
* Firewall : SOAP allows you to get around firewalls.
* It allows circulation of messages in distributed and decentralized environment.

**Disadvantages**
* Slow: XML parsing,slow and consumes more bandwidth and resource.
* WSDL dependent: SOAP uses WSDL and doesn't have any other mechanism to discover the service.

### RESTful Web Services
**Advantages**
* Fast: No strict specification like SOAP.
    - It consumes less bandwidth and resource.
* Language and Platform independent
* Can use SOAP: RESTful web services can use SOAP web services as implementation.
* Permits different data format: RESTful web service permits different data format - Plain Text, HTML, XML and JSON.

# RESTful Web Services

- Representational State Transfer
- Stateless client-server architectural style for developing application accessed over the web.
- **RESTful Web services** - When web services use HTTP methods to implement the concept of REST architecture.
- In this architectural style, data and functionality are served as resources and is accessed by URI (Uniform Resource Identifiers).
- **Resource**
  - Fundamental concept having a type and relationship with other resources.
  - In REST architecture, each content is considered as the resource and they are identified by their URIs.
  - Resources are represented with the help of XML, JSON, text etc in RESTful architecture.

RESTful web services enable web services to work best by inducing properties like
* Performance
* Scalability
* Modifiability

HTTP methods supported
- **GET**: Read-only access to the resource.
- **PUT**: Creation of new resource.
- **DELETE**: Removal of a resource.
- **POST**: Update of an existing resource.
- **OPTIONS**: Get supported operations on the resource.
- **HEAD**: Returns HTTP header only, nobody.

**What is the purpose and format of URI in REST architecture?**
Purpose of URI is to locate resources on the server that are hosting web services.
```
<protocol>://<service-name>/<ResourceType>/<ResourceID>
```

**Explain the term statelessness in terms of RESTful web services?**
- **Statelessness** : REST architecture restriction where a REST web service is not allowed to keep a client state on the server.
- In such situation, the client passes its context to the server and in turn, the server stores the context in order to process client’s further requests.
- **Advantages of statelessness**
  - Each and every method requests are treated independently.
  - Application design is simplified as it does not maintain client’s previous interaction.
  - Works with HTTP protocol as it shares the feature of being statelessness.
- **Disadvantage of statelessness**
  - Every time client interaction takes place, web services are to be provided with extra information about each request so that they can interpret the client’s state.

**For designing a secure RESTful web service, what are the best factors that should be followed?**
- Perform validation of all inputs on the server from SQL injection attacks.
- Perform user’s session based authentication whenever a request is made.
- Never use sensitive data like username, session token password, etc through URL. These should be passed via POST method.
- Methods like GET, POST, PUT, DELETE, etc should be executed with proper restrictions.
- HTTP generic error message should be invoked wherever required.

# Core components of HTTP request and HTTP response

|HTTP Requests	|Meaning/work|
|---|---|
|Verb	|Indicate HTTP methods like GET, PUT, POST, etc
URI	|Identifies the resource on server|
|HTTP Version	|Indicates version.|
|Request Header	|Contains metadata like client type, cache settings, message body format, etc for HTTP request message.|
|Request Body	|Represents content of the message.|

|HTTP Response	|Meaning/work|
|---|---|
|Status/Response code|Indicates the status of the server for requested resource.|
|HTTP version	|Represents HTTP version.|
|Response Header	|Consists of metadata like content length, content type, server length, etc for HTTP response message.|
|Response Body	|Represents response message content.|

# SOAP Web Services

**SOAP based web services development approaches**
- **Contract-first approach**: The contract is defined first by XML and WSDL and then java classes are derived from the contract. **(Preferred)**
- **Contract-last approach**: Java classes are defined first and then the contract is generated which is usually the WSDL file from the java class.

One of the major hindrance observed by users of SOAP is the ‘Firewall security mechanism’.
- In this case, all the HTTP ports except those which bypass firewall are locked.
- In some cases, a technical issue of mixing specification of message transport with message structure is also observed.

|Elements of a SOAP message||
|---|---|
Envelope	|This element is defined as the mandatory root element. It translates the XML document and determines the start and end of the SOAP message.
Header	|This element contains the optional header attributes of the message that contains specific information of the application. This element can occur multiple times and are intended to add new features and functionalities.
Body	|This element is mandatory and contains the call and response messages. It is also defined as the child element of the envelope containing all the application derived XML data that has been exchanged as a part of SOAP message.
Fault element	|Errors that occur during processing of the messages are handled by the fault element. If the error is present, then this element appears as a child element of the body. However, there can only be one fault block.

## Characterstics of SOAP envelope element
- SOAP envelope is a packaging mechanism.
- Every Soap message has a mandatory root envelope message.
- Only one body element is allowed for each envelope element.
- As the SOAP version changes, envelope changes.
- If the header element is present, it should appear as the first child.
- Prefix ENV and envelope element is used for specification.
- A namespace and an optional encoding style are used for optional SOAP encoding.

## Few syntax rules applicable for SOAP message
- Must be encoded using XML.
- Must use the SOAP envelope namespace.
- Must use the SOAP encoding namespace.
- Must not contain the DTD reference.
- Must not contain XML processing instructions.

# Web Service Protocols Layers

1. **Service transport**
- First layer which helps in transporting XML messages between various client applications.
- This layer commonly uses the below-mentioned protocols:
	- HTTP(Hypertext Transport Protocol)
	- SMTP(Simple Mail Transport Protocol)
	- FTP(File Transfer Protocol)
	- BEEP(Block Extensible Exchange Protocol)

2. **XML messaging**
- This layer is based on the XML model where messages are encoded in common XML format which is easily understood by others.
- This layer includes
	- XML-RPC
	- SOAP(Simple Object Access Protocol)

3. **Service description**
- This layer contains description like location, available functions, and data types for XML messaging which describes the public interface to a specific web service.
- This layer includes:
    - WSDL(Web Service Description Language)

4. **Service discovery**
- This layer is responsible for providing a way to publish and find web services over the web.
- It is used for centralizing services into a common registry and providing easy publish/find functionality.
- This layer includes:
    - UDDI(Universal Description, Discovery, and Integration)

## Explain BEEP
- Blocks Extensible Exchange Protocol.
- BEEP is determined as Building new protocols for the variety of applications such as instant messaging, network management, file transfer etc.
- It is termed as new Internet Engineering Task Force (IETF) which is layered directly over TCP. 

It has some built-in features like
- Authentication
- Security
- Error handling
- Handshake Protocol

# Web Services Security

To ensure reliable transactions and secure confidential information, web services requires very high level of security which can be only achieved through **Entrust Secure Transaction Platform**.

**Security issues for web services**
1. **Confidentiality**: A single web service can have multiple applications and their service path contains a potential weak link at its nodes. Whenever messages or say XML requests are sent by the client along with the service path to the server, they must be encrypted. Thus, maintaining the confidentiality of the communication is a must.
2. **Authentication**: Authentication is basically performed to verify the identity of the users as well as ensuring that the user using the web service has the right to use or not? Authentication is also done to track user’s activity. There are several options that can be considered for this purpose
	- Application level authentication
	- HTTP digest and HTTP basic authentication
	- Client certificates
3. **Network Security**: This is a serious issue which requires tools to filter web service traffic.

## Foundation security services
consist of the following
- Integration
- Authentication
- Authorization
- Digital Signatures
- Encryption processes

## Entrust Identification Service
- Categorized under Entrust Secure Transaction Platform which provides essential security capabilities to ensure secure transactions.
- This usually allows companies to fully control the identities that are trusted to perform web service transactions.

## Entrust Entitlements Service
- Entrust Entitlement service is those whose task is to verify the services that are attempting to access the web services.
- It basically ensures security in business operations as well as some authentication services.

### What is Entrust Privacy Service?
- As the name suggests, Entrust Privacy Service perform encryption of the data so that only concerned parties are able to access the data.
- It basically deals with two factors
  - Confidentiality
  - Security

# Jersey JAXB

- Jersey Framework is a development toolkit for client-server communication with standard implementations as Java APIs.
- Example - JSR 311 & JSR 339

## Java Architecture for XML Binding (JAXB)
- Java standard that defines how Java objects are converted from and to XML.
- It uses a standard set of mappings.
- JAXB defines an API for reading and writing Java objects to and from XML documents.
- As JAXB is defined via a specification, it is possible to use different implementations for this standard.
- JAXB defines a service provider which allows the selection of the JAXB implementation.

## JAX-WS
- Meant for XML based web services such as SOAP.
- eared towards server to server interactions with well defined contracts (WSDLs) and usually when the service and client side are from separate groups.
- It is very resource intensive so it isn’t feasible for client-to-server interactions where the network or client device capability is less than optimal.

## JAX-RS
- JAX-RS is geared towards client to server interactions, although server-to-server is okay.
- As it has little service obligations, it can be tuned to whatever the client needs are.
- JAX-RS supports the automatic creation of XML and JSON via JAXB.

# JSESSIONID

**When / what are the conditions when a JSESSIOINID is created?**
Is it per a domain? For instance, if I have a Tomcat app server, and I deploy multiple web applications, will a different JSESSIONID be created per context (web application), or is it shared across web applications as long as they are the same domain?

Answer:
- SESSIONID cookie is created/sent when session is created. Session is created when your code calls request.getSession() or request.getSession(true) for the first time. 
- If you just want to get the session, but not create it if it doesn't exist, use request.getSession(false) -- this will return you a session or null. 
- In this case, new session is not created, and JSESSIONID cookie is not sent. 
- (This also means that session isn't necessarily created on first request... you and your code are in control when the session is created)

Sessions are per-context:

SRV.7.3 Session Scope
HttpSession objects must be scoped at the application (or servlet context) level. The underlying mechanism, such as the cookie used to establish the session, can be the same for different contexts, but the object referenced, including the attributes in that object, must never be shared between contexts by the container.(Servlet 2.4 specification)

Update: Every call to JSP page implicitly creates a new session if there is no session yet. 
- This can be turned off with the session='false' page directive, in which case session variable is not available on JSP page at all.
- you can disable the setting of JSESSIONID by a JSP , <%@ page session="false" %>.

# FAQ

## Do we require any special application to access web service?
- No need of installing any application for accessing web services.
- Only requirement for accessing web services from any application is that it must support XML-based request and response. 

## What tools are used to test web services?
- SoapUI tool for testing SOAP and RESTful web services
- Poster for firefox browser
- Postman extension for Chrome
- REST client
- JMeter

**SOAPUI**
SOAPUI is an open-source, free and cross-platform functional testing solution. Mentioned below are some actions performed by SOAPUI
- It can help create functional, security and load testing test suites.
- Data driven testing and scenario based testing is also performed.
- It has the ability to impersonate web services as well as has got built-in reporting abilities.

## Explain the loosely coupled architecture of web services.
- A consumer of a web service is not tied to that web service directly.
- The web service interface can change over time without compromising the client's ability to interact with the service.
- A tightly coupled system implies that the client and server logic are closely tied to one another, implying that if one interface changes, the other must be updated.
- Adopting a loosely coupled architecture tends to make software systems more manageable and facilitates simpler integration between different systems.

## What are the advantages of having XML based Web services?
- Using XML eliminates any networking, operating system, or platform binding.
- Web Services based applications are highly interoperable application at their core level.

## What do you mean by synchronicity?
- Synchronicity is used to bind the client to the execution of the service.
- In synchronous invocations, the client blocks and waits for the service to complete its operation before continuing.
- On the other hand, synchronous operations facilitate a client to invoke a service and then execute other functions.
