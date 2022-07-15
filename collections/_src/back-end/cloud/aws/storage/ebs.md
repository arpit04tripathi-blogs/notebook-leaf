---
layout: page
title: EBS - Elastic Block Storage
permalink: /aws/ebs
---

- TOC
{:toc}

---

* Elastic Block Storage
* Think of it as virtual disk in the cloud
* Allows to create storage volumes and attach them to EC2 instance.
* Once atttached, you can create a file system on these volumes (called root device volume), run a db, or use as a simple block device.
* EBS volumes are placed in a specific availability zones, where they are automatically replicated to protect you from the failure of a single component.

# EBS Volume Types

## SSD
### General Purpose SSD (GP2)
* For general use, balances both price and performance.
* Ratio of 3 IOPS per GB with upto 10,000 IOPS and the ability to burst upto 3000 IOPS for extended periods of time for volumes at 3334GiB and above.
### Provisioned IOPS SSD (IO1)
* Designed for I/O intensive applications such as large relational or NoSQL db.
* Use if you need more than 10,000 IOPS.
* Can provision upto 20,000 IOPS per volume.
### Throughput Optimized HDD(ST1)
* Big Data
* Data Warehouses
* Log Processing
* Cannot be a boot volume

## Magnetic
### Cold HDD(SC1)
* Lowest cost Storage for infrequent accessed workloads.
* File Server
* Cannot be a boot volume.
### Magnetic (Standard)
* Legacy
* Lowest cost per GB of all EBS types.
* Bootable storage.
* Ideal for workloads where data is accessed infrequently, and low cost is important.

