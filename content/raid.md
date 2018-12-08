---
title: "Raid"
date: 2017-07-25T08:05:51-04:00
draft: false
---

# RAID

Redundant Array of Independent Disks (RAID) **独立硬盘冗余阵列**.



#### RAID 0

```
       RAID 0
  |--------------|
 A1              A2
 A3              A4
 A5              A6

Disk 0         Disk 1
```

#### RAID 1

```
       RAID 1
  |--------------|
 A1              A1
 A2              A2
 A3              A3

Disk 0         Disk 1
```

#### RAID 5

```
             RAID 5 (at least 3 disks)
  |--------------|--------------|--------------|
 A1              A2             A3             Ap
 B1              B2             Bp             B4
 C1              Cp             C3             C4
 Dp              D2             D3             D4
 
Disk 0         Disk 1         Disk 2         Disk 3
```

#### RAID 01

```
                     RAID 1
         |----------------------------|
       RAID 0                       RAID 0
  |--------------|              |--------------|
 A1              A2             A1             A2
 A3              A4             A3             A4
 A5              A6             A5             A6
 
Disk 0         Disk 1         Disk 2         Disk 3
```

#### RAID 10

```
                     RAID 0
         |----------------------------|
       RAID 1                       RAID 1
  |--------------|              |--------------|
 A1              A1             A2             A2
 A3              A3             A4             A4
 A5              A5             A6             A6
 
Disk 0         Disk 1         Disk 2         Disk 3
```

