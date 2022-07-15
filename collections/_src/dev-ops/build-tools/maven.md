---
layout: page
title: Maven
permalink: /maven
---

- TOC
{:toc}

---

# Introduction

***Maven is a build automation tool used primarily for Java projects.***
- meaning accumulator of knowledge
- standard way to build the projects, a clear definition of what the project consisted of, an easy way to publish project information and a way to share JARs across several projects.

![mvn-dependency.png]({{site.cdn}}/devtools/maven/mvn-dependency.png)

**Maven Repository Manager Products**
- Archiva --> Apache
- Arifactory --> JFrog
- Nexus --> Sonatype
- Cloud Hosted Solution, maven cloud hosts
  - www.packagecloud.io
  - www.mymavenrepo.com
- [Maven - Using a Repository Manager](https://maven.apache.org/repository-management.html)


# Maven Goals

- Maven’s primary goal is to allow a developer to comprehend the complete state of a development effort in the shortest period of time. 
- In order to attain this goal there are several areas of concern that Maven attempts to deal with:
	- Making the build process easy
	- Providing a uniform build system
	- Providing quality project information
	- Providing guidelines for best practices development
    - Allowing transparent migration to new features
- [Maven Goals and Phases](https://stackoverflow.com/questions/16205778/what-are-maven-goals-and-phases-and-what-is-their-difference#:~:targetText=If%20you%20specify%20a%20goal,will%20run%20the%20jar%20goal.)

* Maven addresses two aspects of building software: first, it describes how software is built, and second, it describes its dependencies.
* Contrary to preceding tools like Apache Ant, it uses conventions for the build procedure, and only exceptions need to be written down. 
* An XML file describes the software project being built, its dependencies on other external modules and components, the build order, directories, and required plug-ins. 
* It comes with pre-defined targets for performing certain well-defined tasks such as compilation of code and its packaging.
* Maven dynamically downloads Java libraries and Maven plug-ins from one or more repositories such as the Maven 2 Central Repository, and stores them in a local cache. This local cache of downloaded artifacts can also be updated with artifacts created by local projects. Public repositories can also be updated.
* Maven allows a project to build using its **project object model (POM)** and a set of plugins that are shared by all projects using Maven, providing a uniform build system. Once you familiarize yourself with how one Maven project builds you automatically know how all Maven projects build saving you immense amounts of time when trying to navigate many projects.

Maven projects are configured using a [Project Object Model](https://en.wikipedia.org/wiki/Apache_Maven#Project_Object_Model), which is stored in a pom.xml-file.

```xml
<project>
    <!-- model version is always 4.0.0 for Maven 2.x POMs -->
    <modelVersion>4.0.0</modelVersion>
    <!-- project coordinates, i.e. a group of values which uniquely identify this project -->
    <groupId>com.mycompany.app</groupId>
    <artifactId>my-app</artifactId>
    <version>1.0</version>
    <!-- library dependencies -->
    <dependencies>
        <dependency>
            <!-- coordinates of the required library -->
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>3.8.1</version>
            <!-- this dependency is only used for running and compiling tests -->
            <scope>test</scope>
        </dependency>
    </dependencies>
</project>
```

# How Maven Works

- Creates local repository
  - c:\Users\users-home-directory\.m2\repository
- It first checks the local repository, if not found then downloads from maven central repository to local repository.

![]({{site.cdn}}/devtools/maven/how-maven-works.png)

# Project Structure

|Directory name	|Purpose|
---|---
project home	    |Contains the pom.xml and all subdirectories.
src/main/java	    |Contains the deliverable Java sourcecode for the project.
src/main/resources	|Contains the deliverable resources for the project, such as property files.
src/test/java	    |Contains the testing Java sourcecode (JUnit or TestNG test cases, for example) for the project.
src/test/resources	|Contains resources necessary for testing.

![mvn-project-structure]({{site.cdn}}/devtools/maven/mvn-project-structure.png)

![]({{site.cdn}}/devtools/maven/mvn-directory-structure.png)

# POM Structure

- Project Object Model

![]({{site.cdn}}/devtools/maven/pom-structure.png)

# GroupId naming conventions

- [Maven groupId and package name in java source](https://stackoverflow.com/questions/5214075/maven-groupid-and-package-name-in-java-source)
- [Guide to naming conventions on groupId, artifactId, and version](https://maven.apache.org/guides/mini/guide-naming-conventions.html)


```java
your website domain = maven.apache.org      , commons.apache.org
your groupId should be = org.apache.maven   , org.apache.commons
// if the current project is a multiple module project, it should append a new identifier to the parent's groupId.
org.apache.maven, org.apache.maven.plugins, org.apache.maven.reporting
```
> `.com` is primarily used by for-profit businesses, while `.org` is largely used by nonprofit websites.

# Maven Build LifeCycle

- Validate
- generate-sources 
- process-sources 
- generate-resources 
- process-resources 
- compile 
- process-test-sources 
- process-test-resources 
- test-compile
- test
- package 
- install 
- deploy

# Maven Archetypes

- Archetypes can be used to create new maven projects.
- Contains template files for a given maven project.
- Think of it as collection of starter files for a project.
- Eclipse has built-in support for maven - **m2eclipse plugin**

# Maven Commands

- [Maven All Commands](http://tutorials.jenkov.com/maven/maven-commands.html)

```java
mvn clean install               // clean install
mvn clean install -DskipTests
mvn clean install -U            // clean install force update (snapshot dependencies)
mvn dependency:sources          // download sources
mvn dependency:resolve -Dclassifier=javadoc
mvn eclipse:eclipse
mvn dependency:tree > ../zz-mvn-tree.txt
```
