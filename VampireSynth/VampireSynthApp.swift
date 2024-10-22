//
//  VampireSynthApp.swift
//  VampireSynth
//
//  Created by Octavio Rojas on 8/29/24.
//

import AudioKit
import AVFoundation
import SwiftUI

@main
struct VampireSynthApp: App {
    
    private let session = AVAudioSession.sharedInstance()
    
    init() {
        #if os(iOS)
            do {
                Settings.bufferLength = .short
                try session.setPreferredIOBufferDuration(Settings.bufferLength.duration)
                try session.setCategory(
                    .playAndRecord,
                    options:
                        [.defaultToSpeaker,
                         .mixWithOthers,
                         .allowBluetoothA2DP])
                try session.setActive(true)
            } catch let err {
                print(err)
            }
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
