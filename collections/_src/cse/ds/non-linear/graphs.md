---
layout: post
title: Graphs
permalink: /ds/graphs
---

- TOC
{:toc}

---

- Representation
- Reachability
- Connectedness
- Directed Acyclic
- Shortest Path
- Spanning Tree

# Introduction to Graphs
- Non Linear Data Structure.
- Tree has Constraint - N nodes, must have N-1 edges.
- A Graph G is an ordered pair of a set V of vertices and a set E of edges.
  - ordered pair (a,b) != (b,a) if a!=b

```
G = (V , E)
|V| = No. of vertices
|E| = No. of Edges

If No Self Loop or parallel Edges,
0 <= |E| <= n(n-1), if directed
0 <= |E| <= n(n-1)/2, if undirected
where n = |V|
```
- Dense Graph - Too many edges - use adjacency matrix
- Sparse Graph - Less edges - use adjacency list

![graphs-terminology]({{site.cdn}}/cse/ds/graph/graphs-terminology.png)

- **Walk** - A sequence of vertices where each adjacent pair is connected by an edge.
- **Path** - A *Walk* where no vertex or edge is repeated.
- **Trail** - A *Walk* where no edge is repeated, vertex might be repeated.
- **Closed Walk** - Starts and Ends at the same vertex.
- **Cycle** - No repetition other than start and end.
- **Acyclic Graph** - Graph with no cycle.

**Strongly Connected Graphs**
- If there is a path from any vertex to any other vertex.


# Examples
- Facebook is undirected graph.
- World wide web is directed graph.
- Intracity Road Network is undirected graph.
- Intercity Road Network is directed graph.

![graph-applications]({{site.cdn}}/cse/ds/graph/graph-applications.png)

# Graph Representation

![graph-representation-inefficient]({{site.cdn}}/cse/ds/graph/graph-representation-inefficient.png)

Most practical graphs will be sparse.
Facebook - if 10^9 users then, each user may have 1000 friends but not all users on fb will be his friends.
```
total edges required = 10^9 * 1000 / 2 = 5 * 10^11 ~ 0.5 Terabyte
total space for adjacency Matrix = 10^18 ~ 1 Petabyte
```

![graph-representaion]({{site.cdn}}/cse/ds/graph/graph-representaion.png)


## Graph
- DS with two components:
	- finite set of vertices also called as nodes.
	- finite set of ordered pair of the form (u, v) called as edge. 
- pair is ordered as (u, v) != (v, u) for directed graph(di-graph). Edges may contain weight/value/cost.
	- V -> Number of Vertices.
    - E -> Number of Edges.

#### Direction based classification
- Undirected Graph : The graph in which all the edges are bidirectional.
- Directed Graph : The graph in which all the edges are unidirectional.

#### Weight based classification
- Weighted Graph : weight associated with the edges.
- Unweighted Graph : no weight associated to the edges.

![graph-representaion.png]({{site.cdn}}/cse/ds/graph/graph-representaion.png)

|Time Complexities| Adjacency Matrix | Adjacency List |
|---|---|---|
|Traversal        | (By BFS or DFS) O(V^2)	| (By BFS or DFS) O(ElogV)|
|Space            | O(V^2)                  | O(V+E) |

#### Examples
- find shortest path in any network (in google maps). 
- social networking websites with friend suggestion.

