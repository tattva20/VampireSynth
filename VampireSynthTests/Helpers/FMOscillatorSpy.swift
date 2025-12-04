import Foundation
@testable import VampireSynth

final class FMOscillatorSpy: FMOscillatorProtocol {
    enum Message: Equatable {
        case start
        case stop
        case setBaseFrequency(Float)
        case setCarrierMultiplier(Float)
        case setModulatingMultiplier(Float)
        case setModulationIndex(Float)
        case setAmplitude(Float)
    }

    private(set) var messages: [Message] = []
    private(set) var isStarted: Bool = false

    var baseFrequency: Float = 440 {
        didSet { messages.append(.setBaseFrequency(baseFrequency)) }
    }

    var carrierMultiplier: Float = 1.0 {
        didSet { messages.append(.setCarrierMultiplier(carrierMultiplier)) }
    }

    var modulatingMultiplier: Float = 1.0 {
        didSet { messages.append(.setModulatingMultiplier(modulatingMultiplier)) }
    }

    var modulationIndex: Float = 1.0 {
        didSet { messages.append(.setModulationIndex(modulationIndex)) }
    }

    var amplitude: Float = 0.5 {
        didSet { messages.append(.setAmplitude(amplitude)) }
    }

    func start() {
        isStarted = true
        messages.append(.start)
    }

    func stop() {
        isStarted = false
        messages.append(.stop)
    }

    func resetMessages() {
        messages.removeAll()
    }
}
