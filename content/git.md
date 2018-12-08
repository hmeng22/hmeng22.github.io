---
title: "Git"
date: 2017-07-24T18:08:39-04:00
draft: false
---

## Git

```
$ git --version

--global setting
$ git config --global user.name "yourusername"
$ git config --global user.email "youremail"
$ git config --list

--init
$ git init
$ git clone url
$ git log
$ git reflog (any change update the HEAD)
```

```
--branch
$ git branch -a
$ git checkout -b newBranch
$ git checkout branchNameSwitchingTo
$ git branch -d branchNameDeleted
$ git push origin branchNamePushed
$ git merge branchNameMerged
```

```
--local
$ git status
$ git add .
$ git rm .
$ git commit -m "comments"

--remote
$ git remote -v

$ git remote add origin url
$ git remote show origin
$ git remote rm origin

$ git push origin masterOrBranchName
$ git pull
$ git fetch origin masterOrBranchName
```

```
--revert & reset

revert	: 撤销某次操作，此次操作之前的commit都会被保留.
		: 用一次新的commit来回滚之前的commit.
reset	: 撤销某次提交，但是此次之后的修改都会被退回到暂存区.
		: 直接删除指定的commit.

还没push
	git reset --mixed 保留源码,只是将git commit和index 信息回退到了某个版本.
	git reset --soft  保留源码,只回退到commit 信息到某个版本.如果还需要提交,直接commit即可.
	git reset --hard  源码也会回退到某个版本,commit和index 都回回退到某个版本.
	git reset --hard origin/master 将本地的状态回退到和远程的一样.

已经push
	git revert	用一个新提交来消除一个历史提交所做的任何修改.
```

```
--working trees

Say you have this, where C is your HEAD and (F) is the state of your files.

   (F)
A-B-C
    ↑
  master

git reset --hard HEAD~1

 (F)
A-B
  ↑
master

Revert commit, resulting in a linear commit history
git revert C

     (F)
A-B-C-D
      ↑
    master

Where the file tree of D is identical to B


# This saves the modifications, then reapplies that patch after resetting.
git stash
git reset --hard xxxxxx
git stash pop
```

```
--
$ git rm $(git ls-files --deleted)
```


```
local :
git branch -f main side
git rebase -i
git rebase base side
git cherry-pick B1 B2 B3

remote :
git pull --rebase
```
