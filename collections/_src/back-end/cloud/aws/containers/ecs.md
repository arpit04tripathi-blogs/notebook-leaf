---
layout: page
title: ECS - Elastic Container Service
permalink: /aws/ecs
---

- TOC
{:toc}

---

# What are Containers?
- Similar to Virtual Machine, more like virtual operating environment.
- A standardized unit with everything the software needs to run eg. libraries, system tools, code and runtime.
- Applications are created using independent stateless components or microservices running in containers.
- Use Docker to create linux containers and Windows containers for windows workloads.

![]({{site.cdn}}/aws/dev-theory/docker-container-architecture.png)

# Advantages of Containers and Microservices Architecture
- Highly Scalable - If application becomes overloaded, scale only the services you need to.
- Fault Tolerant - A single error in one of your containers shouldn't bring down your entire app.
- Easier to maintain, update and change as compared to large monolithic applications.

# ECS
- It is a container orchasteration service which supports docker and windows containers.
- Enables you to quickly deploy and scale containerized workloads without having to install, congfigure, manage and scale your own orchestration platform.
- Similar to Kubernetes, but with deep integration with AWS services eg. IAM, VPC, Route53.
- Allows you to run your containers on clusters of virtual machines.
  - Use Fargate for serverless containers and you don't need to worry about the underlying EC2 instances.
  - Use EC2 if you want to control the installation, configuration and management of your compute environment.
- ECS picks docker images from ECR (Elastic container registry)

![]({{site.cdn}}/aws/dev-theory/ecr-container-registry.png)

# Cool Services Using ECS
- Amazon Sagemaker - Quickly deploy and scale machine learning models for training and inference jobs.
- Amazon Lex - Uses deep learning to build conversational interfaces eg. chatbots.
- Amazon's own recommendation engine runs on ECS.

# Docker
**Docker** is an open source technology which allows you to create applications based on either linux or windows containers.
- A container is lightweight standalone executable software package which includes everything the software needs to run - code, runtime environment, libraries, environment settings etc.

![]({{site.cdn}}/aws/dev-theory/codeBuild-docker-lab.png)

```
docker build -t myimagerepo --> creates alias

docker tag myimagerepo:latest 725350006743.dkr.ecr.eu-central-1.amazonaws.com/myimagerepo:latest

docker push 725350006743.dkr.ecr.eu-central-1.amazonaws.com/myimagerepo:latest
```

- buildspec.yml to define build commands and settings used by codeBuild to run your build.
- You can override the settings in buildspec.yml by adding your own commands in the console when you launch the build.
- build logs - codeBuild console or cloudWatch.
