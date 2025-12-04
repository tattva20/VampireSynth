import XCTest
@testable import VampireSynth

final class EnvelopeConfigurationTests: XCTestCase {

    func test_init_setsDefaultValues() {
        let config = EnvelopeConfiguration(operatorID: .a)

        XCTAssertEqual(config.operatorID, .a)
        XCTAssertEqual(config.attack, 0.01)
        XCTAssertEqual(config.decay, 0.1)
        XCTAssertEqual(config.sustain, 0.8)
        XCTAssertEqual(config.release, 0.3)
    }

    func test_init_setsCustomValues() {
        let config = EnvelopeConfiguration(
            operatorID: .b,
            attack: 0.5,
            decay: 0.2,
            sustain: 0.7,
            release: 1.0
        )

        XCTAssertEqual(config.operatorID, .b)
        XCTAssertEqual(config.attack, 0.5)
        XCTAssertEqual(config.decay, 0.2)
        XCTAssertEqual(config.sustain, 0.7)
        XCTAssertEqual(config.release, 1.0)
    }

    func test_equality() {
        let config1 = EnvelopeConfiguration(operatorID: .a, attack: 0.5)
        let config2 = EnvelopeConfiguration(operatorID: .a, attack: 0.5)
        let config3 = EnvelopeConfiguration(operatorID: .a, attack: 1.0)

        XCTAssertEqual(config1, config2)
        XCTAssertNotEqual(config1, config3)
    }

    func test_ranges_areValid() {
        XCTAssertEqual(EnvelopeConfigurationRanges.attack, 0.001...2.0)
        XCTAssertEqual(EnvelopeConfigurationRanges.decay, 0.001...2.0)
        XCTAssertEqual(EnvelopeConfigurationRanges.sustain, 0...1)
        XCTAssertEqual(EnvelopeConfigurationRanges.release, 0.001...3.0)
    }
}
