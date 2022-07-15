---
layout: post
title: Suffix Tree
permalink: /suffix-tree
---

- TOC
{:toc}

---

# Suffix Tree
- used to search a pattern in a text.
- preprocess the text so that search operation can be done in time linear in terms of pattern length.
- pattern searching algorithms like KMP, Z, etc take time proportional to text length. 
- using Suffix Tree may not be a good idea when text changes frequently like text editor, etc.

Suffix Tree is compressed trie of all suffixes, so following are very abstract steps to build a suffix tree from given text.
- Generate all suffixes of given text.
- Consider all suffixes as individual words and build a compressed trie.

![suffix-tree.png]({{site.cdn}}/cse/ds/tree/suffix-tree.png)

# Suffix Tree Examples 
- used to find find all occurrences of the pattern in string.
- used to find the longest repeated substring (when text doesn’t change often)
- used to find the longest common substring and the longest palindrome in a string.