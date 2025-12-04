import Foundation
@testable import VampireSynth

final class MixerSpy: MixerProtocol {
    enum Message: Equatable {
        case setVolume(Float)
    }

    private(set) var messages: [Message] = []

    var volume: Float = 0.5 {
        didSet { messages.append(.setVolume(volume)) }
    }
}
