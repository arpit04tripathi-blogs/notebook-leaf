---
layout: page
title: CORS
permalink: /cors
---

- TOC
{:toc}

---

# Introduction to CORS

- [Cross-Origin Resource Sharing](https://developer.mozilla.org/en-US/docs/Glossary/CORS){:target="_blank"}
- [Same-Origin Policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy){:target="_blank"}

Cross-Origin Resource Sharing (CORS) is a mechanism that uses additional HTTP headers to tell a browser to let a web application running at one origin (domain) have permission to access selected resources from a server at a different origin.

A web application executes a **cross-origin HTTP request** when it requests a resource that has a different origin (domain, protocol, and port) than its own origin.

An example of a cross-origin request: The frontend JavaScript code for a web application served from http://domain-a.com uses XMLHttpRequest to make a request for http://api.domain-b.com/data.json.

For security reasons, browsers restrict cross-origin HTTP requests initiated from within scripts. For example, XMLHttpRequest and the Fetch API follow the same-origin policy. This means that a web application using those APIs can only request HTTP resources from the same origin the application was loaded from, unless the response from the other origin includes the right CORS headers.

![client-server-http.png]({{site.cdn}}/webservices/cors/client-server-http.png)

![cors.png]({{site.cdn}}/webservices/cors/cors.png)
