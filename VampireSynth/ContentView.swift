import AudioKit
import AudioKitEX
import AudioKitUI
import Combine
import SoundpipeAudioKit
import SwiftUI

struct ContentView: View {
    @State private var frequency: Float = 440.0
    @State private var modulationIndex: Float = 1.0
    @State private var carrierMultiplier: Float = 1.0
    @State private var modulatingMultiplier: Float = 1.0
    @State private var volume: Float = 0.0
    
    
    var body: some View {
        VStack {
            Text("The Vampire")
                .font(.largeTitle)
                .foregroundColor(Color(red: 1.0, green: 0.1, blue: 0.1, opacity: 1.0))
            let operatorConductor = OperatorConductor()
            OperatorView(conductor: operatorConductor, frequency: $frequency, modulationIndex: $modulationIndex, carrierMultiplier: $carrierMultiplier, modulatingMultiplier: $modulatingMultiplier, volume: $volume)
            let amplitudeEnvelopeConductor = AmplitudeEnvelopeConductor(operatorConductor: operatorConductor)
            AmplitudeEnvelopeView(conductor: amplitudeEnvelopeConductor)
            MIDIKitKeyboard(noteOn: { pitch, point in
                amplitudeEnvelopeConductor.noteOn(pitch: pitch, point: point)
            }, noteOff: { pitch in
                amplitudeEnvelopeConductor.noteOff(pitch: pitch)
            })
        }
        .background(Color.black)
    }
}

#Preview {
    ContentView()
}
