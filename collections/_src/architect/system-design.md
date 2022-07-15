---
layout: page
title: System Design
permalink: /system-design
---

- TOC
{:toc}

---

# Introduction

- [Steps To Approach A System Design Problem](how-to-approach-a-problem)

## Non-Scalable Apps
- [Parking Lot](https://www.youtube.com/watch?v=DSGsa0pu8-k){:target="_blank"}
- Chess
- Card Game
- Lift System
- Atm dispatch
- Vaccum Cleaner
- LRU Cache
- ParkingLot: Automated Solution for Parking-Lots.
- Designing the Chess Game

## Scalable Apps
- Tiny Url
- WhatsApp
- [Uber](scalable/uber)
- MakeMyTrip
- BookMyShow
- [twitter](https://www.youtube.com/watch?v=KmAyPUv9gOY){:target="_blank"}

- BookMyShow: Movie ticket booking application.
- MyFlipcart : Complete e-commerce application.
- ParkingLot: Automated Solution for Parking-Lots.
- BlackJack: A most popular card game in casinos.
- Designing a Live Cricket Commentary Application

# Storage Scalability Introduction

- no design is correct or wrong, there are just good designs and bad designs which heavily depend on the use case.
- Hence, it is extremely important to clarify the requirements for the problem asked.

### Pre Requisites
Have some experience working with a relational DB ( like MySQL ).
- Have a basic idea about NoSQL DBs.
- Understand the basics of the following : 
    -  **Concurrency** : Do you understand threads, deadlock, and starvation? What happens when multiple processes / threads are trying to modify the same data? A basic understanding of read and write locks.
    -  **Networking** : Do you roughly understand basic networking protocols like TCP and UDP? Do you understand the role of switches and routers?
    -  **File systems** : You should understand the systems you’re building upon. Do you know roughly how an OS, file system, and database work? Do you know about the various levels of caching in a modern OS?

## Basic Terminologies

### Replication
Replication refers to frequently copying the data across multiple machines. Post replication, multiple copies of the data exists across machines. This might help in case one or more of the machines die due to some failure.

### Consistency
Assuming you have a storage system which has more than one machine, consistency implies that the data is same across the cluster, so you can read or write to/from any node and get the same data.

### Eventual consistency
Exactly what the name suggests. In a cluster, if multiple machines store the same data, an eventual consistent model implies that all machines will have the same data eventually. Its possible that at a given instance, those machines have different versions of the same data ( temporarily inconsistent ) but they will eventually reach a state where they have the same data.

### Availability
In the context of a database cluster, Availability refers to the ability to always respond to queries ( read or write ) irrespective of nodes going down.

### Partition Tolerance
In the context of a database cluster, cluster continues to function even if there is a “partition” (communications break) between two nodes (both nodes are up, but can’t communicate).

### Vertical scaling and Horizontal scaling
- In simple terms, to scale horizontally is adding more servers.
- To scale vertically is to increase the resources of the server ( RAM, CPU, storage, etc. ). 
- Example: Lets say you own a restaurant which is now exceeding its seating capacity. One way of accommodating more people ( scaling ) would be to add more and more chairs (scaling vertically). However since the space is limited, you won’t be able to add more chairs once the space is full. 
Another way of scaling would be to open new branches of the restaurant ( horizontal scaling ).

### Sharding
With most huge systems, data does not fit on a single machine. In such cases, sharding refers to splitting the very large database into smaller, faster and more manageable parts called data shards.

## CAP Theorem

CAP Theorem states that in a distributed system, it is impossible to simultaneously guarantee all of the following:
- Consistency
- Availability
- Partition Tolerance

> Read More and update notes on [CAP Theorem in plain english](http://ksat.me/a-plain-english-introduction-to-cap-theorem)

## Steps To Approach A Problem

### Step 1 - Feature expectations ( First 2 mins ) : 
As said earlier, there is no wrong design. There are just good and bad designs and the same solution can be a good design for one use case and a bad design for the other. It is extremely important hence to get a very clear understanding of whats the requirement for the question.

### Step 2 - Estimations ( 2-5 mins ) 
Next step is usually to estimate the scale required for the system. The goal of this step is to understand the level of sharding required ( if any ) and to zero down on the design goals for the system.

For example,  
- if the total data required for the system fits on a single machine, we might not need to go into sharding and the complications that go with a distributed system design.  , OR 
- if the most frequently used data fits on a single machine, in which case caching could be done on a single machine.

### Step 3 - Design Goals ( 1 mins ) 
Figure out what are the most important goals for the system. It is possible that there are systems which are latency systems in which case a solution that does not account for it, might lead to bad design.

### Step 4 - Skeleton of the design ( 4 - 5 mins ) 
30-40 mins is not enough time to discuss every single component in detail. As such, a good strategy is to discuss a very high level with the interviewer and go into a deep dive of components as enquired by the interviewer.

### Step 5 - Deep dive ( 20-30 mins ) 
This is an extension of the previous section.

## System Design Useful Reads

- Master Slave : https://www.quora.com/What-are-Master-and-Slave-databases-and-how-does-pairing-them-make-web-apps-faster 
- Real life example of scaling using MySQL : https://medium.com/@Pinterest_Engineering/sharding-pinterest-how-we-scaled-our-mysql-fleet-3f341e96ca6f
- https://en.wikipedia.org/wiki/Paxos_(computer_science)

# Steps To Approach A System Design Problem

## Step 1 - Feature expectations ( First 2 mins ) : 
As said earlier, there is no wrong design. There are just good and bad designs and the same solution can be a good design for one use case and a bad design for the other. It is extremely important hence to get a very clear understanding of whats the requirement for the question.

## Step 2 - Estimations ( 2-5 mins ) 
Next step is usually to estimate the scale required for the system. The goal of this step is to understand the level of sharding required ( if any ) and to zero down on the design goals for the system.

For example,  
- if the total data required for the system fits on a single machine, we might not need to go into sharding and the complications that go with a distributed system design.  , OR 
- if the most frequently used data fits on a single machine, in which case caching could be done on a single machine.

## Step 3 - Design Goals ( 1 mins ) 
Figure out what are the most important goals for the system. It is possible that there are systems which are latency systems in which case a solution that does not account for it, might lead to bad design.

## Step 4 - Skeleton of the design ( 4 - 5 mins ) 
30-40 mins is not enough time to discuss every single component in detail. As such, a good strategy is to discuss a very high level with the interviewer and go into a deep dive of components as enquired by the interviewer.

## Step 5 - Deep dive ( 20-30 mins ) 
This is an extension of the previous section.

# System Design Questions

## Uber System Design

### Reference
- [Uber](https://www.youtube.com/watch?v=J3DY3Te3A_A){:target="_blank"}
- [Design Patterns - Cristopher Okhravi](https://www.youtube.com/watch?v=v9ejT8FO-7I&list=PLrhzvIcii6GNjpARdnO4ueTUAVR9eMBpc)
- [design-patterns-for-humans](https://github.com/kamranahmedse/design-patterns-for-humans)
- [awesome-system-design](https://github.com/madd86/awesome-system-design)

### Introduction

1. Extensible
2. Maintainable
3. Testable

> 12 Factor App - website

### HLD (High Level Design)
- Consistent hashing
- LB
- CAP
- Sharding
- Vertical vs horizantal scale
- caching and cdn
- message queues

### LLD (Low Level Design)
- OOP (Depth)
- Design Patterns

Programming Paradigm
- Functional
- OOP
- event driven
- data oriented
- aspect oriented
- declarative - sql

Gather Requirements
- Riders can book a cab
- Rider can see nearby cab's location
- Once booked, both rider and driver can see each other location until the ride finishes
- Each cab must have details like license, color, brand, driver details
- When booking, only cabs within max radius are shown
- ETA is calculated based on the eucledian distance + 50%
- Multiple types of booking - XL, Pool, Prime, Go, Outstation
- Registration for drivers and riders
- Update cab's location every 10 seconds
- Driver can turn off his availability
- Rider can see history of bookings and upcoming bookings
- Driver can end the trip/ rider can cancel
- OTP
- Driver must accept the ride.
- Estimated and actual cost of ride.

Use Cases
- Actors - Rider, Driver, Internal Employee (Employees)
- Entities
  - Finding the nouns
  - Rider, cab, driver, booking/ride, OTP, Payment, Payment Receipt

Service
- OTP Service
- registration service
- Pricing Strategy
- Matching Strategy
- ETA Service
- Payment Service
- Notification Service
- location service
- tracking service
- Payment Gateway

Driver Entity
- Name
- Contact
- License
- Ratings
- Availability

Cab
- Number
- Brand
- Model
- Color
- cab type
- ac/non-ac
- Capacity

Rider
- Name
- Phone
- Gender
- profile
- Preferred Payment
- Prefered cab type

Trip
- Origin
- Dest
- Estimated cost
- Final Cost
- Trip Type - oustation, pool, rental
- status
- otp

Location
- latitude
- longitude
- zipcode
- landmark
- city
- state
- country

Relationships
- Driver <-> Cab (1-on-1)
- Driver <-> location (1-on-1)
- Driver <->> Booking (1-to-Many)
- Cab <<-> Cab Type
- Rider <<->> Booking
- Rider <<-> Locations
- Trip <-> Driver
- Trip <->> Rider
- Booking <<->> Location
- Location <->> Booking
- Booking <-> OTP
- Booking <-> Status
- Booking <->> Payment Receipt
- Rider <->> Booking
- Trip <->> Booking

For PUBG Type games, location update can be done by persistence connections like socket.


3 Anomalies
- Insert Anomaly
- Delete Anomaly
- Update Anomaly
