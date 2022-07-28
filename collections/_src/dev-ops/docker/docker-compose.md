---
layout: page
title: Docker Compose
permalink: /docker/compose
---

- TOC
{:toc}

---

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
docker-compose -f <filename>.yaml down

# deltes unused docker images
docker system prune -f
```

```bash
docker compose exec cd bash
```