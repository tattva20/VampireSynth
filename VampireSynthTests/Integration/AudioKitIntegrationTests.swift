//
//  AudioKitIntegrationTests.swift
//  VampireSynthTests
//
//  Integration tests that verify the AudioKit adapters work correctly
//  with real AudioKit components (without actual audio output).
//

import XCTest
import AudioKit
import SoundpipeAudioKit
@testable import VampireSynth

final class AudioKitIntegrationTests: XCTestCase {

    // MARK: - AudioKitEngineAdapter Tests

    func test_engineAdapter_startsAndStopsSuccessfully() throws {
        let sut = makeEngineAdapter()

        XCTAssertFalse(sut.isRunning, "Engine should not be running initially")

        try sut.start()

        XCTAssertTrue(sut.isRunning, "Engine should be running after start")

        sut.stop()

        XCTAssertFalse(sut.isRunning, "Engine should not be running after stop")
    }

    func test_engineAdapter_canRestartAfterStopping() throws {
        let sut = makeEngineAdapter()

        try sut.start()
        sut.stop()
        try sut.start()

        XCTAssertTrue(sut.isRunning)
    }

    // MARK: - AudioKitFMOscillatorAdapter Tests

    func test_oscillatorAdapter_startsAndStopsSuccessfully() {
        let sut = makeOscillatorAdapter()

        XCTAssertFalse(sut.isStarted, "Oscillator should not be started initially")

        sut.start()

        XCTAssertTrue(sut.isStarted, "Oscillator should be started after start()")

        sut.stop()

        XCTAssertFalse(sut.isStarted, "Oscillator should not be started after stop()")
    }

    func test_oscillatorAdapter_setsBaseFrequencyCorrectly() {
        let sut = makeOscillatorAdapter()

        sut.baseFrequency = 880.0

        XCTAssertEqual(sut.baseFrequency, 880.0, accuracy: 0.001)
    }

    func test_oscillatorAdapter_setsCarrierMultiplierCorrectly() {
        let sut = makeOscillatorAdapter()

        sut.carrierMultiplier = 2.5

        XCTAssertEqual(sut.carrierMultiplier, 2.5, accuracy: 0.001)
    }

    func test_oscillatorAdapter_setsModulatingMultiplierCorrectly() {
        let sut = makeOscillatorAdapter()

        sut.modulatingMultiplier = 3.0

        XCTAssertEqual(sut.modulatingMultiplier, 3.0, accuracy: 0.001)
    }

    func test_oscillatorAdapter_setsModulationIndexCorrectly() {
        let sut = makeOscillatorAdapter()

        sut.modulationIndex = 50.0

        XCTAssertEqual(sut.modulationIndex, 50.0, accuracy: 0.001)
    }

    func test_oscillatorAdapter_setsAmplitudeCorrectly() {
        let sut = makeOscillatorAdapter()

        sut.amplitude = 0.75

        XCTAssertEqual(sut.amplitude, 0.75, accuracy: 0.001)
    }

    // MARK: - AudioKitEnvelopeAdapter Tests

    func test_envelopeAdapter_setsAttackDurationCorrectly() {
        let sut = makeEnvelopeAdapter()

        sut.attackDuration = 0.5

        XCTAssertEqual(sut.attackDuration, 0.5, accuracy: 0.001)
    }

    func test_envelopeAdapter_setsDecayDurationCorrectly() {
        let sut = makeEnvelopeAdapter()

        sut.decayDuration = 0.3

        XCTAssertEqual(sut.decayDuration, 0.3, accuracy: 0.001)
    }

    func test_envelopeAdapter_setsSustainLevelCorrectly() {
        let sut = makeEnvelopeAdapter()

        sut.sustainLevel = 0.6

        XCTAssertEqual(sut.sustainLevel, 0.6, accuracy: 0.001)
    }

    func test_envelopeAdapter_setsReleaseDurationCorrectly() {
        let sut = makeEnvelopeAdapter()

        sut.releaseDuration = 1.0

        XCTAssertEqual(sut.releaseDuration, 1.0, accuracy: 0.001)
    }

    // MARK: - AudioKitMixerAdapter Tests

    func test_mixerAdapter_setsVolumeCorrectly() {
        let sut = makeMixerAdapter()

        sut.volume = 0.8

        XCTAssertEqual(sut.volume, 0.8, accuracy: 0.001)
    }

    // MARK: - Full Signal Chain Integration Tests

    func test_fullSignalChain_canBeConstructedAndStarted() throws {
        let (engine, oscillators, envelopes, mixer) = makeFullSignalChain()

        try engine.start()

        XCTAssertTrue(engine.isRunning)

        oscillators.forEach { oscillator in
            oscillator.start()
            XCTAssertTrue(oscillator.isStarted)
        }

        engine.stop()
    }

    func test_fullSignalChain_oscillatorsRespondToFrequencyChanges() throws {
        let (engine, oscillators, _, _) = makeFullSignalChain()

        try engine.start()

        let testFrequency: Float = 523.25 // C5

        oscillators.forEach { oscillator in
            oscillator.baseFrequency = testFrequency
        }

        oscillators.forEach { oscillator in
            XCTAssertEqual(oscillator.baseFrequency, testFrequency, accuracy: 0.01)
        }

        engine.stop()
    }

    func test_fullSignalChain_envelopesRespondToADSRChanges() throws {
        let (engine, _, envelopes, _) = makeFullSignalChain()

        try engine.start()

        envelopes.forEach { envelope in
            envelope.attackDuration = 0.1
            envelope.decayDuration = 0.2
            envelope.sustainLevel = 0.5
            envelope.releaseDuration = 0.4
        }

        envelopes.forEach { envelope in
            XCTAssertEqual(envelope.attackDuration, 0.1, accuracy: 0.001)
            XCTAssertEqual(envelope.decayDuration, 0.2, accuracy: 0.001)
            XCTAssertEqual(envelope.sustainLevel, 0.5, accuracy: 0.001)
            XCTAssertEqual(envelope.releaseDuration, 0.4, accuracy: 0.001)
        }

        engine.stop()
    }

    // MARK: - Memory Leak Tests

    func test_engineAdapter_doesNotLeakMemory() {
        let sut = makeEngineAdapter()
        trackForMemoryLeaks(sut)
    }

    func test_oscillatorAdapter_doesNotLeakMemory() {
        let sut = makeOscillatorAdapter()
        trackForMemoryLeaks(sut)
    }

    // MARK: - Helpers

    private func makeEngineAdapter(file: StaticString = #filePath, line: UInt = #line) -> AudioKitEngineAdapter {
        let oscillator = FMOscillator()
        let engine = AudioEngine()
        engine.output = oscillator
        let sut = AudioKitEngineAdapter(engine: engine)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

    private func makeOscillatorAdapter(file: StaticString = #filePath, line: UInt = #line) -> AudioKitFMOscillatorAdapter {
        let sut = AudioKitFMOscillatorAdapter()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

    private func makeEnvelopeAdapter(file: StaticString = #filePath, line: UInt = #line) -> AudioKitEnvelopeAdapter {
        let oscillator = FMOscillator()
        let envelope = AmplitudeEnvelope(oscillator)
        let sut = AudioKitEnvelopeAdapter(envelope: envelope)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

    private func makeMixerAdapter(file: StaticString = #filePath, line: UInt = #line) -> AudioKitMixerAdapter {
        let mixer = Mixer()
        let sut = AudioKitMixerAdapter(mixer: mixer)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

    private func makeFullSignalChain(file: StaticString = #filePath, line: UInt = #line) -> (
        engine: AudioKitEngineAdapter,
        oscillators: [AudioKitFMOscillatorAdapter],
        envelopes: [AudioKitEnvelopeAdapter],
        mixer: AudioKitMixerAdapter
    ) {
        let oscillators = (0..<4).map { _ in AudioKitFMOscillatorAdapter() }
        let envelopes = oscillators.map { AudioKitEnvelopeAdapter(envelope: AmplitudeEnvelope($0.oscillator)) }
        let mixer = Mixer(envelopes.map { $0.envelope })
        let mixerAdapter = AudioKitMixerAdapter(mixer: mixer)

        let engine = AudioEngine()
        engine.output = mixer
        let engineAdapter = AudioKitEngineAdapter(engine: engine)

        trackForMemoryLeaks(engineAdapter, file: file, line: line)
        oscillators.forEach { trackForMemoryLeaks($0, file: file, line: line) }
        envelopes.forEach { trackForMemoryLeaks($0, file: file, line: line) }
        trackForMemoryLeaks(mixerAdapter, file: file, line: line)

        return (engineAdapter, oscillators, envelopes, mixerAdapter)
    }
}
