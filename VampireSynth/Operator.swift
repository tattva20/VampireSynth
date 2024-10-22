//
//  Typealiases.swift
//  VampireSynth
//
//  Created by Octavio Rojas on 10/21/24.
//

import SwiftUI

struct Operator {
    static let a = 0
    static let b = 1
    static let c = 2
    static let d = 3
}

struct OperatorParameters {
    var modulatingFrequency: Binding<Float>
    var modulatingMultiplier: Binding<Float>
    var modulationIndex: Binding<Float>
    var amplitude: Binding<Float>
}
