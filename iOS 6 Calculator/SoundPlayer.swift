//
// iOS 6 Calculator
// SoundPlayer.swift
//
// Created on 29/5/25
//
// Copyright ©2025 DoorHinge Apps.
//

import SwiftUI
import AudioToolbox


class SoundEffectPlayer {
    static let shared = SoundEffectPlayer()
    private var soundID: SystemSoundID = 0

    private init() {
        if let url = Bundle.main.url(forResource: "click", withExtension: "m4a") {
            AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        }
    }

    func play() {
        AudioServicesPlaySystemSound(soundID)
    }
}
