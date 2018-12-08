---
title: "KnapsackProblems"
date: 2017-07-28T18:33:35-04:00
draft: false
---

## Knapsack Problems

Dynamic programming aka optimization is a method saves cpmputation time by using extra space. The key is break the problem into sub-problems, solve each sub-problem and store its result.

```
N			: how many different items
W			: weight limit
V			: volume limit
Value		: Value limit
amount[n]	: each item's amount
weight[n]	: each item's weight
volume[n]	: each item's volume
value[n]	: each item's value
```

```
K1: 0/1 : Each item can only be selected once.

dp[n,w]=max(dp[n-1,w], dp[n-1,W-w[n]]+value[n]);
dp[n,w]=
{ 0,                                       if n=0 and w>=0
{ max(dp[n-1,w], dp[n-1,W-w[n]]+value[n]), if n>0 and W-w[n]>=0
{ dp[n-1,w],                               if n>0 and W-w[n]<0
* notice that dp[n, w] appears at both sides of the equation, re-use it.

for(int n = 1; n <= N; n++) {
  for(int w = 0; w <= W; w++) {
    if(w-weight[n] < 0) {
      dp[n][w] = dp[n-1][w]
    } else {
      dp[n][w] = max(dp[n-1][w], dp[n-1][w-weight[n]] + value[n])
    }
  }
}
// Only 'Top' and 'Top-left' are used in the recursive formula
// Use backward approach (avoid overwrite previous results) with a 1-dimensional

for(int n = 1; n <= N; n++) {
  for(int w = W; w-weight[n] >= 0; w--) {
    dp[w] = max(dp[w], dp[w-weight[n]] + value[n])
  }
}
```

```
K2: complete : Each item can only be selected unlimited.

for(int n = 1; n <= N; n++) {
  for(int w = weight[n]; w <= W; w++) {
    dp[w] = max(dp[w], dp[w-weight[n]] + value[n])
  }
}
```

```
K3: multiple : Each item has a fixed amount.

for(int n = 1; n <= N; n++) {
  for(int w = 0; w <= W; w++) {
    for(int a = 0; a <= amount[n]; a++) {
      dp[w] = max(dp[w], dp[w-a*w[n]] + a*value[n])
    }
  }
}
```

```
K4: K1+K2+K3
```

```
K5: twoLimits : weight and volume

for(int n = 1; n <= N; n++) {
  for(int w = 0; w <= W; w++) {
    for(int v = 0; v <= V; v++) {
      dp[n][w][v] = max(dp[n-1][w][v], dp[n-1][w-w[n]][v-v[n]] + value[n])
    }
  }
}
```

```
K6: groups : Items are divided into groups, each of which collides with each other
```

```
K7: conditions : Some items can only be selected if another item is selected
```
