---
layout: page
title: CloudWatch Monitoring
permalink: /aws/cloudwatch
---

- TOC
{:toc}

---

# Introduction

Amazon CloudWatch is a monitoring service to monitor your AWS resources, as well as the applications that you run on AWS.

CloudWatch can monitor
- Compute
  - Autoscaling Groups
  - Elastic Load Balancers
  - Route53 Health Checks
- Storage and Content Delivery
  - EBS Volumes
  - Storage Gateways
  - CloudFront
- Database & Analytics
  - DynamoDB
  - Elasticache Nodes
  - RDS Instances
  - Elastic MapReduce Job Flows
  - RedShift

Host Level Metrics
- CPU
- Network
- Disc
- Status Check

* RAM Utilization is a custom Metric.  
* By ***default, EC2 monitoring is 5 minute intervals***, unless you enable ***detailed monitoring which will then make it 1 minute intervals***.

# How long are CloudWatch Metrics Stored?
- You can retrieve data using the GetMetricStatistics API or by using 3rd Party tools offered by AWS Partners.
- You can store your log data in CloudWatch logs for as long as you want. By default, CloudWatch logs will store your log data indefinitely. You can change the retention for each log group at any time.
- You can retrieve data from any terminated EC2 or ELB instance after its termination.

# Metric Granularity
- It depends on AWS service. Many default metrics for many ***default services are 1 minute***, but it can be 3 or 5 minutes depending on the service.
- For custom metrics the minimum granularity that you can have is 1 minute.

# CloudWatch Alarms
- You can create an alarm to monitor any Amazon CLoudWatch metric in your account. This can include EC2 CPU Utilization, ELB Latency or even the charges on your AWS bill.
- You can set the appropriate thresholds in which to trigger the alarms and also set the actions that needs to be taken if alarm state is reached.

**NOTE :** 
- CloudWatch can be used on-premise, not restricted to just AWS resources.
- Just need to download and install the SSM agent and CloudWatch agent.

# CloudWatch vs CloudTrail vs Config
- CloudWatch monitors performance.
- CloudTrail monitors API calls in the AWS platform.
- AWS Config records the state of your AWS environment and can notify you of changes.
