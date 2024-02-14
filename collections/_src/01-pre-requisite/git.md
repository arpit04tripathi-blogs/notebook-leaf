---
layout: page
title: Git
permalink: /git/
---

- TOC
{:toc}

---

# Introduction

**_Git is a distributed version control system._**

![](https://communities.sas.com/t5/image/serverpage/image-id/29370i045823D312547584?v=1.0)

![](https://hackernoon.com/hn-images/1*9qX9F9MGsWKfcmgTOR9BPw.png)

# Setup

## Using git bash

- [Adding an existing project to GitHub using the command line](https://docs.github.com/en/github/importing-your-projects-to-github/adding-an-existing-project-to-github-using-the-command-line)

```cmd
git init
git add .
git commit -m "init commit"
git remote add origin https://github.com/[username]/[reponame].git
git remote -v
git push origin master
git branch --set-upstream-to=origin/master

<!-- if unrelated history error -->
git pull origin master
git pull --allow-unrelated-histories
```

# Git commands

```
git fetch --all -p; git pull; git status;
git merge origin/m
git push
```

## git reset

```cmd
git reset --hard                  // remove all local changes
git reset --hard origin/master    // overwrites all local master changes with remote(origin) master
```

## git branch

```cmd
git branch      //Show all local branches|
git branch -r   // Show all remote branches|
git branch -a   // Show all local as well as remote branches|
```

## git remote

```cmd
git remote
```

# git stash

[tutorial - git stash](https://www.atlassian.com/git/tutorials/saving-changes/git-stash){:target="\_blank"}

```cmd
git stash save "message"
git stash list
git stash           // tracked files
git stash -u				// tracked and untracked files
git stash -a				// tracked, untracked and ignored files
```

# git tags

```cmd
git push --tags
git fetch --tags
git fetch --tags --all --prune
git tag -d v0.1.2							        // Delete tag locally
git tag -a <tag_name> -m "message"		// Create tag locally
git push origin :v0.1.2						    // Delete tag on origin
git push origin v0.1.2						    // Create tag on origin
```

git tag pointing to old commit

```sh
# Delete the tag on any remote before you push
git push origin :refs/tags/<tagname>

# Replace the tag to reference the most recent commit
git tag -fa <tagname>

# Push the tag to the remote origin
git push origin master --tags
```

# What's Next

## How to manage multiple GitHub accounts on a single machine with SSH keys

- [How to manage multiple GitHub accounts on a single machine with SSH keys](){:target="\_blank"}

## Deleting your git commit history without removing repo on Github

```git
rm -rf .git
git init
git checkout -b init-branch
git add .
git commit -m "init repo"
git remote add origin github.com:<username>/<repo>.git
git push -u --force origin init-branch
```
