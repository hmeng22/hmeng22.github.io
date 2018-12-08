---
title: "Regex"
date: 2017-07-24T18:09:00-04:00
draft: false
---

## Regular Expression

```
圆括号 "()" 分组
方括号 "[]" 匹配字符
花括号 "{}" 匹配字符的数量

插入符 "^" 开始
美元符 "$" 结束
```

```
.		除换行符以外任意单字符
a|b		a or b
*		0 or more times
+		at least 1 time
?		0 or 1 time
{n}		more than n times
{n, m}	between n and m times
```

| Reg  |               |                |
| ---- | ------------- | -------------- |
| \d   | [0-9]         | Digit          |
| \D   | [^0-9]        | Non-digit      |
| \s   | [\s\t\r\n\f]  | Whitespace     |
| \S   | [^\s\t\r\n\f] | Non-Whitespace |
| \w   | [A-Za-z0-9]   | Word           |
| \W   | [^A-Za-z0-9]  | Non-word       |
