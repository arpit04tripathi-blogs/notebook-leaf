---
layout: page
title: String
permalink: /java/string
---

- TOC
{:toc}

---

# Introduction

* String in java is an **object rather than character arrays**. (sequence of characters) 
* String is **immutable**, cannot change characters once created. 
* Each modification creates a new **String** object, original left unchanged.   (s = s + “xyz”;)
	- **Reason**: because fixed, immutable strings can be implemented more efficiently than changeable ones. 
* **StringBuffer and StringBuilder** – **modifiable (mutable)**
* String, StringBuffer, StringBuilder - **final class** and implement the **CharSequence interface**.
* implements **Comparable\<T>** interface, method **compareTo()** for sorting.

```java
String s = "This is a demo of the getChars method.";        // string literal
int start = 10; int end = 14; char buf[] = new char[end - start];
s.getChars(start, end, buf, 0);   // getBytes(String) throws UnsupportedEncodingException
System.out.println(buf);    => returns demo
```
* concatenation - for creating very long strings. 
* Convert data into string representation by overloaded **valueOf()**.

|Overloaded valueOf()||
|---|---|
|primitive types | valueOf() returns a string in human-readable value.
|objects | valueOf() calls the toString( ). 
|array | valueOf() returns cryptic string, indicating that its an array of some type. 

* For arrays of char, String object is created that contains the characters in the char array.
* Most Internet protocols and text file formats use 8-bit ASCII for all text interchange, **getBytes()** is used here.
* **equals()** for characters,== for references.
  * `==` true implies `.equals` is also true but not vice-versa.

```java
String s1 = "Hello";
String s2 = new String(s1); // .equals is true but == is false
```

# Methods

|String Methods||
|---|---|
|String s = new String();                                               |
|String(char chars[ ])                                                  |
|**String(char chars[ ], int startIndex, int numChars)**                |char chars[]= {'a','b','c','d','e','f'}; `String s = new String(chars, 2, 3);` => cde
|String(StringBuffer buffer)                                            |
|String(StringBuilder builder)                                          |
|str.length()                                                           |"abc".length()
|str.charAt(int where)                                                  |"abc".charAt(1); => Returns b
|byte[ ] getBytes( )                                                    |`str.getBytes();`, `str.getBytes("UTF-16");`
|**char[ ] toCharArray( )**                                             |Entire String to char array
|**char[ ] getChars()**                                                 |str.getChars(srcStart, srcEnd, dest[], destStart);
|**boolean equals(Object str)**                                         |
|boolean equalsIgnoreCase(String str)                                   |
|**substring(int beginIndex, int endIndex)**                            |**beginIndex to endIndex–1**, endIndex is excluded.
|indexOf(String str, int startIndex)                                    |
|**indexOf(int ch, int startIndex)**                                    |first occurrence of a char or substring, **-1 on failure**
|**boolean startsWith(String str,int startIndx)**                       |"Foobar".startsWith("bar", 3)   => true
|**boolean startsWith(String str)**                                     |
|**boolean endsWith(String str)**                                       |
|lastIndexOf(int ch, int startIndex)                                    |
|**lastIndexOf(String str, int startIndex)**                            |
|**int compareTo(String str)**                                          | a.compareTo(str) => (a-str)
|int compareToIgnoreCase(String str)                                    |
|String substring(int startIndex)                                       |
|**String substring(int startIndx, int endIndx)**                       |
|**String concat(String str)**                                          |
|String replace(char original, char replacer)                           |
|**String replace(CharSequence o,CharSequence replacer)**               |
|**static String join(CharSequence delim, CharSequence . . . strs)**    |
|join(CharSequence delim, Iterable<? extends CharSequence> elements)    |
|intern()                                                               |
|**static String format(String format, Object... args)**                |String.format("My String is %.6f",12.121) --> 12.121000
|String **trim( )**                                                     |leading and trailing whitespace removed
|String **toLowerCase( )**                                              |
|String **toUpperCase( )**                                              |
|**int codePointAt(int i)**                                             |Unicode code point
|**boolean contains(CharSequence str)**                                 |
|**boolean isEmpty( )**                                                 |
|**boolean matches(String regex)**                                      | [PatternSyntaxException](https://docs.oracle.com/javase/7/docs/api/java/util/regex/PatternSyntaxException.html)|
|**CharSequence subsequence(int startIndex, int stopIndex)**            | 
|**String replaceFirst(regExp, newStr)**                                |
|**String replaceAll(regExp, newStr)**                                  |
|String[ ] split(String regExp)                                         |
|**String[ ] split(String regExp, int max)**                            |max - number of pieces <br> -ve value implies fully decomposed. <br> +ve, last entry contains remainder. <br> 0, fully decomposed, but no trailing empty strings included.|

# Modifying a String

* String are immutable, copy it to **StringBuffer** or **StringBuilder** and create string after modifications.
* All these methods new String which needs to assigned back if updated one is required in code.

## toLowerCase()
* **Internally calls toLowerCase(Locale.getDefault())**.
* locale sensitive (**internationalization (i18n)**).
* **Do not write a logic around it interpreting locale independently**.

```java
BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
String str = br.readLine();    
str = str.trim();
```
```java
List<String> list = Arrays.asList("Steve", "Rick", "Peter", "Abbey");
String names = String.join(" | ", list);            
Output - Steve | Rick | Peter | Abbey
```
```java
//Java automatically interns this
String str1 = "beginnersbook";
// intern() method searches "beginnersbook" in the memory pool and returns the reference of it.
String str2 = new String("beginnersbook").intern(); 
System.out.println("str1==str2: "+(str1 == str2));     //prints true 
```

## Changing the Case of Characters Within a String
* Your application selects default locale.
* **toLowerCase() is locale specific**.
* Code logic based on string length is a nice catch in code review.
* You can use toLowerCase(Locale.English) but here you lose internationalization.

```java
import java.util.Locale; 
Locale.setDefault(new Locale("lt"));        //Lithuanian
String str = "\u00cc";                      // Ì
String lowerCaseStr = str.toLowerCase();    // iı`
// length was 1, after toLowerCase length is 3
```

## split(String regExp, int max)
* max - number of pieces
  * -ve value implies fully decomposed.
* +ve, last entry contains remainder. 
* 0, fully decomposed, but no trailing empty strings included.

# StringBuilder and StringBuffer

## StringBuffer
* StringBuffer - growable and modifiable character sequence. 
* **Default, extra 16 additional characters** as reallocation is costly and frequent reallocations can fragment memory.
* StringBuffer method are synchronized hence thread-safe.

## StringBuilder
- Non Thread safe version.

### StringBuffer vs StringBuilder

|                       |StringBuffer  |StringBuilder |
|---                    |---           |---           |
|**synchronization**    |Yes           |No
|**thread-safety**      |Yes           |No
|**speed**              |Slow          |Fast

## Why 3 classes - String, StringBuilder, StringBuffer

***Why do one need three classes for same functionality, why can't String just do what StringBuilder and StringBuffer does?***  
- For keeping String mutable, due to many reasons like Security, String Pool, and Performance.
- So, Java API designers introduced a pattern of providing mutable companion class for immutable main class.

## Methods

|StringBuffer Methods                                                         |     |
|---                                                                          |---  |
|**StringBuffer(int size)**                                                   |
|**int capacity( )**                                                          | total allocated capacity
|**void ensureCapacity(int minCapacity)**                                     |minCapacity - min size of the buffer (larger may be allocated for efficiency.)
|**StringBuffer(String str)**                                                 |
|**int length( )**                                                            | current length
|**setLength(int len)**                                                       |len > str.length(), null characters added to the end else characters are lost.
|StringBuffer(CharSequence chsq)                                              |
|**char charAt(int where)**                                                   |
|**void setCharAt(int where, char ch)**                                       |
|**StringBuffer deleteCharAt(int loc)**                                       |
|**StringBuffer append(String str)**                                          |
|StringBuffer append(Object obj)                                              |
|**reverse( )**                                                               |
|**StringBuffer delete(startIndex, endIndex)**                                |
|**StringBuffer insert(int index, String str)**                               |
|**getChars(int sourceStart, int sourceEnd, char target[ ], int targetStart)**|
|**StringBuffer replace(startIndex, endIndex, String str)**                   |
|String substring(int startIndex)                                             |
|**String substring(startIndex, endIndex)**                                   |
|int indexOf(String str)                                                      |
|**int indexOf(String str, int startIndex)**                                  |
|int lastIndexOf(String str)                                                  |
|**int lastIndexOf(String str, int startIndex)**                              |
|**void trimToSize( )**                                                       | size reduced to better fit the current contents.

# String Literal Pool

* String objects are immutable, cannot be changed once created.
* concat - If the length of the argument string is 0, then this String object is returned. **Otherwise, a new String object is created.**

## Storage of Strings - The String Literal Pool

* ***String Literal Pool*** - collection of references to String objects, while the actual String Objects live on the heap. 
* This is feasible due to String immutable nature.
* String Literal Pool (**constant table**) is application level, not class or package level.

## How it is accomplished
* When .java file is compiled into .class file, String literals are noted in a special way, just as all constants are. 
* When class is [loaded](https://docs.oracle.com/javase/specs/jls/se8/html/jls-12.html#jls-12.2) (prior to initialization), JVM checks if String literal is already referenced from the heap.
* If found, references to that string literal is simple replaced with reference in String Literal Pool.
* If not, creates a String instance on heap and adds a reference to the constant table. 

```java
String one = "string";
String two = " string ";
System.out.println(one.equals(two));
System.out.println(one == two);

String two = new String("string ");
two.intern();
```

* With "new" keyword, references of both are kept in constant table (String Literal Pool), but new object created at run-time.
* *[intern()](https://docs.oracle.com/javase/8/docs/api/java/lang/String.html#intern) method looks for referenced in String Literal Pool and returns the reference, even for new keyword.*
* Strings created at run-time will always be distinct from those created from String Literals.
* reuse String Literals with run-time Strings via intern() method.
* equals() – to check equality.
* **String literals are by default interned**.

![string-literal-new.png]({{site.cdn}}/java/strings/string-literal-new.png)

**What makes an object eligible for garbage collection?**  
When object is no longer referenced from an active part of application.

**what is special about garbage collection for String literals?**
* String literals always have a reference to them from the String Literal Pool, not eligible for garbage collection ever.
* object is always reachable via intern() method.

**how many objects are available for garbage collection?**
```java
public static void main(String[] args) {
   String one = "someString";
   String two = new String("someString");
   one = two = null;
}
```
![how-many-objects]({{site.cdn}}/java/strings/how-many-objects.png)

The answer is ***1***.

**Will it create 5 new strings in memory and lead to a performance hit?**
```java
String longString = "abc" + "def" + "ghi" + "jkl" + "mnop";    // evaluated at compile time, only 1 string created 
String longString = "This string is very long.";
String other = "This string" + " is " + "very long.";    // == is true
String is = " is ";
String other = "This string" + is + "very long.";        // == false
```

# String Interning

* **intern()** enables == comparision by using pre-existing pool of string literals, faster than equals(). 
* pool of strings -- to save space and faster comparisons.

## Why and When to Intern?
* Java automatically interns all Strings by default. (Literals)
* intern() method with new String() to compare them by == operator.
* ensure that strings having same contents share same memory.

```java
String s1 = "Test";
String s2 = "Test";
String s3 = new String("Test");
final String s4 = s3.intern();
System.out.println(s1 == s2);       // true
System.out.println(s2 == s3);       // false
System.out.println(s3 == s4);       // false
System.out.println(s1 == s4);       // true
System.out.println(s2.equals(s3));  // true
System.out.println(s3.equals(s4));  // true
```

## Memory constraints of using intern()
* internalized strings go to Permanent Generation, reserved for non-user objects, like Classes, Methods, other JVM objects.
  * size of this area is limited, and much smaller than the heap. So you may run out of PermGen space. 
* jdk8, interned strings stored on heap (young & old generations), along with the other objects created by the application. 

# Why Strings are Immutable?

1. **Design** - Strings reference in java heap area known as "String Intern pool". If mutable, changes may affect others.
2. **Security** - String used as parameter for network connection, files, DB connection urls, usernames/passwords etc.If mutable, changes in such params can lead to serious security threat.
3. **Efficiency** - String’s hashcode frequently used in Java, like HashMap. Immutable hence can be cached.
4. **Synchronization,concurrency** - Immutabe, thread safe thereby solving the synchronization issues.
5. **Class loading** - String arguments for class loading. mutable could result in wrong class being loaded 

**Note**: *Immutability of String, cannot change it using its public API but can be manipulated using reflection.*

# Strings FAQ

## Why character array is better than String for Storing password in Java?
* **Strings are immutable in Java**, password as plain text will remain in memory until Garbage collection cycle.
* Can be accessed via String pool (remain in memory for long duration), this poses a security threat.
* any one with access to memory dump can find the password, always use encrypted password.
* for char[], can set all elements as blank or zero. **character array mitigates security risk of stealing password.**
* **Java itself recommends** using getPassword() of JPasswordField returning char[] and deprecated getText().
* risk of printing plain text in log file or console, for Array its memory location get printed.
* using char[] is not enough, need to erase content to be more secure.
* Use hash'd or encrypted password and clear it from memory as soon as authentication is completed.

```java
String strPassword="Unknown";                               //String password: Unknown
char[] charPassword= new char[]{'U','n','k','w','o','n'};   //Character password: [C@110b053
```

## Ways to check if String is empty in Java?

|Check empty string        ||
|---                       |---
**string.length()**        |if(string != null && string.length() == 0){ return true; }
**equals()**               |"".equals(input);
**isEmpty()**              |if(string != null && string.isEmpty()){ return true; }
**StringUtils**            |StringUtils.isEmpty("")    // apache lang3
**StringUtils.hasLength()**|StringUtils.hasLength(null) = false

## Reverse a string

```java
String reverse = new StringBuffer(word).reverse().toString();
reverse = new StringBuilder(word).reverse().toString();
```

## Ways to Concatenate?
* Concatenation operator (+)
* StringBuffer append()
* StringBuilder append()
* String.concat()

![concat.png]({{site.cdn}}/java/strings/concat.png)
