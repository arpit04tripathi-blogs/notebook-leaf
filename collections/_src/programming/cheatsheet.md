---
layout: page
title: Cheatsheet
permalink: /cheatsheet
---

- TOC
{:toc}

---

# Read Input

## Buffered Reader

```java
import java.io.BufferedReader;
import java.io.InputStreamReader;
BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
int testCasesCount = Integer.valueOf(br.readLine());
for (int t = 0; t < testCasesCount; t++) {
    int n = Integer.valueOf(br.readLine());
    int[] arr = Arrays.stream(br.readLine().trim().split(" ")).mapToInt(Integer::parseInt).toArray();
    // split("\\s+") can be used
    System.out.println(Arrays.stream(arr).sum());
}
```

## Scanner

```java
import java.util.*;
Scanner s = new Scanner(System.in);
String name = s.nextLine();
System.out.println(String.format("Num-%2.2d, String-%s", num, str)); 
```

# Array

```java
import java.util.Arrays;
System.out.println(Arrays.toString(array));
System.out.println(Arrays.deepToString(deepArray));
System.out.println(Arrays.asList(array));
String[] greeting = {"Hey", "there", "amigo!"};
System.out.println(String.join("-", greeting));
```
```java
/* int[] to List<Integer> */
List<Integer> arrayList = Arrays.stream(arr).boxed().collect(Collectors.toList());
```

`Arrays.asList(int[])` not working
* List<int[]> with a single element - the array itself
* signature of asList is `List<T> asList(T...)` and a primitive can't replace a generic type 

# Data Type and Operations

## BigInteger
```java
Scanner sc = new Scanner(System.in);
BigInteger a = new BigInteger(sc.nextLine());
BigInteger b = new BigInteger(sc.nextLine());
System.out.println(a.add(b));
System.out.println(a.multiply(b));
```

## BigDecimal
```java
Input : -100, 50, 0, 56.6, 90, 0.12, .12, 02.34, 000.000
Output: 90, 56.6, 50, 02.34, 0.12, .12, 0, 000.000, -100
Comparator<String> sortComparator = (a,b) -> new BigDecimal(b).compareTo(new BigDecimal(a));
Arrays.sort(s, 0, n, sortComparator);
```

# Binary

Number <--> Binary
```java
System.out.println(Integer.toBinaryString(11));
System.out.println(Integer.parseInt("1010",2));
System.out.println(BigInteger.toString(2));
```

# Comparator
```java
Comparator<Student> c = Comparator.comparingDouble(Student::getCgpa).reversed()
	.thenComparing(Student::getFname)
	.thenComparingInt(Student::getId);
Collections.sort(studentList, c);
```

# Collections

## TreeSet

```java
import java.io.*;
import java.util.*;
import java.util.stream.*;
TreeSet<Integer> treeSet = new TreeSet<>(); 
treeSet.addAll(arrayList);
```

# Streams

```java
String[] arr = new String[]{"a", "b", "c"};
Stream<String> stream = Arrays.stream(arr);
stream = Stream.of("a", "b", "c");
Stream<String> stream = list.stream();
list.parallelStream().forEach(element -> doWork(element));
long count = list.stream().distinct().count();
```
* intermediate operation `distinct()` creates a new stream of unique elements of the previous stream. 
* terminal operation `count()` returns stream’s size.
```java
for (String string : list) {
    if (string.contains("a")) {  return true;  }
}
boolean isValid = list.stream().anyMatch(element -> element.contains("h")); 
boolean isValidOne = list.stream().allMatch(element -> element.contains("h")); 
boolean isValidTwo = list.stream().noneMatch(element -> element.contains("h")); 
// filter
Stream<String> stream = list.stream().filter(element -> element.contains("d"));
```
### map()
```java
List<String> uris = new ArrayList<>();
uris.add("C:\\My.txt");
Stream<Path> stream = uris.stream().map(uri -> Paths.get(uri));
```
So, the code above converts Stream<String> to the Stream<Path> by applying a specific lambda expression to every element of the initial Stream.

### flatMap()
If you have a stream where every element contains its own sequence of elements and you want to create a stream of these inner elements, you should use the flatMap() method:
```java
List<Detail> details = new ArrayList<>();
details.add(new Detail());
Stream<String> stream  = details.stream().flatMap(detail -> detail.getParts().stream());
```
we have a list of elements of type Detail, Detail class contains a field PARTS as List<String>.
`flatMap()` will extract every element from field PARTS and add to the new resulting stream. After that, the initial Stream<Detail> will be lost.

### reduce() 
takes two parameters: 
* first – start value, 
* second – an accumulator function.
```java
List<Integer> integers = Arrays.asList(1, 1, 1);
Integer reduced = integers.stream().reduce(23, (a, b) -> a + b); 
26 	// (23 + 1 + 1 + 1).
```
Example – you want to sum all elements of a List<Integer> and some initial Integer (here, 23).

### Collecting
* The reduction can also be provided by the `collect()` method of Stream. 
* Very useful in case of converting a stream to a Collection or a Map and representing a stream in form of a single string.
* Utility class Collectors, provide a solution for almost all typical collecting operations. 
* For some, not trivial tasks, a custom Collector can be created.
```java
List<String> resultList = list.stream().map(element -> element.toUpperCase()).collect(Collectors.toList());
```
This code uses the terminal `collect()` operation to reduce a Stream<String> to the List<String>.


# Concepts

## Difference Array
Each operation adds 'k' to elements from index 'a' to 'b', Find the max value after all operations.

![difference-array]({{site.cdn}}/programming/concept-of-difference-array.png)

```java
// Complete the arrayManipulation function below.
static long arrayManipulation(int n, int[][] queries) {
    long[] sol = new long[n + 2];
    long max_value = Long.MIN_VALUE;
    for (int[] q: queries) {
        sol[q[0]] += q[2];
        sol[q[1] + 1] -= q[2];
    }
    long sum = 0;
    for (long val: sol) {
        sum += val;
        if (sum > max_value) {
            max_value = sum;
        }
    }
    return max_value;
}
```

```java
Map<Integer, Integer> freqMap = new HashMap<>();
for(int i: ar)
  freqMap.put(i, freqMap.containsKey(i)?freqMap.get(i)+1:1);
int sum = 0;
for(int count : freqMap.values())
    sum += count/2;
return sum;
```