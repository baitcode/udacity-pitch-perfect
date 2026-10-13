# Pitch Perfect

Voice changer for iOS, built in March 2015 as the first project of the Udacity
iOS course.

## What it does

- Record audio from the microphone, with pause and resume.
- Play the recording back slow, fast, as a chipmunk (high pitch), as Darth Vader (low pitch), or with reverb.

Playback uses `AVAudioEngine` with `AVAudioUnitTimePitch` and `AVAudioUnitReverb`.

## Build

Open `Pitch Perfect.xcodeproj` in Xcode. There are no third-party dependencies.

## Status

Written in Swift 1.x, so it will not compile with a current Xcode without
migration.
