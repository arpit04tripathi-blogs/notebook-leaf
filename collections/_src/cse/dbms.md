---
layout: post
title: Database Management System
permalink: /dbms
---

- TOC
{:toc}

---

# ToDo
- Why DBMS
- Normalization – 1NF, 2NF, 3NF, BCNF
- Query Injection
- Parameterized Query
- Indexing – Types, How(B+, B, 2-3-4 trees)
- View
- SQL Queries
- DCL, DML
- Date, String Functions
- ACID, BASE
- CAP Theorem
- Transaction Management
- Serializability
- Sharding
- [UNION and UNION ALL](https://www.java67.com/2014/09/difference-between-union-vs-union-all-in-SQL.html?m=1){:target="_blank"}

# ACID properties

- Certain properties are followed in order to maintain consistency in a database, before and after the transaction.

|ACID Properties||
|---|---|
|**Transaction**|A unit of program that updates various data items.<br>To ensure the integrity of data during a transaction, the database system maintains the ACID properties.|
|**Atomicity**|Ensures that either all the operations of a transaction reflect in database or none. No partial transactions.<br>Example - transferring amount between accounts.|
|**Consistency**|To preserve the consistency of database, the execution of transaction should take place in isolation (that means no other transaction should run concurrently when there is a transaction already running).<br>Example - A(400) -> 100 to each B and C. Final should be 200, not 300 which happens in concurrent transaction.|
|**Isolation**|Transactions occur independently without interference.<br>For every pair of transactions, one transaction should start execution only when the other finished execution.<br>Ensures that execution of transactions concurrently will result in a state that is equivalent to a state achieved these were executed serially in some order.|
|**Durability**|On successful transaction completion, changes made should be permanent even if there is a system failure. Stored on non-volatile memory.<br>recovery-management component of database systems ensures the durability of transaction.|

![ACID properties]({{site.cdn}}/cse/dbms/ACID%20Properties.jpg)

# Database Normalization

**Database Normalization** is the process of efficiently organizing data in a database. There are two reasons of the normalization process:
- Eliminating redundant data, for example, storing the same data in more than one tables.
- Ensuring data dependencies make sense.

* Both of these are worthy goals as they reduce the amount of space a database consumes and ensure that data is logically stored. Normalization consists of a series of guidelines that help guide you in creating a good database structure.
* Normalization guidelines are divided into normal forms; think of form as the format or the way a database structure is laid out. The aim of normal forms is to organize the database structure so that it complies with the rules of first normal form, then second normal form, and finally third normal form.
* It's your choice to take it further and go to fourth normal form, fifth normal form, and so on, but generally speaking, third normal form is enough.
	- [First Normal Form (1NF)](https://www.tutorialspoint.com/sql/first-normal-form.htm)
	- [Second Normal Form (2NF)](https://www.tutorialspoint.com/sql/second-normal-form.htm)
	- [Third Normal Form (3NF)](https://www.tutorialspoint.com/sql/third-normal-form.htm)
    - BCNF
