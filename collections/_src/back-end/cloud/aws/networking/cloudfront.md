---
layout: page
title: CloudFront
permalink: /aws/cloudfront
---

- TOC
{:toc}

---

# Introduction

- Amazon's Content Delivery Network.
- CDN is a system of distributed servers (network) that deliver webpages and other web contents to a user based on the geographical locations of the user, the origin of the webpage, and a content delivery server.
- Service that speeds up the distribution of static and dnyamic web content for geographically distributed users.
- Multiple network hops hence network latency.
- cloud from used for GET, PUT, POST, PATCH, DELETE, OPTIONS, HEAD
- TTL is default 86400 sec = 24 hours.

### CloudFront vs Transfer Acceleration

|CloudFront | Transfer Acceleration|
---|---
Focused on content delivery ie. efficient reads and downloads | Enabling faster uploads for S3.

### Edge Location
- Colection of servers in geographically dispersed data centers.
- Used to keep cache, copies of your files till TTL(Time To Live).
- you can clear the cache yourself (before TTL), but you will be charged for it.

![edge-location]({{site.cdn}}/aws/s3/edge-location.png)


### CloudFront Terms
- **Edge Location** - Location where content is cached and can also be written. Separate to an AWS Region/AZ.
- **Origin** - Origin of all the files that a CDN will distribute. Origins can be S3 bucket, EC2 instance, ELB, Route53.
- **Distribution** - Name given to CDN, which consists of a collection of Edge Locations.
    - **Web Distribution** - Typically used for websites.
    - **RTMP** - Adobe Real Time Messaging Protocol, Used for media streaming/Flash multi-media content.

### CloudFront and S3 Transfer Acceleration
- Enables fast,easy and secure transfer of files over long distance between your end userd and S3 bucket.
- Transfer Acceleration takes advantage of AWS CloudFront's globally distributed edge locations to reduce the latency. As the data arrives at an edge location, data is routed to S3 over an optimized network path.

## CloudFront Lab
- create a public S3 bucket in the region farthest from from you.
- create cloud front web distribution
- use signed urls/ signed cookie
    - content which is paid for only.
- WAF - Web Application Firewall
    - For traffic filtering for wellknown attacks like SQL Injection and  Cross site scripting
    - Works at application layer unlike nowmal firewall that protects on network layer.
- Can use custom SSL, need to be stored in AWS Certificate manager or applied in IAM policy.
- Create CloudFront Distribution.
- Select cloudFront distribution --> Restrictions --> blacklist/whitelist regions(countries) to acces the content.
- Invalidations tab - For removing the files from Edge Locations ie. cache. Here you will be charged a fee.
- Remove public access to S3 file, try accessing using cloudfront.
