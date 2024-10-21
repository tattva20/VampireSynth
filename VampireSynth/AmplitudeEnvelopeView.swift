//
//  AmplitudeEnvelopeView.swift
//  VampireSynth
//
//  Created by Octavio Rojas on 9/1/24.
//

import SwiftUI
import AudioKitUI


struct AmplitudeEnvelopeView: View {
    @ObservedObject var conductor: AmplitudeEnvelopeConductor
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isEnvelopeABCollapsed = false
    @State private var isEnvelopeCDCollapsed = false
    
    var body: some View {
        VStack {
            // Envelope A and B section with collapse functionality
            DisclosureGroup(isExpanded: $isEnvelopeABCollapsed) {
                HStack {
                    VStack {
                        Text("Amplitude Envelope A")
                            .font(.title)
                            .foregroundColor(.white)
                        ADSRWidget { att, dec, sus, rel in
                            
                            let a = 0
                            let envelopeA = conductor.envelopes[a]
                            
                            envelopeA.attackDuration = att
                            envelopeA.decayDuration = dec
                            envelopeA.sustainLevel = sus
                            envelopeA.releaseDuration = rel
                        }
                    }
                    
                    VStack {
                        Text("Amplitude Envelope B")
                            .font(.title)
                            .foregroundColor(.white)
                        ADSRWidget { att, dec, sus, rel in
                            
                            let b = 1
                            let envelopeB = conductor.envelopes[b]
                            
                            envelopeB.attackDuration = att
                            envelopeB.decayDuration = dec
                            envelopeB.sustainLevel = sus
                            envelopeB.releaseDuration = rel
                        }
                    }
                }
            } label: {
                HStack {
                    Text("Envelopes A & B")
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.up")
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(isEnvelopeABCollapsed ? 0 : 180))
                }
                .padding()
                .background(Color.gray.opacity(0.2))
            }
            .padding(.bottom)
            
            // Envelope C and D section with collapse functionality
            DisclosureGroup(isExpanded: $isEnvelopeCDCollapsed) {
                HStack {
                    VStack {
                        Text("Amplitude Envelope C")
                            .font(.title)
                            .foregroundColor(.white)
                        ADSRWidget { att, dec, sus, rel in
                            
                            let c = 2
                            let envelopeC = conductor.envelopes[c]
                            
                            envelopeC.attackDuration = att
                            envelopeC.decayDuration = dec
                            envelopeC.sustainLevel = sus
                            envelopeC.releaseDuration = rel
                        }
                    }
                    
                    VStack {
                        Text("Amplitude Envelope D")
                            .font(.title)
                            .foregroundColor(.white)
                        ADSRWidget { att, dec, sus, rel in
                            
                            let d = 3
                            let envelopeD = conductor.envelopes[d]
                            
                            envelopeD.attackDuration = att
                            envelopeD.decayDuration = dec
                            envelopeD.sustainLevel = sus
                            envelopeD.releaseDuration = rel
                        }
                    }
                }
            } label: {
                HStack {
                    Text("Envelopes C & D")
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.up")
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(isEnvelopeCDCollapsed ? 0 : 180))
                }
                .padding()
                .background(Color.gray.opacity(0.2))
            }
        }
        .padding()
        .background(Color.clear)
    }
}

#Preview {
    let operatorConductor = OperatorConductor()
    let amplitudeEnvelopeConductor = AmplitudeEnvelopeConductor(operatorConductor: operatorConductor)
    return AmplitudeEnvelopeView(conductor: amplitudeEnvelopeConductor)
}
