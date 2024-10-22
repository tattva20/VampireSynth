//
//  AmplitudeEnvelopeView.swift
//  VampireSynth
//
//  Created by Octavio Rojas on 9/1/24.
//

import SwiftUI
import SoundpipeAudioKit

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
                    ADSRWidgetView(title: "Amplitude Envelope A", envelope: envelopeFor(Operator.a))
                    ADSRWidgetView(title: "Amplitude Envelope B", envelope: envelopeFor(Operator.b))
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
                    ADSRWidgetView(title: "Amplitude Envelope C", envelope: envelopeFor(Operator.c))
                    ADSRWidgetView(title: "Amplitude Envelope D", envelope: envelopeFor(Operator.d))
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
        .accessibilityElement(children: .contain)
    }
    
    // MARK: - Helpers

    private func envelopeFor(_ index: Int) -> Binding<AmplitudeEnvelope> {
        return $conductor.envelopes[index]
    }
}

#Preview {
    let operatorConductor = OperatorConductor()
    let amplitudeEnvelopeConductor = AmplitudeEnvelopeConductor(operatorConductor: operatorConductor)
    return AmplitudeEnvelopeView(conductor: amplitudeEnvelopeConductor)
}
