---
title: "Latex"
date: 2017-07-25T08:12:05-04:00
draft: false
---

## 概念

控制序列，是以反斜杠\开头，以第一个***空格或非字母***的字符结束一段文字。

## 开头

```latex
\documentclass[12pt,a4paper]{article}
\title{Hello,World!}
\author{Hua}
\date{\today}

页边距
\usepackage{geometry}
\geometry{papersize={15cm,15cm}}
\geometry{left=2.5cm,right=2.5cm,top=2.5cm,bottom=2.5cm}

字间距
\renewcommand{\topfraction}{1}
\renewcommand{\bottomfraction}{1}
\renewcommand{\textfraction}{0}

行间距
\linespread{1}

换行
~\\ or \\
```

## 正文

```latex
\begin{document}
... ...

\maketitle
\tableofcontents

\section{Hello World!}
\subsection{Hello, China!}
\subsubsecton{Hello, Captial!}

\paragraph{a paragraph}
\subparagraph{an a paragraph}

... ...
\end{document}

行间距
\usepackage{setspace}
\begin{spacing}{1.5}
...
\end{spacing}
```

## 文字

```latex
左对齐文字
\begin{flushleft}
\end{flushleft}

居中文字
\begin{center}
\end{center}

右对齐文字
\begin{flushright}
\end{flushright}

Latex 设置字体大小（由小到大）
\tiny
\scriptsize
\footnotesize
\small
\normalsize
\large
\Large
\LARGE
\huge
\Huge
e.g. \large{… …}

加粗\textbf{}
下划线\underline{}
斜体\emph{} or \textit{} or \textsl{}
```

## 列表

```latex
\usepackage{enumerate}

\begin{itemize}
\item[-]
\item[*]
\end{itemize}

\begin{enumerate}[step 1]  (e.g. [1.~],(1),i,[{case} 1])
\item
\end{enumerate}
```

## 数学

```latex
数学环境，右面会有公式序号。$$生成的公式没有序号。
\begin{equation}
… …
\end{equation}

a^2_{ij}\neq e^{x^2}

\overline{m+n}, \underline{m+n}
\overrightarrow{mn}

\sqrt[]{}, \frac{}{},

矩阵
\begin{pmatrix} a&b\\c&d \end{pmatrix}
\begin{bmatrix} a&b\\c&d \end{bmatrix}
\begin{Bmatrix} a&b\\c&d \end{Bmatrix}
\begin{vmatrix} a&b\\c&d \end{vmatrix}
\begin{Vmatrix} a&b\\c&d \end{Vmatrix}

\left[
\begin{array}{ccc}
1 & 1 & 1 \\
1 & 1 & 1 \\
1 & 1 & 1 \\
\end{array}
\right]

大括号公式
\left\{
\begin{array}{ccc}
x = x_0 + at \\
y = y_0 + bt \\
z = z_0 + ct \\
\end{array}
\right.

求和
\sum_{i=1}^{n}
\sum\limits_{i=1}^{n}

积分
\int_{-\infty}^{\infty}, \iint

极限
\lim\limits_{x\to0}

字母
\alpha \beta \gamma \delta \varepsilon \eta \theta \lambda \sigma \upsilon \phi \varphi \chi \psi \omega \Gamma \Delta \Theta \Lambda \Pi \Sigma \Phi \Omega \nabla \rho \epsilon

偏导数
\partial

梯度
\bigtriangledown \nabla

点乘
\cdot

箭头
\leftarrow \Rightarrow \longleftarrow \Longrightarrow ...

多行公式左对齐
\begin{equation}
\begin{split}
& equ1 \\
& equ2 \\
& equ3 \\
\end{split}
\end{equation}

表格
\begin{table}[ht]
\begin{center}
\begin{tabular}[ht]{|c|lr|c|}
%c stands for centre, l for left, r for right; the | puts lines in between, and the hline puts a horizontal line in
\hline
$n$ & $\alpha$ &$n\alpha$ & $\beta$\\
\hline
1 & 0.2 & 0.2 & 5\\
\hline
2 & 0.3 & 0.6 & 4\\
\hline
3 & 0.7 & 2.1 & 3\\
\hline
\end{tabular}
\caption{A random table \label{tab1}}
\end{center}
\end{table}

合并单元格
\multicolumn{3}{c|}{title}
\hline 画一整条横线
\cline{2-3} 画从2到3列横线
\multicolumn{1}{|c|}{Human}
\vline 画一行竖线
```

## 图片

```latex
\usepackage{graphicx}

\begin{figure}[H]
\begin{center}
\begin{tabular}{c c}
\includegraphics [width=7.62cm] {image1.jpg} &
\includegraphics [width=7.62cm] {image2.jpg} \\
{(a) image1} & {(b) image2}
\end{tabular}
\end{center}
\caption{{\bf (a) n=1} caption1 and {\bf (b) n=3} caption2}
\label{fig1}
\end{figure}

图片位置不对
\usepackage{float}
\begin{figure}[H]
\end{figure}
```

## 表格

```latex
\begin{tabular}{|l|c|r|}
 \hline 操作系统& 发行版& 编辑器\\
 \hline Windows & MikTeX & TexMakerX \\
 \hline Unix/Linux & teTeX & Kile \\
 \hline Mac OS & MacTeX & TeXShop \\
 \hline 通用& TeX Live & TeXworks \\
 \hline
\end{tabular}
```
