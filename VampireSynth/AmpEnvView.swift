//
//  AmplitudeEnvelopeView.swift
//  VampireSynth
//
//  Created by Octavio Rojas on 9/1/24.
//

import SwiftUI
import SoundpipeAudioKit

struct AmpEnvView: View {
    @ObservedObject var conductor: AmpEnvConductor
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isEnvGroupABCollapsed = false
    @State private var isEnvGroupCDCollapsed = false

    var body: some View {
        VStack {
            // Envelope A and B section with collapse functionality
            DisclosureGroup(isExpanded: $isEnvGroupABCollapsed) {
                HStack {
                    ADSRWidgetView(
                        title: "Amp Env A",
                        env: envFor(Operator.a))
                    ADSRWidgetView(
                        title: "Amp Env B",
                        env: envFor(Operator.b))
                }
            } label: {
                HStack {
                    Text("Envelopes A & B")
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.up")
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(isEnvGroupABCollapsed ? 0 : 180))
                }
                .padding()
                .background(Color.gray.opacity(0.2))
            }
            .padding(.bottom)
            
            // Envelope C and D section with collapse functionality
            DisclosureGroup(isExpanded: $isEnvGroupCDCollapsed) {
                HStack {
                    ADSRWidgetView(
                        title: "Amp Env C",
                        env: envFor(Operator.c))
                    ADSRWidgetView(
                        title: "Amp Env D",
                        env: envFor(Operator.d))
                }
            } label: {
                HStack {
                    Text("Envelopes C & D")
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.up")
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(isEnvGroupCDCollapsed ? 0 : 180))
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

    private func envFor(_ index: Int) -> Binding<AmplitudeEnvelope> {
        return $conductor.envs[index]
    }
}

#Preview {
    let operatorConductor = OperatorConductor()
    let amplitudeEnvelopeConductor = AmpEnvConductor(operatorConductor: operatorConductor)
    return AmpEnvView(conductor: amplitudeEnvelopeConductor)
}
