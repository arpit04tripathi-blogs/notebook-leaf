---
layout: page
title: SQS - Simple Queueing Service
permalink: /aws/sqs
---

- TOC
{:toc}

---

# Introduction

- Web service that gives access to message queue that can be used to store messages while waiting for server to process them.
- ***SQS is Pull based system, not push-based.***
- Distributed queue system to enable web service applications to quickly and reliably queue messages that one component in application generates to be consumed by other component.
- A queue is temporary repository for messages that are awaiting processing.
- Using SQS, you can decouple the components of an application so they run independently, easing message management between components.
- Any component of a distributed application can store messages in the queue.
- ***Message can contain upto 256KB of text in any format.***
- ***Messages can be kept in the queue from 1 minute to 14 days***
- ***Default retention period is 4 days.***
- Any component can later retrieve the messages programmatically using the Amazon SQS API.
- The queue acts as buffer between the component producing and saving data, and the component receiving the data for processing.
- Queue resolves issues that arise if the producer is faster than the consumer or if the producer or consumer are only intermittently connected to the network.

# SQS Visibility Timeout

- Amount of time that the message is invisible to SQS after a reader picks up the message.
- Provided the job is processed before the visibility timeout expires, the message will then be deleted from the queue.
- If the job is not processed within that time, the message will become visible again and another reader will process it. This could result in the same message being delivered twice.
- Default visibility timeout is 30 seconds, increase if your task takes >30 seconds.
- Maximum is 12 hours.

# Long Polling

- SQS uses Long Polling for retrieving messages from queue.
- While Regular Short Polling returns immediately(even if the queue is empty), Long Polling doesn't return a response until a message arrives in the message queue, or the Long Polling times out.
- Maximum long poll time out is 20 seconds.
- As such, Long Polling can save you money.

# Queue Types

- Standard Queue (default)
- FIFO Queues

![]({{site.cdn}}/aws/sqs/sqs-queue-types.png)

## Standard Queue

- Lets you have a nearly-unlimited number of transactions per second.
- Guarantees that a message is delivered ***at least once***. However. occasionally(because of high-distributed architecture that allows high throughput), more than one copy of message might be delivered out of order.
- Standard queues provide ***best-effort ordering*** which ensures that messages are generally delivered in the same order as they are sent.

## FIFO Queues

- FIFO queues complements the standard queue.
- Important Feature
  - ***First In First Out Delivery***
  - ***Exactly once processing***
- Order in which messages are sent and received is strictly preserved and a message is delivered once and remains available until a consumer processes and deletes it; duplicates are not introduced into the queue.
- FIFO queues also support message groups within a single queue.
- FIFO queues are limited to 300 transactions per second (TPS), but have all the capabilities of standard queue.

# SQS Delay Queue

- Postpone delivery of new message to a queue for number of seconds.
- Message sent to a delay queue remains invisible to customers for the duration of the delay period
- Default delay is 0 seconds, max is 900 seconds (15 Minutes).
- For standard queues, changing the setting doesn't affect the delay of messages already in the queue, only new messages.
- For FIFO queues, this affects the delay of messages already in the queue.

## When to use Delay Queues
- Large distributed applications which may need to introduce a delay in processing.
- You need to apply a delay to an entire queue of messages.
- eg. adding a delay of few seconds to allow for updates to your sales and stock control databases before sending a notification to a customer confirming an online transaction.

# Messaging Large SQS Messages

- For large SQS messages - 256KB upto 2GB.
- Use S3 to store the messages.
- Use Amazon SQS Extended client library for Java to manage them.
- AWS SDK for java provides an api for S3 bucket and object operations.

SQS Extended Client Library for java allows you to
- Specify that messages are always stored in S3 for only messages > 256KB
- Send a message which references a message object stored in S3.
- Get a message object from S3.
- Delete a message object for S3.

![]({{site.cdn}}/aws/sqs/large-sqs-messages.png)

For Large SQS
- You need
  - AWS SDK for java
  - SQS extended client library for java
  - S3 bucket
- You can't use
  - AWS CLI
  - AWS Management Console/ SQS console
  - SQS API
  - Any other AWS SDK
