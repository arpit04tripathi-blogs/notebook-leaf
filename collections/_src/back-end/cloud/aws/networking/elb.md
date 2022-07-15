---
layout: page
title: ELB - Elastic Load Balancer
permalink: /aws/elb
---

- TOC
{:toc}

---

* Balances load accross multiple web-server instances.

# Types of ELB
  - Application Load Balancer
  - Network Load Balancer
  - CLassic Load Balancer

## Application Load Balancer
- Operates on OSI layer 7 of computing and are application-aware, ie. can make decision based on application sending the request.
- Can see upto layer 7 to make routing decisions.
- Best suited for http and https traffic.
- Can create advanced request routing, sending specified requests to specific web servers.

## Network Load Balancer
- Operates at connection level on OSI layer 4 of computing.
- Superfast performance and superfast speed ie. low latency.
- Most expensive load balancer, generally used in Production.
- Best suited for tcp traffic requiring extreme performance.
- Capable of handling millions of requests per second, while maintaining ultra-low latencies.

## Classic Load Balancer
* Legacy elastic load balancer - important for aws certification
* Can load-balance http/https applications and uses layer-7 specific features, such as X-Forwarded and sticky sessions.
* Can also use strict layer 4 load balancing for applications that rely purely on the TCP protocol.
* Error
    - If your application stops responding, the ELB responds with a 504 error.
    - This implies application is having issues, could be either on web server layer or database layer.
    - Identify the point of faliure and scale up/scale out where possible.

# X-Forwarded-For Header
* To get ipv4 address of your end user.

![x-forwarded-for]({{site.cdn}}/aws/ec2/x-forwarded-for.png)
