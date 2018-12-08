---
title: "Bash"
date: 2018-07-27T17:46:46-04:00
draft: false
---

## Bash

```
# export PS1="[\#] \$ "
PS1变量可以使用的参数值有如下 :
\d	日期weekday month date
\H	完整主机名称
\h	仅取主机的第一个名字
\t	显示时间为24小时格式，如：HH：MM：SS
\T	显示时间为12小时格式
\A	显示时间为24小时格式：HH：MM
\u	当前用户的账号名称
\v	BASH的版本信息
\w	完整的工作目录名称。家目录会以 ~代替
\W	利用basename取得工作目录名称，所以只会列出最后一个目录
\#	下达的第几个命令(应该是\\#)
\$	提示字符，如果是root时，提示符为：# ，普通用户则为：$（应该是\\$）
\[	字符"["(应该是\\[)
\]	字符"]"(应该是\\])
\!	命令行动态统计历史命令次数(应该是\\!)
```

## Command

```
cp -R dirA dirB
rm -rf files

更改文件权限 : chmod -R 755 file
更改文件属组 : chown -R root:wheel dirA

分页格式化显示文件内容 : pg file  
分屏格式化显示文件内容 : more file

查找文件 : find  
显示文件类型 : file file

显示文件前20行 : head -20 file  
显示文件后20行 : tail -20 file  
在文件中查找 : grep 

统计文件字符数、词数和行数 : wc file  
显示文件系统总空间和可用空间 : df  
显示当前系统活动的总信息 : w  

查看文件夹大小 : du -sh *

查看系统信息 : uname -a  
查询进程 : ps -ef | grep httpd

压缩 : tar zcvpf filename.tar.gz /directoryPath  
zip filename.zip /directoryPath/files

找出特定的行 : grep
把行拆分成多个字段 : awk
更新插入删除等操作 : sed

重定向复制和粘贴 : pbcopy 和 pbpaste (ls ~ | pbcopy < content.txt)

ls 命令 :
只列出文件夹 : ls -l |grep ^d 或者 ls -d */
列出所有文件夹和其中内容 : ls */

multiple files :
file[1-3].txt
```

## Bash Programming

```bash
#!/bin/sh
cd ~
mkdir aDirectory
cd aDirectory

for ((i=0; i<10; i++)); do
    touch test_$i.txt
done

# 定义变量
var = 1
echo ${var}
str = 'I am a string'
str = "hello, my number is \"$var\" \n"
echo ${#string}
echo ${string:1:4}

if ps -ef | grep httpd
then
	echo hello
elif ps -ef | grep 
	echo else
fi

for var in item1 item2 ... itemN
do
	echo ${var}
done

while condition (: = true)
do
	command
done

# 定义函数
source ./function.sh or . ./function.sh
```

## Tools

```
显示路由表: netstat -nr
追踪ip: traceroute xxx.xxx.xxx.xxx
DNS域名解析:    host www.xxx.xxx


reset launchpad
defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
```