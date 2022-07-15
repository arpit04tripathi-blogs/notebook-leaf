---
layout: post
title: Bitwise Operations
permalink: /ds/bitwise
---

- TOC
{:toc}

---

# Basic Bitwise Operations

**Bitwise AND**
```
0100_1011
0001_0101 &
----------
0000_0001
```

**Bitwise OR**
```
0100_1011
0001_0101 |
----------
0101_1111
```

**Bitwise XOR**
```
0100_1011
0001_0101 ^
----------
0101_1110
```

**Bitwise Complement**
```
0100_1011 ~
----------
1011_0100
```

**Bitwise Left Shift**
```
0100_1011 <<2
----------
0010_1100
```

**Bitwise Right Shift**
```
0100_1011 >>2
----------
??01_0010
```
? fill with bits, sign extended.

# kth Bit Operations

**Check Kth Bit (Least Significant) is set?**
`(n & 1<<k-1) > 0`

```
k = 4
0000_1000 1<<k-1
```
```
0100_1011 n
0000_1000 1<<k-1  &
----------
0000_1000
```

**Set Kth Bit (Least Significant) is set?**
`(n | 1<<k-1) > 0`

```
k = 4
0000_1000 1<<k-1
```
```
0100_0011 n
0000_1000 1<<k-1  |
----------
0100_1011
```

**Clear Kth Bit (Least Significant) is set?**
`(n & ~(1<<k-1)) > 0`

```
k = 4
0000_1000 1<<k-1
1111_0111 1<<k-1 ~
```
```
0100_1011 n
1111_0111 ~(1<<k-1)  &
----------
0100_0011
```

**Toggle Kth Bit (Least Significant) is set?**
`(n ^ 1<<k-1) > 0`

```
k = 4
0000_1000 1<<k-1
```
```
0100_0011 n
0000_1000 1<<k-1  ^
----------
0100_1011
```

# Rightmost Bit Operations

**Toggle rightmost One bit**
`n & n-1`

```
0100_0110 n
0100_0101 n-1 &
----------
0100_0100
```

```
0100_0100 n
0100_0011 n-1 &
----------
0100_0000
```

**Isolate rightmost One bit**
`n & -n`

```
0100_1010 n
1011_0110 -n & (2's complement)
----------
0000_0010
```

**Isolate rightmost Zero bit**
`~n & n+1`

```
0100_1011 n
1011_0100 ~n
0100_1100 n+1 &
----------
0000_0100
```

# Power of 2

**Is power of 2**
`n & n-1 == 0`

```
0100_1011 n
0100_1010 n-1 &
----------
0100_1010  (not 0, not power of 2)
```

```
0100_0000 n
0011_1111 n-1 &
----------
0000_0000  (0, power of 2)
```

**Multiply power of 2**
`(n x 2^k) == n <<k`
```
0001_1011 n
----------
1101_1000  n << 3
```

**Divide by power of 2**
`(n / 2^k) == n >>k`
```
0001_1011 n = 27 (divide by 8)
----------
0000_0011  n >>3
```

# Bitwise Miscellaneous

**Modulo**
- %8 = `n & 0x7`
- %32 = `n & 0x1F`

```
0100_1011 n (75)
0000_0111 0x7
----------
0000_0011 3 (75%8 = 3)
```

**Average without Division**
- `mid = (low + high)/2` - this can go beyond int limit
- `mid = low + (high-low)/2`

```
mid = low + (high-low)>>1
```

**Swap All Odd and Even bits**
`(n & 0x55) << 1 | (n & 0xAA) >> 1`

```
0100_1011 n
1010_1010 0xAA 
----------
0000_1010 (Even bits)
0000_0101 (Even bits)>>1
```
```
0100_1011 n
0101_0101 0x55 
----------
0100_0001 (Odd bits)
1000_0010 (Odd bits)<<1
```
```
1000_0010 (Odd bits)<<1
0000_0101 (Even bits)>>1 |
----------
1000_0111
```

**Reverse Binary Number**
```java
int n = 10;
int reverse = 0;
int lsb = 0;
int s = 32; // size of int
System.out.println(Integer.toString(n, 2));
System.out.println(String.format("%32s", Integer.toBinaryString(n)).replaceAll(" ", "0"));
while (n > 0) {
    reverse <<= 1;
    lsb = n & 1;
    reverse |= lsb;
    n >>= 1;
    s--;
}
reverse <<= s;
System.out.println(String.format("%32s", Integer.toBinaryString(reverse)).replaceAll(" ", "0"));
```

**Count number of Ones**
- bit by bit

```java
while(n>0){
    count += n & 1;
    n >>= 1;
}
```

- 4 bit group map
- 0100 = 1 bit (4)

```java
int[] bits = {0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4};
while(n>0){
    count += bits[n & 0xF];
    n >>= 4;
}
```

**Create mask for trailing Zero**
`(n & -n) - 1`

```
0100_1000 n
1011_1000 -n &
----------
0000_1000 (n & -n)
----------
0000_0111 (n & -n) - 1
```

