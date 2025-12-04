import XCTest
@testable import VampireSynth

final class MIDINoteTests: XCTestCase {

    func test_frequency_calculatesCorrectlyForA4() {
        let note = MIDINote(pitch: 69)

        XCTAssertEqual(note.frequency, 440.0, accuracy: 0.01)
    }

    func test_frequency_calculatesCorrectlyForMiddleC() {
        let note = MIDINote(pitch: 60)

        XCTAssertEqual(note.frequency, 261.63, accuracy: 0.01)
    }

    func test_frequency_calculatesCorrectlyForA3() {
        let note = MIDINote(pitch: 57)

        XCTAssertEqual(note.frequency, 220.0, accuracy: 0.01)
    }

    func test_frequency_calculatesCorrectlyForA5() {
        let note = MIDINote(pitch: 81)

        XCTAssertEqual(note.frequency, 880.0, accuracy: 0.01)
    }

    func test_init_setsDefaultVelocity() {
        let note = MIDINote(pitch: 60)

        XCTAssertEqual(note.velocity, 127)
    }

    func test_equality() {
        let note1 = MIDINote(pitch: 60, velocity: 100)
        let note2 = MIDINote(pitch: 60, velocity: 100)
        let note3 = MIDINote(pitch: 61, velocity: 100)

        XCTAssertEqual(note1, note2)
        XCTAssertNotEqual(note1, note3)
    }
}
