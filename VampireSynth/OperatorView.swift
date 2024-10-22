//
//  OperatorView.swift
//  VampireSynth
//
//  Created by Octavio Rojas on 9/1/24.
//

import SwiftUI

struct OperatorView: View {
    @ObservedObject var conductor: OperatorConductor
    
    @Binding var frequency: Float
    @Binding var modulationIndex: Float
    @Binding var carrierMultiplier: Float
    @Binding var modulatingMultiplier: Float
    @Binding var volume: Float
    
    @State private var isRowABCollapsed = false
    @State private var isRowCDCollapsed = false
    
    var body: some View {
        VStack {
            // Operator A and B section with collapse functionality
            DisclosureGroup(isExpanded: $isRowABCollapsed) {
                HStack {
                    let paramsA = parametersFor(Operator.a)
                    let paramsB = parametersFor(Operator.b)
                    OperatorControlView(
                        title: "Operator A",
                        modulatingFrequency: paramsA.modulatingFrequency,
                        modulatingMultiplier: paramsA.modulatingMultiplier,
                        modulationIndex: paramsA.modulationIndex,
                        amplitude: paramsA.amplitude
                    )
                    OperatorControlView(
                        title: "Operator B",
                        modulatingFrequency: paramsB.modulatingFrequency,
                        modulatingMultiplier: paramsB.modulatingMultiplier,
                        modulationIndex: paramsB.modulationIndex,
                        amplitude: paramsB.amplitude
                    )
                }
            } label: {
                HStack {
                    Text("Operators A & B")
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.up")
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(isRowABCollapsed ? 0 : 180))
                }
                .padding()
                .background(Color.gray.opacity(0.2))
            }
            .padding(.bottom)
            
            // Operator C and D section with collapse functionality
            DisclosureGroup(isExpanded: $isRowCDCollapsed) {
                HStack {
                    let paramsC = parametersFor(Operator.c)
                    let paramsD = parametersFor(Operator.d)
                    OperatorControlView(
                        title: "Operator C",
                        modulatingFrequency: paramsC.modulatingFrequency,
                        modulatingMultiplier: paramsC.modulatingMultiplier,
                        modulationIndex: paramsC.modulationIndex,
                        amplitude: paramsC.amplitude
                    )
                    OperatorControlView(
                        title: "Operator D",
                        modulatingFrequency: paramsD.modulatingFrequency,
                        modulatingMultiplier: paramsD.modulatingMultiplier,
                        modulationIndex: paramsD.modulationIndex,
                        amplitude: paramsD.amplitude
                    )
                }
            } label: {
                HStack {
                    Text("Operators C & D")
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.up")
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(isRowCDCollapsed ? 0 : 180))
                }
                .padding()
                .background(Color.gray.opacity(0.2))
            }
        }
        .background(Color.black)
        .padding()
        
        Text("Octave Shift: \(conductor.octaveShift)")
            .foregroundColor(.white)
        Stepper(value: $conductor.octaveShift, in: -2...3) {}
        .accessibilityLabel("Octave Shift")
    }
    
    // MARK: - Helpers
    
    private func parametersFor(_ index: Int) -> OperatorParameters {
        OperatorParameters(
            modulatingFrequency: $conductor.operators[index].modulatingFrequency,
            modulatingMultiplier: $conductor.operators[index].modulatingMultiplier,
            modulationIndex: $conductor.operators[index].modulationIndex,
            amplitude: $conductor.operators[index].amplitude
        )
    }
}

#Preview {
    let operatorConductor = OperatorConductor()
    return OperatorView(
        conductor: operatorConductor,
        frequency: .constant(440.0),
        modulationIndex: .constant(1.0),
        carrierMultiplier: .constant(1.0),
        modulatingMultiplier: .constant(1.0),
        volume: .constant(1.0)
    )
}
