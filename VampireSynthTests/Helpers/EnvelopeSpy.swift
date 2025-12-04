import Foundation
@testable import VampireSynth

final class EnvelopeSpy: EnvelopeProtocol {
    enum Message: Equatable {
        case openGate
        case closeGate
        case setAttack(Float)
        case setDecay(Float)
        case setSustain(Float)
        case setRelease(Float)
    }

    private(set) var messages: [Message] = []

    var attackDuration: Float = 0.01 {
        didSet { messages.append(.setAttack(attackDuration)) }
    }

    var decayDuration: Float = 0.1 {
        didSet { messages.append(.setDecay(decayDuration)) }
    }

    var sustainLevel: Float = 0.8 {
        didSet { messages.append(.setSustain(sustainLevel)) }
    }

    var releaseDuration: Float = 0.3 {
        didSet { messages.append(.setRelease(releaseDuration)) }
    }

    func openGate() {
        messages.append(.openGate)
    }

    func closeGate() {
        messages.append(.closeGate)
    }

    func resetMessages() {
        messages.removeAll()
    }
}
