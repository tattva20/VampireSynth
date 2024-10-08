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
    
    var envelopeA: AmplitudeEnvelope
    var envelopeB: AmplitudeEnvelope
    var envelopeC: AmplitudeEnvelope
    var envelopeD: AmplitudeEnvelope
    
    var faderA: Fader
    var faderB: Fader
    var faderC: Fader
    var faderD: Fader
    
    var currentNote = 0
    
    init(operatorConductor: OperatorConductor) {
        self.operatorConductor = operatorConductor
        
        envelopeA = AmplitudeEnvelope(operatorConductor.operatorA)
        envelopeB = AmplitudeEnvelope(operatorConductor.operatorB)
        envelopeC = AmplitudeEnvelope(operatorConductor.operatorC)
        envelopeD = AmplitudeEnvelope(operatorConductor.operatorD)
        
        faderA = Fader(envelopeA)
        faderB = Fader(envelopeB)
        faderC = Fader(envelopeC)
        faderD = Fader(envelopeD)
        
        operatorConductor.operatorA.amplitude = 1
        operatorConductor.operatorB.amplitude = 1
        operatorConductor.operatorC.amplitude = 1
        operatorConductor.operatorD.amplitude = 1
        engine.output = Mixer(faderA, faderB, faderC, faderD)
        
        do {
            try engine.start()
        } catch {
            Log("AudioKit did not start!")
        }
    }
    
    func noteOn(pitch: Pitch, point _: CGPoint) {
        let adjustedMidiNoteNumber = pitch.midiNoteNumber + (12 * operatorConductor.octaveShift)
        if adjustedMidiNoteNumber != currentNote {
            envelopeA.closeGate()
            envelopeB.closeGate()
            envelopeC.closeGate()
                    envelopeD.closeGate()
        }
        operatorConductor.setFrequency(for: adjustedMidiNoteNumber)
        envelopeA.openGate()
        envelopeB.openGate()
        envelopeC.openGate()
        envelopeD.openGate()
        operatorConductor.play()
    }

    func noteOff(pitch _: Pitch) {
        envelopeA.closeGate()
        envelopeB.closeGate()
        envelopeC.closeGate()
        envelopeD.closeGate()
    }
}
