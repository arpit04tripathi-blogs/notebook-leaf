---
layout: page
title: JSON (Java Script Object Notion)
permalink: /json
---

- TOC
  {:toc}

---

# Introduction

**Jackson** is a multi-purpose Java library for processing JSON data format.

Offers 3 methods of processing

1. **Streaming API or incremental parsing/generation**: reads and writes JSON content as discrete events
2. **Tree model**: provides a mutable in-memory tree representation of a JSON document
3. **Data binding**: converts JSON to and from POJO’s

dependencies

- jackson-core-2.3.1.jar
- jackson-databind-2.3.1.jar
- jackson-annotations-2.3.1.jar

```java
@Test
public void whenSerializeAndDeserializeUsingJackson_thenCorrect()
  throws IOException{
    Foo foo = new Foo(1,"first");
    ObjectMapper mapper = new ObjectMapper();

    String jsonStr = mapper.writeValueAsString(foo);
    Foo result = mapper.readValue(jsonStr, Foo.class);
    assertEquals(foo.getId(),result.getId());
}
```

```java
ObjectMapper mapper = new ObjectMapper();
    String jsonInput = "{\"id\":0,\"firstName\":\"Robin\",\"lastName\":\"Wilson\"}";
    Person q = mapper.readValue(jsonInput, Person.class);
    System.out.println("Read and parsed Person from JSON: " + q);

    Person p = new Person("Roger", "Rabbit");
    System.out.print("Person object " + p + " as JSON = ");
    mapper.writeValue(System.out, p);
```
