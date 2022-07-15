---
layout: page
title: Spring Data
permalink: /spring/data
---

- TOC
{:toc}

---

# Introduction to Spring Data
***Spring Data JPA*** is a separate project within Spring Data ecosystem to enable you connect with persistent stores(SQL and NoSQL).

![spring-data]({{site.cdn}}/spring/spring-data/spring-data.png)

![spring-data-abstraction]({{site.cdn}}/spring/spring-data/spring-data-abstraction.png)

## Spring DATA JPA (Java Persistence API)

### Spring DATA JPA Features
- Support for Querydsl to create type-safe JPA queries
- Validation of @Query annotated queries at bootstrap time.
- @EnableJpaRepositories
- Advance Features
  - Extending and adding custom queries with JPQL
  - Query Domain Specific Language (Query DSL)
  - Defining custom methods (low-level coding)

### Adding JPA
- @Repository
- Extends JpaRepository<MyEntity, Long>
- List<ProductCategory> findByBestCategory(Boolean bestCategory), where bestCategory is a field(column)

```java
public interface EmployeeRepository extends JPARepositoty<Employee, Integer>{
    // findAll()
    // findById()
    // save()
    // deleteById()
}
```

# ORM(Object Relational Mapping)
- Map Entity classes into relational mapping.
- ORM framework does the query, transaction and mapping.
- JPA is specification to use ORM.

![orm]({{site.cdn}}/spring/spring-data/orm.png)

pom.xml
- Hibernate-core
- Hibernate entity manager

application.properties
- Datasource
- Hibernate.ddl-auto=update

Create POJO
- @Entity, @TableName, @MappedSuperClass
- @Column, @Id, 

@EntityScan(basePackages={"a","b"})

## @EntityScan vs @ComponentScan

# Spring Data Rest

- `spring-data-rest`
- scans all JPARepositories, provides all basic crud features. 
- exposes REST api for each entity type for your JPARepository.

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-data-rest</artifactId>
</dependency>
```

- Spring data rest endpoints are HATEOAS compliant
  - HATEOAS - Hypermedia As the Engine of Application State
- Hypermedia driven sites provide information to access REST interfaces.
  - Think of it as metadata for REST data.
- HATEOAS uses HAL (Hypertext Application Language) data format. 
- For a collection, metadata includes page size, total elements, pages etc.
- Advance Features
  - Pagination, sorting and searching
  - Extending and adding custom queries with JPQL
  - Query Domain Specific Language (Query DSL)

```java
@RepositoryRestResource(path="members")
public interface EmployeeRepository extends JPARepositoty<Employee, Integer>{
    // findAll()
    // findById()
    // save()
    // deleteById()
}
```

```properties
spring.data.rest.base-path=/base
spring.data.rest.default-page-size=10
spring.data.rest.max-page-size=50
```

```
http://localhost:8080/employees?sort=lastname,firstname,asc
```
