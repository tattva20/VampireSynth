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

    // Custom bindings for operator properties
    private func synthOperator(_ index: Int) -> (Binding<Float>, Binding<Float>, Binding<Float>, Binding<Float>) {
        (
            $conductor.operators[index].modulatingFrequency,
            $conductor.operators[index].modulatingMultiplier,
            $conductor.operators[index].modulationIndex,
            $conductor.operators[index].amplitude
        )
    }
    
    var body: some View {
        VStack {
            // Operator A and B section with collapse functionality
            DisclosureGroup(isExpanded: $isRowABCollapsed) {
                HStack {
                    let (modFreqA, modMultA, modIndexA, ampA) = synthOperator(a)
                    let (modFreqB, modMultB, modIndexB, ampB) = synthOperator(b)
                    OperatorControlView(
                        title: "Operator A",
                        modulatingFrequency: modFreqA,
                        modulatingMultiplier: modMultA,
                        modulationIndex: modIndexA,
                        amplitude: ampA
                    )
                    OperatorControlView(
                        title: "Operator B",
                        modulatingFrequency: modFreqB,
                        modulatingMultiplier: modMultB,
                        modulationIndex: modIndexB,
                        amplitude: ampB
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
                    let (modFreqC, modMultC, modIndexC, ampC) = synthOperator(c)
                    let (modFreqD, modMultD, modIndexD, ampD) = synthOperator(d)
                    OperatorControlView(
                        title: "Operator C",
                        modulatingFrequency: modFreqC,
                        modulatingMultiplier: modMultC,
                        modulationIndex: modIndexC,
                        amplitude: ampC
                    )
                    OperatorControlView(
                        title: "Operator D",
                        modulatingFrequency: modFreqD,
                        modulatingMultiplier: modMultD,
                        modulationIndex: modIndexD,
                        amplitude: ampD
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
