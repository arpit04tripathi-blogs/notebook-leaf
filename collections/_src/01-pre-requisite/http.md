---
layout: page
title: Http (Hypertext Transfer Protocol)
permalink: /http
---

- TOC
{:toc}

---

# Introduction

- Application protocol for distributed, collaborative, hypermedia information systems. 
- foundation of data communication for the World Wide Web.
- URI (Uniform resource identifier) - string of characters used to identify a name or a resource
  - URN (Uniform resource name) - URI that uses the urn scheme and does not imply availability of the identified resource.
  - URL (Uniform resource locator)
- Both URN's (names) and URL's (locators) are URI's, and a particular URI may be a name and a locator at the same time.

![urn-url.png]({{site.cdn}}/webservices/http/urn-url.png)

- RFC 1737: Uniform Resource Names (URN): [Link](http://tools.ietf.org/html/rfc1737){:target="_blank"}
- RFC 1808: Relative Uniform Resource Locators (URL): [Link](http://tools.ietf.org/html/rfc1808){:target="_blank"}

|SCHEME	|DESCRIPTION|
|---    |---|
|http   |Hypertext transfer protocol
|https	|Secured Hypertext transfer protocol
|mailto	|Email composer
|ftp    |File transfer protocol

# URL (Uniform resource locator)
- string that constitutes a reference to an Internet resource.

**Query String Encoding**
- Letters (A-Z and a-z), numbers (0-9) and the characters '.' , '-' , '~' and '_' are left as-is
- SPACE is encoded as '+' or hexadecimal (%20)
- All other characters are encoded as %FF hexadecimal representation, with any non-ASCII characters first encoded as UTF-8 (or other specified encoding)
- Typical max value for a single GET parameter value is 512 bytes


|Purpose	|Parameters|
|---|---|
|Pagination	       |?offset=x&limit=y
|Sorting	       |sort=\<criteria>&order=[ASC\|DESC]
|Max results	   |?max=n
|Dedicated elements|?id=xyz&id=abc&id=def&...


|IMPLEMENTATION|LIMIT|
|---|---|
|Firefox|Unlimited, although instability occurs with URLs reaching around 65,000 characters.|
|Safari|Unlimited.|
|Internet Explorer v6 - v7|Maximum length of a URL in Internet Explorer is 2,083 characters, with no more than 2,048 characters in the path portion of the URL.
|Internet Explorer v8+	|Maximum length of a URL in Internet Explorer is 4,095 characters, with no more than 2,048 characters in the path portion of the URL. <br>Maximum mailto: length is 500 to 512 characters long.|
|Sitemap Protocol	|\<loc> URL of the page. This URL must begin with the protocol (such as http) and end with a trailing slash, if your web server requires it. This value must be less than 2,048 characters.|
|GoogleBot crawler	|Google will index URLs up to 2047 characters in length.|
|Google search results page (SERP)|Google index-able links that will work when clicked in the SERP's is ~1855 characters in length.|

# Http Request and Response Message

- The request line and headers must all end with `<CR><LF>` 
  - `<CR>` - carriage return character
  - `<LF>` - line feed character `\r\n`
- The empty line must consist of only `<CR><LF>` and no other whitespace.
- In the HTTP/1.1 protocol, all headers except Host are optional.

![req-res.png]({{site.cdn}}/webservices/http/req-res.png)

## MIME Types (Multipurpose Internet Mail-Extension)
- Internet media type.
- referred as Content-types
- two-part identifier for file formats on the Internet.
  - `type/subtype` - text/html, text/plain
- Generally present after the name of a header in several protocols.

## Cookies
- HTTP cookie / web cookie / browser cookie.
- small piece of data sent from a website and stored in a user's web browser while browsing.
  - When user revisits, cookies can be retrieved to notify the website about the user's previous activity.
  - This can include clicking particular buttons, logging in, or a record of which pages were visited by the user even months or years ago.
- Cookies were designed to be a reliable mechanism for websites to remember the state of the website or activity the user had taken in the past.

## Avoiding caching
- web server response contains `Cache-Control: no-cache`.
  - web browser or other caching system must check with the originating server first for subsequent requests.

## HTTP Conditional GET
- returns HTTP 304 response rather than HTTP 200.
- indicates that the resource has not been modified since the previous GET request and the resource will not be returned to the requesting client as part of the response.

# Http Methods

**Safety**
- If it does not change the state of a resource when invoked.
  - GET, HEAD

**Idempotent**
- If it can be called multiple times and the end result is the same.
  - GET, HEAD, PUT, DELETE 
- DELETE is idempotent because there are no side-effects to the resource.
  - subsequent calls can result in an error message dependent on your implementation.

**Http Methods**

|HTTP VERB|Description|Response Code|Note|Idempotent|Safe|Feature|
|---|---|---|---|
|POST   |Create         |201 : CREATED|Create a new entity, optionally return URI also.||||
|PUT    |Update         |200 : OK,<br>202 : ACCEPTED,<br>204 : NO_CONTENT|Update an existing entity entirely|Y|||
|PATCH  |Patch          |200 : OK,<br>202 : ACCEPTED,<br>204 : NO_CONTENT|Partial updates|Y|
|GET    |Retrieve       |200 : OK|Read a list of entities or single entity|Y|Y|linkable, cacheable|
|DELETE |Delete         |200 : OK,<br>202 : ACCEPTED,<br>204 : NO_CONTENT|delete an existing entity|Y|||
|HEAD   |Retrieve       |200 : OK|identical to GET, except that only the HTTP header is returned.|Y|Safe||
|OPTIONS|API description|200 : OK|request information about the communication options available|
|TRACE  |Trace          |200 : OK|invoke a remote, application-layer loop-back of the request message.<br>Used for testing.|
|CONNECT|               |        |reserves the method name CONNECT for use with a proxy that can dynamically switch to being a tunnel (e.g. SSL tunneling)|

- **TRACE**: Provides a way to test what server receives. It simply returns what was sent.
- **CONNECT**: Used by browser when it knows it talks to a proxy and the final URI begins with https://. The intent of CONNECT is to allow end-to-end encrypted TLS session, so the data is unreadable to a proxy.

## POST vs PUT
- "POST /books" with a bunch of book information might create a new book, and respond with the new URL identifying that book: "/books/5".
- "PUT /books/5" would have to either create a new book with the id of 5, or replace the existing book with ID 5.
    - In non-resource style, POST can be used for just about anything that has a side effect.
- PUT is idempotent - multiple PUTs of the same data to the same URL should be fine
- POST is not idempotent - multiple POSTs creates multiple objects.
- PUT is meant as a a method for "uploading" stuff to a particular URI, or overwriting what is already in that URI.

# HTTP Response Codes

|GROUP|Type|DESCRIPTION|
|---|---|---|
|1xx|Informational|further action needs to be taken by the user agent in order to fulfill the request.|
|2xx|Successful   |the client's request was successfully received, understood, and accepted.|
|3xx|Redirection  |further action needs to be taken by the user agent in order to fulfill the request.|
|4xx|Client Error |intended for cases in which the client seems to have erred.|
|5xx|Server Error |server is aware that it has erred or is incapable of performing the request.|

|2xx|Description|
|---|---|
|200 : OK         |Successfully executed
|201 : CREATED    |- New resources has been created<br>- response body is either empty or contains URI(s) of the created resource<br>- The location header should should also contain the new URI|
|202 : ACCEPTED   |- request was valid and has been accepted but has not yet been processed.<br>- response should include a URI to poll for status updates on the request.<br>- Allows for asynchronous request|
|204 : NO_CONTENT |request was successful but the server did not have a response|

|3xx|Description|
|---|---|
|301 : MOVED_PERMANENTLY      |new location should be returned in the response|
|304 : Not Modified           |
|307 : Temporary Redirect     |

|4xx|Description|
|---|---|
|400 : BAD_REQUEST            |Malformed or invalid request|
|401 : UNAUTHORIZED           |Invalid authorization credentials|
|403 : FORBIDDEN              |Disallowed request. Security error|
|404 : NOT_FOUND              |Resource not found|
|405 : METHOD_NOT_ALLOWED     |Method (verb) not allowed for requested resource.<br>Response will provide an “Allow” header to indicate what is allowed|
|408 :                        |Request Time-out|
|414 :                        |Request-URI Too Large|
|415 : UNSUPPORTED_MEDIA_TYPE |Client submitted a media type that is incompatible for the specified resource.|

|5xx|Description|
|---|---|
|500 : INTERNAL_SERVER_ERROR  |Catchall for server processing problem|
|503 : SERVICE_UNAVAILABLE    |Response in the face of too many request|

## HTTP
- [100 Continue](https://support.airship.com/hc/en-us/articles/213492003--Expect-100-Continue-Issues-and-Risks)
- [7-http-methods-every-web-developer-should-know-and-how-to-test-them](https://assertible.com/blog/7-http-methods-every-web-developer-should-know-and-how-to-test-them)

# Http Authentication

## Transfer Layer Security (TLS / SSL)
- Transfer Layer Security (TLS) and its predecessor, Secure Sockets Layer (SSL).
- cryptographic protocols to provide communication security over the Internet.
- TLS and SSL encrypt the segments of network connections at the Application Layer for the transfer Layer using,
  - asymmetric cryptography for key exchange.
  - symmetric encryption for privacy.
  - message authentication codes for message integrity.

## Basic access Authentication (BASIC)
- In context of an HTTP transaction.
- method for a web browser or other client program to provide a user name and password when making a request.
- Most basic way of implementing authentication, suitable when we are accessing the application both using browser and other software such as scripts.
- Browser will use its standard dialog to collect the credentials.
- Easy to implement, but credentials transmitted as plain text.
- Hence, you must have TLS/SSL or some network level encryption in place.

- Before transmitting `username:password` is Base64 encoded.
- Base64-encoded string is transmitted in the HTTP header and decoded by the receiver.
- Base64 makes them unreadable visually, but they are easily decoded.
- *Confidentiality is not the intent of the encoding step*
  - rather, the intent is to encode non-HTTP-compatible characters that a username or password may contain, into those that are HTTP-compatible.

## Digest access authentication (DIGEST)
- similar to the BASIC, a digest of the password is transmitted instead of password.
- Digest communication starts with a client that requests a resource from a web server.
- If the resource is secured with Digest Authentication, the server will respond with the http status code 401, which means Unauthorized to access this resource.

```
GET /secured/index.html HTTP/1.0
Host: localhost
Authorization: Digest username="mick",
        realm="baselogic.com",
        nonce="dcd98b7102dd2f0e8b11d0f600bfb0c093",
        uri="/secured/index.html",
        qop=auth,
        nc=00000001,
        cnonce="0a4f113b",
        response="35f308904a9a9623498f358d1cb10afd"
```
- response contains term Digest as indication.
- server also indicates the type of Digest Authentication algorithm used by the client with Quality Of Protection (QOP) and the nonce string, which is a Base64 encoded timestamp and private hash generated by the server.

```
HA1 = MD5( "mick:baselogic.com:secret key")
HA2 = MD5( "GET:/secured/index.html" )
```

## Form-Based Authentication (FORM)
- we can use our own form to collect the username and password.
- It is very flexible in terms of implementation and how we ask for the username and password, but requires extra work for implementing the forms.
- This method suffers from the same security risk as the BASIC method because the credentials are transmitted as plain text.
