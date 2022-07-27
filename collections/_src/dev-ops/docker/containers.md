---
layout: page
title: Containers
permalink: /docker/containers
---

- TOC
{:toc}

---

## What is a Container?
- A way to package applications with all necessary dependencies and configuration.
- Portable artifact, easily shared and moved around
- Makes development and deployment more efficient

## Where do containers live?
- Container repository
  - Private repositories by companies
  - Public repository for docker - [DockerHub](https://hub.docker.com){:target="_blank"}

**Steps**
- blueprint from `Dockerfile`
- built into a `Docker Image`
- which can be run as a `docker container`

## Improvements by using containers

### Application Development
**Before containers**
- Installation process different for each OS env
- Many steps where something could go wrong

**After Containers**
- container has its own isolated env (config + PostgresSQL_v9.3 + start_script)
- packaged with all needed configuration
- one command to install the app
- you can also run same app with 2 different versions

### Application Deployment
**Before containers**
- Developer : Jar + config files
- configuration on server needed
- dependency version conflicts
- misunderstandings between Developer and operations team

**After Containers**
- Developers and Operations work together to package the application in a container
- No environmental config needed on server, except docker runtime

### Memory efficient
- Docker images are build up of multiple layers of images
- `docker pull` uses locally available layer images and downloads only the new layers

### Application portability
Docker containers run exactly the same on any Linux host. This eliminates the challenge of deploying applications across different compute infrastructure (e.g. local developer machine, VM, or in the cloud).

### Higher server density
The lightweight nature of containers allows developers to optimize server utilization for their application workloads by running more containers on the same host while achieving the same isolation and resource allocation benefits of virtual machines.
