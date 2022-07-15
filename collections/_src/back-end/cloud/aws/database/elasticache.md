---
layout: page
title: RDS
permalink: /aws/rds
---

- TOC
{:toc}

---

# Introduction

* Elasticache is a web service to deploy, operate and scale an in-memory cache in cloud.
* The service improves performance of web applications by allowing you to retrieve information from fast, managed, in-memory caches, instead of relying on slower disk-based DB.
* Sits between you application and DB.
* Takes load off your DB.
* Good if your DB is particularly read-heavy and data is not changing frequently.
* Used to significantly improve latency and throughput for many 
    - read-heavy application-workloads(such as social networking, gaming, media sharing and Q&A portals) or
    - compute-intensive workloads(such as a recommnedation engine)
* Caching improves appilcation performance by storing critical pieces of data in memory for low latency access.
* Cached info may include
    - results of IO intensive DB queries.
    - results of computationally intensive calculations.

# Types of Elasticache

* Elasticache supports two open-source in-memory caching engines
    - **Memcached**
        - Widely adopted memory object caching system
        - Multi-threaded
        - No Multi-AZ capability.
    - **Redis**
        - Open source in-memory key-value store
        - Supports more complex data structures: sorted sets and lists
        - Supports Master/Slave replication and Multi-AZ for cross AZ redundancy.

## Redis
* Popular open-source in-memory key-value store that supports data structures such as sorted sets and lists.
* Elasticache supports master-slave replication and multi-AZ which can be used to achieve cross AZ redundancy.
* Because of replication and persistence feature, Elasticache manages Redis more as a Relational DB.
* Redis Elasticache clustures are managed as stateful entities that include failover, similar to how RDS manages DB failover.

**Use Cases - Redis**
* Looking for more advanced data types, such as lists, hashes and sets.
* Sorting and ranking datasets in memory help you, such as with leaderboard.
* Persistence of your key stores is important.
* Want to run in multiple AWS Availability Zones with failover.

## Memcached
* Designed as pure caching solution with no persistence, Elasticache manages Memcached nodes as a pool that can grow or shrink similar to EC2 auto scaling group.
* Individual nodes are expendable, and elasticache provides additional capabilities such as automatic node replacement and Auto Discovery.

**Use Cases - Memcached**
* Is object caching is your primary goal, for example to offload your DB?
* Interested in simple caching model.
* Planning on running large cache nodes, and require multithreaded performance with utilization of multiple cores.
* Want an ability to scale your cache horizontallly as you grow.

# Caching Strategies

## Lazy Loading
- Lazy Loading - Loads the data into the cache only when necessary.
- If requested data is in cache, Elasticache returns the data.
- If data not present in cache or has expired, Elasticache returns null.
- Your application then fetches the data from the DB and writes the data received into the cache so that it is available next time.

|Advantages|Disadvantages|
---|---
|Only requested data is cached: Avoids filling up cache with useless data.|Cache miss penalty: Initial request query to DB writing data to the cache.|
|Node Failures are not fatal, a new empty node will just have a lot of cache misses initially.|Stale Data - If data is only updated when there is a cache miss, it can become stale. Does't automatically update if the data in DB changes.|

### TTL for Cache
- TTL (Time To Live)
- Specifies the number of seconds until the key(data) expires to avoid keeping stale data in the cache.
- Lazy Loading treats an expired key as a cache miss and causes the application to retrieve the data from the DB and subsequently write the data into the cache with a new TTL.
- Does not eliminate stale data - but helps avoid it.

## Write Through
- Adds or updates the data to cache whenever data is written to DB.

|Advantages|Disadvantages|
---|---
|Data in cache never stales.|Write Penalty: Every write involves a write to cache as well as DB.|
|Users are generally more tolerant of additional latency when updating data than when retrieving it.|If a node fails and a new one is spun up, data is missing until added or updated in DB (mitigate by implementing Lazy Loading in conjuction with write-through)|
||Wasted resources if most of the data is never read.|

# Elasticache vs Redshift

* Scenario : Particular DB is under a lot of stress/load, which service will you alleviate.
    - Elasticache, if your DB is particularly read-heavy and not prone to frequent changing.
    - Redshift, if your DB is feeking stress because management keep running OLAP transactions on it.

