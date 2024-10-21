//
//  OperatorConductor.swift
//  VampireSynth
//
//  Created by Octavio Rojas on 9/1/24.
//

import AudioKit
import SoundpipeAudioKit
import SwiftUI
import Tonic

class OperatorConductor: ObservableObject {
    
    class FMOscillatorWrapper {
        var fmOscillator: FMOscillator
        @Published var carrierFrequency: AUValue = 440 {
            didSet { fmOscillator.baseFrequency = carrierFrequency }
        }
        @Published var modulatingMultiplier: AUValue = 1.0 {
            didSet { fmOscillator.modulatingMultiplier = modulatingMultiplier }
        }
        @Published var modulationIndex: AUValue = 1.0 {
            didSet { fmOscillator.modulationIndex = modulationIndex }
        }
        @Published var modulatingFrequency: AUValue = 440 {
            didSet { fmOscillator.modulatingMultiplier = modulatingFrequency / carrierFrequency }
        }
        @Published var amplitude: AUValue = 0.5 {
            didSet { fmOscillator.amplitude = amplitude }
        }
        
        init() {
            fmOscillator = FMOscillator()
        }
        
        func start() {
            fmOscillator.start()
        }
        
        func stop() {
            fmOscillator.stop()
        }
    }

    @Published var octaveShift: Int8 = 0
    var operators: [FMOscillatorWrapper]

    init() {
        operators = (0..<4).map { _ in FMOscillatorWrapper() }
    }

    func setFrequency(for midiNoteNumber: Int8) {
        let frequency = AUValue(midiNoteNumber).midiNoteToFrequency()
        operators.forEach { $0.carrierFrequency = frequency }
    }

    func play() {
        operators.forEach { $0.start() }
    }

    func stop() {
        operators.forEach { $0.stop() }
    }
}
