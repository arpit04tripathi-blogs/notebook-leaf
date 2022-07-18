---
layout: page
title: Docker Basic Workflow
permalink: /docker/basic-workflow
---

- TOC
{:toc}

---

- building an image from a Dockerfile or pulling an image from a registry (like Docker Hub).
- Once the image is available on the Docker Host, a container can be launched as a runtime environment.
- Once a container is running, it can be stopped, started, or restarted using the CLI.
- If changes are made to the container, a user can commit the changes made into a new image with either the same tag (or version) or a different one. The new image can, of course, then be pushed to a registry (like Docker Hub).

![]({{site.cdn}}/webservices/docker/docker-workflow.png)

## Docker Image vs Docker Container
- Container is running env for IMAGE
- port binded : talk to application running inside of container
- virtual file system

