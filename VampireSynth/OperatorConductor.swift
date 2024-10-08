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

    var operatorA: FMOscillator
    var operatorB: FMOscillator
    var operatorC: FMOscillator
    var operatorD: FMOscillator
    
    @Published var octaveShift: Int8 = 0
    
    init() {
        operatorA = FMOscillator()
        operatorB = FMOscillator()
        operatorC = FMOscillator()
        operatorD = FMOscillator()
    }

    @Published var carrierFrequencyA: AUValue = 440 {
        didSet {
            operatorA.baseFrequency = carrierFrequencyA
        }
    }
    
    @Published var carrierFrequencyB: AUValue = 440 {
        didSet {
            operatorB.baseFrequency = carrierFrequencyB
        }
    }
    
    @Published var carrierFrequencyC: AUValue = 440 {
        didSet {
            operatorC.baseFrequency = carrierFrequencyC
        }
    }
    
    @Published var carrierFrequencyD: AUValue = 440 {
        didSet {
            operatorD.baseFrequency = carrierFrequencyD
        }
    }
    
    @Published var modulatingMultiplierA: AUValue = 1.0 {
        didSet {
            operatorA.modulatingMultiplier = modulatingMultiplierA
        }
    }
    
    @Published var modulatingMultiplierB: AUValue = 1.0 {
        didSet {
            operatorB.modulatingMultiplier = modulatingMultiplierB
        }
    }
    
    @Published var modulatingMultiplierC: AUValue = 1.0 {
        didSet {
            operatorC.modulatingMultiplier = modulatingMultiplierC
        }
    }
    
    @Published var modulatingMultiplierD: AUValue = 1.0 {
        didSet {
            operatorD.modulatingMultiplier = modulatingMultiplierD
        }
    }
    
    @Published var modulationIndexA: AUValue = 1.0 {
        didSet {
            operatorA.modulationIndex = modulationIndexA
        }
    }
    
    @Published var modulationIndexB: AUValue = 1.0 {
        didSet {
            operatorB.modulationIndex = modulationIndexB
        }
    }
    
    @Published var modulationIndexC: AUValue = 1.0 {
        didSet {
            operatorC.modulationIndex = modulationIndexC
        }
    }
    
    @Published var modulationIndexD: AUValue = 1.0 {
        didSet {
            operatorD.modulationIndex = modulationIndexD
        }
    }
    
    @Published var modulatingFrequencyA: AUValue = 440 {
        didSet {
            operatorA.modulatingMultiplier = modulatingFrequencyA / carrierFrequencyA
        }
    }
    
    @Published var modulatingFrequencyB: AUValue = 440 {
        didSet {
            operatorB.modulatingMultiplier = modulatingFrequencyB / carrierFrequencyB
        }
    }
    
    @Published var modulatingFrequencyC: AUValue = 440 {
          didSet {
              operatorC.modulatingMultiplier = modulatingFrequencyC / carrierFrequencyC
          }
      }
      
      @Published var modulatingFrequencyD: AUValue = 440 {
          didSet {
              operatorD.modulatingMultiplier = modulatingFrequencyD / carrierFrequencyD
          }
      }
    
    @Published var amplitudeA: AUValue = 0.5 {
        didSet {
            operatorA.amplitude = amplitudeA
        }
    }
    
    @Published var amplitudeB: AUValue = 0.5 {
        didSet {
            operatorB.amplitude = amplitudeB
        }
    }
    
    @Published var amplitudeC: AUValue = 0.5 {
        didSet {
            operatorC.amplitude = amplitudeC
        }
    }
    
    @Published var amplitudeD: AUValue = 0.5 {
        didSet {
            operatorD.amplitude = amplitudeD
        }
    }
    
    func setFrequency(for midiNoteNumber: Int8) {
        carrierFrequencyA = AUValue(midiNoteNumber).midiNoteToFrequency()
        carrierFrequencyB = AUValue(midiNoteNumber).midiNoteToFrequency()
        carrierFrequencyC = AUValue(midiNoteNumber).midiNoteToFrequency()
        carrierFrequencyD = AUValue(midiNoteNumber).midiNoteToFrequency()
    }

    func play() {
        operatorA.start()
        operatorB.start()
        operatorC.start()
        operatorD.start()
    }
    
    func stop() {
        operatorA.stop()
        operatorB.stop()
        operatorC.stop()
        operatorD.stop()
    }
}
