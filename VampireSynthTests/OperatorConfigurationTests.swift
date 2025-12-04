import XCTest
@testable import VampireSynth

final class OperatorConfigurationTests: XCTestCase {

    func test_init_setsDefaultValues() {
        let config = OperatorConfiguration(id: .a)

        XCTAssertEqual(config.id, .a)
        XCTAssertEqual(config.baseFrequency, 440.0)
        XCTAssertEqual(config.carrierMultiplier, 1.0)
        XCTAssertEqual(config.modulatingMultiplier, 1.0)
        XCTAssertEqual(config.modulationIndex, 1.0)
        XCTAssertEqual(config.amplitude, 0.5)
    }

    func test_init_setsCustomValues() {
        let config = OperatorConfiguration(
            id: .b,
            baseFrequency: 880,
            carrierMultiplier: 2.0,
            modulatingMultiplier: 3.0,
            modulationIndex: 5.0,
            amplitude: 0.8
        )

        XCTAssertEqual(config.id, .b)
        XCTAssertEqual(config.baseFrequency, 880)
        XCTAssertEqual(config.carrierMultiplier, 2.0)
        XCTAssertEqual(config.modulatingMultiplier, 3.0)
        XCTAssertEqual(config.modulationIndex, 5.0)
        XCTAssertEqual(config.amplitude, 0.8)
    }

    func test_equality() {
        let config1 = OperatorConfiguration(id: .a, baseFrequency: 440)
        let config2 = OperatorConfiguration(id: .a, baseFrequency: 440)
        let config3 = OperatorConfiguration(id: .a, baseFrequency: 880)

        XCTAssertEqual(config1, config2)
        XCTAssertNotEqual(config1, config3)
    }

    func test_operatorID_allCases() {
        let allCases = OperatorConfiguration.OperatorID.allCases

        XCTAssertEqual(allCases.count, 4)
        XCTAssertEqual(allCases, [.a, .b, .c, .d])
    }

    func test_ranges_areValid() {
        XCTAssertEqual(OperatorConfigurationRanges.baseFrequency, 20...2000)
        XCTAssertEqual(OperatorConfigurationRanges.carrierMultiplier, 0.1...10)
        XCTAssertEqual(OperatorConfigurationRanges.modulatingMultiplier, 0.1...10)
        XCTAssertEqual(OperatorConfigurationRanges.modulationIndex, 0...100)
        XCTAssertEqual(OperatorConfigurationRanges.amplitude, 0...1)
    }
}
