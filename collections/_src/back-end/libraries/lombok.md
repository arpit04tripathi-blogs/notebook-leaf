---
layout: page
title: Lombok
permalink: /lombok
---

- TOC
{:toc}

---

# Introduction

- Project Lombok is a java library that automatically plugs into your editor and build tools.

```groovy
compileOnly 'org.projectlombok:lombok'
annotationProcessor 'org.projectlombok:lombok'
```

## Why use this library

Helps get rid of many boilerplate code for POJOs
- constructors
- getters
- setters
- toString
- equals
- hashCode

# Keywords

local variables without worrying about the type.

```java
import org.lombok.val;
```

## val

val makes the variable as `final`;

```java
val map = new HashMap<Integer, String>();
...
...
for(val entry: map.entrySet())
```

```java
final HashMap<Integer, String> map = new HashMap<Integer, String>();
for(final Map.Entry<Integer, String> entry: map.entrySet())
```

## var

```java
var map = new HashMap<Integer, String>();
...
...
for(var entry: map.entrySet())
```

# Annotations

```java
@Data
// @Getter - all fields
// @Setter - non final fields
// @ToString
// @EqualsAndHashCode
// @RequiredArgsConstructor
@Builder(
  builderClassName = "ActorBuilder",
  builderMethodName = "anActor",
  buildMethodName = "execute",
  access = AccessLevel.PUBLIC,
  setterPrefix = "set",
  toBuilder = true // actorObject.toBuilder().id(5).build()
)
public class Actor{
  private int id;
  @Builder.Default
  private String name;
  private String topRole;
  @Singular // used with @Builder on List, Set and Map
  private List<String> movies; 

  //  Default
  Actor actor = Actor.builder().id(1).build();
  // with customization
  Actor actor = Actor.anActor().setId(1).execute();
  // with @Builder along with @Singular
  Actor actor = Actor.builder().id(1)
    .movie("Secret Life Walter Mitty") // add single movie
    .clearMovies() // clear the collection
    .movies(List.of("Martian", "Interstellar")) // add multiple movies
    // no setter to set the collection
    .build();

  // 
}
```

```java
// no callSuper argument for @Builder
@SuperBuilder
public class Actor extends Person {
  private int id;
}
```

```java
@Getter
@Setter
@Accessors(chain = true, fluent = true) // customize setters and getters, fluent -> returns instance itself
@ToString(includeFieldNames = false, callSuper = true)
@EqualsAndHashCode(callSuper = true)
@RequiredArgsConstructor // includes final and @NonNull
@NoArgsConstructor // empty constructors
@AllArgsConstructor // all fields
public class Actor extends Person{

  private int id; // public is the default access level

  @Getter(AccessLevel.PROTECTED)
  @ToString.Exclude
  @EqualsAndHashCode.Exclude
  private String name;

  @NonNull
  @Setter(AccessLevel.PACKAGE)
  private String topRole;

  @Getter(lazy=true)
  private final List<String> data = initData();

  private List<String> initData(){
    // does some heavy stuff
    // returns data
  }
}
```

```java
Actor actor = new Actor();
// chaining of fluid setters due to @Accessors(chain = true, fluent = true)
actor.id(1).name("Arpit Tripathi").topRole("Superb");
```

```java
@ToString(onlyExplicitlyIncluded = true)
@EqualsAndHashCode(onlyExplicitlyIncluded = true, callSuper = true)
public class Actor{

  private int id;
  @ToString.Include
  @EqualsAndHashCode.Include
  private String name;
  private String topRole;
  private final List<String> data = initData();
}
```

```java
// given resource is automatically cleaned-up or closed before code execution path exits current scope

@Cleanup
BufferedReader reader = new BufferedReader(new FileReader(in));

@Cleanup
BufferedWriter writer = new BufferedWriter(new FileWriter(out));

writer.write(reader.readLine())
```

```java
// Logger Annotations - creates field called log
@CommonsLog   // org.apache.commons.logging.Log
@Flogger      // com.google.common.flogger.FluentLogger
@JBossLog     // org.jboss.logging.Logger
@Log          // java.util.logging.Logger
@Log4j        // org.apache.log4j.Logger
@Log4j2       // org.apache.logging.log4j.Logger
@Slf4j        // org.slf4j.Logger
@XSlf4j       // org.slf4j.ext.XLogger
```

## Immutable Class

```java
@Value
class Actor {
  private int id;
}
```
