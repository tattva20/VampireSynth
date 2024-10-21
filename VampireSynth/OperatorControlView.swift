//
//  OperatorControlView.swift
//  VampireSynth
//
//  Created by Octavio Rojas on 10/21/24.
//

import SwiftUI

struct OperatorControlView: View {
    let title: String
    @Binding var modulatingFrequency: Float
    @Binding var modulatingMultiplier: Float
    @Binding var modulationIndex: Float
    @Binding var amplitude: Float

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.top)
                .padding(.bottom)
            
            Text("Mod. Frequency: \(Int(modulatingFrequency)) Hz")
                .foregroundColor(.white)
            Slider(value: $modulatingFrequency, in: 20...2000)
            Text("Mod. Multiplier: \(String(format: "%.2f", modulatingMultiplier))")
                .foregroundColor(.white)
            Slider(value: $modulatingMultiplier, in: 0.1...10)
            Text("Mod. Index: \(Int(modulationIndex))")
                .foregroundColor(.white)
            Slider(value: $modulationIndex, in: 0...100)
            Text("Amp: \(String(format: "%.2f", amplitude))")
                .foregroundColor(.white)
            Slider(value: $amplitude, in: 0...1)
        }
    }
}

