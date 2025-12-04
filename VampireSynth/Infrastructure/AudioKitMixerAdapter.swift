import AudioKit

public final class AudioKitMixerAdapter: MixerProtocol {
    public let mixer: Mixer

    public var volume: Float {
        get { Float(mixer.volume) }
        set { mixer.volume = AUValue(newValue) }
    }

    public init(mixer: Mixer) {
        self.mixer = mixer
    }
}
