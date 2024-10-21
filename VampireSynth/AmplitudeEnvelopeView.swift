//
//  AmplitudeEnvelopeView.swift
//  VampireSynth
//
//  Created by Octavio Rojas on 9/1/24.
//

import SwiftUI

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
                    let a = 0
                    let b = 1
                    ADSRWidgetView(title: "Amplitude Envelope A", envelope: $conductor.envelopes[a])
                    ADSRWidgetView(title: "Amplitude Envelope B", envelope: $conductor.envelopes[b])
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
                    let c = 2
                    let d = 3
                    ADSRWidgetView(title: "Amplitude Envelope C", envelope: $conductor.envelopes[c])
                    ADSRWidgetView(title: "Amplitude Envelope D", envelope: $conductor.envelopes[d])
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
