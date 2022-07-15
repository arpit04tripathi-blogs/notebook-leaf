---
layout: page
title: Docker
permalink: /docker
---

- [containers](containers)
- TOC
{:toc}

---

Docker is a famous tool for containerization.

# Architecture

- Technically, Container is Layers of images.
- Mostly Linux Base Image (alpine:3.10), because small in size
- Application image on top

Docker uses a typical client-server architecture. The Docker client talks to the Docker daemon, which does the heavy lifting of building, running, and distributing Docker containers. The Docker client and daemon communicate via sockets or through a RESTful API.

![]({{site.cdn}}/webservices/docker/docker-architecture-2.png)

![]({{site.cdn}}/webservices/docker/docker-components.png)

![]({{site.cdn}}/webservices/docker/docker-architecture.png)

## Docker vs Virtual Machine (VM)
## Docker on OS level
Operating Systems has 2 layers
1. OS Kernel - communicates with Hardware - CPU, memory etc
2. Applications layer

For example, Multiple versions of linux exist which use same linux kernel but they implement different applications on top of their kernel 

## Different levels of absrtaction
- Docker and VM are both virtualization tools
  - Docker : virtualises Applications layer of OS while using the kernel of host
  - VM : Virtualises whole OS (Applications layer + OS kernel)
- **Size** : Docker image size is much smaller due to this.
  - Docker images in MBs, while Vm are in GBs
- **Speed** : Docker containers start and run much fast.
- **Compatibility** : VM of any OS can run on any OS host

## Why linux based docker containers don't run on windows
- Host - Windows OS (Applications + Kernel)
- Linux based image (Aplpications layer) might not be compatible with Host OS kernel
- Check whether Host can run docker natively, ie. check if your os kernel is compatible with docker images.
- Workaround - Use Docker Toolbox to abstract way kernel to allow host run the docker images

## How Is Docker Different Than JVM?

- The JVM is Java’s solution for application portability across different platforms — but Docker provides a different kind of virtualization that makes use of the guest operating system libraries, not just the Java application.
- When a Docker container is launched, a filesystem is allocated, along with the network/bridge interface and IP address.
- The command (or script) specified in the Dockerfile used to build the underlying Docker image is then executed, and the resulting Linux process runs in isolation.
- As a result, Docker can be used to package an entire JVM along with the JAR or WAR files and other parts of the application into a single container that can run on any Linux host consistently.
- This eliminates some of the challenges associated with making sure that the right JAR file version is used on the right JVM.
- Moreover, CPU and memory resource controls can be used with Docker containers — allowing users to allocate maximum amounts of resources that an application can use.

- A **hypervisor**, also known as a ***virtual machine monitor*** or VMM, is software that creates and runs virtual machines (VMs). A hypervisor allows one host computer to support multiple guest VMs by virtually sharing its resources, such as memory and processing.
- A **container engine** is a piece of software that accepts user requests, including command line options, pulls images, and from the end user's perspective runs the container.

![]({{site.cdn}}/webservices/docker/vm-vs-docker.png)

## Docker Basic Workflow

- building an image from a Dockerfile or pulling an image from a registry (like Docker Hub).
- Once the image is available on the Docker Host, a container can be launched as a runtime environment.
- Once a container is running, it can be stopped, started, or restarted using the CLI.
- If changes are made to the container, a user can commit the changes made into a new image with either the same tag (or version) or a different one. The new image can, of course, then be pushed to a registry (like Docker Hub).

![]({{site.cdn}}/webservices/docker/docker-workflow.png)

## Docker Image vs Docker Container
- Container is running env for IMAGE
- port binded : talk to application running inside of container
- virtual file system

# Developing with Docker

- Install docker from official website 

```bash
docker run hello-world

# Dockerfile
FROM ubuntu:16.04
RUN echo "welcome to dockerfile"

docker build -t local-mysql .   # builds image from dockerfile
docker pull mysql:5.6           # pulls image from Docker Hub (puclic repo)
docker images

# new container
docker run mysql:5.6
docker run -d redis # runs in detached mode and prints container id in output
docker run -d -p 80:80 image service myapp

docker ps       # running containers
docker ps -a    # all containers : running + stopped

docker stop <container-id>
docker start <container-id>

# host port 6000 --> container port 6379
docker run -d -p 6000:6379 --name redis-older redis:4.0
docker logs <container_id or name>

# interactive terminal to log into docker container
docker exec -it <container_id or name> /bin/bash
```

## Docker Network
- Docker creates its own isolated docker network where containers are running.
- Containers in same Docker Network can communicate with each-other just with the `container name` without needing `host:port`
- Docker provides some default network

```bash
docker network ls
# create new network
docker network create my-network
# run container in specific network my-network
docker run -d -p 6000:6379 -e <env_var> --name local-redis --net my-network redis
```

# Docker Compose

- running multiple docker containers and network them can be tedious
- docker compose is a structured way of doing this

```yaml
version: '3' # version of docker compose
services:
  redis-older: # name of container
    image: redis:4.0 # image from docker hub
    ports:
      - 6000:6379 # host port 6000 --> container port 6379
      - 8000:6379
    environment: # env variables, found on dockerhub doc for image
      - USERNAME=admin
      - PASSWORD=password
# no network name to be provided
# docker compose will create a common docker env for all the services in the file
```

```bash
# creates a common docker network and starts all containers in it
docker-compose -f <filename>.yaml up
# stops all containers and tears down the docker network
docker-compose -f <filename>.yaml up
```

# Dockerfile

- In CICD, Jenkins takes the github repo to perform actions
- At last, it takes the Dockerfile to create the docker image and push it to Container Repository
- `Dockerfile` is like a blueprint to build images

```bash
# start with a base images
FROM node
# set env variables
ENV MONGO_DB_USERNAME=admin \
MONGO_DB_PWD=password
# RUN executes inside the container, so directory is created inside of container
# RUN <any linux commands>
RUN mkdir -p /home/app
# COPY executes on the HOST machine
# COPY source on host -> target on container
COPY . /home/app
ENTRYPOINT ["docker-entrypoint.sh"]
# CMD is entry point command
# as server.js copied to /home/app folder
CMD["node", "/home/app/server.js"]
# node server.js cmd to start node server
```

**CMD vs RUN in Dockerfile**
- you can have multiple RUN commands
- but only 1 CMD command as entrypoint command

## Build image from Dockerfile

```bash
docker build -t my-app:1.0 .
```

# Create Private Docker Repository on AWS (ECR)

- Login to AWS and go to ECR
- Create repository with application name
- This repository will contain different versions (tags) of images for a single application
  - can contain upto 1,000 versions of the image
- Image naming - `registryDomain/imageName:tag`

```sh
# get Push commands for ECR repo from AWS GUI
aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.eu-west-2.amazonaws.com
# build docker image locally
docker build -t app-name .
# creates new copy of image locally and tag it for AWS ECR
docker tag app-name:latest <aws_account_id>.dkr.ecr.eu-west-2.amazonaws.com/app-name:latest
# pushes to AWS ECR
docker push <aws_account_id>.dkr.ecr.eu-west-2.amazonaws.com/app-name:latest
# This will try to push to DockerHub -> docker.io/library/app-name:latest
docker push app-name:latest
```

```sh
# In DockerHub
docker pull mongo:4.2 # this translates to
docker pull docker.io/library/mongo:4.2

# In AWS ECR (private)
docker pull <aws_account_id>.dkr.ecr.eu-west-2.amazonaws.com/app-name:2.4.6
```

# Deploy Containerized App

- Create a `docker-compose.yaml` file
- do a docker login to AWS ECR
- run this cmd - `docker-compose -f docker-compose.yaml up`

```yaml
version: '3' # version of docker hub
services:
  my-app:
    image: <aws_account_id>.dkr.ecr.eu-west-2.amazonaws.com/app-name:2.4.6
    ports:
      - 4000:3000 # host machine port 4000 --> docker container port 3000
  mongodb-server:
    image: mongo # shorthand for docker.io/library/mongo:latest
    ports:
      - 27017:27017
    volumes:
      - mongo-data:/data/db # using a named volume here
      # for MongoDB - container stores data at /data/db
      # for MySQL - container stores data at /var/lib/mysql
      # for Postgres - container stores data at /var/lib/postgresql/data
      # This info available in DockerHub Official image page under section `Where to Store Data`
    environment:
      - MONGO_INITDB_ROOT_USERNAME=admin
      - MONGO_INITDB_ROOT_PASSWORD=password
  # UI client to connect to mongo-db server
  mongo-express:
    image: mongo-express
    ports:
      - 8080:8081
    environment:
      - ME_CONFIG_MONGODB_ADMINUSERNAME=admin
      - ME_CONFIG_MONGODB_ADMINPASSWORD=password
      - ME_CONFIG_MONGODB_SERVER=mongodb-server
volumes: # named volumes
  mongo-data:
    driver: local
```

- with docker containers running through single docker-compose file, they are by default a part of common docker network.
- we can replace connection uri `mongodb://admin:password@localhost:3000` with `mongodb://admin:password@mongodb-server`

# Docker Volumes
- Persisting data with docker volumes for
  - stateful applications
  - databases
    - Container runs on host and uses virtual file system `/var/lib/mysql/data`.
    - This is volatile, so data is gone when we restart or remove the container.
- Docker Volumes : Folder in physical host file system is mounted into the virtual file system of Docker container

## Docker Volume Types

There are 3 volume types

### Host Volumes
You decide where on the host file system the reference is made.

```sh
# host folder --> container folder 
docker run -v /home/mount/data:/var/lib/mysql/data
```

### Anonymous Volumes
For each container a folder is generated by docker that gets mounted

```sh
# /var/lib/docker/volumes/random-hash/_data
docker run -v /var/lib/mysql/data
```
### Named Volumes
- Improvement of Anomymous volumes
- Specifies a name for the volume to be referenced in the host file system
- ***should be used in production***

```sh
# /var/lib/docker/volumes/random-hash/_data referenced by my-named-volume
docker run -v my-named-volume:/var/lib/mysql/data
```

#### Where is my data on mac

```sh
# below folder does not exist
ls /var/lib/docker
# Docker for mac creates a Linux VM and stores all the Docker data here
cd Library/Containers/com.docker.docker/Data
ls
# get terminal of the VM
screen com.docker.driver.amd64-linux/tty
cd /var/lib/docker/volumes
ls
ls <named-volume>/_data
# close terminal of VM
```

# What's Next
- Now you can create containers using dockers.
- These containers will need to be deployed across multiple servers in a distributed way.
- For this you can learn about `Container Orchestration Tools`
  - Kubernetes
  - OpenShift
  - Nomad