---
layout: page
title: AWS Developer Tools
permalink: /aws/aws-devtools
---

- TOC
{:toc}

---

# Introduction

- **CodeCommit** - Source and Version Control
  - Source control service enabling teams to collabrate on code, html pages, script, images and binaries.
  - Central code repository.
- **CodeBuild** - Automated Build
  - Compiles source code, runs tests and roduces packages that are ready to deploy.
- **CodeDeploy** - Automated Deployment
  - Automates code deployment to any instance, including EC2, lambda, on-premises.
- **CodePipeline** - Manages the workflow
  - End-to-End solution, build, test and deploy your application everytime there is a code change.

# CICD

- Software industry best practice.
- Continuous Integration Continuous Delivery/Deployment

## Benefits of CICD Approach
- Automation is good - Fast, repeatable, scalable, enables rapid deployment.
- Manual is bad - Slow, error prone, inconsistent, unscalable, complex.
- Small Changes - Test each code change and catch bugs while they are small and simple to fix.

## Continuous Integration Workflow
- Shared code repository - Multiple developers contributing to a shared code repository like git. Frequently merging or integrating code updates.
- Automated Build - When changes appear in the code repository, this triggers an automated build of the new code.
- Automated Test - Run automated tests to check the code locally before it is committed into the master code repository.

## Continuous Delivery and Deployment Workflow
- Code is Merged - After successful tests, the code gets merged to the master repository.
- Prepared for Deployment - Code is biuld, tested and packaged for deployment.
- **Manual Decision** - Humans involved in decision to deploy the code. Continuous Delivery.
- or **Fully Automated** - System deploys the code as soon as it is ready for deployment. This is known as Continuous Deployment.

# CodeCommit

- Centralized code repository
  - A place to store source code, binaries, libraries, images, html pages etc. based on git.
- Enables Collabration
  - Manages updates from multiple users.
- Version Control
  - Tracks and manages code changes.
  - Maintains version history.
- Supports https and ssh
- Supports notifications via SNS and cloudwatch.

![]({{site.cdn}}/aws/dev-theory/codeCommit.png)

# CodeDeployment

![]({{site.cdn}}/aws/dev-theory/code-deploy-approaches.png)

## CodeDeployment Approaches

### In Place
- Known as rolling update.
- Application is stopped on each instance, capacity is reduced during deployment.
- You should configure your ELB to stop sending requests to the instance.
- CodeDeploy installs new version, known as Revision.
- Instance comes back into service and registered with ELB.
- CodeDeploy contiunes to deploy to next instance.

**How to Rollback?**
- No quick fix.
- You will need to redeploy the previous version, time consuming.

### Blue/Green
- Blue represents the current version of our application.
- New instances are provisioned and the new release (Revision) is installed on the new isntances.
- Green is the new release (environment), gets registered with the ELB.
- Traffic is routed away from the Blue environment.
- Once everything works fine, we can terminate the blue environment.

**How to Rollback?**
- Re-register Blue environment.
- Route Traffic back to Blue environment.
- De-register green environment

|In Place | Blue/Green |
|---|---|
|Capacity Reduced during Deployment|No capacity reduction.|
|Lambda is not supported.|Green instances can be created ahead of time.|
|Rolling back involves a re-deploy.|Easy to switch between old and new.|
|Great when deploying the first time.|You pay for 2 environments until you terminate the old one.|

# AppSpec File

- Configuration file defining parameters to be used during CodeDeploy deployment.
- For EC2 and On-Premise systems, YAML only.
- Lambda - YAML and JSON supported.
- File structure depends on whether you are deploying on EC2 or Lambda.

## EC2 AppSpec File
- version
  - reserved for future use.
  - currently allowed value is 0.0
- OS - Operating system version being used eg. linux or windows.
- files
  - configuration files, packages.
  - location of any application file that needs to be copied and where they need to be copied to.
- hooks
  - lifecycle hooks
  - scripts to run at certain point during the deployment lifecycle.
  - Hooks have a very specific run order.

**Example of scripts**
- unzip files - unzip application files prior to deployment.
- run tests - run functional tests on newly deployed application.
- deal with load balancing - de-register and re-register instances with load balancer.

![]({{site.cdn}}/aws/dev-theory/appspec-yaml.png)

**Typical Folder Setup**
- /Scripts
- /Config
- /Source
- appspec.yml must be placed in root directory otherwise deployment will be failed.

![]({{site.cdn}}/aws/dev-theory/code-deploy-lifecycle.png)

# CodePipeline

A fully managed CICD service 
- Orchestrates build, test and deployment
  - Pipeline is triggered everytime there is a change to your code. Like a conductor in orchestra.
- Automated release process
  - Fast, consistent, fewer mistakes.
  - Enables quick release of new features and bug fixes.
- CodePipeline integrates with
  - CodeCommit, CodeBuild, CodeDeploy, GitHub, Jenkins, Elastic Beanstalk, CloudFormation, Lambda, Elastic Container Service.

![]({{site.cdn}}/aws/dev-theory/codePipeline-workflow.png)

![]({{site.cdn}}/aws/dev-theory/codePipeline-architecture.png)

# AWS X-Ray

- AWS X-Ray is a service that collects data about requests that your application serves, and provides tools you can use to view, filter, and gain insights into that data to identify issues and opportunities for optimization.
- For any traced request to your application, you can see detailed info not only about the request and response, but also about the calls that your appication makes downstream AWS resources, microservices, databases and HTTP web APIs.

![aws-x-ray.png]({{site.cdn}}/aws/serverless/aws-x-ray.png)

## X-Ray SDK
It provides
- Interceptors to add to your code to trace incoming HTTP requests.
- Client handlers to instrument AWS SDK clients that your application uses to call other AWS Services.
- An HTTP client to use to instrument calls to other internal and external HTTP web services.

![]({{site.cdn}}/aws/serverless/x-ray-overview.png)

- AWS X-Ray SDK sends the data to the X-Ray daemon which buffers segments in a queue and uploads them to X-Ray in batches.
- You need both X-Ray SDK and X-Ray Daemon on your systems.

## X-Ray Integration
X-Ray integrates to following AWS Services
- ELB
- AWS Lambda
- API Gateway
- Elastic Compute Cloud (EC2)
- Elastic BeanStalk

## X-Ray Languages
- Java, Go, Node.js, Python, Ruby, .Net

## X-Ray High Level Configuration Steps
High level requirements
- X-Ray SDK
- X-Ray Daemon

You use the SDK to instrument your application to send the required data eg. data about incoming and outgoing HTTP requests that are being made to your Java application.

On-Premise or EC2 Instances
- Install X-Ray Daemon to your EC2 instance or on-premise server.
Elastic Beanstalk
- Install X-Ray Daemon on the EC2 instances inside your EBS environment.
Elastic Container Service
- Install X-Ray daemon in its own docker container on your ECS cluster alongside your app.

## Annotations and Indexing
**Annotations** 
- When instrumenting your application, you can record additional information about requests by using annotations.
- Annotaions are simply Key-Value Pairs that are indexed for use with filter expressions, so that you can search for traces that contain specific data and group related traces together in the console - eg. game_name=TicTacToe, game_id=2645445842

