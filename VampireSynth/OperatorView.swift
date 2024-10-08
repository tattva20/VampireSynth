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
                        
                        Text("Mod. Frequency: \(Int(conductor.modulatingFrequencyA)) Hz")
                            .foregroundColor(.white)
                        Slider(value: $conductor.modulatingFrequencyA, in: 20...2000)
                        Text("Mod. Multiplier: \(String(format: "%.2f", conductor.modulatingMultiplierA))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.modulatingMultiplierA, in: 0.1...10)
                        Text("Mod. Index: \(Int(conductor.modulationIndexA))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.modulationIndexA, in: 0...100)
                        Text("Amp: \(String(format: "%.2f", conductor.amplitudeA))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.amplitudeA, in: 0...1)
                    }
                    VStack {
                        Text("Operator B")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.top)
                            .padding(.bottom)
                        
                        Text("Mod.Frequency: \(Int(conductor.modulatingFrequencyB)) Hz")
                            .foregroundColor(.white)
                        Slider(value: $conductor.modulatingFrequencyB, in: 20...2000)
                        
                        Text("Mod. Multiplier: \(String(format: "%.2f", conductor.modulatingMultiplierB))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.modulatingMultiplierB, in: 0.1...10)
                        
                        Text("Mod. Index: \(Int(conductor.modulationIndexB))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.modulationIndexB, in: 0...100)
                        
                        Text("Amp: \(String(format: "%.2f", conductor.amplitudeB))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.amplitudeB, in: 0...1)
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
                        
                        Text("Mod. Frequency: \(Int(conductor.modulatingFrequencyC)) Hz")
                            .foregroundColor(.white)
                        Slider(value: $conductor.modulatingFrequencyC, in: 20...2000)
                        Text("Mod. Multiplier: \(String(format: "%.2f", conductor.modulatingMultiplierC))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.modulatingMultiplierC, in: 0.1...10)
                        Text("Mod. Index: \(Int(conductor.modulationIndexC))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.modulationIndexC, in: 0...100)
                        Text("Amp: \(String(format: "%.2f", conductor.amplitudeC))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.amplitudeC, in: 0...1)
                    }
                    VStack {
                        Text("Operator D")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.top)
                            .padding(.bottom)
                        
                        Text("Mod.Frequency: \(Int(conductor.modulatingFrequencyD)) Hz")
                            .foregroundColor(.white)
                        Slider(value: $conductor.modulatingFrequencyD, in: 20...2000)
                        
                        Text("Mod. Multiplier: \(String(format: "%.2f", conductor.modulatingMultiplierD))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.modulatingMultiplierD, in: 0.1...10)
                        
                        Text("Mod. Index: \(Int(conductor.modulationIndexD))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.modulationIndexD, in: 0...100)
                        
                        Text("Amp: \(String(format: "%.2f", conductor.amplitudeD))")
                            .foregroundColor(.white)
                        Slider(value: $conductor.amplitudeD, in: 0...1)
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
