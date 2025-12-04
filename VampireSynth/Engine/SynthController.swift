import Foundation

public final class SynthController {
    private let engine: AudioEngineProtocol
    private let oscillators: [FMOscillatorProtocol]
    private let envelopes: [EnvelopeProtocol]
    private let mixer: MixerProtocol

    private let operatorIDs = OperatorConfiguration.OperatorID.allCases

    public init(
        engine: AudioEngineProtocol,
        oscillators: [FMOscillatorProtocol],
        envelopes: [EnvelopeProtocol],
        mixer: MixerProtocol
    ) {
        self.engine = engine
        self.oscillators = oscillators
        self.envelopes = envelopes
        self.mixer = mixer
    }

    public func start() throws {
        try engine.start()
    }

    public func stop() {
        engine.stop()
    }

    public func noteOn(_ note: MIDINote) {
        let frequency = note.frequency

        for oscillator in oscillators {
            oscillator.baseFrequency = frequency
            oscillator.start()
        }

        for envelope in envelopes {
            envelope.openGate()
        }
    }

    public func noteOff() {
        for envelope in envelopes {
            envelope.closeGate()
        }

        for oscillator in oscillators {
            oscillator.stop()
        }
    }

    public func updateOperator(_ id: OperatorConfiguration.OperatorID, configuration: OperatorConfiguration) {
        guard let index = operatorIDs.firstIndex(of: id) else { return }
        let oscillator = oscillators[index]

        oscillator.baseFrequency = configuration.baseFrequency
        oscillator.carrierMultiplier = configuration.carrierMultiplier
        oscillator.modulatingMultiplier = configuration.modulatingMultiplier
        oscillator.modulationIndex = configuration.modulationIndex
        oscillator.amplitude = configuration.amplitude
    }

    public func updateEnvelope(_ id: OperatorConfiguration.OperatorID, configuration: EnvelopeConfiguration) {
        guard let index = operatorIDs.firstIndex(of: id) else { return }
        let envelope = envelopes[index]

        envelope.attackDuration = configuration.attack
        envelope.decayDuration = configuration.decay
        envelope.sustainLevel = configuration.sustain
        envelope.releaseDuration = configuration.release
    }

    public func setMasterVolume(_ volume: Float) {
        mixer.volume = volume
    }
}
