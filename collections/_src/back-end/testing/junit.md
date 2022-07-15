---
layout: page
title: JUnit
permalink: /junit
---

- TOC
  {:toc}

---

# JUnit ToDo

- What and Why
- ArgumentMatchers – anyString(), any(XYZ.class) from journaldev
- @Mock
- @InjectMocks – main class where mocks needs to be injected
- @MockMvc

# Introduction

**Why write Tests**  
The point of writing automated tests is not so much to verify that the code works now, but to verify on an ongoing basis that it continues to work in the future.

**Why use testing Framework?**  
![]({{site.cdn}}/junit/why-testing-framework.png)

**JUnit 4**

- 10 years old
- Not up to date with new testing patterns
- Not up to date with java language features
- Monolithic architecture
- Bugs and feature requests piled up

**JUnit 5**

- JUnit 5 aims to adapt java 8 style of coding and several other features as well.
- Java 8 is required to create and execute tests in JUnit 5 (though tests written with JUnit 3 or JUnit 4 can be exceued as well for backward compatibility).

## Setup

**How to include JUnit 5 to your project ?**

```xml
<!-- pom.xml -->
<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter-engine</artifactId>
    <version>${junit.jupiter.version}</version>
</dependency>
<dependency>
    <groupId>org.junit.platform</groupId>
    <artifactId>junit-platform-runner</artifactId>
    <version>${junit.platform.version}</version>
    <scope>test</scope>
</dependency>
```

```gradle
// build.gradle
testRuntime("org.junit.jupiter:junit-jupiter-engine:5.0.0-M4")
testRuntime("org.junit.platform:junit-platform-runner:1.0.0-M4")
```

`scope = test`, means that the dependency jar will not be included in the final distributable.

# JUnit 4 vs JUnit 5

![junit4-vs-junit5]({{site.cdn}}/junit/junit4-vs-junit5.png)

## JUnit 5 Architecture

```
JUnit 5 = JUnit Platform + JUnit Jupiter + JUnit Vintage
```

![junit5-architecture]({{site.cdn}}/junit/junit5-architecture.png)

### JUnit Platform

- To be able to launch junit tests, IDEs, build tools or plugins need to include and extend platform APIs.
- It defines the TestEngine API for developing new testing frameworks that runs on the platform.
- It also provides a Console Launcher to launch the platform from the command line and build plugins for Gradle/Maven.

### JUnit Jupiter

- It includes new programming and extension models for writing tests.
- It has all new junit annotations and TestEngineimplementation to run tests written with these annotations.

### JUnit Vintage

- It primary purpose is to support running JUnit 3 and JUnit 4 written tests on the JUnit 5 platform. It’s there are backward compatibility.

## JUnit 5 Annotations

| Annotaions   |                                                                                                         |
| ------------ | ------------------------------------------------------------------------------------------------------- |
| @BeforeEach  | The annotated method will be run before each test method in the test class.                             |
| @AfterEach   | The annotated method will be run after each test method in the test class.                              |
| @BeforeAll   | The annotated method will be run before all test methods in the test class. This method must be static. |
| @AfterAll    | The annotated method will be run after all test methods in the test class. This method must be static.  |
| @Test        | It is used to mark a method as junit test                                                               |
| @DisplayName | Used to provide any custom display name for a test class or test method                                 |
| @Disable     | It is used to disable or ignore a test class or method from test suite.                                 |
| @Nested      | Used to create nested test classes                                                                      |
| @Tag         | Mark test methods or test classes with tags for test discovering and filtering                          |
| @TestFactory | Mark a method is a test factory for dynamic tests                                                       |

```java
@Test(timeout = time)
@Test(expected = exception.class)
```

```java
@RepeatedTest(3)
void testCircleArea(RepetitionInfo repetitionInfo){
    if(repetitionInfo.getCurrentRepetition == 1){...}
    ...
    // Here JUnit 5 gives RepetitionInfo by Dependency Injection
}
```

```java
public class AppTest {
    @BeforeAll
    static void setup() {
        System.out.println("@BeforeAll executed");
    }

    @BeforeEach
    void setupThis() {
        System.out.println("@BeforeEach executed");
    }

    @Tag("DEV")
    @Test
    void testCalcOne() {
        System.out.println("======TEST ONE EXECUTED=======");
        Assertions.assertEquals(4, Calculator.add(2, 2));
    }

    @Tag("PROD")
    @Disabled
    @Test
    void testCalcTwo() {
        System.out.println("======TEST TWO EXECUTED=======");
        Assertions.assertEquals(6, Calculator.add(2, 4));
    }

    @AfterEach
    void tearThis() {
        System.out.println("@AfterEach executed");
    }

    @AfterAll
    static void tear() {
        System.out.println("@AfterAll executed");
    }
}
```

![]({{site.cdn}}/junit/nested-unit-tests.png)

### Conditional Execution

```java
@EnabledOnOS(OS.LINUX)
@EnabledOnJre(JRE.JAVA_11)
@EnabledIf
@EnabledIfSystemProperty
@EnabledIfEnvironmentVariable
```

Other way for conditional execution is to use assumptions.

# JUnit 5 - Assertions and Assumptions

## Assertions

- Assertions help in validating the expected output with actual output of a testcase.
- To keep things simple, all JUnit Jupiter assertions are static methods in the `org.junit.jupiter.Assertions` class e.g. `assertEquals()`, `assertNotEquals()`.

```java
assertEquals(expected, actual)
assertArrayEquals(expectedArray, actualArray)
assertIterableEquals(expectedIterable, actualIterable)
```

```java
void testCase(){
    //Test will pass
    Assertions.assertNotEquals(3, Calculator.add(2, 2));
    //Test will fail
    Assertions.assertNotEquals(4, Calculator.add(2, 2), "Calculator.add(2, 2) test failed");
}
```

```java
//Test will fail - Lazy Assert Messages
Supplier<String> messageSupplier  = ()-> "Calculator.add(2, 2) test failed";
Assertions.assertNotEquals(4, Calculator.add(2, 2), messageSupplier);
```

```java
//Assert Exception Throw
Assertions.assertThrows(ArithmeticException.class, () -> Calculator.divide(2, 0), "Divide by zero should throw.");
```

```java
@Test
void assertAllProperties_fail() {
    Address address = new Address("New City", "Some Street", "No");
    assertAll("address",
        () - > assertEquals("Neustadt", address.city),
        () - > assertEquals("Irgendeinestraße", address.street),
        () - > assertEquals("Nr", address.number)
    );
}

// Output
org.opentest4j.MultipleFailuresError: address (3 failures)
	expected: <Neustadt> but was: <New City>
	expected: <Irgendeinestraße> but was: <Some Street>
	expected: <Nr> but was: <No>
```

## Assumptions

- Assumptions class provides static methods to support conditional test execution based on assumptions.
- A failed assumption results in a test being aborted.
- Assumptions are typically used whenever it does not make sense to continue execution of a given test method. In test report, these test will be marked as passed.
- JUnit jupiter Assumptions class has two such methods: `assumeFalse()`, `assumeTrue()`.

```java
public class AppTest {
    @Test
    void testOnDev() {
        System.setProperty("ENV", "DEV");
        Assumptions.assumeTrue("DEV".equals(System.getProperty("ENV")), AppTest::message);
    }
    @Test
    void testOnProd() {
        System.setProperty("ENV", "PROD");
        Assumptions.assumeFalse("DEV".equals(System.getProperty("ENV")));
    }
    private static String message () {
        return "TEST Execution Failed :: ";
    }
}
```

# TestInfo and TestReporter

![]({{site.cdn}}/junit/testinfo-testreporter.png)

# Test Suites

- Using **JUnit 5 test suites**, you can run tests spread into multiple test classes and different packages.
- JUnit 5 provides two annotations to create test suites.

  - [@SelectPackages](http://junit.org/junit5/docs/current/api/index.html?org/junit/platform/runner/SelectPackages.html)
  - [@SelectClasses](http://junit.org/junit5/docs/current/api/index.html?org/junit/platform/runner/SelectClasses.html)

- To execute the suite, you will use @RunWith(JUnitPlatform.class).
- Additionally, you can use following annotations for filtering test packages, classes or even test methods.

* @IncludePackages and @ExcludePackages to filter packages
* @IncludeClassNamePatterns and @ExcludeClassNamePatterns to filter test classes
* @IncludeTags and @ExcludeTags to filter test methods

```java
@RunWith(JUnitPlatform.class)
@SelectPackages("com.howtodoinjava.junit5.examples")
@IncludePackages("com.howtodoinjava.junit5.examples.packageC")
@ExcludeTags("PROD")
public class JUnit5TestSuiteExample{ }
```

# JUnit Lifecycle

JUnit 5 creates new instance of test class for every method run.

- @BeforeAll needs to be executed before creating an instance of the test class hence it has to static only.

```java
@BeforeAll
static void beforeAllInit(){
    System.out.println("Before All executed.");
}
```

- To change this behavior, use `@TestInstance` annotation on the test class.

```java
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class MathUtilTest{...}
```

![junit-lifecycle]({{site.cdn}}/junit/junit-lifecycle.png)

# Maven Surefire Plugin

- To run unit test using maven command, such as in jenkins pipeline.
- Run maven build as goal test.

```xml
<build>
    <plugins>
        <plugin>
            <artifactId>maven-surefire-plugin</artifactId>
            <version>2.22.1</version>
        </plugin>
    </plugins>
</build>
```

# FixMethodOrder

**How to test methods in specific order using JUnit4?**

- JUnit currently allows test methods run ordering using class annotations:
  - @FixMethodOrder(MethodSorters.NAME_ASCENDING)
  - @FixMethodOrder(MethodSorters.JVM)
  - @FixMethodOrder(MethodSorters.DEFAULT)

```java
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class SampleTest {
   @Test
   public void testAcreate() {
       System.out.println("first");
   }
   @Test
   public void testBupdate() {
       System.out.println("second");
   }
   @Test
   public void testCdelete() {
       System.out.println("third");
   }
}
```

```java
@Test
public void testOrder1() { test1(); test3(); }
```

# Testing Spring Boot

## Mocking with @MockBean

For Unit Testing, Service layer needs to be independent of repository layer implementation.

`@MockBean` annotation

- It [creates a Mock](https://www.baeldung.com/mockito-mock-methods) for the EmployeeRepository which can be used to bypass the call to the actual EmployeeRepository.

`@TestConfiguration` annotation

- To check the Service class, instance needs to be created and available as a @Bean in order to @Autowire it.
- Spring Boot annotation that can be used on classes in src/test/java to indicate that they should not be picked up by component scanning.

```java
@RunWith(SpringRunner.class)
public class EmployeeServiceImplIntegrationTest {

    @TestConfiguration
    static class EmployeeServiceImplTestContextConfiguration {
        @Bean
        public EmployeeService employeeService() {
            return new EmployeeServiceImpl();
        }
    }

    @Autowired
    private EmployeeService employeeService;
    @MockBean
    private EmployeeRepository employeeRepository;

    @Before
    public void setUp() {
        Employee alex = new Employee("alex");
        Mockito.when(employeeRepository.findByName(alex.getName()))
            .thenReturn(alex);
    }

    @Test
    public void whenValidName_thenEmployeeShouldBeFound() {
        String name = "alex";
        Employee found = employeeService.getEmployeeByName(name);
        assertThat(found.getName()).isEqualTo(name);
    }
}
```

## Unit Testing with @WebMvcTest

Mock the Service layer code for our unit tests of `@Controller`.

`@WebMvcTest` annotation

- auto-configure the Spring MVC infrastructure for our unit tests.
- Mostly @WebMvcTest will be limited to bootstrap a single controller.
- used along with @MockBean to provide mock implementations for required dependencies.
- also auto-configures `MockMvc` which offers a powerful way of easy testing MVC controllers without starting a full HTTP server.

```java
@RunWith(SpringRunner.class)
@WebMvcTest(EmployeeRestController.class)
public class EmployeeRestControllerIntegrationTest {

    @Autowired
    private MockMvc mvc;
    @MockBean
    private EmployeeService service;

    @Test
    public void givenEmployees_whenGetEmployees_thenReturnJsonArray() throws Exception {
        Employee alex = new Employee("alex");
        List < Employee > allEmployees = Arrays.asList(alex);
        given(service.getAllEmployees()).willReturn(allEmployees);
        mvc.perform(get("/api/employees")
                .contentType(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$", hasSize(1)))
            .andExpect(jsonPath("$[0].name", is(alex.getName())));
    }
}
```

# Integration Testing with @SpringBootTest

**Integration Tests**

- focus on integrating different layers of the application.
- That also means no mocking is involved.
- Ideally, we should keep the integration tests separated from the unit tests and should not run along with the unit tests.
  - Can be done by using a different profile to only run the integration tests.
  - **_Reason_** : Integration tests are time-consuming and might need an actual database to execute.

> Integration tests need to start up a container to execute the test cases, which needs extra setup.

`@SpringBootTest` annotation

- used when we need to bootstrap the entire container
- creating the ApplicationContext that will be utilized in our tests.
- `webEnvironment` attribute configures runtime environment
  - we’re using WebEnvironment.MOCK - container will operate in a mock servlet environment.

`@TestPropertySource` annotation

- configure locations of properties files specific to our tests.
- property file loaded with `@TestPropertySource` will override the existing application.properties file.

```properties
# application-integrationtest.properties
spring.datasource.url = jdbc:h2:mem:test
spring.jpa.properties.hibernate.dialect = org.hibernate.dialect.H2Dialect
```

```java
@RunWith(SpringRunner.class)
@SpringBootTest(SpringBootTest.WebEnvironment.MOCK, classes = Application.class)
@AutoConfigureMockMvc
@TestPropertySource(locations = "classpath:application-integrationtest.properties")
public class EmployeeRestControllerIntegrationTest {

    @Autowired
    private MockMvc mvc;
    @Autowired
    private EmployeeRepository repository;

    @Test
    public void givenEmployees_whenGetEmployees_thenStatus200() throws Exception {
        createTestEmployee("bob");
        mvc.perform(get("/api/employees")
                .contentType(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk())
            .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON))
            .andExpect(jsonPath("$[0].name", is("bob")));
    }
}
```

Test cases for the integration tests might look similar to the Controller layer unit tests, but for IntegrationTest nothing is mocked and end-to-end scenarios will be executed.

## Auto-Configured Tests

One of the amazing features of Spring Boot’s auto-configured annotations is that it helps to load parts of the complete application and test specific layers of the codebase.

**Few widely used annotations**

|                 |                                                                                                                                                                                                                                                  |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| @WebFluxTest    | Used to test Spring Webflux controllers. It’s often used along with @MockBean to provide mock implementations for required dependencies.                                                                                                         |
| @JdbcTest       | Used to test JPA applications but it’s for tests that only require a DataSource. The annotation configures an in-memory embedded database and a JdbcTemplate.                                                                                    |
| @JooqTest       | To test jOOQ-related tests, this annotation configures a DSLContext.                                                                                                                                                                             |
| @DataMongoTest  | To test MongoDB applications. By default, it configures an in-memory embedded MongoDB if the driver is available through dependencies, configures a MongoTemplate, scans for @Document classes, and configures Spring Data MongoDB repositories. |
| @DataRedisTest  | Used to test Redis applications. It scans for @RedisHash classes and configures Spring Data Redis repositories by default.                                                                                                                       |
| @DataLdapTest   | configures an in-memory embedded LDAP (if available), configures a LdapTemplate, scans for @Entry classes, and configures Spring Data LDAP repositories by default.                                                                              |
| @RestClientTest | Used to test REST clients. It auto-configures different dependencies like Jackson, GSON, and Jsonb support, configures a RestTemplateBuilder, and adds support for MockRestServiceServer by default.                                             |

> The complete source code of this article can be [found over on GitHub](https://github.com/eugenp/tutorials/tree/master/spring-boot).
> And, if you want to keep learning about testing – we have separate articles related to [integration tests](https://www.baeldung.com/integration-testing-in-spring) and [unit tests in JUnit 5](https://www.baeldung.com/junit-5).

## Example

**_spring-boot-starter-test dependency_**

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
    <version>2.0.4.RELEASE</version>
</dependency>
```

for practice add h2 DB (in-memory DB)

**_Entity Definition_**

```java
@Entity
@Table(name = "person")
public class Employee {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @Size(min = 3, max = 20)
    private String name;
    // standard getters and setters, constructors
}
```

**_Repository Definition_**

```java
@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Long> {
     public Employee findByName(String name);
}
```

**_Service Implementation Definition_**

```java
@Service
public class EmployeeServiceImpl implements EmployeeService {
    @Autowired
    private EmployeeRepository employeeRepository;
    @Override
    public Employee getEmployeeByName(String name) {
        return employeeRepository.findByName(name);
    }
}
```

**_Controller Definition_**

```java
@RestController
@RequestMapping("/api")
public class EmployeeRestController {
    @Autowired
    private EmployeeService employeeService;
    @GetMapping("/employees")
    public List<Employee> getAllEmployees() {
        return employeeService.getAllEmployees();
    }
}
```

Integration Testing with `@DataJpaTest`

```java
@RunWith(SpringRunner.class)
@DataJpaTest
public class EmployeeRepositoryIntegrationTest {
    @Autowired
    private TestEntityManager entityManager;
    @Autowired
    private EmployeeRepository employeeRepository;

    @Test
    public void whenFindByName_thenReturnEmployee() {
        // given
        Employee alex = new Employee("alex");
        entityManager.persist(alex);
        entityManager.flush();
        // when
        Employee found = employeeRepository.findByName(alex.getName());
        // then
        assertThat(found.getName()).isEqualTo(alex.getName());
    }
}
```

- `@RunWith(SpringRunner.class)` is used to provide a bridge between Spring Boot test features and JUnit.
- `@DataJpaTest` provides some standard setup needed for testing the persistence layer:
  - configuring H2, an in-memory database
  - setting Hibernate, Spring Data, and the DataSource
  - performing an `@EntityScan`
  - turning on SQL logging
- `TestEntityManager` provided by Spring Boot
  - to setup data in our database
  - alternative to the standard `JPAEntityManager` that provides methods commonly used when writing tests.

# MockMvc - Unit Testing Controller

```java
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.is;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(MockitoJUnitRunner.class)
public class MyControllerTest {

    private MockMvc mockmvc;

    @InjectMocks MyController controller;
    @Mock MyService myService;

    @Before
    public void setup() {
        this.mockmvc = MockMvcBuilders.standaloneSetup(verifyController).build();
    }

    @Test
    public void method_success() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.get("/v1/users"))
            .andDo(MockMvcResultHandlers.print())
            .andExpect(status().isOk())
            .andExpect(jsonPath("$[0].date").exists())
            .andExpect(jsonPath("$[0].type").value("1"))
            .andExpect(jsonPath("$[0].element.list").value(new ArrayList < > ()))
            .andExpect(jsonPath("$[0].element.id").value("42"))
            .andExpect(jsonPath("$[0].element.*", hasSize(2)))
            .andExpect(jsonPath("$[0].*", hasSize(3)))
            .andExpect(jsonPath("$.*", hasSize(1)))
            .andExpect(jsonPath("$.graph_data.length()", is(equalTo(1))))
            .andExpect(jsonPath("$.graph_data[0][1]", is(equalTo(123))))
            .andExpect(jsonPath("$.table_data.length()", is(equalTo(1))));

        MvcResult result = mockMvc.perform(
                post("/api/users")
                .header("Authorization", base64ForTestUser)
                .contentType(MediaType.APPLICATION_JSON)
                .content("{\"userName\":\"testUserDetails\",\"firstName\":\"xxx\",\"lastName\":\"xxx\",\"password\":\"xxx\"}")
            )
            .andExpect(status().isBadRequest())
            .andReturn();

        String content = result.getResponse().getContentAsString();
        // do what you will
    }
}
```
