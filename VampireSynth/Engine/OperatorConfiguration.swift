import Foundation

public struct OperatorConfiguration: Equatable {
    public let id: OperatorID
    public var baseFrequency: Float
    public var carrierMultiplier: Float
    public var modulatingMultiplier: Float
    public var modulationIndex: Float
    public var amplitude: Float

    public enum OperatorID: String, CaseIterable {
        case a, b, c, d
    }

    public init(
        id: OperatorID,
        baseFrequency: Float = 440.0,
        carrierMultiplier: Float = 1.0,
        modulatingMultiplier: Float = 1.0,
        modulationIndex: Float = 1.0,
        amplitude: Float = 0.5
    ) {
        self.id = id
        self.baseFrequency = baseFrequency
        self.carrierMultiplier = carrierMultiplier
        self.modulatingMultiplier = modulatingMultiplier
        self.modulationIndex = modulationIndex
        self.amplitude = amplitude
    }
}

public enum OperatorConfigurationRanges {
    public static let baseFrequency: ClosedRange<Float> = 20...2000
    public static let carrierMultiplier: ClosedRange<Float> = 0.1...10
    public static let modulatingMultiplier: ClosedRange<Float> = 0.1...10
    public static let modulationIndex: ClosedRange<Float> = 0...100
    public static let amplitude: ClosedRange<Float> = 0...1
}
