import Foundation
@testable import VampireSynth

final class AudioEngineSpy: AudioEngineProtocol {
    enum Message: Equatable {
        case start
        case stop
    }

    private(set) var messages: [Message] = []
    private(set) var isRunning: Bool = false

    var startError: Error?

    func start() throws {
        if let error = startError {
            throw error
        }
        isRunning = true
        messages.append(.start)
    }

    func stop() {
        isRunning = false
        messages.append(.stop)
    }
}
