---
layout: post
title: CloudFormation
permalink: /aws/cloudformation
---

- TOC
{:toc}

---

- Service that allows you to manage, configure and provision your aws infrastructure as code.
- Resources are defined using a cloudFormation template.
- cloudFormation interprets the template and makes the appropriate api calls to create the resources you have defined.
- supports yaml or json.

# CloudFormation Benefits
- Infrastructure is provisioned consistently with fewer mistakes.
- Less time and efforts than configuring manually.
- You can version control and peer review your templates.
- Free to use (Charged for what you create)
- Can be used to manage updates and dependencies.
- Can be used to rollback and delete the entire stack as well.

# CloudFormation Template
- YAML or JSON template used to describe the endstate of the infrastructure you are either provisioning or changing.
- After creating the template, you upload it to cloudFormation using S3.
- CloudFormation reads the template and makes the API calls on your behalf.
- The resulting resources are called a stack.

![]({{site.cdn}}/aws/dev-theory/cloudformation-template-structure.png)

- Resources is the only mandatory section of the template.
- Transform section is used to reference additional code stored in S3, allowing for code re-use eg. for lambda code or template snippets / reusable pieces of cloudFormation code.

# SAM (Sererless Application Model)
- extension to cloudFormation used to define serverless applications.
- Simplified syntax for defining serverless resources: APIs, Lambda Functions, DynamoDB tables etc.
- Use SAM CLI to package your deployment code, upload it to S3 and deploy your serverless application.

```
sam package \
  --template-file ./mytemplate.yml \
  --output-template-file sam-template.yml \
  --s3-bucket s3-bucket-name

sam deploy \
  --template-file sam-template.yml \
  --stack-name mystack \
  --capabilities CAPABILITY_IAM
```

# CloudFormation Nested Stack
- Nested Stacks allow re-use of CloudFormation code for common usecase.
- eg. standard configuration for a load balancer, web server, application server etc.
- Instead of copying out the code each time, create a standard template for each common usecase and reference from within your CloudFormation template.
