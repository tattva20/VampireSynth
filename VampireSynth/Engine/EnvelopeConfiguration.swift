import Foundation

public struct EnvelopeConfiguration: Equatable {
    public let operatorID: OperatorConfiguration.OperatorID
    public var attack: Float
    public var decay: Float
    public var sustain: Float
    public var release: Float

    public init(
        operatorID: OperatorConfiguration.OperatorID,
        attack: Float = 0.01,
        decay: Float = 0.1,
        sustain: Float = 0.8,
        release: Float = 0.3
    ) {
        self.operatorID = operatorID
        self.attack = attack
        self.decay = decay
        self.sustain = sustain
        self.release = release
    }
}

public enum EnvelopeConfigurationRanges {
    public static let attack: ClosedRange<Float> = 0.001...2.0
    public static let decay: ClosedRange<Float> = 0.001...2.0
    public static let sustain: ClosedRange<Float> = 0...1
    public static let release: ClosedRange<Float> = 0.001...3.0
}
