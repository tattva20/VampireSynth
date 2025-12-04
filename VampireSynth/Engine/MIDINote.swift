import Foundation

public struct MIDINote: Equatable {
    public let pitch: UInt8
    public let velocity: UInt8

    public init(pitch: UInt8, velocity: UInt8 = 127) {
        self.pitch = pitch
        self.velocity = velocity
    }

    public var frequency: Float {
        440.0 * pow(2.0, (Float(pitch) - 69.0) / 12.0)
    }
}
