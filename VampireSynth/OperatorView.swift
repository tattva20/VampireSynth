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
                    let a = 0
                    let b = 1
                    OperatorControlView(
                        title: "Operator A",
                        modulatingFrequency: $conductor.operators[a].modulatingFrequency,
                        modulatingMultiplier: $conductor.operators[a].modulatingMultiplier,
                        modulationIndex: $conductor.operators[a].modulationIndex,
                        amplitude: $conductor.operators[a].amplitude
                    )
                    OperatorControlView(
                        title: "Operator B",
                        modulatingFrequency: $conductor.operators[b].modulatingFrequency,
                        modulatingMultiplier: $conductor.operators[b].modulatingMultiplier,
                        modulationIndex: $conductor.operators[b].modulationIndex,
                        amplitude: $conductor.operators[b].amplitude
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
                    let c = 2
                    let d = 3
                    OperatorControlView(
                        title: "Operator C",
                        modulatingFrequency: $conductor.operators[c].modulatingFrequency,
                        modulatingMultiplier: $conductor.operators[c].modulatingMultiplier,
                        modulationIndex: $conductor.operators[c].modulationIndex,
                        amplitude: $conductor.operators[c].amplitude
                    )
                    OperatorControlView(
                        title: "Operator D",
                        modulatingFrequency: $conductor.operators[d].modulatingFrequency,
                        modulatingMultiplier: $conductor.operators[d].modulatingMultiplier,
                        modulationIndex: $conductor.operators[d].modulationIndex,
                        amplitude: $conductor.operators[d].amplitude
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
