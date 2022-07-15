---
layout: page
title: Programming (Basics)
permalink: /programming-basics
---

- TOC
{:toc}

---

# Prime Numbers

## isPrime(int n)
### Prime Test (6k+1, 6k-1)
**Optimized School Method**  
We can do following optimizations in iterative method:
- Instead of checking till n, we can check till √n because a larger factor of n must be a multiple of smaller factor that has been already checked.
- The algorithm can be improved further by observing that all primes are of the form 6k ± 1, with the exception of 2 and 3. This is because all integers can be expressed as (6k + i) for some integer k and for i = -1, 0, 1, 2, 3, or 4; 2 divides (6k + 0), (6k + 2), (6k + 4); and 3 divides (6k + 3). So a more efficient method is to test if n is divisible by 2 or 3, then to check through all the numbers of form 6k ± 1. 

```java
public static boolean checkPrime(int n) {
    boolean isPrime = true;
    if (n <= 1 || n == 4) {
        isPrime = false;
    } else if (n < 4) {
        isPrime = true;
    } else if (n % 2 == 0 || n % 3 == 0) {
        isPrime = false;
    }
    for (int i = 5; i * i <= n; i = i + 6) {
        if (n % i == 0 || n % (i + 2) == 0)
            isPrime = false;
    }
    return isPrime;
}
```
`isProbablePrime` : "Parameter certainty - a measure of the uncertainty that the caller is willing to tolerate: if the call returns true the probability that this BigInteger is prime exceeds (1 - (1/2)^certainty). The execution time of this method is proportional to the value of this parameter."
```java
boolean isPrime = new BigInteger(n).isProbablePrime(1);
```

# Factorial
* Factorial for Numbers up to 20 – Use `Long` data-type.
* For n > 20, use `BigInteger` from the java.math package, which can hold values up to **2^Integer.MAX_VALUE**

## factorial(int n)
### Iterative
```java
// n <= 20
public long factorialUsingForLoop(int n) {
    long fact = 1;
    for (int i = 2; i <= n; i++) {
        fact = fact * i;
    }
    return fact;
}
// n > 20
public BigInteger factorialHavingLargeResult(int n) {
    BigInteger result = BigInteger.ONE;
    for (int i = 2; i <= n; i++)
        result = result.multiply(BigInteger.valueOf(i));
    return result;
}
```
### Stream API
```java
public long factorialUsingStreams(int n) {
    return LongStream.rangeClosed(1, n)     // stream 1 to n
        .reduce(1, (long x, long y) -> x * y);
}
```
reduce(), uses an identity value and accumulator function for the reduction step.

### Recursive
```java
public long factorial(n){
    if(n<0) return 0L;
    if(n==0) return 1L;
    return n * factorial(n-1);
}
```

# Permutation and Combination
### nCr, nPr
```java
BigInteger factn = BigInteger.ONE;
factn = factn.multiply(BigInteger.valueOf(i));
factn.divide(factr);
```

# Common Patterns
## Pattern 1

```
Enter number of rows to print : 10
01 02 03 04 05 06 07 08 09 10 
21 22 23 24 25 26 27 28 29 30 
41 42 43 44 45 46 47 48 49 50 
61 62 63 64 65 66 67 68 69 70 
81 82 83 84 85 86 87 88 89 90 
91 92 93 94 95 96 97 98 99 100 
71 72 73 74 75 76 77 78 79 80 
51 52 53 54 55 56 57 58 59 60 
31 32 33 34 35 36 37 38 39 40 
11 12 13 14 15 16 17 18 19 20 
The End.......
```
> Tip: Select mid such that, pattern continues till mid.

n=10 and (n-1)/2 = mid = 4
- For i <= mid, value[i]= j+1 + 2ni
- For i > mid, value[i] = j+1 + n + 2n(n-1-i)

```java
public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    System.out.print("Enter number of rows to print:");
    int n = scanner.nextInt();
    pattern01(n);
    System.out.println("The End.......");
}

private static void pattern01(int n) {
    int m = 0;
    DecimalFormat twodigits = new DecimalFormat("00");
    for (int i = 0; i < n; i++) {
        if (i <= (n - 1) / 2) {
            m = 2 * i;
        } else {
            m = 2 * (n - 1 - i) + 1;
        }
        for (int j = 0; j < n; j++) {
            System.out.print(twodigits.format(((n * m) + j + 1)) + " ");
        }
        System.out.println();
    }
}
```

## Pattern 2
```
Enter number of rows to print : 5
01 11 21 16 06 
02 12 22 17 07 
03 13 23 18 08 
04 14 24 19 09 
05 15 25 20 10 
The End.......
```
n=5 and (n-1)/2 = mid = 2
- For j <= mid, value[j] = (i+1) + (2n x j)
- For j > mid, value[j] = (i+1) + n + 2n(n-1-j)

```java
public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    System.out.print("Enter number of rows to print : ");
    int n = scanner.nextInt();
    pattern01(n);
    System.out.println("The End.......");
}

private static void pattern01(int n) {
    int m = 0;
    DecimalFormat twodigits = new DecimalFormat("00");
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (j <= (n - 1) / 2) {
                m = 2 * j;
            } else {
                m = (n - j) + 1;
            }
            System.out.print(twodigits.format(((n * m) + (i + 1))) + " ");
        }
        System.out.println();
    }
}
```

# 1D Array

[Painting Fence Algorithm](https://www.geeksforgeeks.org/painting-fence-algorithm/)

# 2D Array

* [Min Cost Path](https://www.geeksforgeeks.org/minimum-cost-path-left-right-bottom-moves-allowed/)
* [Rat in a maze with Jumps Allowed](https://www.geeksforgeeks.org/a-variation-of-rat-in-a-maze-multiple-steps-or-jumps-allowed/)

## Min Cost Path
```java
/* A utility function that returns minimum of 3 integers */
private static int min(int x, int y, int z) {
    if (x < y) {
        return (x < z) ? x : z;
    } else {
        return (y < z) ? y : z;
    }
}

private static int minCost(int cost[][], int m, int n) {
    int i, j;
    int tc[][] = new int[m + 1][n + 1];
    tc[0][0] = cost[0][0];
    /* Initialize first column of total cost(tc) array */
    for (i = 1; i <= m; i++) {
        tc[i][0] = tc[i - 1][0] + cost[i][0];
    }
    /* Initialize first row of tc array */
    for (j = 1; j <= n; j++) {
        tc[0][j] = tc[0][j - 1] + cost[0][j];
    }
    /* Construct rest of the tc array */
    for (i = 1; i <= m; i++)
        for (j = 1; j <= n; j++)
            tc[i][j] = min(tc[i - 1][j - 1], tc[i - 1][j], tc[i][j - 1]) + cost[i][j];
    return tc[m][n];
}
```

# 3D Array
![3d-array]({{site.cdn}}/dsa/ds/array/array-3d.png)

# Others

## Runtime Demo
```java
public static void main(String[] args) {
	Runtime r = Runtime.getRuntime();
	System.out.println("Total Memory: " + r.totalMemory());
	System.out.println("Free Memory: " + r.freeMemory());
	String [] str = new String[10000];
	for (int i = 0; i < 10000; i++) {	str[i] = new String("Hello");	}
System.out.println("After instances, Free Memory:" + r.freeMemory());
	System.gc();
	System.out.println("After gc(), Free Memory: " + r.freeMemory());
// Number Of Processors
	System.out.println(r.availableProcessors());
// will open a new notepad
	try { r.exec("notepad"); } catch (IOException e) {	e.printStackTrace();	}
}
```
Output :
```
Total Memory: 64487424
Free Memory: 63479712
After creating 10000 instance, Free Memory: 63087864
After gc(), Free Memory: 63576872
4
```

## Properties
```java
public class Executor { 
    public static void main(String[] args) {
        FileReader reader=null;
        FileWriter writer = null;
        try {
            reader = newFileReader("D:\\zzMyProject\\src\\properties\\example\\dummy.properties");
        } catch (FileNotFoundException e1) {e1.printStackTrace();}
        Properties p=new Properties(); 
        try { p.load(reader); }
        catch (IOException e1) { e1.printStackTrace(); }
        System.out.println(p.getProperty("user") + “ ” + p.getProperty("password")); 
        p.setProperty("name","Sonoo Jaiswal"); 
        p.setProperty("email","sonoojaiswal@javatpoint.com");                
        try {
            writer = newFileWriter("D:\\ zzMyProject\\src\\properties\\example\\dummy.properties");
            p.store(writer,"Javatpoint Properties Example");
        } catch (IOException e) {  e.printStackTrace();  } 
        Set set=p.entrySet();
        //p=System.getProperties();       
        Iterator itr=set.iterator(); 
        while(itr.hasNext()){
            Map.Entry entry=(Map.Entry)itr.next(); 
            System.out.println(entry.getKey()+" = "+entry.getValue()); 
        } 
    } 
}
```
## First Non-Repeated / Repeated character in String

```java
public static void main(String[] args) {
    System.out.print("Please enter the input string :");
    Scanner in = new Scanner(System.in);
    String s = in .nextLine().trim();
    char c = firstNonRepeatedCharacter(s, true);
    System.out.println("The first repeated character is :  " + c);
    c = firstNonRepeatedCharacter(s, false);
    System.out.println("The first non repeated character is :  " + c);
}

public static Character firstNonRepeatedCharacter(String str, boolean repeated) {
    HashMap < Character, Integer > characterMap = new HashMap < Character, Integer > ();
    int i, length;
    Character c = null;
    length = str.length(); // Scan string and build hash table
    for (i = 0; i < length; i++) {
        c = str.charAt(i);
        if (characterMap.containsKey(c)) {
            characterMap.put(c, characterMap.get(c) + 1);
        } else {
            characterMap.put(c, 1);
        }
    }
    if (repeated) {
        for (i = 0; i < length; i++) {
            c = str.charAt(i);
            if (characterMap.get(c) > 1) break;
        }
    } else {
        for (i = 0; i < length; i++) {
            c = str.charAt(i);
            if (characterMap.get(c) == 1) break;
        }
    }
    return c;
}
``` 
Output: 
```
Please enter the input string : stars are awesome!
The first repeated character is :  s
The first non repeated character is :  t
```

# ToDo
* Nearest Square Root
* Queue Using Stack
* All Permutations of String (No Duplicate) - use Set
* [Find the repeating and the missing](https://www.geeksforgeeks.org/find-a-repeating-and-a-missing-number/)
* Minimum Platforms
