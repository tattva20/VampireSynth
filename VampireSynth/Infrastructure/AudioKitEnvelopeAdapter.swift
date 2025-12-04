import AudioKit
import SoundpipeAudioKit

public final class AudioKitEnvelopeAdapter: EnvelopeProtocol {
    public let envelope: AmplitudeEnvelope

    public var attackDuration: Float {
        get { Float(envelope.attackDuration) }
        set { envelope.attackDuration = AUValue(newValue) }
    }

    public var decayDuration: Float {
        get { Float(envelope.decayDuration) }
        set { envelope.decayDuration = AUValue(newValue) }
    }

    public var sustainLevel: Float {
        get { Float(envelope.sustainLevel) }
        set { envelope.sustainLevel = AUValue(newValue) }
    }

    public var releaseDuration: Float {
        get { Float(envelope.releaseDuration) }
        set { envelope.releaseDuration = AUValue(newValue) }
    }

    public init(envelope: AmplitudeEnvelope) {
        self.envelope = envelope
    }

    public func openGate() {
        envelope.openGate()
    }

    public func closeGate() {
        envelope.closeGate()
    }
}
