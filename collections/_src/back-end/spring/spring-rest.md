---
layout: page
title: Spring Rest
permalink: /spring/rest
---

- TOC
{:toc}

---

# References
- [Spring Annotations (Quick Reference)](https://springframework.guru/spring-framework-annotations){:target="_blank"}

# Introduction

- SOAP (Simple Object Access Protocol)
  - typically focus on actions and processing
  - Envelop - Header + Body
  - xml based
- **Representational State Transfer (REST)**
  - concern is with the data being handled.
  - **Representational**
    - REST resources can be represented in virtually any form
    - XML, JSON (JavaScript Object Notation), or HTML
  - **State** - concerned with the state of a resource.
  - **Transfer** - transferring resource data from one application to another.
- HttpMethods
  - Create - POST - non-idempotent
  - Read - GET
  - Update - PUT or PATCH
  - Delete - DELETE
- representation best suited for the client can be chosen using **ContentNegotiatingViewResolver**.
- **@RequestBody** along with HttpMethodConverter implementations
  - can convert inbound HTTP data into Java objects passed into controller handler methods.
- **@ResponseBody** along with HttpMethodConverter implementations.
  - bypass view-based rendering
  - resturn response as json.
- Spring applications can consume REST resources using RestTemplate.

![spring-rest-diagram-2]({{site.cdn}}/spring/spring-rest/spring-rest-diagram-2.png){:target="_blank"}

# Creating REST endpoint

- Controllers deal with resources in terms of the Java objects.
- Spring offers two options to transform a resource into the required representation by client: 
  - **Content negotiation** - A view is selected that can render the model into a representation to be served to the client.
  - **Message conversion** - A message converter transforms response object into a representation required by the client.

```
/spittles/456?max=100&count=10
```
```java
@Controller
@RequestMapping("/spittles")
public class SpittleController {

    private static final String MAX_LONG_AS_STRING = "9223372036854775807";
    
    @Autowired
    private SpittleRepository spittleRepository;

    @RequestMapping(
        value={"/{id}","/{id}/show"},
        method={RequestMethod.POST, RequestMethod.GET},
        produces={"application/json", "application/xml"},
        consumes="text/html"
      )
    @ResponseBody
    public List<Spittle> spittles(
        @PathVariable("id") int id,
        @RequestParam(value = "max", defaultValue = MAX_LONG_AS_STRING, required=false) long max,
        @RequestParam(value = "count", defaultValue = "20") int count) {
        return spittleRepository.findSpittles(max, count);
    }
}
```

- Annotations
  - @RequestMapping
  - @PathVariable
  - @RequestParam
  - @RequestBody
  - @ResponseBody

## ContentNegotiatingViewResolver

- Controller handler method response is generally a logical view name.
  - If method doesn’t return a logical view name, logical view name is derived from the request’s URL.
  - DispatcherServlet passes view name to view resolver to render the results of the request.
- **ContentNegotiatingViewResolver**
  - view resolver that takes the content type that the client wants into consideration.
- Content-negotiation two-step:
  - Determine the requested media type(s).
  - Find the best view for the requested media type(s).

```java
@Bean
public ViewResolver cnViewResolver(){
    return new ContentNegotiatingViewResolver();
}
```

### ContentNegotiatingViewResolver Limitation
- can only determine how a resource (controller response) is rendered to a client.
- has no say in what representations a controller can consume.
- The View chosen renders the model—not the resource—to the client.
  - client requests list of Spittle objects in JSON, But model is a map of key-value pairs.
- ***Instead, Use Spring message converters for producing resource representations.***

### Identify Requested Media Type

- **ContentNegotiatingViewResolver**
  - first looks at the URL’s file extension.
  - then, considers Accept header is considered as MIME type(s).
  - Accept header can’t always be deemed reliable.
  - Eventually, falls back to `/` as default content type, client has to take whatever representation the server sends it.
- ContentNegotiatingViewResolver delegates to other view resolvers.
  - Every view resolved is added to a list of candidate views.
  - It cycles through all requested media types, trying to find from candidate views that produces a matching content type.
  - The first match found is the one that’s used to render the model.

```
.json -> application/json
.xml -> application/xml
.html -> text/html
```

## ContentNegotiationManager Configuration

- Specify default content type.
  - Specify content type via request parameter.
  - Ignore the request’s Accept header.
- Map request extensions to specific media types.
  - Use the Java Activation Framework (JAF) as a fallback option for looking up media types from extensions.
- Three ways to configure a ContentNegotiationManager:
  - Create bean of type ContentNegotiationManager.
  - Create bean indirectly via ContentNegotiationManagerFactoryBean.
  - Override configureContentNegotiation() method of WebMvcConfigurerAdapter.

For Java configuration
- easiest way to get a ContentNegotiationManager is to extend WebMvcConfigurerAdapter and override configureContentNegotiation().

```java
@Override
public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
    configurer.defaultContentType(MediaType.APPLICATION_JSON);
}
```

- If logical view name is `spittles`, configured BeanNameViewResolver resolves the View declared in the spittles() method.
- That’s because the bean name matches the logical view name.
- Otherwise, unless there’s another matching View, ContentNegotiatingViewResolver falls back to the default, serving HTML.

```java
@Bean
public ViewResolver cnViewResolver(ContentNegotiationManager cnm) {
    ContentNegotiatingViewResolver cnvr = new ContentNegotiatingViewResolver();
    cnvr.setContentNegotiationManager(cnm);
    return cnvr;
}

@Bean
public ViewResolver beanNameViewResolver() {
    return new BeanNameViewResolver();
}

@Bean
public View spittles() {
    return new MappingJackson2JsonView();
    // method name and logical view name matched and used by BeanNameViewResolver
}

@Override
public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
    configurer.defaultContentType(MediaType.TEXT_HTML);
}
```

## HttpMessageConverters

- Message conversion
  - more direct way to transform data produced by a controller into a representation served to a client.
  - data produced by controller, and message converter transforms that data.
- application/json
  - Jackson JSON library on classpath,
  - **MappingJacksonHttpMessageConverter** 
- text/xml
  - **Jaxb2RootElementHttpMessageConverter**
- HttpMessageConverter - 5 are registered by default without additional configuration.

|Message converter|	Description|
|---|---|	
|AtomFeedHttpMessageConverter|	Converts Rome Feed objects to and from Atomfeeds (media type application / atom+xml).|
|BufferedImageHttpMessageConverter|	Registered if the Rome library is present on the classpath. Converts BufferedImage to and from image binary data.|
|ByteArrayHttpMessageConverter|	Reads and writes byte arrays. Reads from all media types (*/*), and writes as application/octet-stream.|
|FormHttpMessageConverter|	Reads content as application/x-www-form-urlencoded into a MultiValueMap\<String,String>. Also writes MultiValueMap\<String,String> as application/x-www-form-urlencoded and MultiValueMap\<String, Object> as multipart/form-data.|
|Jaxb2RootElementHttpMessageConverter|	Reads and writes XML (either text/xml or application/xml) to and from JAXB2-annotated objects. Registered if JAXB v2 libraries are present on the classpath.|
|MappingJacksonHttpMessageConverter|	Reads and writes JSON to and from typed objects or untyped HashMaps. Registered if the Jackson JSON library is present on the classpath.|
|MappingJackson2HttpMessageConverter|	Reads and writes JSON to and from typed objects or untyped HashMaps. Registered if the Jackson 2 JSON library is present on the classpath.|
|MarshallingHttpMessageConverter|	Reads and writes XML using an injected marshaler and unmarshaler. Supported (un)marshalers include Castor, JAXB2, JIBX, XMLBeans, and XStream.|
|ResourceHttpMessageConverter|	Reads and writes org.springframework.core.io.Resource.|
|RssChannelHttpMessageConverter|	Reads and writes RSS feeds to and from Rome Channel objects. Registered if the Rome library is present on the classpath.|
|SourceHttpMessageConverter|	Reads and writes XML to and from javax.xml.transform.Source objects.|
|StringHttpMessageConverter|	Reads all media types (*/*) into a String. Writes String to text/plain.|
|XmlAwareFormHttpMessageConverter|	An extension of FormHttpMessageConverter that adds support for XML-based parts using a SourceHttpMessageConverter.|

## @RestController
- @RestController instead of @Controller
  - Spring applies message conversion to all handler methods in the controller.
  - You don’t need to annotate each method with @ResponseBody.
- Defaulting Controllers For Message Conversion
- Available from Spring 4.0

### @RequestBody and @ResponseBody

- @RequestBody - tells Spring message converter to convert request a resource representation coming from a client into an object.
- @ResponseBody - tells Spring message converter to convert response in client required format.

```java
@RequestMapping(
    method=RequestMethod.POST,
    consumes="application/json",
    produces="application/json"
  )
@ResponseBody
public Spittle saveSpittle(@RequestBody Spittle spittle) {
  return spittleRepository.save(spittle);
}
```

- **Content-Type** header set to application/json.
  - client sent the Spittle data in a JSON representation.
  - DispatcherServlet looks for a message converter to convert JSON into Java objects.
    - If Jackson2 library is on the classpath, then **MappingJackson2HttpMessageConverter** is used.
- **Accept** header includes application/json.
  - If Jackson JSON library is on the classpath, then either **MappingJacksonHttpMessageConverter** or **MappingJackson2HttpMessageConverter** will be used.
- By default, Jackson JSON libraries use reflection.

## ResponseEntity

Communicating errors to the client, Spring offers:
-	@ResponseStatus - Status codes.
-	@ExceptionHandler - deal with error cases, leaving controller methods to focus on the happy path. 
- ResponseEntity - carries more metadata concerning the response.
  - Setting headers in response.
  - No need to annotate the method with @ResponseBody if it returns ResponseEntity.
  - **HttpHeaders** - A special implementation of MultiValueMap<String, String>

```java
@ExceptionHandler(SpittleNotFoundException.class)
public ResponseEntity<Error> spittleNotFound(SpittleNotFoundException e) {
  long spittleId = e.getSpittleId();
  Error error = new Error(4, "Spittle [" + spittleId + "] not found");
  return new ResponseEntity<Error>(error, HttpStatus.NOT_FOUND);
}

@RequestMapping(value="/{id}", method=RequestMethod.GET)
public ResponseEntity<Spittle> spittleById(@PathVariable long id) {
  Spittle spittle = spittleRepository.findOne(id);
  if (spittle == null)
    throw new SpittleNotFoundException(id);
  return new ResponseEntity<Spittle>(spittle, HttpStatus.OK);
}
```

POST operation return 201 CREATED, with resource location.
```java
@RequestMapping(method=RequestMethod.POST, consumes="application/json")
public ResponseEntity<Spittle> saveSpittle(@RequestBody Spittle spittle) {
  Spittle spittle = spittleRepository.save(spittle);
  HttpHeaders headers = new HttpHeaders();
  URI locationUri = URI.create("http://localhost:8080/spittr/spittles/" + spittle.getId());
  headers.setLocation(locationUri);
  ResponseEntity<Spittle> responseEntity = new ResponseEntity<Spittle>(spittle, headers, HttpStatus.CREATED);
  return responseEntity;
}
```
- Rather than construct the URI manually, Spring offers UriComponentsBuilder.
  - UriComponentsBuilder is preconfigured with known information such as the host, port, and servlet content.
  - It obtains this foundational information from the request that the handler method is serving.
  - From there, the code builds up the rest of the UriComponents by setting the path.

```java
@RequestMapping(method=RequestMethod.POST, consumes="application/json")
public ResponseEntity<Spittle> saveSpittle(@RequestBody Spittle spittle, UriComponentsBuilder ucb) {
  Spittle spittle = spittleRepository.save(spittle);
  HttpHeaders headers = new HttpHeaders();
  URI uri = ucb.path("/spittles/").path(String.valueOf(spittle.getId())).build().toUri();
  headers.setLocation(uri);
  ResponseEntity<Spittle> responseEntity = new ResponseEntity<Spittle>(spittle, headers, HttpStatus.CREATED);
  return responseEntity;
}
```

## Difference - @Component, @Service, @Repository, @Controller

- @Component
  - specializations - @Service, @Repository, @Controller - stereotype annotations
  - used for automatic bean detection using component-scan.
- used for different classification.
- ***Difference in preprocessor and post processor of each annotation.***
- In a Multitier application, we have layers - presentation, service, business, data access etc.
	- **@Component** – generic and can be used across application.
	- **@Service** – service layer.
	- **@Controller** – presentation layer.
	- **@Repository** – persistence layer.
- @Repository
  - postprocessor automatically looks for all exception translators
    - implementations of the PersistenceExceptionTranslator interface
  - advises all beans marked with the @Repository annotation so that the discovered translators can intercept and apply the appropriate translation on the thrown exceptions.
- Similar to above, in future Spring may choose to add value for @Service, @Controller and @Repository based on their layering conventions.
- To that additional feature advantage its better to respect the convention and use them in line with layers.
- To modify auto-detected behavior, use **include-filter** or **exclude-filter**.

## POST vs PUT vs PATCH

- **Safe Methods** - method never modifies nor changes a resource.
- **Idempotent** - operation performed N number of times, end result is always same.
- HttpMethods
  - GET - Idempotent and Safe
  - POST - none
  - PUT - Idempotent
  - PATCH - Idempotent
  - OPTIONS - Idempotent and Safe
  - HEAD - Idempotent and Safe
  - DELETE - Idempotent

### POST
-	allows us to create a resource.
-	Always create a new house at a different location
  - will always generate a different (unique) system ID.

```
http://domain.com/house

{
  "front_garden": true,
  "back_garden": true,
  "windows": 3,
  "doors": 2,
  "garage": true
}
```

### PUT
-	Replaces complete body for id.
  -	PUT for non-existing, creates new record.

```
http://domain.com/house/1

{
  "front_garden": true,
  "back_garden": true,
  "windows": 13,
  "doors": 3,
  "garage": false
}
```
House with only windows
```
{"windows": 8}
```

### PATCH
- partial update

```
{"windows": 8}
```
```
{
  "front_garden": true,
  "back_garden": true,
  "windows": 8,
  "doors": 3,
  "garage": false
}
```

# Consuming REST resources - RestTemplate

- RestTemplate frees you from the tedium of consuming RESTful resources.
- TRACE not covered by RestTemplate.
- total 36 methods
  - 11 unique operations
    - 10 are overloaded into 3 method variants
    - 11th overloaded 6 times
- execute() and exchange() - lower-level and general-purpose methods for using any of the HTTP methods.
- Overloaded into three method forms:
  - java.net.URI with no support for parameterized URLs.
  - String URL with URL parameters as a Map.
  - String URL with URL parameters as variable argument list.

|Method|	Description|
|---|---|	
|exchange()|	Executes a specified HTTP method against a URL, returning a ResponseEntity containing an object mapped from the response body|
|execute()|	Executes a specified HTTP method against a URL, returning an object mapped from the response body.|
|getForEntity()|	Sends an HTTP GET request, returning a ResponseEntity containing an object mapped from the response body.|
|getForObject()|	Sends an HTTP GET request, returning an object mapped from a response body.|
|postForEntity()|	POSTs data to a URL, returning a ResponseEntity containing an object mapped from the response body.|
|postForLocation()|	POSTs data to a URL, returning the URL of the newly created resource.|
|postForObject()|	POSTs data to a URL, returning an object mapped from the response body.|
|headForHeaders()|	Sends an HTTP HEAD request, returning the HTTP headers for the specified resource URL.|
|optionsForAllow()|	Sends an HTTP OPTIONS request, returning the Allow header for the specified URL.|
|delete()|	Performs an HTTP DELETE request on a resource at a specified URL|
|put()|	PUTs resource data to the specified URL.|

## GET

- can throw unchecked exception - `RestClientException`.

```java
public Profile fetchFacebookProfile(String id) {
  RestTemplate rest = new RestTemplate();
  // getForObject
  Profile profile = rest.getForObject("http://graph.facebook.com/{spitter}", Profile.class, id);
  // getForEntity - with response Http Header and status code
  ResponseEntity<Profile> response = rest.getForEntity("http://graph.facebook.com/{spitter}", Profile.class, id);
  return profile;
}
```

### getForObject
```java
<T> T getForObject(URI url, Class<T> responseType) throws RestClientException;
<T> T getForObject(String url, Class<T> responseType, Object... uriVariables) throws RestClientException;
<T> T getForObject(String url, Class<T> responseType, Map<String, ?> uriVariables) throws RestClientException;
```

### getForEntity
```java
<T> ResponseEntity<T> getForEntity(URI url, Class<T> responseType) throws RestClientException;
<T> ResponseEntity<T> getForEntity(String url, Class<T> responseType,  Object... uriVariables) throws RestClientException;
<T> ResponseEntity<T> getForEntity(String url, Class<T> responseType,  Map<String, ?> uriVariables) throws RestClientException;
```

### Extracting response metadata

```java
responseEntity.getStatusCode() == HttpStatus.NOT_MODIFIED) { 304 }
```

- HttpHeaders 
  - `get("header_key")` - list of string values
  - `getFirst("header_key")` - returns first one.

```java
public List<MediaType> getAccept() { ... }
public List<Charset> getAcceptCharset() { ... }
public Set<HttpMethod> getAllow() { ... }
public String getCacheControl() { ... }
public List<String> getConnection() { ... }
public long getContentLength() { ... }
public MediaType getContentType() { ... }
public long getDate() { ... }
public String getETag() { ... }
public long getExpires() { ... }
public long getIfNotModifiedSince() { ... }
public List<String> getIfNoneMatch() { ... }
public long getLastModified() { ... }
public URI getLocation() { ... }
public String getOrigin() { ... }
public String getPragma() { ... }
public String getUpgrade() { ... }
```

## PUT

```java
void put(URI url, Object request) throws RestClientException;
void put(String url, Object request, Object... uriVariables) throws RestClientException;
void put(String url, Object request, Map<String, ?> uriVariables) throws RestClientException;
```
```java
public void updateSpittle(Spittle spittle) throws SpitterException {
  RestTemplate rest = new RestTemplate();

  String url = "http://localhost:8080/spittr-api/spittles/" + spittle.getId();
  rest.put(URI.create(url), spittle);

  rest.put("http://localhost:8080/spittr-api/spittles/{id}", spittle, spittle.getId());

  Map<String, String> params = new HashMap<String, String>();
  params.put("id", spittle.getId());
  rest.put("http://localhost:8080/spittr-api/spittles/{id}", spittle, params);
}
```

## DELETE

```java
void delete(String url, Object... uriVariables) throws RestClientException;
void delete(String url, Map<String, ?> uriVariables) throws RestClientException;
void delete(URI url) throws RestClientException;
```

```java
public void deleteSpittle(long id) {
  RestTemplate rest = new RestTemplate();
  rest.delete(URI.create("http://localhost:8080/spittr-api/spittles/" + id));
  rest.delete("http://localhost:8080/spittr-api/spittles/{id}", id));
}
```

## POST

```java
public String postSpitterForObject(Spitter spitter) {
  RestTemplate rest = new RestTemplate();

  Spitter spitter = rest.postForObject("http://localhost:8080/spittr-api/spitters", spitter, Spitter.class);

  ResponseEntity<Spitter> response = rest.postForEntity("http://localhost:8080/spittr-api/spitters", spitter, Spitter.class);
  Spitter spitter = response.getBody();
  URI url = response.getHeaders().getLocation();
  
  return rest.postForLocation("http://localhost:8080/spittr-api/spitters",spitter).toString();
}
```

### postForObject
```java
<T> T postForObject(URI url, Object request, Class<T> responseType) throws RestClientException;
<T> T postForObject(String url, Object request, Class<T> responseType, Object... uriVariables) throws RestClientException;
<T> T postForObject(String url, Object request, Class<T> responseType, Map<String, ?> uriVariables) throws RestClientException;
```

### postForEntity
```java
<T> ResponseEntity<T> postForEntity(URI url, Object request, Class<T> responseType) throws RestClientException;
<T> ResponseEntity<T> postForEntity(String url, Object request, Class<T> responseType, Object... uriVariables) throws RestClientException;
<T> ResponseEntity<T> postForEntity(String url, Object request, Class<T> responseType, Map<String, ?> uriVariables) throws RestClientException;
```

### postForLocation
```java
URI postForLocation(String url, Object request, Object... uriVariables) throws RestClientException;
URI postForLocation(String url, Object request, Map<String, ?> uriVariables) throws RestClientException;
URI postForLocation(URI url, Object request) throws RestClientException;
```

## Exchange

- ***set headers on the request sent.***

```java
<T> ResponseEntity<T> exchange(URI url, HttpMethod method, HttpEntity<?> requestEntity, Class<T> responseType) throws RestClientException;
<T> ResponseEntity<T> exchange(String url, HttpMethod method, HttpEntity<?> requestEntity, Class<T> responseType, Object... uriVariables) throws RestClientException;
<T> ResponseEntity<T> exchange(String url, HttpMethod method, HttpEntity<?> requestEntity, Class<T> responseType, Map<String, ?> uriVariables) throws RestClientException;
```

```java
ResponseEntity<Spitter> response = rest.getForEntity("http://localhost:8080/spittr-api/spitters/{spitter}", Spitter.class, spitterId);
Spitter spitter = response.getBody();

ResponseEntity<Spitter> response = rest.exchange("http://localhost:8080/spittr-api/spitters/{spitter}", HttpMethod.GET, null, Spitter.class, spitterId);
Spitter spitter = response.getBody();

MultiValueMap<String, String> headers = new LinkedMultiValueMap<String, String>();
headers.add("Accept", "application/json");
HttpEntity<Object> requestEntity = new HttpEntity<Object>(headers);
ResponseEntity<Spitter> response = rest.exchange( "http://localhost:8080/spittr-api/spitters/{spitter}", HttpMethod.GET, requestEntity, Spitter.class, spitterId);
Spitter spitter = response.getBody();
```

```
GET /Spitter/spitters/habuma HTTP/1.1
Content-Length: 0
User-Agent: Java/1.6.0_20
Host: localhost:8080
Connection: keep-alive
<!-- Default -->
Accept: application/xml, text/xml, application/*+xml, application/json
<!-- When set explicitly -->
Accept: application/json
```

# Handler Mapping

- **HandlerMapping** provides ***HandlerExecutionChain***.
- Then, DispatcherServlet execute the handler and interceptors in the chain (if any).

### BeanNameUrlHandlerMapping (Default)
- Maps incoming HTTP requests to bean names.
- By default, DispatcherServlet creates a BeanNameUrlHandlerMapping if no handler mapping can be found in the context.

```xml
<beans>
  <bean id="handlerMapping" class="org.springframework.web.servlet.handler.BeanNameUrlHandlerMapping"/>
  <bean name="/editaccount.form" class="org.springframework.web.servlet.mvc.SimpleFormController">
    <property name="formView" value="account"/>
    <property name="successView" value="account-created"/>
    <property name="commandName" value="account"/>
    <property name="commandClass" value="samples.Account"/>
  </bean>
<beans>
```

### SimpleUrlHandlerMapping
- configurable in the application context
- has Ant-style path matching capabilities.

```xml
<beans>
    <!-- no 'id' required, HandlerMapping beans are automatically detected by the DispatcherServlet -->
    <bean class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
        <property name="mappings">
            <value>
                /*/account.form=editAccountFormController
                /*/editaccount.form=editAccountFormController
                /ex/view*.html=helpController
                /**/help.html=helpController
            </value>
        </property>
    </bean>
    <bean id="helpController" 
          class="org.springframework.web.servlet.mvc.UrlFilenameViewController"/>
    <bean id="editAccountFormController"
          class="org.springframework.web.servlet.mvc.SimpleFormController">
        <property name="formView" value="account"/>
        <property name="successView" value="account-created"/>
        <property name="commandName" value="Account"/>
        <property name="commandClass" value="samples.Account"/>
    </bean>
<beans>
```

The above two HandlerMappings have below properties :
-	**interceptors**: list of interceptors to use (HandlerInterceptors)
-	**defaultHandler**: default handler to use, when matching handler not found.
-	**order**: Spring sort all handler mappings available in the context by this property and apply the first matching handler.
- **alwaysUseFullPath**:
  - If true, Spring use full path within the current servlet context to find an appropriate handler.
  - If false (default), path within current servlet mapping will be used.
  - servlet `/testing/*`
    - true -> `/testing/viewPage.html`
    - false -> `/viewPage.html`
- **urlDecode**: 
  - default true.
  - If you prefer to compare encoded paths, switch this flag to false.
  - HttpServletRequest always exposes the servlet path in decoded form.
    - Be aware that the servlet path will not match when compared with encoded paths.
- **lazyInitHandlers**
  - Default value is false.
  - allows for lazy initialization of singleton handlers
  - prototype handlers are always lazily initialized.

## HandlerInterceptor

- `org.springframework.web.servlet.HandlerInterceptor` interface - Intercepting requests
  - extremely useful when you want to apply specific functionality to certain requests, for example, checking for a principal. 
- HandlerInterceptor interface defines three methods for pre- and post-processing
  - called before the actual handler will be executed
  - called after the handler is executed
  - called after the complete request has finished.
- **preHandle(..)** returns a boolean value.
  - You can use this method to break or continue the processing of the execution chain.
  - true, handler execution chain will continue
  - false, DispatcherServlet assumes the interceptor itself has taken care of requests and does not continue executing the other interceptors and the actual handler in the execution chain.

```java
public class TimeBasedAccessInterceptor extends HandlerInterceptorAdapter {
    private int openingTime;
    private int closingTime;

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Calendar cal = Calendar.getInstance();
        int hour = cal.get(HOUR_OF_DAY);
        if (openingTime <= hour < closingTime) {
            return true;
        } else {
            response.sendRedirect("http://host.com/outsideOfficeHours.html");
            return false;
        }
    }
}
```
```xml
<beans>
    <bean id="handlerMapping" class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
        <property name="interceptors">
            <list>
                <ref bean="officeHoursInterceptor"/>
            </list>
        </property>
        <property name="mappings">
            <value>
                /*.form=editAccountFormController
                /*.view=editAccountFormController
            </value>
        </property>
    </bean>
    <bean id="officeHoursInterceptor"
          class="samples.TimeBasedAccessInterceptor">
        <property name="openingTime" value="9"/>
        <property name="closingTime" value="18"/>
    </bean>
<beans>
```

- Any request coming in, will be intercepted by the TimeBasedAccessInterceptor, and if the current time is outside office hours, the user will be redirected to a static html file, saying, for example, he can only access the website during office hours.
- Spring has an adapter class (the cunningly named **HandlerInterceptorAdapter**) to make it easier to extend the HandlerInterceptorinterface.

# PropertyPlaceholderConfigurer and ReloadableResourceBundleMessageSource

## PropertyPlaceholderConfigurer 
- Used when we load some property files which is used in applicationcontext.xml of spring.
- We can use the properties directly using JSTL expressions.
- for properties files to be used in the application context or inside the code with with `@value`.
- need to restart your application when making changes
- **ResourceBundleMessageSource** uses a JDK class to do its thing.
  - It delegates to it to load the bundle.
  - ResourceBundle does not know how to handle the classpath: prefix and so it fails.

## ReloadableResourceBundleMessageSource 
- Used when property files are used outside the applicationcontext.xml.
- properties loaded are not accessible in applicationcontext.xml.
- for Internationalization & Localization (i18n) of messages.
- capable of refreshing the messages while the application is running.
- more powerful as you are not limited to bundles on the classpath but you can load files from other locations too.
- **ReloadableResourceBundleMessageSource** knows how to load bundles from other places, not just the classpath.
  - works with a Spring class `Resource`
  - knows how to handle the classpath: prefix.
    
- ReloadableResourceBundleMessageSource is more advance than ResourceBundleMessageSource.
   - It is not restricted to read .properties files alone but can read xml property files as well.
   - It is not restricted to reading files from just classpath but from any location.

# Singleton Bean to Multiple Request

**How spring serves singleton bean to multiple request at the same time**
- *For Spring, what if I have two requests that access the singleton bean at the same time? Does one request have to wait until the other to finish?*
- web requests will be served using single instance of the controller/service classes.
- There is no problem (i.e., there will not be any waits in between) even if two requests access the singleton bean as they will be served in two separate threads.
- All you need to ensure is that your **controller and service classes (i.e., singleton scoped beans) do not carry/hold any state (i.e., they are stateless) and are thread-safe.**

**How does Spring container find the singleton bean instance for my requests?**  
- Spring container creates and then injects the singleton bean instances based upon the configurations
  - provided **using the xml or through annotations.**

**For servlets, if I have two requests that access a normal class's normal method (no static no other complex things) at the same time? Does one request have to wait until the other to finish to avoid concurrency (at the same time two request are trying to access the object of the same class) ?**
- No, **each request will be handled in a separate thread**
  - so one request will not wait for the other request to be served/completed i.e. the requests will be served/processed parallelly.
  - This is achieved by the Web containers by using/managing the Thread pools.

**How does web container find the instance for my requests?**  
- **Web container (like Tomcat, etc..) creates and loads all of the servlet classes** and then once the web request comes from the client (like Browser), it will be handled to the servlet according to the url-pattern configured in the web.xml or through annotations.
