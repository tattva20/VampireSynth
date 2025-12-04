import AudioKit

public final class AudioKitEngineAdapter: AudioEngineProtocol {
    private let engine: AudioEngine

    public var isRunning: Bool {
        engine.avEngine.isRunning
    }

    public init(engine: AudioEngine) {
        self.engine = engine
    }

    public func start() throws {
        do {
            try engine.start()
        } catch {
            throw AudioEngineError.failedToStart(error.localizedDescription)
        }
    }

    public func stop() {
        engine.stop()
    }
}
