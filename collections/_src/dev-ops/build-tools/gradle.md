---
layout: page
title: Gradle
permalink: /gradle
---

- TOC
{:toc}

---

# References
- Official
  - [Documentation](https://docs.gradle.org/current/userguide/userguide.html){:target="_blank"}
  - [YouTube](https://www.youtube.com/channel/UCvClhveoEjokKIuBAsSjEwQ){:target="_blank"}
  - [multi-project](https://docs.gradle.org/current/userguide/multi_project_builds.html){:target="_blank"}
- [gradle implementation vs compile](https://stackoverflow.com/questions/44493378/whats-the-difference-between-implementation-and-compile-in-gradle){:target="_blank"}

# Introduction
open-source build automation tool focused on flexibility and performance.  
Gradle build scripts are written using a `Groovy` or `Kotlin` DSL.

## compile vs api vs implementation
- compile configuration is now deprecated and should be replaced by implementation or api
- `api` : configurations are transitively exposed to consumers of the library, and will appear on the compile classpath of consumers
- `implementation` : configuration not be exposed to consumers, and therefore not leak into the consumers' compile classpath.

```
dependencies {
    api 'commons-httpclient:commons-httpclient:3.1'
    implementation 'org.apache.commons:commons-lang3:3.5'
}
```
```
my_app -> (implements) library_main -> (api) library_2

my_app code can do library_2.ClassA.method()
```
```
my_app -> (implements) library_main -> (implements) library_2

my_app code will throw compilation error for library_2.ClassA.method()
```
