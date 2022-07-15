---
layout: page
title: RegEx - Regular Expressions
permalink: /java/regex
---

- TOC
{:toc}

---

* ***Pattern of regex is applied on String from left to right and source char in a match can’t be reused.***
* For example, regex “121” will match “31212142121” only twice as “_121____121”.

```java
System.out.println("Using String matches method: " + str.matches(".bb"));
System.out.println("Using Pattern matches method: " + Pattern.matches(".bb", str));
Pattern.matches(“[a - e1 - 3].”, “d#”)
```
```java
import java.util.regex package;

public class PatternExample {
    public static void main(String[] args) {
        try {
            Pattern pattern = Pattern.compile(".xx.");
            Matcher matcher = pattern.matcher("MxxY");
            System.out.println("Input String matches regex - " + matcher.matches());
            pattern = Pattern.compile("*xx*"); // bad regular expression
        } catch (PatternSyntaxException pse) {
            System.out.println(e.getMessage());
        }
    }
}
```

# Capturing Groups

* () in regex is used to treat multiple characters as a single unit.
* portion of input matching the capturing group is saved into memory and can be recalled using **Backreference**.
* **matcher.groupCount()** method - find number of capturing groups.
* For example, ((a)(bc)) contains 3 capturing groups – ((a)(bc)), (a) and (bc).
* You can use **Backreference** in regular expression with backslash (\) and then the number of groups to be recalled.

```java
System.out.println(Pattern.matches("(\\w\\d)\\1", "a2a2"));         	//true  \1 is a2
System.out.println(Pattern.matches("(\\w\\d)\\1", "a2b2"));         	//false \1 is a2
System.out.println(Pattern.matches("(AB)(B\\d)\\2\\1", "ABB2B2AB"));	//true  \1 is AB
System.out.println(Pattern.matches("(AB)(B\\d)\\2\\1", "ABB2B3AB"));	//false \2 is B2
```

# RegEx Keywords

|Regex Basics|Description|
--- |---
^   |The start of a string
$   |The end of a string
.   |Wildcard which matches any character, except newline (\n).
\|  |Matches a specific character or group of characters on either side (e.g. a\|b corresponds to a or b)
\   |Used to escape a special character
a   |The character “a”
ab  |The string “ab”

|Quantifiers	|Description|
---|---
*	    | Used to match 0 or more of the previous (e.g. xy*z could correspond to “xz”, “xyz”, “xyyz”, etc.
?	    | Matches 0 or 1 of the previous
+	    | Matches 1 or more of the previous
{5}	    | Matches exactly 5
{5,}    | Matches 5 or more.
{5, 10} |Matches everything between 5-10

|Character Classes|Description|
---|---
\s	    |Matches a whitespace character
\S	    |Matches a non-whitespace character
\w	    |Matches a word character
\W	    |Matches a non-word character
\d	    |Matches one digit
\D	    |Matches one non-digit
[\b]    |A backspace character
\c	    |A control character

|Special Characters	|Description|
---|---
\n	    |Matches a newline
\t	    |Matches a tab
\r	    |Matches a carriage return
\ZZZ    |Matches octal character ZZZ
\xZZ	|Matches hex character ZZ
\0	    |A null character
\v	    |A vertical tab

|Groups	| Description|
---|---
(xyz)	|Grouping of characters
(?:xyz)	|Non-capturing group of characters
[xyz]	|Matches a range of characters (e.g. x or y or z)
[^xyz]	|Matches a character other than x or y or z
[a-q]	|Matches a character from within a specified range
[0-7]	|Matches a digit from within a specified range

|String Replacements	| Description|
---|---
$`	|Insert before matched string
$’	|Insert after matched string
$+	|Insert last matched
$&	|Insert entire match
$n	|Insert nth captured group

|Assertions	|Description|
---|---
(?=xyz)	    |Positive lookahead
(?!xyz)	    |Negative lookahead
?!= or ?<!	|Negative lookbehind
\b	        |Word Boundary (usually a position between /w and /W)
?#	        |Comment

# Pattern and Matcher

* Pattern object with flags, Pattern.CASE_INSENSITIVE enables case insensitive matching.
* Pattern class also provides split(String) method that is similar to String class split() method.
* Pattern class toString() - regex String from which pattern was compiled.
* Matcher classes have start() and end() index methods that show precisely where the match was found in the input string.
* Matcher class provides - replaceAll(String replacement) and replaceFirst(String replacement).

```java
package com.journaldev.util;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
public class RegexExamples {
    public static void main(String[] args) {
        // using pattern with flags
        Pattern pattern = Pattern.compile("ab", Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher("ABcabdAb");
        // using Matcher find(), group(), start() and end() methods
        while (matcher.find()) {
            System.out.println("Found the text \"" + matcher.group() +
                "\" starting at " + matcher.start() +
                " index and ending at index " + matcher.end());
        }
        // using Pattern split() method
        pattern = Pattern.compile("\\W");
        String[] words = pattern.split("one@two#three:four$five");
        for (String s: words) {
            System.out.println("Split using Pattern.split(): " + s);
        }
        // using Matcher.replaceFirst() and replaceAll() methods
        pattern = Pattern.compile("1*2");
        matcher = pattern.matcher("11234512678");
        System.out.println("Using replaceAll: " + matcher.replaceAll("_"));
        System.out.println("Using replaceFirst: " + matcher.replaceFirst("_"));
    }
}
```
```java
Output of the above java regex example program is.
Found the text "AB" starting at 0 index and ending at index 2
Found the text "ab" starting at 3 index and ending at index 5
Found the text "Ab" starting at 6 index and ending at index 8
Split using Pattern.split(): one
Split using Pattern.split(): two
Split using Pattern.split(): three
Split using Pattern.split(): four
Split using Pattern.split(): five
Using replaceAll: _345_678
Using replaceFirst: _34512678
```

# Common Matchings

## Matching an Email Address

```java
/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,5})$/
```
* **Group 1 ([a-z0-9_\.-]+)** 
	- In this section of the expression, we match one or more lowercase letters between a-z, numbers between 0-9, underscores, periods, and hyphens. The expression is then followed by an @ sign.
* **Group 2 ([\da-z\.-]+)**
	- Next, the domain name must be matched which can use one or more digits, letters between a-z, periods, and hyphens. The domain name is then followed by a period \..
* **Group 3 ([a-z\.]{2,5})**
	- Lastly, the third group matches the top level domain. This section looks for any group of letters or dots that are 2-5 characters long. This can also account for region-specific top-level domains.
* Therefore, with the regex expression above you can match many of the commonly used emails such as firstname.lastname@domain.com for example.

## Matching a Phone Number
```java
/^\b\d{3}[-.]?\d{3}[-.]?\d{4}\b$/
```
* **Section 1 \b\d{3}**
    - This section begins with a word boundary to tell regex to match the alpha-numeric characters. It then matches 3 of any digit between 0-9 followed by either a hyphen, a period, or nothing [-.]?.
* **Section 2 \d{3}**
    - The second section is quite similar to the first section, it matches 3 digits between 0-9 followed by another hyphen, period, or nothing [-.]?.
* **Section 3 \d{4}\b**
    - Lastly, this section is slightly different in that it matches 4 digits instead of three. The word boundary assertion is also used at the end of the expression. Finally, the end of the string is defined by the $.
* Therefore, with the above regex expression for finding phone numbers, it would identify a number in the format of 123-123-1234, 123.123.1234, or 1231231234.

