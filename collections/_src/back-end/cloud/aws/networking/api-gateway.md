---
layout: page
title: API Gateway
permalink: /aws/api-gateway
---

- TOC
{:toc}

---

# Introduction

- API - Application Programming Interface
    - example - Waiter is the API in a Restraunt
- Travel Website Exapmle

![travel-website-example]({{site.cdn}}/aws/serverless/travel-website-example.png)

**Types of APIs**
- REST APIs (REpresentational State Transfer) - Uses JSON
- SOAP APIs (Simple Object Access Protocol) - Uses XML

***Amazon API Gateway*** is fully managed service that makes it easy for developers to publish, maintain, monitor, and Secure APIs at any scale. With AWS Management Console, you can create an API that acts as Front Door for applications to access data, business logic, or functionality from your backend services, such as applications running on Amazon Elastic Compute Cloud (EC2), code running on AWS Lambda, or any web application.

![api-gateway]({{site.cdn}}/aws/serverless/api-gateway.png)

# What API Gateway can do?

- Expose https endpoint to define a RESTful API.
    - Weather API
- Serverless way to connect to service like Lambda and DynamoDB.
- Send each API endpoint to a different target.
- Runs efficiently with low cost
- Scale effortlessly
- Track and Control usage by API key
- Throttle requests to prevent attacks
- Connect to CloudWatch to log all requests for monitoring.
- Maintain multiple versions of your api

# How to Configure API Gateway

- Define an API(container)
- Define Resources and nested Resources(URL paths)
- For each Resource:
    - Select supported HTTP methods (verbs)
    - Set security
    - Choose target (such as EC2, Lambda, DynamoDB etc.)
    - Set request and response transformations
- Deploy API to a Stage
    - Use api gaetway domain by default
    - Can use custom domain
    - Now supports AWS Certificate Manager: free SSL/TLS certs

# API Caching

- You can allow API caching in API gateway to cache your endpoint response.
- Caching to reduce the number of calls and latency.
- When you enable caching for a stage, API Gateway caches responses from your endpoint for specified TTL(Time To Live) period, in seconds.
- API Gateway then responds to request by looking up the endpoint response from the cache instead of making a request to your endpoint.

# Origin Policies

## Same Origin Policy
- In Computing, same-origin-policy is important concept in the web application security model.
- Under this policy, a web browser permits scripts contained in a first web page to access data in a second web page, but only if both web pages have the same origin.
- This is done to prevent Cross-Site Scripting (XSS) attacks.
    - Enforced by web browsers.
    - Ignored by tools like PostMan and Curl.

## Cross Origin Resource Sharing (CORS)
- CORS is one way the server at the other end (not the client code in browser) can relax the same-origin-policy.
- CORS is a mechanism that allows restricted resources (eg. fonts) on the webpage to be requested from another domain outside the domain from which the first resource was served.
- Browser makes an HTTP OPTIONS call for a URL.
    - OPTIONS is HTTP methods like GET, POST, PUT
- Server returns a response saying "These other domains are approved to GET this URL"
- Error - "Origin policy cannot be read at the remote resource? You need to enable CORS on API Gateway."

# Import APIs

- Use API Gateway Import API feature to import API from an external definition file into API Gateway.
- Supports Swagger 2.0 definition files.
- To import API
    - Create new by submitting a POST request with swagger definition file as payload and endpoint configuration.
    - Update an existing API using PUT request with swagger definition file as payload.
        - Update the existing file either by overwriting with new defintion file or merge defintion with existing file. You can specify the options using a mode query parameter in the request URL.

# API Throttling

- By default, API Gateway limits the steady state request rate to 10,000 requests per second (rps).
- Maximum concurrent requests is 5000 requests ***across all APIs within an AWS account***.
- If you go over 10,000 rps or 5000 concurrent requests, you will receive HTTP status code 429 - Too Many Request error response.
- Examples
    - 10,000 rps evenly distributed in 1 sec --> API Gateway processes all without dropping any.
    - 10,000 requests in first millisecond, API Gateway serves 5,000 of those requests and throttles the rest in the 1 sec period.
    - 5,000 requests in first millisecond and remaining 5000 spread evenly in 999 milliseconds, API Gateway processes all 10,000 requests without 429 Too Many Requests error response.
- You can increase the throttling limit of API Gateway, but you incurr additional charges.

## SOAP Webservice Passthrough
- You can configure API Gateway as a SOAP web service passthrough.
