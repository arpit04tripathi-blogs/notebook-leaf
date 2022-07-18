---
layout: page
title: Create Private Docker Repository on AWS (ECR)
permalink: /docker/aws-ecr-private-repo
---

- TOC
{:toc}

---

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
