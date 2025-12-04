import Foundation

public protocol OscillatorProtocol: AnyObject {
    var isStarted: Bool { get }
    func start()
    func stop()
}

public protocol FMOscillatorProtocol: OscillatorProtocol {
    var baseFrequency: Float { get set }
    var carrierMultiplier: Float { get set }
    var modulatingMultiplier: Float { get set }
    var modulationIndex: Float { get set }
    var amplitude: Float { get set }
}
