---
layout: page
title: Docker
permalink: /docker/
---

- TOC
{:toc}

---

Docker is a famous tool for containerization - Build and run an image as a container, Share images using Docker Hub.

- [Official website](https://docs.docker.com/get-started/){:target="_blank"}
  - [YT - Docker Tutorial for Beginners (3 Hr)](https://www.youtube.com/watch?v=3c-iBn73dDE&t=124s){:target="_blank"}
- [Containers](containers)
- [Architecture](architecture)
- [Docker vs Virtual Machine (VM)](docker-vs-vm)
- [Docker vs JVM](docker-vs-jvm)
- [Docker Basic Workflow](basic-workflow)

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

- [Docker Volumes](volumes)
- [What's Next](whats-next)
