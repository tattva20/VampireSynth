import Foundation

public protocol AudioEngineProtocol: AnyObject {
    var isRunning: Bool { get }
    func start() throws
    func stop()
}

public enum AudioEngineError: Error, Equatable {
    case failedToStart(String)
    case hardwareUnavailable
}
