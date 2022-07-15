---
layout: page
title: Spring Session 
permalink: /spring/session
---

- TOC
{:toc}

---

# References
- [SpringBoot session management](https://www.youtube.com/watch?v=7e5R7FetJnc){:target="_blank"}

# Introduction
- HTTP is a stateless protocol.
- Server can't distinguish between new visitor and returning visitor on its own, but we want to keep track of client's activity across multiple requests.
- ***Session Management*** - Mechanism used by Web Container to store session information for a particular user.
- Ways to achieve this
  1. Cookies
  2. Hidden form field
  3. URL Rewriting
     - appending or modifying any url structure while loading a page, example - adding sessionID as param
     - works even when cookies are disabled for browser
  4. HttpSession

## Spring Session Modules
Uses HttpSession for session management
- Spring session core -
- Spring session Data Redis - SessionRepository and ReactiveSessionRepository Implementations backed by Redis
- Spring session JDBC - SessionRepository Implementation backed by RDMS
- Spring Session Hazlecast - SessionRepository Implementation backed by Hazlecast (open source in-memory data grid based on Java)

By Default, Tomcat stores HTTP sessino objects in memory.
- To store in DB, `spring.session.store-type=jdbc` with spring-session-jdbc dependency.
- Here, Spring creates a bean, `SessionRepositoryFilter` named as springSessionRepositoryFilter

![Http Session](https://www.javainuse.com/boot-50_7.jpg)

properties
```
spring.session.store-type=jdbc
spring.session.timeout.seconds=900
```

code snippets/methods
```
request.getSession().setAttribute(KEY, VALUE);
request.getSession().getAttribute(KEY);
request.getSession().invalidate();
```

DB and tables created
```
use springsession;
show tables;
> spring_session
> spring_session_attributes
```

