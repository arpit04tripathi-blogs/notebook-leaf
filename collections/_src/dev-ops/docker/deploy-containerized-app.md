---
layout: page
title: Deploy Containerized App
permalink: /docker/deploy-containerized-app
---

- TOC
{:toc}

---

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

