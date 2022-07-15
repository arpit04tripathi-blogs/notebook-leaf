---
layout: page
title: DynamoDB
permalink: /aws/ddb
---

- TOC
{:toc}

---

# Introduction

- Fast and flexible NoSQL database service for all applications that need consistent, single-digit millisecond latency at any scale.
- It is fully managed DB and supports both document and key-value data models.
- It's flexible data model and reliable performance make it a great fit for mobile,web, gaming, ad-tech, IoT, and many other applications.
- DDB is also serverless, and integrates really well with Lambda.
- DynamoDB
    - Tables
    - Items (row )

## Tables

- Stored on SSD storage (Solid State Disks)
- Spread across 3 geographically distinct data centers
- Choice of 2 consistency Models:
    - Eventual Consistent Reads (default)
        - Consistency across all copies of data is usually reached within a second.
        - Repeating a read after a short timeshould return the updated data. (best read performance)
    - Strongly Consistent Reads
        - returns a result that reflects all writes that received a successful response prior to the read.

* Dynamo DB
    - Table
    - Items (row of a table)
    - Attributes (column in a table)
    - Supports key-value and document data-structures
        - key = name of data
        - value = data itself
        - Documents can be written in json, html or xml

## Primary Keys

* DynamoDB stores and retrieves data based on a primary key
* Two types of primary key
    - partition key
    - sort key

### Partition Key - Unique Attribute (eg. user ID)
- value of partition key is input to an internal hash function which determines partition or physical location on which the data is stored.
- if you are using partition key as primary key, then no 2 items can have the same partition key.

### Composite Key
- Partition Key + Sort Key
- example - same user posting multiple times in a forum
- primary key = userID (partition key) + timestamp (sort key)
- All items with same partition key are stored together; then sorted according to sortKey value.
- Allows you to store multiple items with same partition key.

# DDB Access Control

- Authentication and Access Control is managed using AWS IAM.
- Can create an IAM user with specific permissions to access and create dynamodb tables.
- Can create an IAM role which enables you to obtain temporary access keys to be used for accessing dynamoDB.
- Can also use special IAM Condition to restrict user access to only their records.

## IAM Condition Example
- Mobile gaming application with millions of users.
- User needs to access high scores for each game they are playing, access must be restricted so that they don't see anyone else's data.
- This can be done by adding a condition to an IAM Policy to allow access only to items where the partition key value matches their userID.
    - iam conditional parameter - dynamodb:LeadingKeys

![dynamodb-iam-condition]({{site.cdn}}/aws/ddb/dynamodb-iam-condition.png)

```cli
aws dynamodb get-item --table-name ProductCatalog --region eu-west-2 --key '{"id":{"n":"205"}}'
```

# Indexes

- In SQL DB, index is a data structure which allows you to perform fast queries on speccific columns that you want to include in index and run your queries on index rather than entire dataset.
- Types of Index in DynamoDB for fast queries
    - Local Secondary Index
    - Global Secondary Index

## Local Secondary Index
- can only be created when you are creating your table
- cannot add, remove or modify it later
- has same partition key as your original table, but a different sort key
- Gives you a different view of data organized according to an alternative sort key.
- Any queries based on this sort key are much faster using the index then main table.
- ex. partition key = userID, sort key = account creation date

## Global Secondary Index
- can create when you create a table or add it later.
- different partition keys as well as different sort key.
- gives a completely different view of data
- speeds up any queries relating to this alternative partition and sort key
- ex. partition key = email address, sort key = last login date

![index-types]({{site.cdn}}/aws/ddb/index-types.png)

# Scan vs Query

## Query
- Query operation inda item in table based on primary key attribute and value to search for.
- use optional sort key name and value to refine the results.
- by default, query returns all the attributes for the items but you can use the `projection expression` parameter to return only specific attributes.
- results are always sorted by the sort key
    - numeric order - ascending order
    - ASCII character code values
- You can reverse the order by setting the `ScanIndexForward` parameter to false.
- by default, queries are eventually consistent
- you need to explicitly set the query to be Strongly Consistent.

## Scan
- Scan operation examines every item in the table.
- By default returns all data attributes.
- `projectionExpression` parameter to refine the scan to only return the attributes you want.

## Query or Scan
- Query is much more efficient than scan.
- Scan dumps entire table, then filters out the values to provide the desired results - removing unwanted data.
    - Additional step of removing data you don't want.
- As table grows, Scan operation takes longer.
- Scan operation on large table can use up the provisioned throughput in just a single operation.

## How to improve Performance
- You can reduce the impact of a query or scan by setting smaller page size which uses fewer read operations.
- Large number of smaller operations will allow other requests to succeed without throttling.
- Avoid using scan operations, instead you can design tables in a way that you can use the query, get or BatchGetItem APIs.
- by default, a scan operation processes data sequencially in returning 1MB increments before moving on to retrieve next 1MB of data. It can scan only 1 partiton at a time.
- You can configure dynamoDB to use parallel scans by logically dividing a table or index into segments and scanning each segment in parallel.
- best to avoid parallel scans if your table or index is already incurring heavy read/write activity from other applications.

# DDB Provisioned Throughput
- Mechanism to define capacity and performance requirements in DynamoDB.
- DynamoDB provisioned Throughput is measured in Capacity Units.
- At time of creating table you specify - Read Capacity Units and Write Capacity Units.
```
1 Write Capacity Units = 1 x 1KB Write per second
```
```
1 Read Capacity Unit = 1 x Strongly Consistent Read of 4KB per second
OR
2 x Eventually Consistent Read of 4KB per second. (default)
```

Example - RCU to KB - 5 RCU and 5 WCU
```
5 RCU   = 5 x 4 ie. 20 KB strongly consistent read
        = 5 x 2 x 4 ie. 40 KB eventually consistent read

5 WCU   = 5 x 1 ie. 5 KB write per second
```
Example - KB to RCU - 80 items per second with 3KB each, strongly consistent reads required
```
3KB/4KB = 0.75, rounded to ceil integer ie. 1 RCU.
80 items per second ==> 80 RCU
// For eventually consistent
Divide 80 by 2, ie. 40 RCU eventual consistency as it has 2 x 4KB reads per second
```
Example - KB to RCU - Write 100 items per second, 512 bytes size
```
512 bytes/1KB = 0.5, rounded to ceil integer ie. 1 WRU
100 Writes per second ==> 100 WCU
```

## Provisioned Throughput exceeded and Exponential Backoff
- ProvisionedThroughputExceededException
- Your request rate is too high for read/write capacity provisioned on your DynamoDB table.
- SDK will automatically retry the request until successful.
- If you are not using SDK, you can:
    - Reduce request frequency.
    - Use Exponential Backoff.

### Exponential Backoff
- Many components ina network can generate errors due to being overloaded.
- In addition to simple retries, all aws sdk use Exponential Backoff.
- Progressively longer waits between consecutive retries eg. 50ms, 100ms, 200ms .. for improved flow control.
- If after 1 minute this doesn't work, your request size may be exceeding the throughput for your read/write capacity.
- This feature is not just for DynamoDB, it is available for every aws sdk and applies to many services within aws eg. s3 buckets, cloudFormation, SES.

# DDB On Demand Capacity

- Charges apply for Reading, Writing and Storing Data.
- With On-Demand, you don't need to specify your requirements.
- DynamoDB instantly scales up and down based on the activity of your application.
- Great for unpredictable workloads.
- Pay per request - pay only for what you use.

## Which pricing model should I use

![pricing-model]({{site.cdn}}/aws/ddb/pricing-model.png)

# DynamoDB Caching

## DAX - DDB Accelerator

- Fully managed, clustured in-memory cache for DynamoDB.
- Delivers upto 10x read performance improvement.
- Microsecond performance for millions of requests per second.
- Ideal for Read-Heavy and bursty workloads.
- eg. auction applications, gaming and retail sites during black friday promotions.

### How Does it Work
- DAX is write-through caching service - this means data is written to the cache as well as the backend store at the same time.
- Allows you point your DynamoDB API calls at the DAX clusture.
- If item being queried is in the cache(cache hit), DAX returns the result to application.
- If item not available in cache(cache miss) then DAX performs an Eventually Consistent GetItem operation against DynamoDB.
- Retrieval of Data from DAX reduces the read load on DynamoDB Tables.
- May be able to reduce Provisioned Read Capacity.

### What is it Suitable for
- Caters for Eventually Consistent reads only - so not suitable for applications that require Strongly Consistent Reads.
- Write Intensive applications.
- Applications that do not perform many read operations.
- Applications that do not require microsecond response times.

## Elasticache

> (refer section for elasticache)

## DAX vs Elasticache

- DAX is optimized to only used for DynamoDB.
- DAX only supports write-through caching strategy.

In general, 
- DynamoDB - use DAX
- RDS - use Elasticache.

# Transactions

- To support missino critical applications requiring all or nothing approach for transactions.
- ACID Transactions (Atomic, Consistent, Isolated, Durable)
- Read or write multiple items across multiple tables as an all or nothing operation.
- Check for a pre-requisite condition before writing to a table.

# TTL

- Time To Live attribute defines an expiry time for your data.
- Expired items are marked for deletion, will be deleted within next 48 hours.
- Great for removing old or irrelevant data
    - session data
    - event logs
    - temporary data
- Reduces storage cost by automatically removing data which is no longer relevant.
- TTL is expressed in epoch time, seconds elapsed since Jan,1 1970 00:00.
- expiration time is set at the time of making the entry.
- When current time is greater than the TTL, the item will be expired and marked for deletion.
- You can filter out expired items from your queries and scans.

```
aws iam get-user

// Create SessionData table
aws dynamodb create-table --table-name SessionData --attribute-definitions \
AttributeName=UserID,AttributeType=N --key-schema \
AttributeName=UserID,KeyType=HASH \
--provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

// Populate SessionData Table
aws dynamodb batch-write-item --request-items file://items.json
```

DynamoDB --> Table --> Actions --> TTL --> name of TTL attribute --> preview and save

# Streams

- Time-ordered sequence of item level modifications(insert, update, delete).
- Logs are encrypted at rest and stored for 24 hours.
- Used typically for auditing, archiving of transactions, replaying transactions to different tables, trigger events based on specific change within the dynamodb table.
- Good for serverless architectures, to trigger lambda functions or application to perform operations based on change in DynamoDB entry.
- Accessed using a dedicated endpoint.
- By default, primary key is recorded.
- Before and after images can be captured.

![dynamodb-streams-usecase]({{site.cdn}}/aws/ddb/dynamodb-streams-usecase.png)

## Processing DynamoDB Streams
- Events are recorded in near real-time.
- Applications can take actions based on contents.
- Event source for lambda.
- Lambda polls the dynamodb stream.
- Executes Lambda code based on a DynamoDB streams event.

![dynamodb-streams-usecase-trigger-workflow]({{site.cdn}}/aws/ddb/dynamodb-streams-usecase-trigger-workflow.png)

