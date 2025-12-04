import AudioKit
import SoundpipeAudioKit

public final class AudioKitFMOscillatorAdapter: FMOscillatorProtocol {
    public let oscillator: FMOscillator

    public var isStarted: Bool {
        oscillator.isStarted
    }

    public var baseFrequency: Float {
        get { Float(oscillator.baseFrequency) }
        set { oscillator.baseFrequency = AUValue(newValue) }
    }

    public var carrierMultiplier: Float {
        get { Float(oscillator.carrierMultiplier) }
        set { oscillator.carrierMultiplier = AUValue(newValue) }
    }

    public var modulatingMultiplier: Float {
        get { Float(oscillator.modulatingMultiplier) }
        set { oscillator.modulatingMultiplier = AUValue(newValue) }
    }

    public var modulationIndex: Float {
        get { Float(oscillator.modulationIndex) }
        set { oscillator.modulationIndex = AUValue(newValue) }
    }

    public var amplitude: Float {
        get { Float(oscillator.amplitude) }
        set { oscillator.amplitude = AUValue(newValue) }
    }

    public init(oscillator: FMOscillator = FMOscillator()) {
        self.oscillator = oscillator
    }

    public func start() {
        oscillator.start()
    }

    public func stop() {
        oscillator.stop()
    }
}
