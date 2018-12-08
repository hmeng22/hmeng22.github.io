---
title: "Elasticsearch"
date: 2017-11-02T22:46:51-04:00
draft: false
---

# ElasticSearch

## Cluster

A **_Cluster_** is a collection of one or more Nodes(servers) that together holds the entire data and provides federated indexing and search capabilities across all Nodes.

A **_Cluster_** is identified by a unique name.

## Node

A **_Node_** is a single server that is part of the **_Cluster_**, stores the data, and participates in the **_Cluster_**'s indexing and search capabilities.

A **_Node_** is identified by a name which by default is a random Universally Unique Identifier(UUID).

## Index

An **_Index_** is a collection of documents that have somewhat similar characteristics.

An **_Index_** is identified by a name which must be all lowercase.

## Type

A **_Type_** is a logical category/partition of the **_Index_**. (Lucene has no concept of **_Type_**, ElasticSearch applies a filter on the field.)

## Document

A **_Document_** is a basic unit of information that can be indexed.

## Shards & Replicas

ElasticSearch provides the ability to subdivide the **_Index_** into multiple pieces called **_Shards_**.

One or more copies of **_Shards_** are called **_Replicas_**.

To summarize, each **_Index_** can be split into multiple **_Shards_**. An **_Index_** can also be replicated zero or more times. Replica is never allocated on the same **_Node_** as the primary Shard that it was copied from.

```
ElasticSearch Structure

        |-Node-|-Index-|-PrimaryShards
        |              |-ReplicaShards
        |
Cluster-|-Node-|-Index-|-PrimaryShards
        |              |-ReplicaShards
        |
        |-Node-|-Index-|-PrimaryShards
        |              |-ReplicaShards

Index-|-Type-|-Document
      |-Type-|-Document
      |-Type-|-Document
```

### Cons

1. Cluster down
2. Rebuilding Indices
3. Migration

## REST APIs

```
GET /_cat
GET /_cluster/*
GET /_nodes
GET /_tasks
POST /_reindex

<REST Verb> /<Index>/<Type>/<ID>
Query DSL : "query", "bool", "must", "should", "match", "match_all", "filter", "_source"

Bulk actions : "index", "create", "delete", "update"
```
