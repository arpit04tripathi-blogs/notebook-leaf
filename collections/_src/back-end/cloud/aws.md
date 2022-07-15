---
layout: page
title: AWS - Amazon Web Services
permalink: /aws/
---

- TOC
{:toc}

---

# Introduction

[AWS this Week](https://www.youtube.com/playlist?list=PLI1_CQcV71RmeydXo-5K7DAxLsUX6SVhL)

**AWS Associate Developer Certification Details**

![aws-associate-developer-cert-breakup]({{site.cdn}}/aws/intro/aws-associate-developer-cert-breakup.png)

![AWS Components]({{site.cdn}}/aws/intro/aws-components.png)

**AWS CLI Pagination**
- You can control the number of items included in the output when you run a cli command.
- By Default, AWS page size is 1000.
- eg. if you run `aws s3api list-objects my_bucket` on a bucket with 2500 objects, cli makes 3 calls to s3 but displays the entire output in one go.

**AWS CLI Pagination Errors**
- If you see errors while running list commands on a large number of resources, the default page size 1000 might be too high.
- You are most likely to see a time out error as api calls have exceeded the max allowed time to fetch the required results.
- To fix use `--page-size <100>` option to have the cli request a smaller number of items from each api call.
- cli still retrieves the full list, but performs large number of api calls in background and retrieves smaller number of items with each call.
```
aws s3api list-objects my_bucket --page-size 100
aws s3api list-objects my_bucket --page-size 100 --max-items 180
```
- use `max-items` to return fewer items in the cli output.

# Services

**Security, Identity, & Compliance**
- [IAM - Identity Access Management](iam)
- [KMS - Key Management System - Encryption](kms)

**Compute**
- [EC2 - Elastic Cloud Compute](ec2)
- [Serverless and Lambda](lambda)

**Storage**
- [S3 - Simple Storage Service](s3)
- [EBS - Elastic Block Storage](ebs)
- [Storage Gateway service](storage-gateway)

**Networking**
- [ELB - Elastic Load Balancer](elb)
- [Route53 DNS](route53)
- [CloudFront](cloudfront)
- [API Gateway](api-gateway)

**Database**
- [RDS](rds)
- [Elasticache](elasticache)
- [DynamoDB](dynamo-db)

**Application Integration Services**
- [SQS](sqs)
- [SNS](sns)
- [SES](ses)
- [Step Functions](step-functions)

**Analytics**
- [Kinesis Data Streams](kinesis)

**AWS Developer Tools**
- [AWS Developer Tools](aws-devtools) - CodeCommit, CodeDeployment, CodePipeline, AWS X-Ray

**Deployment and Administration**
- [CloudWatch Monitoring](cloudwatch)
- [Elastic Beanstalks](beanstalks)

**Containers**
- [ECS - Elastic Container Service](ecs)

**Management & Governance**
- [CloudFormation](cloudFormation) : contains intro to SAM (Sererless Application Model)