---
title: "2Arrays"
date: 2017-07-28T17:42:07-04:00
draft: false
---

```
Given two arrays a[] and b[] and they have the same length.
Find the maximum difference diff = b[j] - a[i] while j >= i.
```

## Solutions

```
Method 1 :
/*
Iterate a[i] (0 < i < length) and a[j] (i < j < length), record the maximum difference b[j] - a[i].
*/

function method1(a, b) {
  var o_max = 0;
  var p_i,
    p_j;
  for (var i = 0; i < length; i++) {
    for (var j = i; j < length; j++) {
      if (b[j] - a[i] >= o_max) {
        o_max = b[j] - a[i];
        p_i = i;
        p_j = j;
      }
    }
  }
  return o_max;
}
```

```
Method 2 :
/*
Find a[] minimum value a[i] and b[] maximum value b[j];
if (j>i) {
  return b[j] - a[i];
} else {
  Slice a[] and b[] into 3 arrays separately:
  a_left[0-i], a_mid[i-j], a_right[j-length]
  b_left[0-i], b_mid[i-j], b_right[j-length]

  Find a_left[0-i] minimum value a_left_min
  Find b_right[j-length] maximum value b_right_max
  Find maximum difference ab_mid_diff in a_mid[i-j] and b_mid[i-j]

  return maximum value of (b[j] - a_left_min, ab_mid_diff, b_right_max - a[i])
}
*/

function method2(a, b) {
  var o_max = m2(a, b);
  return o_max;
}

function arrayMin(a) {
  var l = a.length
  var min = Number.POSITIVE_INFINITY
  for (var i = 0; i < l; i++) {
    if (min > a[i])
      min = a[i]
  }
  return min
}

function arrayMax(a) {
  var l = a.length
  var max = Number.NEGATIVE_INFINITY
  for (var i = 0; i < l; i++) {
    if (max < a[i])
      max = a[i]
  }
  return max
}

function m2(a, b) {
  if (a.length == 0 || b.length == 0) {
    return Number.NEGATIVE_INFINITY;
  } else {
    var a_min = arrayMin(a);
    var a_min_index = a.indexOf(a_min);
    var b_max = arrayMax(b);
    var b_max_index = b.indexOf(b_max);

    if (b_max_index >= a_min_index) {
      return b_max - a_min;
    } else {
      var a_leftFromBMax_min = arrayMin(a.slice(0, b_max_index + 1))

      var a_mid = a.slice(b_max_index + 1, a_min_index)
      var b_mid = b.slice(b_max_index + 1, a_min_index)

      var b_rightFromAMix_max = arrayMax(b.slice(a_min_index, b.length))

      return Math.max(b_max - a_leftFromBMax_min, m2(a_mid, b_mid), b_rightFromAMix_max - a_min);
    }
  }
}
```

```
Method 3 :
/*
Initlize a_min[] and b_max[]
a_min[i] stores the minimum value of a[0-i]
b_max[j] stores the maximum value of b[j-length]

return maximum value of b_max[t] - a_min[t]
*/

function method3(a, b) {
  var a_min = []
  var b_max = [];

  a_min[0] = a[0];
  b_max[length] = b[length];
  b_max[0] = Math.max(...b);

  for (var i = 1; i <= length; i++) {
    a_min[i] = a_min[i - 1] < a[i]
      ? a_min[i - 1]
      : a[i];
    b_max[length - i] = b_max[length - i + 1] > b[length - i]
      ? b_max[length - i + 1]
      : b[length - i]
  }

  var o_max = 0;
  for (var i = 0; i <= length; i++) {
      if (o_max < b_max[i] - a_min[i]) {
        o_max = b_max[i] - a_min[i];
      }
  }

  return o_max;
}
```

```
Method 4 :
/*
o_max[i][j] represents the maximum difference of array a[0-i] and b[0-j].
o_max[0][0] = b[0] - a[0];

o_max[t][t-1] = o_max[t-1][t-1];
o_max[t-1][t] = Math.max(o_max[n-1][n-1], b[t] - a_min[0-(t-1)]);
o_max[t][t] = Math.max(o_max[t-1][t-1], o_max[t-1][t], b[t] - a[t]);
*/

function method4(a, b) {
  var o_max = [];
  for (var i = 0; i < length; i++) {
    o_max[i] = [];
  }

  var a_min = a[0];
  o_max[0][0] = b[0] - a_min;

  for (var n = 1; n < length; n++) {
    o_max[n][n - 1] = o_max[n - 1][n - 1];
    o_max[n - 1][n] = Math.max(o_max[n - 1][n - 1], b[n] - a_min);
    o_max[n][n] = Math.max(o_max[n - 1][n - 1], o_max[n - 1][n], b[n] - a[n]);

    a_min = a_min < a[n]
      ? a_min
      : a[n];
  }

  return o_max[length - 1][length - 1];
}
```

```
Method 5 :
/*
In Method 4, o_max[n][n] = Math.max(o_max[n - 1][n - 1], o_max[n - 1][n], b[n] - a[n]); o_max[n][n] appears at both sides of the equation.
Improve Method 4.

o_max_i_1_j represents the maximum difference of array a[0-(t-1)] and b[0-t].
o_max represents the maximum difference of array a[0-t] and b[0-t].

o_max = Math.max(o_max, o_max_i_1_j, b[t] - a[t]);
*/

function method5(a, b) {
  var a_min = a[0];
  o_max_i_1_j = b[1] - a[0];
  o_max = b[0] - a[0];

  for (var n = 1; n < length; n++) {
    o_max_i_1_j = Math.max(o_max, b[n] - a_min);
    o_max = Math.max(o_max, o_max_i_1_j, b[n] - a[n]);

    a_min = a_min < a[n]
      ? a_min
      : a[n];
  }

  return o_max;
}
```

## Comparison

| Methods \ Complexity |     Time      | Space  |
| :------------------: | :-----------: | :----: |
|       Method1        |    O(n^2)     |  O(1)  |
|       Method2        | O(n) - O(n^2) |  O(1)  |
|       Method3        |     O(n)      |  O(n)  |
|       Method4        |     O(n)      | O(n^2) |
|       Method5        |     O(n)      |  O(1)  |

```
* The worst case of Method 2.
T(n) = T(n-2) + O(n)
T(n-2) = T(n-4) + O(n-2)
T(n-4) = T(n-6) + O(n-4)
...
T(n-k) = T(n-k-2) + O(n-k)

T(n) = T(n-k-2) + O((k/2) * (n+n-k)/2)
T(n) = T(n-k-2) + O((2kn-k^2)/4)

Since T(1) = O(1), let n-k-2=1, k=n-3.
T(n) = T(1) + O((2(n-3)n-(n-3)^2)/4)
T(n) = O(1) + O((n^2-9)/4)
```

| Methods \ Data Amount | 1000       | 10000       | 100000        |
| --------------------- | ---------- | ----------- | ------------- |
| Method1               | 1.186251ms | 49.271391ms | 5365.147697ms |
| Method2               | 0.188762ms | 0.410724ms  | 1.857212ms    |
| Method3               | 0.225481ms | 2.525954ms  | 30.219815ms   |
| Method4               | 2.032282ms | 15.501883ms | 165.721653ms  |
| Method5               | 0.20739ms  | 0.913879ms  | 1.280959ms    |

> \* This table is generated by codes below.



```
2ArrayComparison.js

var a, b, length;

var dataLengthArray = [1000, 10000, 100000];
var methodsLength = 6;
var o_max_Array = [];
for (var l = 0; l < dataLengthArray.length; l++) {
  length = dataLengthArray[l];
  a = [];
  b = [];
  for (var r = 0; r < length; r++) {
    a.push(Math.floor((Math.random() * length) + 1));
    b.push(Math.floor((Math.random() * length) + 1));
  }

  var o_max_results = [];
  for (var m = 1; m <= methodsLength; m++) {
    var result_obj = {};
    var result = 0;
    var hrstart = process.hrtime();
    switch (m) {
      case 1:
        result = method1(a, b);
        break;
      case 2:
        result = method2(a, b);
        break;
      case 3:
        result = method3(a, b);
        break;
      case 4:
        result = method4(a, b);
        break;
      case 5:
        result = method5(a, b);
        break;
      case 6:
        result = method6(a, b);
        break;
    }
    var hrend = process.hrtime(hrstart);
    result_obj.method = "method" + m;
    result_obj.result = result;
    result_obj.ms = hrend[0] * 1000 + hrend[1] / 1000000;
    o_max_results.push(result_obj);
  }
  o_max_Array.push(o_max_results);
}

// console.log(o_max_Array)
comparison();

function comparison() {
  var dataAmountStr = '|Methods \\ Data Amount |   ';
  var tableStr = '|---|';
  for (var l = 0; l < dataLengthArray.length; l++) {
    dataAmountStr += dataLengthArray[l] + '|';
    tableStr += '----|';
  }
  console.log(dataAmountStr);
  console.log(tableStr);

  for (var m = 0; m < methodsLength; m++) {
    var methodStr = '|Method' + (m + 1) + '|';
    for (var l = 0; l < dataLengthArray.length; l++) {
      var result_obj = o_max_Array[l][m];
      methodStr += result_obj.ms + 'ms' + '|';
    }
    console.log(methodStr);
  }
}

function method1(a, b) {
  var o_max = 0;
  var p_i,
    p_j;
  for (var i = 0; i < length; i++) {
    for (var j = i; j < length; j++) {
      if (b[j] - a[i] >= o_max) {
        o_max = b[j] - a[i];
        p_i = i;
        p_j = j;
      }
    }
  }
  return o_max;
}

function method2(a, b) {
  var o_max = m2(a, b);
  return o_max;
}

function arrayMin(a) {
  var l = a.length
  var min = Number.POSITIVE_INFINITY
  for (var i = 0; i < l; i++) {
    if (min > a[i])
      min = a[i]
  }
  return min
}

function arrayMax(a) {
  var l = a.length
  var max = Number.NEGATIVE_INFINITY
  for (var i = 0; i < l; i++) {
    if (max < a[i])
      max = a[i]
  }
  return max
}

function m2(a, b) {
  if (a.length == 0 || b.length == 0) {
    return Number.NEGATIVE_INFINITY;
  } else {
    var a_min = arrayMin(a);
    var a_min_index = a.indexOf(a_min);
    var b_max = arrayMax(b);
    var b_max_index = b.indexOf(b_max);

    if (b_max_index >= a_min_index) {
      return b_max - a_min;
    } else {
      var a_leftFromBMax_min = arrayMin(a.slice(0, b_max_index + 1))

      var a_mid = a.slice(b_max_index + 1, a_min_index)
      var b_mid = b.slice(b_max_index + 1, a_min_index)

      var b_rightFromAMix_max = arrayMax(b.slice(a_min_index, b.length))

      return Math.max(b_max - a_leftFromBMax_min, m2(a_mid, b_mid), b_rightFromAMix_max - a_min);
    }
  }
}

function method3(a, b) {
  var a_min = []
  var b_max = [];

  a_min[0] = a[0];
  b_max[length] = b[length];
  b_max[0] = arrayMax(b);

  for (var i = 1; i <= length; i++) {
    a_min[i] = a_min[i - 1] < a[i]
      ? a_min[i - 1]
      : a[i];
    b_max[length - i] = b_max[length - i + 1] > b[length - i]
      ? b_max[length - i + 1]
      : b[length - i]
  }

  var o_max = 0;
  for (var i = 0; i <= length; i++) {
      if (b_max[i] - a_min[i] >= o_max) {
        o_max = b_max[i] - a_min[i];
      }
  }

  return o_max;
}

function method4(a, b) {
  var o_max = [];
  for (var i = 0; i < length; i++) {
    o_max[i] = [];
  }

  var a_min = a[0];
  o_max[0][0] = b[0] - a_min;

  for (var n = 1; n < length; n++) {
    o_max[n][n - 1] = o_max[n - 1][n - 1];
    o_max[n - 1][n] = Math.max(o_max[n - 1][n - 1], b[n] - a_min);
    o_max[n][n] = Math.max(o_max[n - 1][n - 1], o_max[n - 1][n], b[n] - a[n]);

    a_min = a_min < a[n]
      ? a_min
      : a[n];
  }

  return o_max[length - 1][length - 1];
}

function method5(a, b) {
  var a_min = a[0];
  o_max_i_1_j = b[1] - a[0];
  o_max = b[0] - a[0];

  for (var n = 1; n < length; n++) {
    o_max_i_1_j = Math.max(o_max, b[n] - a_min);
    o_max = Math.max(o_max, o_max_i_1_j, b[n] - a[n]);

    a_min = a_min < a[n]
      ? a_min
      : a[n];
  }

  return o_max;
}
```
