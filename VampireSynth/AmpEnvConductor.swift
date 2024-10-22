//
//  AmpEnvConductor.swift
//  VampireSynth
//
//  Created by Octavio Rojas on 9/1/24.
//

import AudioKit
import AudioKitEX
import Foundation
import SoundpipeAudioKit
import Tonic

class AmpEnvConductor: ObservableObject, HasAudioEngine {
    let engine: AudioEngine
    let operatorConductor: OperatorConductor
    var envs: [AmplitudeEnvelope]
    var faders: [Fader]
    var currentNote = 0

    init(operatorConductor: OperatorConductor, engine: AudioEngine = AudioEngine()) {
        self.operatorConductor = operatorConductor
        self.envs = operatorConductor.operators.map { AmplitudeEnvelope($0.fmOscillator) }
        self.faders = envs.map { Fader($0) }
        self.engine = engine

        operatorConductor.operators.forEach { $0.amplitude = 1 }
        engine.output = Mixer(faders)

        do {
            try engine.start()
        } catch {
            Log("AudioKit did not start! Error: \(error)")
        }
    }

    func noteOn(pitch: Pitch, point _: CGPoint) {
        let adjustedMidiNoteNumber = pitch.midiNoteNumber + (12 * operatorConductor.octaveShift)
        if adjustedMidiNoteNumber != currentNote {
            envs.forEach { $0.closeGate() }
        }
        operatorConductor.setFrequency(for: adjustedMidiNoteNumber)
        envs.forEach { $0.openGate() }
        operatorConductor.play()
    }

    func noteOff(pitch _: Pitch) {
        envs.forEach { $0.closeGate() }
    }
}
