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
                            conductor.envelopeA.attackDuration = att
                            conductor.envelopeA.decayDuration = dec
                            conductor.envelopeA.sustainLevel = sus
                            conductor.envelopeA.releaseDuration = rel
                        }
                    }
                    
                    VStack {
                        Text("Amplitude Envelope B")
                            .font(.title)
                            .foregroundColor(.white)
                        ADSRWidget { att, dec, sus, rel in
                            conductor.envelopeB.attackDuration = att
                            conductor.envelopeB.decayDuration = dec
                            conductor.envelopeB.sustainLevel = sus
                            conductor.envelopeB.releaseDuration = rel
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
                            conductor.envelopeC.attackDuration = att
                            conductor.envelopeC.decayDuration = dec
                            conductor.envelopeC.sustainLevel = sus
                            conductor.envelopeC.releaseDuration = rel
                        }
                    }
                    
                    VStack {
                        Text("Amplitude Envelope D")
                            .font(.title)
                            .foregroundColor(.white)
                        ADSRWidget { att, dec, sus, rel in
                            conductor.envelopeD.attackDuration = att
                            conductor.envelopeD.decayDuration = dec
                            conductor.envelopeD.sustainLevel = sus
                            conductor.envelopeD.releaseDuration = rel
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
