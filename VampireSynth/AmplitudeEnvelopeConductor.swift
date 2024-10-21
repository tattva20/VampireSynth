//
//  AmplitudeEnvelopeConductor.swift
//  VampireSynth
//
//  Created by Octavio Rojas on 9/1/24.
//

import AudioKit
import AudioKitEX
import SoundpipeAudioKit
import SwiftUI
import Tonic

class AmplitudeEnvelopeConductor: ObservableObject, HasAudioEngine {

    let engine = AudioEngine()
    let operatorConductor: OperatorConductor
    var envelopes: [AmplitudeEnvelope]
    var faders: [Fader]
    var currentNote = 0

    init(operatorConductor: OperatorConductor) {
        self.operatorConductor = operatorConductor
        self.envelopes = operatorConductor.operators.map { AmplitudeEnvelope($0.fmOscillator) }
        self.faders = envelopes.map { Fader($0) }

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
            envelopes.forEach { $0.closeGate() }
        }
        operatorConductor.setFrequency(for: adjustedMidiNoteNumber)
        envelopes.forEach { $0.openGate() }
        operatorConductor.play()
    }

    func noteOff(pitch _: Pitch) {
        envelopes.forEach { $0.closeGate() }
    }
}
