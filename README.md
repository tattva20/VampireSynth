# Vampire Synth

## Overview

**Vampire Synth** is a virtual FM synthesizer app built using **AudioKit** and **SwiftUI**. It is designed for real-time sound synthesis and manipulation, leveraging multiple oscillators, amplitude envelopes, and a MIDI-compatible keyboard interface. The app is compatible with iOS devices and uses AudioKit's DSP capabilities for sound generation.

## Features

- **FM Synthesis**: 4 independent operators (Oscillators A, B, C, and D), each configurable with modulation frequency, index, amplitude, and more.
- **Amplitude Envelopes**: Configurable ADSR envelope for each operator.
- **MIDI Compatibility**: Supports MIDI note input for real-time play using an external MIDI device.
- **SwiftUI Interface**: Responsive and modern UI for real-time control of the synthesizer parameters.
- **Keyboard Interface**: On-screen piano-style keyboard with customizable note events.
- **Octave Shift**: Control the pitch range of the oscillators.
- **Customizable Modulation**: Adjust modulation frequency, modulation index, and other synthesis parameters dynamically.

## Requirements

### Hardware:
- iOS device with iOS 14.0 or later
- External MIDI controller (optional but recommended)

### Software:
- Xcode 12.0 or later (for building the app)
- AudioKit 5 or later (included via Swift Package Manager)

## Installation

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/your-repo/vampire-synth.git
    cd vampire-synth
    ```

2. **Open in Xcode**:
    - Open the `VampireSynth.xcodeproj` file in Xcode.
    - Ensure the AudioKit dependencies are properly resolved (via Swift Package Manager).

3. **Build and Run**:
    - Select your target device (iPhone, iPad).
    - Press `Cmd + R` to build and run the app on your device.

## Usage

### Real-time Sound Synthesis:

1. **Operators (A, B, C, D)**:
    - Each operator is an FM oscillator with configurable parameters such as base frequency, modulation frequency, modulation multiplier, and modulation index.
    - Use sliders to dynamically adjust these parameters during sound generation.

2. **Amplitude Envelopes**:
    - Each operator has an independent amplitude envelope with ADSR (Attack, Decay, Sustain, Release) controls.
    - Modify the envelope settings using intuitive sliders.

3. **MIDI Support**:
    - Play notes using the on-screen keyboard or connect a MIDI controller for external control.
    - The app listens for MIDI note-on and note-off events to trigger sound synthesis in real-time.

4. **Octave Shift**:
    - Adjust the octave range for the oscillators using a simple stepper control.

### User Interface:

- **Operator Controls**: Each operator has sliders to adjust modulation frequency, modulation multiplier, modulation index, and amplitude.
- **Amplitude Envelope Controls**: Configure the ADSR envelope using the provided interface.
- **MIDI Keyboard**: The on-screen keyboard supports note events and can be used to control the sound synthesis in real-time.
- **Dark Mode**: The interface is optimized for dark mode with a sleek black background and red highlights.

## Customization

- **Synth Parameters**: You can modify various parameters within the code, such as the range of frequencies, modulation indices, and ADSR values.
- **Operator Settings**: The `OperatorConductor` class controls the behavior of each FM oscillator, allowing for further customizations like oscillator waveforms and modulation types.

## Future Plans

- Add support for saving and loading presets.
- Introduce more synthesis types (e.g., additive, subtractive).
- Implement effects such as reverb, delay, and chorus.

## Troubleshooting

- **No Sound**: Ensure your audio session is active and the device is not in silent mode.
- **MIDI Issues**: Verify that your MIDI device is properly connected and recognized by your iOS device.

## License

This project is licensed under the **MIT License**. See the `LICENSE` file for details.

## Credits

- **Octavio Rojas** - Developer and creator of the Vampire Synth
- **AudioKit Team** - For providing the powerful audio processing library used in this app

## Acknowledgements

- Special thanks to the **AudioKit** community for their tools and support in developing audio applications.
- Inspired by the retro-modern synthesis approach and the continuous innovation in audio technology.
