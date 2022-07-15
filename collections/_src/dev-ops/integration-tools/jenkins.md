---
layout: page
title: Jenkins
permalink: /jenkins
---

- TOC
{:toc}

---

# Introduction

***Jenkins is a java application used for continuous integration and delivery.***

Shared repository is updated by developers and the build at end of day has failed due to the introduced bug. Jenkins will help to find what code caused the failure rather than the developer going through the logs.
- Mail sent – Build Triggered and completed
- Post Build Action – Automated Unit test, Acceptance test, performance test. Report is generated. If build succeed but code breaks something it can be troubleshooted.

![jenkins]({{site.cdn}}/devtools/jenkins/jenkins.png)

# Setup

- Download war file for Jenkins from Jenkins.io
- Cmd prompt > java –jar Jenkins.war [optional --httpPort=9090]
- Admin password in logs (cmd prompt) or .jenkins/secrets/initialAdminPassword
- http://localhost:8080
- Install custom plugins – ( suggested plugins )
- Create First admin User
- Folder - Uers/.jenkins/plugins

## Setup Jenkins on Tomcat

Apart from being started Jenkins on Standalone server. It can also be started on tomcat.

**Why on tomcat when it can be started on Standalone server?**
- Jenkins comes with its own servlet container – jetty/winstone.
- It can be started and deployed on tomcat and other servlet container.
- Running on tomcat – All applications can be run on single server (Not necessary)
- Required – tomcat 5+ , java 1.7+

***Steps***
* Download tomcat zip file. Extract to folder. Paste Jenkins.war in Tomcat/webapps folder.
* Make all files executable – chmod +x *.sh in command prompt.
* bin folder - ./startup.sh
* Verify if tomcat started – browser http://localhost:8080/jenkins

You can run Jenkins on tomcat and standalone simultaneously. Same Jenkins is used.

**Servers supported (servlet container)**
- Glassfish, JBoss, Tomcat
- IBM Websphere, Jetty, Jonas
- Weblogic etc.

## Change Home Directory

- User Profile/.jenkins – contains info about logs, jobs, plugins, configuration etc.
- Why to change home directory – Default directory location is User profile. Have to move to disk where more memory space is available.

```
Cmd > go to Jenkins war > java –jar Jenkins.war
Go to local Jenkins > Manage Jenkins > Configure System > Check Home Directory
```

![jenkins-home-directory]({{site.cdn}}/devtools/jenkins/jenkins-home-directory.png)

Create new folder in required place > Copy everything from old directory to new one > Change the environment variable JENKINS_HOME to new directory

To restart - Localhost:8080/restart or through cmd prompt
Localhost:8080/systeminfo – To see summary of plugins, environment variables etc.

## Jenkins CLI

**Why to use CLI ?**
- Easier, faster, efficient(memory management), continuous integration (setup build process)
- Start Jenkins => Java –jar Jenkins.war –httpPort=9080
- localhost:9080 > Manage Jenkins > Configure Global Security > enable security Checkbox > localhost:9080/cli > Download Jenkins cli jar from given hyperlink and place in any location > Got to specified location of cli jar > run the given command

```
java –jar Jenkins-cli.jar –s http://localhost:8080/ help
```

Enter passphrase > java –jar Jenkins-cli.jar –s http://localhost:8080/safe restart > Error regarding authorization > temporarily do Configure global security (Any one can do anything) > Safe restart

# Create Users and Manage Roles

Run Jenkins.war > java –jar Jenkins.war –httpPort=9080
Local:9080 > Login as Admin > Manage Jenkins > Manage users > Create User > Login with New user > Hover Logged in User (Configure)

Admin Password => Home Directory / secrets / initialAdminPassword

- For creating user roles, use Roles Strategy Plugin (.hpi file).
- HomeDirectory/Plugins – copy here and restart
- localhost:9080 > Manage Jenkins > Manage Plugins > goto Available tab and search for it 
OR
localhost:9080 > Manage Jenkins > Manage Plugins > goto Advance tab and upload .hpi

## Steps To Create Roles

Now Login as Admin > Manage Jenkins > configure Global Security > Enable security checkbox > Authorization (Role Based Strategy)

- Global Roles – (employee)
  - Login as Admin > Manage Jenkins > Manage and Assign Roles > Manage Roles > Global Roles (Overall Read and view)
- Project Roles – (Dev)
  - Login as Admin > Manage Jenkins > Manage and Assign Roles > Manage Roles > Project Roles > Developer (pattern = Dev.*) > Apply

Pattern – Pattern in name of project 

**Types of roles in Manage and Assign Roles**
1. Global Roles
2. Project Roles
3. Slave Roles

## Steps To Assign Roles

Login as Admin > Manage Jenkins > Manage and Assign Roles > Assign Users > Add User to global Roles (employee) > Apply

Login as Admin > Manage Jenkins > Manage and Assign Roles > Assign Users > Add User to Project Roles (Dev or Test) > Apply

