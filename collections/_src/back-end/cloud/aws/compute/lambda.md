---
layout: page
title: Serverless and Lambda
permalink: /aws/lambda
---

- TOC
{:toc}

---

# Serverless Computing Introduction

![history-of-cloud]({{site.cdn}}/aws/serverless/history-of-cloud.png)

![serverless-usecase]({{site.cdn}}/aws/serverless/serverless-usecase.png)

# Lambda Introduction

## What is Lambda?
- ***AWS Lambda*** is a compute service where you can upload code and create lambda functions. AWS lambda takes care of provisioning and managing the servers that you use to run the code. You don't have to worry about the OS, patching, scaling etc.
- You can use Lamda in following ways
    - As an event driven compute service where AWS Lambda runs your code in response to events. These events could be changes in data in ana Amazon S3 bucket or an Amazon DynamoDB table.
    - As a compute service to run your code in response to HTTP requests using amazon API Gateway or API calls made using AWS SDKs, This is what is used at Cloud Guru.

* Cloud Guru hosts everything on AWS with videos stored in S3 with CloudFront as CDN provider
  - These videos are stored in a Data Centres
  - Data Centres have Hardware, things like Sands, Servers, Switches, Routers, Firewalls, load balancers etc.
  - These devices use Assembly code/Protocols
  - Developers learn High Level Languages
- To use these languages we have Operating Systems
- Interaction happens either via Application Layer(Chrome, explorer etc.) or via AWS APIs when using console
  - Final Layer of abstraction is AWS Lambda, any api calls to api gateway  triggers lambda functions in background.
* So, Lamda is the latest abstraction layer which means you only have to worry about the codem other things are taken care of by Lambda.

## How is Lamda Priced ?
- Number of Requests
    - First 1 million req are free, 0.2$ per million requests per month thereafter.
- Duration
    - Duration is calculated from time when your code begins executing until it returns or otherwise terminates, rounded up to nearest 100ms. The price depends on the amount of memory allocated to your function.
    - You are Charged $0.00001667 for every GB-second use.

## Why is Lambda Cool?
- No Servers - No System, database, network administrators
- Continuous Scaling - Lamda scales out(not up) automatically.
- Cost effective
- Lambda functions are independent, 1 event = 1 function
- When talking to alexa, you are talking to Lambda.
- Lamda funtions can trigger other lambda functions, 1 event can = x functions if functions triggers other functions.
- Architectures can get extremely complicated, AWS X-ray allows you to debug what is happening.
- Lambda can do things globally, you can use it to backup S3 buckets to other S3 buckets etc.
- You should know your lambda triggers.

## Lambda Concurrent Execution Limit
- Safety feature to limit the number of concurrent executions across all functions in a given region per account.
- Default 1000 per region, 429-TooManyRequestsException for Request throughput limit exceeded.
- You can request an increase in this limit by submitting a request to AWS support center.
- **Reserved Concurrency** guarantees that a set number of executions which will always be available for your critical function, however this also acts as limit.

# Version Control in Lambda

- Publish one or more versions of your lambda functions.
- Can work with different variations of your lambda function in development workflow, such as development, beta and production.
- Each lambda function version has a unique ARN(Amazon Resource Name).
- Once published a version, it is immutable(ie. it can't be changed).
- latest function code is maintained by AWS Lambda in $LATEST version.
- You can refer to this function by using ARN. There are two ARNs associated with initial version:
    - Qualified ARN - function ARN with version suffix
        - arn:aws:lambda:aws-region:acct-id:function:helloworld:$LATEST
    - UNQUALIFIED ARN - function ARN without the version suffix.
        - arn:aws:lambda:aws-region:acct-id:function:helloworld
- Alias - After creating version 1($LATEST), create alias PROD to point to version 1.
    - Once version 2 is published, update the alias PROD mapping to version 2.
    - In case of failure you can rollback to pred=vious version just by remapping the alias PROD.
- You can use versioning to split traffic for using BLUE-GREEN strategy

![]({{site.cdn}}/aws/serverlesl/../serverless/lambda-alias.png)

## LAB

- Create new lambda --> Qualifiers --> Version ($LATEST) --> Action --> Publish new version (Version 1)
- Edit in $LATEST --> Action --> Publish new version (Version 2)
- Create new alias --> Version 2 --> Additional Version as Version 2 with % load
    - Doesn't work with $LATEST

* Echo --> Hardware
* Alexa --> Voice Service

![lambda-version-control.png]({{site.cdn}}/aws/serverless/lambda-version-control.png)

# Lambda and VPC

![]({{site.cdn}}/aws/serverless/lambda-and-vpc.png)

- Some usecases require lambda to access resources which are inside a private VPC.
- eg. read or write a RDS daabase, or shut down an EC2 instance in response to security alert.

## Enabling Lambda to Access VPC Resources
- To enable this, you need to allow the finction to connect to private subnet.
- Lambda needs the following VPC Configuration information so that it can connect to VPC
  - Private subnet id
  - Security group id (eith required access)
  - lambda uses this information to setup ENI(Elastic Network Interfaces) using an available ip address from your private subnet.
- Add `vpc-config` parameter to your lambda

```
aws lambda update-function-configuration --function-name my-function --vpc-config SubnetIds=subnet-1122aabb,SecurityGroupIds=sg-51530134
```

# Simple Serverless Website

- Using Route53, API Gateway, Lambda, S3

![simple-serverless-website]({{site.cdn}}/aws/serverless/simple-serverless-website.png)

- Create S3 static website hosting bucket (helpmestudy)
- Purchase Route53 DNS helpmestudy.com
- Bucket name and Domain must be same (till .com) for this to work otherwise it will fail.
- Create Lambda Function
    - Author from Scratch
    ![lambda-function-create]({{site.cdn}}/aws/serverless/lambda-function-create.png)
    - Define Function Name, Runtime Language, select Create new role and provide name (MyLambdaRole) and select policy template (Simple microservice permissions)
- Add API Gateway trigger to Lambda
    - Configure Trigger
    ![lambda-function-trigger.png]({{site.cdn}}/aws/serverless/lambda-function-trigger.png)
    - create new method
    ![lambda-function-method.png]({{site.cdn}}/aws/serverless/lambda-function-method.png)
- Actions --> Deploy API
- Route53 --> Hosted Zones(purchased domains) --> Select helpmestudy.com --> Create A Record (ipv4) with Alias as helpmestudy.com
    - here s3 bucketname and dns name should be same else, Alias Target will not be populated with desired entry.
    ![lambda-function-record.png]({{site.cdn}}/aws/serverless/lambda-function-record.png)
