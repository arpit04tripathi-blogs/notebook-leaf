---
layout: post
title: Sorting Algorithms
permalink: /algo/sort
---

- TOC
{:toc}

---

# Introduction

- Sorting refers to arranging data in a particular order.
- Data searching can be optimized to a very high level, if data is stored in a sorted manner. 

|In-Place Sorting	|Not-In-Place Sorting|
|---|---|
Sorting algorithms may require some extra space for comparison and temporary storage of few data elements. These algorithms do not require any extra space and sorting is said to happen in-place, or for example, within the array itself. This is called in-place sorting. |In some sorting algorithms, the program requires space which is more than or equal to the elements being sorted. Sorting which uses equal or more space is called not-in-place sorting. 
|Bubble sort is an example of in-place sorting.	|Merge-sort is an example of not-in-place sorting.|

Stable Sorting and Not Stable Sorting – In a Sorting Algorithm, after sorting the contents, does not change the sequence of similar content in which they appear, it is called stable sorting.

|Adaptive Sorting Algorithm	|Non-Adaptive Sorting Algorithm|
|---|---|
|A sorting algorithm is said to be adaptive, if it takes advantage of already 'sorted' elements in the list that is to be sorted. That is, while sorting if the source list has some element already sorted, adaptive algorithms will take this into account and will try not to re-order them.	|A non-adaptive algorithm is one which does not take into account the elements which are already sorted. They try to force every single element to be re-ordered to confirm their sortedness.|

- Increasing Order - 1, 3, 4, 6, 8, 9
- Non-Increasing Order - 1, 3, 3, 6, 8, 9
- Decreasing Order - 9, 8, 6, 4, 3, 1 
- Non-Decreasing Order - 9, 8, 6, 3, 3, 1

|Algorithm        |Best-case  |Worst-case |Average-case|Space Complexity   |Stable?|
|---              |---        |---        |---        |---                 |---|
|Bubble Sort      |Ο(n)       |Ο(n2)      |Ο(n2)      |Ο(1)                |Yes|
|Insertion Sort   |Ο(n)       |Ο(n2)      |Ο(n2)      |Ο(1)                |Yes|
|Selection Sort   |Ο(n2)      |Ο(n2)      |
|Merge Sort       |Ο(n logn)  |Ο(n logn)  |Ο(n logn)  |Ο(n)                |Yes|
|Quicksort        |Ο(n logn)  |Ο(n2)      |Ο(n logn)  |Log n(best), n (avg)|Usually not*
|Heapsort         |Ο(n logn)  |Ο(n logn)  |Ο(n logn)  |Ο(1)                |No|
|Counting Sort    |Ο(k + n)   |Ο(k + n)   |Ο(k + n)   |Ο(k + n)            |Yes|

# Bubble Sort

![bubble-sort.png]({{site.cdn}}/cse/algo/sort/bubble-sort.png)

**Algorithm**
```
begin BubbleSort(list)
   for all elements of list
      if list[i] > list[i+1]
         swap(list[i], list[i+1])
      end if
   end for   
   return list   
end BubbleSort
```

**Pseudo Code**
```java
procedure bubbleSort( list : array of items )
   loop = list.count;   
   for i = 0 to loop-1 do:
      swapped = false        
      for j = 0 to loop-1 do:
         /* compare the adjacent elements */   
         if list[j] > list[j+1] then
            /* swap them */
            swap( list[j], list[j+1] )         
            swapped = true
         end if         
      end for      
      /*if no number was swapped that means array is sorted now, break the loop.*/      
      if(not swapped) then
         break
      end if      
   end for   
end procedure return list
```

# Selection Sort

An in-place comparison-based algorithm in which the list is divided into two parts, the sorted part at the left end and the unsorted part at the right end. Initially, the sorted part is empty and the unsorted part is the entire list.

The smallest element is selected from the unsorted array and swapped with the leftmost element, and that element becomes a part of the sorted array. This process continues moving unsorted array boundary by one element to the right.

This algorithm is not suitable for large data sets as its average and worst-case complexities are of Ο(n2), where n is the number of items.

![selection-sort.png]({{site.cdn}}/cse/algo/sort/selection-sort.png)

**Algorithm**
```
Step 1 − Set MIN to location 0
Step 2 − Search the minimum element in the list
Step 3 − Swap with value at location MIN
Step 4 − Increment MIN to point to next element
Step 5 − Repeat until list is sorted
```

**Pseudo Code**
```java
procedure selection sort 
   list  : array of items
   n     : size of list
   for i = 1 to n - 1
   /* set current element as minimum*/
      min = i      
     /* check the element to be minimum */
      for j = i+1 to n 
         if list[j] < list[min] then
            min = j;
         end if
      end for
     /*swap the minimum element with the current element*/
      if indexMin != i  then
         swap list[min] and list[i]
      end if
   end for    
end procedure
```

# Insertion Sort

![insertion-sort.png]({{site.cdn}}/cse/algo/sort/insertion-sort.png)

```
Time - O(n2)
Auxillary Sapce – O(1)   key
```

An in-place comparison-based sorting algorithm. Here, a sub-list is maintained which is always sorted. For example, the lower part of an array is maintained to be sorted. An element which is to be 'insert'ed in this sorted sub-list, has to find its appropriate place and then it has to be inserted there. Hence the name, insertion sort.

The array is searched sequentially and unsorted items are moved and inserted into the sorted sub-list (in the same array). This algorithm is not suitable for large data sets as its average and worst case complexity are of Ο(n2), where n is the number of items.

**Algorithm**
```
Step 1 − If it is the first element, it is already sorted. return 1;
Step 2 − Pick next element
Step 3 − Compare with all elements in the sorted sub-list
Step 4 − Shift all the elements in the sorted sub-list that is greater than the value to be sorted
Step 5 − Insert the value
Step 6 − Repeat until list is sorted
```

**Pseudo Code**
```java
procedure insertionSort( A : array of items )
   int holePosition
   int valueToInsert    
   for i = 1 to length(A) inclusive do:    
      /* select value to be inserted */
      valueToInsert = A[i]
      holePosition = i      
      /*locate hole position for the element to be inserted */        
      while holePosition > 0 and A[holePosition-1] > valueToInsert do:
         A[holePosition] = A[holePosition-1]
         holePosition = holePosition -1
      end while        
      /*insert the number at hole position*/
      A[holePosition] = valueToInsert      
   end for
end procedure
```

```java
for j = 2 to A.length{
  key = A[j];
  // insert A[j] into sorted sequence
  i = j-1;
  while (i>0 and A[i] > key){ A[i+1] = A[i]; i--; }
  A[i+1] = key;
}

Inner loop is dependent on outer, need to unroll
j = 2 to n ---> n-1
j= 2 i= 1 time
j=3 i=2time
j=n i=n-1 time
Total Executions = (n-1)(n)/2
```

# Merge Sort

- Divide and Conquer Algorithm.
- It divides input array in two halves, calls itself for the two halves and then merges the two sorted halves. The merge() function is used for merging two halves. 

Merge sort is a sorting technique based on divide and conquer technique. With worst-case time complexity being Ο(n log n), it is one of the most respected algorithms. 

Merge sort first divides the array into equal halves and then combines them in a sorted manner.

![merge-sort.png]({{site.cdn}}/cse/algo/sort/merge-sort.png)

## Algorithm

```
Step 1 − if it is only one element in the list it is already sorted, return.
Step 2 − divide the list recursively into two halves until it can no more be divided.
Step 3 − merge the smaller lists into new list in sorted order. 
```

## Pseudo Code

```java
procedure mergesort( var a as array )
   if ( n == 1 ) return a
   var l1 as array = a[0] ... a[n/2]
   var l2 as array = a[n/2+1] ... a[n]
   l1 = mergesort( l1 )
   l2 = mergesort( l2 )
   return merge( l1, l2 )
end procedure

procedure merge( var a as array, var b as array )
   var c as array
   while ( a and b have elements )
      if ( a[0] > b[0] )
         add b[0] to the end of c
         remove b[0] from b
      else
         add a[0] to the end of c
         remove a[0] from a
      end if
   end while   
   while ( a has elements )
      add a[0] to the end of c
      remove a[0] from a
   end while   
   while ( b has elements )
      add b[0] to the end of c
      remove b[0] from b
   end while   
   return c    
end procedure
```

## Merge Sort for Arrays
The merge(arr, l, m, r) is key process that assumes that arr[l..m] and arr[m+1..r] are sorted and merges the two sorted sub-arrays into one.
 
### STEPS: 
MergeSort(arr[], l,  r), If r > l
1. Find the middle point to divide the array into two halves:  middle m = (l+r)/2
2. Call mergeSort for first half: Call mergeSort(arr, l, m)
3. Call mergeSort for second half: Call mergeSort(arr, m+1, r)
4. Merge the two halves sorted in step 2 and 3: Call merge(arr, l, m, r)

- Time Complexity: T(n) = 2T(n/2) + O(n)
- O(nLogn) for all 3 cases (worst, average and best) as merge sort always divides the array in two halves and take linear time to merge two halves.
- Auxiliary Space: O(n)
- Sorting In Place: No in a typical implementation
- Stable: Yes

## Merge Sort for Linked Lists
 
Preferred for sorting a linked list as slow random-access performance of a linked list makes some other algorithms (such as quicksort) perform poorly, and others (such as heapsort) completely impossible.

![merge-sort-for-list.png]({{site.cdn}}/cse/algo/sort/merge-sort-for-list.png)

## Applications of Merge Sort
- [Inversion Count Problem](https://www.geeksforgeeks.org/counting-inversions/){:target="_blank"}
- Used in [External Sorting](https://en.wikipedia.org/wiki/External_sorting){:target="_blank"}
- [For sorting linked lists in O(nLogn) time](https://www.geeksforgeeks.org/merge-sort-for-linked-list/){:target="_blank"}

## Further
- 3-way Merge sort
- Merge sort for doubly linked list

# Shell Sort

# Quick Sort

# Bucket Sort
