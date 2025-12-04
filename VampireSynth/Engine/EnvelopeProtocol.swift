import Foundation

public protocol EnvelopeProtocol: AnyObject {
    var attackDuration: Float { get set }
    var decayDuration: Float { get set }
    var sustainLevel: Float { get set }
    var releaseDuration: Float { get set }

    func openGate()
    func closeGate()
}
