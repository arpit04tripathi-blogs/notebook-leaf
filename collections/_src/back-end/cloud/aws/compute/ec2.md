---
layout: page
title: EC2 - Elastic Cloud Compute
permalink: /aws/ec2
---

- TOC
{:toc}

---

# Introduction

* Amazon Elastic Cloud Compute
* Provides resizable compute capacity in the cloud.
* New Server Instance in minutes, allowing to scale capacity up or down as required.
* Pay only for capacity you use.
* Think of it as virtual server in the cloud

## Types of EC2
- On Demand
- Reserved
- Spot
- Dedicated Host

### On Demand
- Pay a fixed rate per hour with no commitment.
- No upfront payments or long-term commitment.
- For applications with short term, spiky or unpredicatable workloads that can't be interrpted.

### Reserved
- Provides you with a capacity reservation, significant discount on hourly charges.
- 1 or 3 years Term.
- Applications with steady state or predictable usage.
- Applications that require reserved capacity.
- Users can make upfront payments for further cost reduction
    - Standard RI : Upto 75% off on-demand
    - Convertible RI : Upto 54% off on-demand
        - Can change attributes of RI as long as new RI is of equal or greater value.
    - Scheduled RI - Available to launch within time window you reserve.
        - Allows you to match capacity for predicatable recurring schedule that requires only a fraction of day/month/year, ex. month end sale.

### Spot
- Bid prices for instance capacity, greater savings if your application have flexibile start and end times.
- For Genomic companies or pharmaceutical companies or chemical companies use this for doing huge amount of computing on 4 am of sunday morning to reduce cost.
- If a spot isntance is terminated by EC2, you will not be charged for partial hour of usage. However, if you terminate the instance yourself, you will be charged for the complete hour in which the instance ran.

### Dedicated Host
- Physical EC2 server for dedicated use, can help reduce cost by allowing you to use your existing server-bound software licenses.
- Used for regulatory requirements that may support multi-tenant virtualization.
- Great for licensing which does not support multi tenancy or cloud deployments.
- Can be purchased on-demand(hourly).
- Can be purchaed as a reservation for upto 70% off the on-demand price.

# Instance Types

![ec2-instance-types]({{site.cdn}}/aws/ec2/ec2-instance-types.png)

# EC2 Lab

AWS Console --> Services --> EC2 --> Launch Instance --> Amazon Linux AMI --> t2 micro free tier --> configure instance details --> Add root storage --> Add tags --> Create instance

![ec2-config]({{site.cdn}}/aws/ec2/ec2-config.png)

Instance created from AMI (Amazon Machine Images)

Web Security Group 
- Virtual firewall, request come and go from here
- port 80 , tcp http
- port 22 , tcp ssh

Use Putty and PuttyKeyGen for connecting to EC2 instance.
- EC2 instance launch will prompt you for creating a private key .pem file.
- Putty needs .ppk (putty private key) file, so use PuttyGen.
- Open putty, 
    - hostname = ec-2-user@ipv4_address
    - Port 22
    - SSH --> Auth --> load private key
    - save and load

```linux
sudo su
yum update -y
yum install httpd -y // install apache to turn into web server
service httpd start
chkconfig httpd on // initiate httpd on instance restart
service httpd status
cd /var/www/html
ls
echo
```

## EC2 CLI
```ssh
ssh ec2-user@ec2_ip_address -i MyNewKeyPair.pem
sudo su
aws s3 ls
aws configure
    - Create IAM User with programatic access with User Group
aws s3 mb s3://acloudguru-rk
echo "hello cloudgurus" > hello.txt
aws s3 cp hello.txt s3://acloudguru-rk
```

* Always give your users the minimum amount of access required. (Least Privilege)
* Create groups and assign users to group.
* Secret Access Key (visible once on creation) and Access Key ID
* Create Access Credentials for each user rather than sharing single.

## EC2 WIth S3 Role
* Create IAM Role for EC2 --> Permissions for s3Full Access
* EC2 Instance --> Actions --> Instance Settings --> Attach/Replace IAM Roles --> Select EC2 Role

```java
cd ~/.aws   // home_directory/.aws
dir %UserProfile%\.aws  // Windows
```

* Roles allows you to not use access_key_id and secret_access_key
* ***Roles are preferred from Security perspective.***
* Roles are controlled by policies.
* You can change a policy on a role and it will take immediate affect.
* You can attach and detach roles to running EC2 instances without having to stop or terminate these instances.
