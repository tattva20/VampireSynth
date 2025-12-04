import XCTest
@testable import VampireSynth

final class SynthControllerTests: XCTestCase {

    // MARK: - Init Tests

    func test_init_doesNotStartEngine() {
        let (_, engine, _, _, _) = makeSUT()

        XCTAssertEqual(engine.messages, [])
        XCTAssertFalse(engine.isRunning)
    }

    func test_init_doesNotStartOscillators() {
        let (_, _, oscillators, _, _) = makeSUT()

        oscillators.forEach { oscillator in
            XCTAssertFalse(oscillator.isStarted)
        }
    }

    // MARK: - Start Tests

    func test_start_startsEngine() throws {
        let (sut, engine, _, _, _) = makeSUT()

        try sut.start()

        XCTAssertEqual(engine.messages, [.start])
        XCTAssertTrue(engine.isRunning)
    }

    func test_start_deliversErrorOnEngineFailure() {
        let (sut, engine, _, _, _) = makeSUT()
        engine.startError = AudioEngineError.failedToStart("Test error")

        XCTAssertThrowsError(try sut.start())
    }

    // MARK: - Stop Tests

    func test_stop_stopsEngine() throws {
        let (sut, engine, _, _, _) = makeSUT()
        try sut.start()

        sut.stop()

        XCTAssertEqual(engine.messages, [.start, .stop])
        XCTAssertFalse(engine.isRunning)
    }

    // MARK: - Note On Tests

    func test_noteOn_setsBaseFrequencyOnAllOscillators() {
        let (sut, _, oscillators, _, _) = makeSUT()
        let note = MIDINote(pitch: 69) // A4 = 440Hz

        sut.noteOn(note)

        oscillators.forEach { oscillator in
            XCTAssertTrue(oscillator.messages.contains(.setBaseFrequency(440.0)))
        }
    }

    func test_noteOn_startsAllOscillators() {
        let (sut, _, oscillators, _, _) = makeSUT()
        let note = MIDINote(pitch: 60)

        sut.noteOn(note)

        oscillators.forEach { oscillator in
            XCTAssertTrue(oscillator.messages.contains(.start))
            XCTAssertTrue(oscillator.isStarted)
        }
    }

    func test_noteOn_opensAllEnvelopeGates() {
        let (sut, _, _, envelopes, _) = makeSUT()
        let note = MIDINote(pitch: 60)

        sut.noteOn(note)

        envelopes.forEach { envelope in
            XCTAssertTrue(envelope.messages.contains(.openGate))
        }
    }

    // MARK: - Note Off Tests

    func test_noteOff_closesAllEnvelopeGates() {
        let (sut, _, _, envelopes, _) = makeSUT()
        sut.noteOn(MIDINote(pitch: 60))
        envelopes.forEach { $0.resetMessages() }

        sut.noteOff()

        envelopes.forEach { envelope in
            XCTAssertEqual(envelope.messages, [.closeGate])
        }
    }

    func test_noteOff_stopsAllOscillators() {
        let (sut, _, oscillators, _, _) = makeSUT()
        sut.noteOn(MIDINote(pitch: 60))
        oscillators.forEach { $0.resetMessages() }

        sut.noteOff()

        oscillators.forEach { oscillator in
            XCTAssertTrue(oscillator.messages.contains(.stop))
            XCTAssertFalse(oscillator.isStarted)
        }
    }

    // MARK: - Update Operator Tests

    func test_updateOperator_appliesConfigurationToCorrectOscillator() {
        let (sut, _, oscillators, _, _) = makeSUT()
        let config = OperatorConfiguration(
            id: .a,
            baseFrequency: 880,
            carrierMultiplier: 2.0,
            modulatingMultiplier: 3.0,
            modulationIndex: 5.0,
            amplitude: 0.8
        )

        sut.updateOperator(.a, configuration: config)

        let operatorA = oscillators[0]
        XCTAssertTrue(operatorA.messages.contains(.setBaseFrequency(880)))
        XCTAssertTrue(operatorA.messages.contains(.setCarrierMultiplier(2.0)))
        XCTAssertTrue(operatorA.messages.contains(.setModulatingMultiplier(3.0)))
        XCTAssertTrue(operatorA.messages.contains(.setModulationIndex(5.0)))
        XCTAssertTrue(operatorA.messages.contains(.setAmplitude(0.8)))
    }

    func test_updateOperator_doesNotAffectOtherOscillators() {
        let (sut, _, oscillators, _, _) = makeSUT()
        let config = OperatorConfiguration(id: .a, baseFrequency: 880)

        sut.updateOperator(.a, configuration: config)

        // Operators B, C, D should not receive setBaseFrequency(880)
        for i in 1..<oscillators.count {
            XCTAssertFalse(oscillators[i].messages.contains(.setBaseFrequency(880)))
        }
    }

    // MARK: - Update Envelope Tests

    func test_updateEnvelope_appliesConfigurationToCorrectEnvelope() {
        let (sut, _, _, envelopes, _) = makeSUT()
        let config = EnvelopeConfiguration(
            operatorID: .a,
            attack: 0.5,
            decay: 0.2,
            sustain: 0.7,
            release: 1.0
        )

        sut.updateEnvelope(.a, configuration: config)

        let envelopeA = envelopes[0]
        XCTAssertTrue(envelopeA.messages.contains(.setAttack(0.5)))
        XCTAssertTrue(envelopeA.messages.contains(.setDecay(0.2)))
        XCTAssertTrue(envelopeA.messages.contains(.setSustain(0.7)))
        XCTAssertTrue(envelopeA.messages.contains(.setRelease(1.0)))
    }

    func test_updateEnvelope_doesNotAffectOtherEnvelopes() {
        let (sut, _, _, envelopes, _) = makeSUT()
        let config = EnvelopeConfiguration(operatorID: .a, attack: 0.5)

        sut.updateEnvelope(.a, configuration: config)

        // Envelopes B, C, D should not receive setAttack(0.5)
        for i in 1..<envelopes.count {
            XCTAssertFalse(envelopes[i].messages.contains(.setAttack(0.5)))
        }
    }

    // MARK: - Master Volume Tests

    func test_setMasterVolume_updatesMixer() {
        let (sut, _, _, _, mixer) = makeSUT()

        sut.setMasterVolume(0.75)

        XCTAssertEqual(mixer.messages, [.setVolume(0.75)])
    }

    // MARK: - Memory Leak Tests

    func test_init_doesNotLeakMemory() {
        let (sut, engine, oscillators, envelopes, mixer) = makeSUT()

        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(engine)
        oscillators.forEach { trackForMemoryLeaks($0) }
        envelopes.forEach { trackForMemoryLeaks($0) }
        trackForMemoryLeaks(mixer)
    }

    // MARK: - Helpers

    private func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (
        sut: SynthController,
        engine: AudioEngineSpy,
        oscillators: [FMOscillatorSpy],
        envelopes: [EnvelopeSpy],
        mixer: MixerSpy
    ) {
        let engine = AudioEngineSpy()
        let oscillators = OperatorConfiguration.OperatorID.allCases.map { _ in FMOscillatorSpy() }
        let envelopes = OperatorConfiguration.OperatorID.allCases.map { _ in EnvelopeSpy() }
        let mixer = MixerSpy()

        let sut = SynthController(
            engine: engine,
            oscillators: oscillators,
            envelopes: envelopes,
            mixer: mixer
        )

        trackForMemoryLeaks(sut, file: file, line: line)

        return (sut, engine, oscillators, envelopes, mixer)
    }
}
