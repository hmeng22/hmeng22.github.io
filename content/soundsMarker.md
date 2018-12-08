---
title: "SoundsMarker"
date: 2017-11-16T22:10:43-05:00
draft: true
---

# SoundMaker

```
混声 Mix   : 由若干轨道NOT（Number of Tracks）组成
轨道 Track : 由若干个节拍NOB（Number of Beats）组成
节拍 Beat  : 由若干个音符NON（Number of Notes）组成
音符 Note  : 单位时间－触发点

音乐 Sound : 音乐

＊ 每分钟多少节拍BPM（Beats Per Minute）来表示速度 tempo（时间基准单位）（60秒触发多少次单位时间）
＊ 每个 Beat 时间固定

S 秒触发 T 个轨道 N 个音、由 BPM 决定、每 Beat 时间固定。
```

```
Engine

Library
    |- SoundPackage
    |        |- SoundItem
    |- MixPackage
    |        |- MixItem
    |- ScorePackage
    |        |- ScoreItem
    |- BeatPackage
    |        |- BeatItem
                    |- Note

MixItem
    |- BeatsPerMinute
    |- NotesPerBeat
    |- Tracks
            |- Track(SoundItem) - ScoreItem - BeatItem - Notes
            |- Track(SoundItem) - ScoreItem - BeatItem - Notes
            |- Track(SoundItem) - ScoreItem - BeatItem - Notes
```

## Medly

=> Medly : Rhythm

```
This App is based on Tracks.
    ​Each Track has Treble, Middle, Bass.
    ​Each Track has at least 5 'Columns'.
    ​Each 'Column' has 1,2,4 Bars.
    ​Each Bar has 4 Beats.
    ​Each Beat has 4 or 8 Notes.

    Each Track could :
        - Attach an instrument or a sound
        - Mute itself
        - Change its volume
```

## Bangers

=> Bangers : Mix

```
This App is based on Beats.
    4 Beats as an 'Unit'.
    4 Tracks and at most 10 one-shot sounds.

    Each Beat could :
        - Attach an instrument or a sound
        - Loop itself
        - Stop after it finishes all the beats
```

## Hook

=> Hook : Super Mix

```
This App is based on Sounds and Beats.
    Each of 36 cells could attach a sound.

    Filters, Effects.
    Record from MIC as a sound.
```
