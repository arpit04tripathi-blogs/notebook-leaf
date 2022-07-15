---
layout: page
title: Elastic Beanstalks
permalink: /aws/beanstalks
---

- TOC
{:toc}

---

# Introduction

- Elastic Beanstalk is a service to for deploying and scaling web applications developed in many languages: Java, .Net, node.js, python, ruby, Go and Docker onto widely used application server platforms like Apache Tomcat, Nginx, Passenger and IIS.
- Developers focus on writing the code and need not to worry about underlying infrastructure needed to run the application.
- You upload the code to EBS will handle deployment, capacity provisioning, load balancing, auto-scaling and application health.
- You retain full control of the underlying AWS resources powering your application and you pay only for the resources required to store and run your applications, eg. EC2 instances and S3 buckets.
- Fastest and simplest way to deploy your application in AWS.
- Automatically scales your application up and down.
- You can select EC2 instance type optimal for your application.
- You can retain full administration control over resources powering your application or let EBS do it for you.
- Managed platform updates feature automatically applies updates to your OS, Java, PHP, Node.js etc.
- Monitor and manage application health via dashboard.
- Integrated with cloudwatch and X-Ray for performance data and metrics.

# Beanstalks Deployment Policies

## All at Once
- Deploys the new version to all instances simultaneously.
- All of your instance are out of service while the deployment takes place.
- You will experience an outage while the deployment is taking place - not ideal for mission critical production system.
- If the update fails, you need to roll back the changes by re-deploying the original version to all your instances.

## Rolling Deployment
- Deploys the new version in batches.
- Each batch of instances is taken out of service while deployment takes place.
- Your environment capacity would be reduced by no. of instances in the batch.
- Not ideal for performance sensitive systems.
- If update fails, you need to perform an additional rolling update to roll back the changes.

## Rolling with additional batch
- Launches additional batch of instances.
- Deploys the new version in batches.
- Maintains full capacity during the deployment process.
- If the update fails, you need to perform an additional rolling update to roll back the changes.

## Immutable
- Deploys new version to fresh group of instances in their own new autoscaling groups.
- When the new instances pass their health checks, they are moved to your existing auto-scaling group and finally old instances are terminated.
- Maintains full capacity during deployment process.
- Impact of failed update is far less, and rollback process only requires terminating the new autoscaling group.
- Preferred option for mission-critical production systems.

# Configuring Beanstalks

- EBS can be configured by using EBS configuration file.
- eg. you can define packages to install, create linux users and group, run shell commands, specify services to enable or configure your load balancer etc.
- These are yaml files or json files
- can have name of your choice but extension should be .config and should be saved inside folder called .ebextensions

## Location of configuration file
- The .ebextensions folder must be included in the top-level directory of your application source code bundle.
- configuration files can be placed under source control along with the rest of your application code.

```json
// myHealthCheckUrl.config
{
    "option_settings":
        [
            {
                "namespace":"aws:elasticbeanstalk:application",
                "option_name":"My Application health check url",
                "value":"/healthcheck"
            }
        ]
}
```

This .config file configures an application health check url to be used by ELB.

# RDS and Beanstalks

EBS (Beanstalks) supports 2 ways of integrating an RDS DB with your Beanstalk environment.
- **Launch within the EBS env**
  - Launch RDS instance from within EBS console ie. RDS instance created within your EBS environment - good option for Dev and Test env.
  - However it is not good for production environment because lifecycle of DB is tied to lifecycle of your application environment. If you terminate the envirinment, DB instance is also terminated.
- **Launch outside the EBS env**
  - For Production environments, preferred option is to decouple RDS instance from your EBS envirinment ie. launch outside EBS, directly from RDS section of aws console.
  - This option gives you more flexibility, allows you to connect multiple environments to the same DB, provides choice of wider types of DB types, and allows your to tear down your application environment without affecting the DB instance.

## Access to RDS from Beanstalks
To allow EC2 instances in EBS env to connect to outside DB, there are 2 additional configuration steps
- An additional security group must be added to your environment's autoscaling group.
- You need to provide connectino string configuration info to your application servers (endpoint, password using EBS env properties)

# Deploying Docker with Beanstalks

- EBS supports deployment of docker containers.
- Docker containers are self-contained and include all the configuration information and software your web application requires to run - libraries, system tools, code and runtime.
- EBS handles the capacity provisioning, load balancing, scaling and application health monitoring.
