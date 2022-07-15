---
layout: page
title: Kinesis Data Streams
permalink: /aws/kinesis
---

- TOC
{:toc}

---

# Introduction

**Streaming Data** - data generated continuosly by thousands of data sources, which typically sends data records simultaneously and in small sizes (kb).
- Purchases from online store
- Stock Prices
- Game Data (as gamer plays)
- Social network data
- Geospatial data (uber)
- IOT sensors data

Amazon Kinesis is a platform on AWS to send your streaming data too. Kinesis makes it easy to load and analyze streaming data, also providing ability for you to build your own custom applications for your business needs.

- Use cloudformation to create kinesis stack.

# Types of Kinesis

## Kinesis Streams

- Kinesis data stream consists of shards
- A shard is a sequence of data records in a stream, each data record has a unique sequence number.
- Total capacity of stream is sum of individual capacities of shards.
- Single Shard Capacity
  - 5 transactions per second, upto max total data read rate 2MB per second.
  - upto 1000 records per second for writes, upto total data write rate of 1MB per second (including partition keys).
- As your data rate increases, you need to increase the number of shards (resharding).

![]({{site.cdn}}/aws/kinesis/kinesis-streams.png)

## Kinesis Firehose

- Don't have to worry about shards, streams or manually adding shards to keep up with your data.
- It is completely automated and you don't have to worry about consumers going in and mining that data as we can analyze data using lamda in realtime.
- Analysis step is optional.
- Analyzed data can be sent to S3 or to Elastic search clusture.
- No retention period as opposed to Kinesis Streams
- More automated way of doing kinesis

![]({{site.cdn}}/aws/kinesis/kinesis-firehose.png)

## Kinesis Analytics

- Kinesis Analytics lets you run SQL queries on that data as if it exists within firehose or streams then, you can use SQL query to store output data to S3. Redshift, Elastic Search Clusture etc.

![]({{site.cdn}}/aws/kinesis/kinesis-analytics.png)

# Kinesis Consumers

- Kinesis client library runs on the consumer instances.
- Tracks the number of shards in your stream.
- Discovers new shards when you reshard.
- KCL ensures that each consumer has a record processor.
- Manages the nuumber of record processors relative to the number of shards and consumers.
- If you have only one consumer, KCL will create all the record processors on a single consumer.
  - If you have 2 consumers it will load balance and create half the processors on each instance.
- With KCL, generally you should ensure that the number of instances does not exceed the number of shards (except for failure or standby purposes).
- You never need multiple instances of consumer to process load of 1 shard, however 1 consumer can process multiple shards.
- It is fine if number of shards exceeds the number of instances.
- Don't think that just because you reshard, you need to add more instances.
- Instead CPU Utilizatin is what should drive the quantity of consumer instances you have, not the number of shards in your kinesis streams.
- Use an autoscaling group, and base scaling decisions on CPU load of your consumers.
