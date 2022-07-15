---
layout: page
title: Spring WebFlux
permalink: /spring/webflux
---

- TOC
{:toc}

---

# Spring Reactive Web

> RestTemplate is getting deprecated, user reactive WebClient to make rest calls.

- Required root Dependency - Spring Reactive Web
- It comes with Spring WebFlux.
- `spring-boot-starter-webflux`

```java
WebClient.Builder builder = WebClient.builder();
Movie movie = builder.build()
    .get()
    .uri("http://localhost:8080/movie/108")
    .retrieve()
    .bodyToMono(Movie.class) // Mono - kind of Promise for this object, Async
    .block(); // Wait till container is filled with returned object
```
