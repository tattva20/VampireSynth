//
//  OperatorView.swift
//  VampireSynth
//
//  Created by Octavio Rojas on 9/1/24.
//

import SwiftUI
import AudioKit

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
                    VStack {
                        Text("Operator A")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.top)
                            .padding(.bottom)
                        
                        let a = 0
                        
                        Text("Mod. Frequency: \(Int(conductor.operators[a].modulatingFrequency)) Hz")
                            .foregroundColor(.white)
                        Slider(value: $conductor.operators[a].modulatingFrequency, in: 20...2000)
                        Text("Mod. Multiplier: \(String(format: "%.2f", conductor.operators[0].modulatingMultiplier))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.operators[a].modulatingMultiplier, in: 0.1...10)
                        Text("Mod. Index: \(Int(conductor.operators[a].modulationIndex))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.operators[a].modulationIndex, in: 0...100)
                        Text("Amp: \(String(format: "%.2f", conductor.operators[a].amplitude))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.operators[a].amplitude, in: 0...1)
                    }
                    VStack {
                        Text("Operator B")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.top)
                            .padding(.bottom)
                        
                        let b = 1
                        
                        Text("Mod.Frequency: \(Int(conductor.operators[b].modulatingFrequency))) Hz")
                            .foregroundColor(.white)
                        Slider(value: $conductor.operators[b].modulatingFrequency, in: 20...2000)
                        Text("Mod. Multiplier: \(String(format: "%.2f", conductor.operators[1].modulatingMultiplier))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.operators[b].modulatingMultiplier, in: 0.1...10)
                        Text("Mod. Index: \(Int(conductor.operators[b].modulationIndex))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.operators[b].modulationIndex, in: 0...100)
                        Text("Amp: \(String(format: "%.2f", conductor.operators[b].modulationIndex))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.operators[b].amplitude, in: 0...1)
                    }
                }
            } label: {
                HStack {
                    Text("Operators A & B")
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
            .padding(.bottom)
            
            // Operator C and D section with collapse functionality
            DisclosureGroup(isExpanded: $isRowCDCollapsed) {
                HStack {
                    VStack {
                        Text("Operator C")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.top)
                            .padding(.bottom)
                        
                        let c = 2
                        
                        Text("Mod.Frequency: \(Int(conductor.operators[c].modulatingFrequency))) Hz")
                            .foregroundColor(.white)
                        Slider(value: $conductor.operators[c].modulatingFrequency, in: 20...2000)
                        Text("Mod. Multiplier: \(String(format: "%.2f", conductor.operators[1].modulatingMultiplier))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.operators[c].modulatingMultiplier, in: 0.1...10)
                        Text("Mod. Index: \(Int(conductor.operators[c].modulationIndex))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.operators[c].modulationIndex, in: 0...100)
                        Text("Amp: \(String(format: "%.2f", conductor.operators[c].modulationIndex))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.operators[c].amplitude, in: 0...1)
                    }
                    VStack {
                        Text("Operator D")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.top)
                            .padding(.bottom)
                        
                        let d = 3
                        
                        Text("Mod.Frequency: \(Int(conductor.operators[d].modulatingFrequency))) Hz")
                            .foregroundColor(.white)
                        Slider(value: $conductor.operators[d].modulatingFrequency, in: 20...2000)
                        Text("Mod. Multiplier: \(String(format: "%.2f", conductor.operators[1].modulatingMultiplier))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.operators[d].modulatingMultiplier, in: 0.1...10)
                        Text("Mod. Index: \(Int(conductor.operators[d].modulationIndex))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.operators[d].modulationIndex, in: 0...100)
                        Text("Amp: \(String(format: "%.2f", conductor.operators[d].modulationIndex))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.operators[d].amplitude, in: 0...1)
                    }
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
    return OperatorView(conductor: operatorConductor, frequency: .constant(440.0), modulationIndex: .constant(1.0), carrierMultiplier: .constant(1.0), modulatingMultiplier: .constant(1.0), volume: .constant(1.0))
}
