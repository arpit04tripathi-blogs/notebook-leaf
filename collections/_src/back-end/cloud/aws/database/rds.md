---
layout: page
title: RDS
permalink: /aws/rds
---

- TOC
{:toc}

---

# Introduction

* Relational Database Service
    - SQL Server
    - Oracle
    - MySQL Server
    - PostgreSQL
    - Aurora
    - MariaDB
* Non-Relational DB
- Need not to define columns at the time of creation.
- DynamoDB

|Non-Relational DB  |   |
|---                |---       |
|Collection         | Table    |
|Document           | Row      |
|Key Value Pairs    | Fields   |

# Data Warehousing

* Used for business intelligence. Tool slike Cognos, Jaspersoft, SQLServer Reporting Services, Oracle Hyperion, and SAP NetWeaver.
* Used to pull in very large and complex data sets. Usually used by management to do queries in data (such as current performance vs targets, etc.)

## OLTP vs OLAP
* Online Transaction Processing(OLTP) differs from Online Analytics Processing(OLAP) in terms of the types of queries you will run.
* OLTP Example
    - Frequent but simple transactions
    - Order number 2120354 pulls up a row of data such as Name, Date, Address to Deliver to, Delivery status etc.
* OLAP Example
    - RedShift
    - Infrequent but complex transactions
    - Net profit of EMEA and Pacific for Digital Radio Product pulls in large number of records.
    - Sum of radios sold in EMEA.
    - Unit cost of Radio in each region.
    - Sales price - unit cost.
* Database Warehousing DB use a different type of architecture both from a DB perspective and infrastructure layer.

# RDS Lab

AWS Services --> RDS --> Create DB --> will get dns rather than ip address
- Amazon Aurora not available in free tier
- VPC Security Group

EC2 --> Advanced Details --> Add Bootsrap Scripts

* Bootstrap scripts starts with shabang #!
```
#!/bin/bash
yum install httpd php-mysql -y
yum update -y
chkconfig httpd on
service httpd start
...
```

* RDS in one Security Group while EC2 in other Security Group, how to communicate?
    - Open port 3306 in RDS to EC2 security group as communication is EC2 -> RDS
    - Add SG to inbound value

# RDS Backups

* Two types of backups
    - Automated Backups
    - Database Snapshots

## Automated Backups
- Allow to recover your DB to any point in time within **retention period**
- retention period can be between 1 and 35 days.
- Takes full daily snapshots and also stores transaction logs throughout the day.
- When you do recovery, AWS first choose most recent daily backup, and then apply transaction logs relevant to that day. This allows you to point down the recovery upto specific second in time, within retention period.
- enabled by default.
- backup data stored in s3.
- free storage equals to size of DB ie. 10 Gb RDS instance will have 10 Gb sorage on s3.
- Backups are taken within defined window.
- During backup window, storage I/O may be suspended while your data is being backed-up and you may experience elevated latency.
- Deleting RDS instance also deletes Automated backup.

## Snapshots
- DB snapshots are done manually ie. user initiated.
- They are stored even after you delete the original RDS instance, unlike automated backups.

# Restoring Backups

* Whenever you restore either an automatic backup or a manual snapshot, the restored version of the database will be a new RDS isntance with a new DNS endpoint.

```
original.eu-west-1.rds.amazonaws.com --> restored.eu-west-1.rds.amazonaws.com
```

# RDS Encryption

* Encryption at rest is supported for MySQL, Oracle, SQL Server, PostgreSQL, MariaDB and Aurora.
* Encryption done using AWS Key Management Service(KMS).
* Once RDS instance is encrypted, it applies to
    - data stored at rest in the underlying storage
    - Automated Backups
    - Read replicas
    - Snapshots
* Encrypting existing DB is not yet supported
    - Create snapshot, make a copy of the snapshot and encrypt the copy, then restore it.

```
RDS --> Instance Actions --> Create replicas or restore
RDS --> Snapshots --> Actions --> Copy --> Enable Encryption
```

# RDS Multi-AZ

![multi-az]({{site.cdn}}/aws/ec2/multi-az.png)

* Multi-AZ allows you to have an exact copy of your production database in another availabilty zone. (Standby DB)
* AWS handles the replication for you, write to production database is automatically synchronized to the standby database.
* For planned DB maintenance event, DB instance failure, or Availability Zone failure, amazon RDS will automatically failover to standby so that DB operations can resume quickly without administrative intervention. For this reason we deal with DNS name rather than ip-addresses.
* ***Multi-AZ is for Disaster Recovery only, For performance improvement use Read Replicas***
* Multi-AZ Databases - SQL Server, Oracle, MySQL Server, PostgreSQL, MariaDB

## Read Replicas

![read-replica.png]({{site.cdn}}/aws/ec2/read-replica.png)

* Allow you to have read-only copy of your production DB.
* Achieved by using Asynchronous replication from the primary RDS instance to the read replica.
* Used primarily for very read-heavy database workloads.
* Available for - MySQL Server, PostgreSQL, MariaDB, Aurora.
* Used for scaling, not for Disaster Recovery.
* Must have automatic backups turned on in order to deploy read replicas.
* Can have upto 5 read replica copies of any DB.
* You can have read replicas of read replicas, with some latency.
* Each read replica will have its own DNS endpoint.
* You can have read replicas that have Multi-AZ.
* You can create read replicas of Multi-AZ source DB.
* Read replicas can be promoted to be their own DB, this breaks the replication.
* You can have read replicas in a different region.
* Can enable encryption on read replicas even if source RDS instance is not encrypted.

## How to create Read Replica?
	- Step 1 : AWS console > RDS > Select instance 
    - Create Read Replica : Step 1 > Instance Actions > Create read replica
    - Apply Multi-AZ : Step 1 > Instance Action > Modify > check multi-az as yes.

![read-replica-encrypt.png]({{site.cdn}}/aws/ec2/read-replica-encrypt.png)
