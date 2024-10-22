//
//  VampireKeyboardView.swift
//  VampireSynth
//
//  Created by Octavio Rojas on 9/1/24.
//

import SwiftUI
import Tonic
import Keyboard

struct VampireKeyboardView: View {
    var noteOn: (Pitch, CGPoint) -> Void = { _, _ in }
    var noteOff: (Pitch) -> Void
    
    var body: some View {
        Keyboard(
            layout: .piano(pitchRange: Pitch(36) ... Pitch(83)),
            noteOn: noteOn,
            noteOff: noteOff)
        .padding()
        .background(Color.clear) // Allows keyboard events to pass through
    }
}

struct MIDIKitKeyboard: View {
    var noteOn: (Pitch, CGPoint) -> Void = { _, _ in }
    var noteOff: (Pitch) -> Void
    
    var body: some View {
        Keyboard(
            layout: .piano(pitchRange: Pitch(36) ... Pitch(83)),
            noteOn: noteOn,
            noteOff: noteOff){ pitch, isActivated in
            MIDIKitKeyboardKey(
                pitch: pitch,
                isActivated: isActivated,
                color: .red)
        }.cornerRadius(5)
    }
}

struct MIDIKitKeyboardKey: View {
    @State var MIDIKeyPressed = [Bool](repeating: false, count: 128)
    var pitch : Pitch
    var isActivated : Bool
    var color: Color
    
    var body: some View {
        VStack{
            KeyboardKey(pitch: pitch,
                        isActivated: isActivated,
                        text: "",
                        whiteKeyColor: .white,
                        blackKeyColor: .black,
                        pressedColor:  color,
                        flatTop: true,
                        isActivatedExternally: MIDIKeyPressed[pitch.intValue])
        }
        .onReceive(NotificationCenter.default.publisher(for: .MIDIKey), perform: { obj in
            if let userInfo = obj.userInfo, let info = userInfo["info"] as? UInt8, let val = userInfo["bool"] as? Bool {
                self.MIDIKeyPressed[Int(info)] = val
            }
        })
    }
}

struct VampireKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        MIDIKitKeyboard(noteOn: { pitch, point in
            print("Note on: \(pitch)")
        }, noteOff: { pitch in
            print("Note off: \(pitch)")
        })
    }
}

extension NSNotification.Name {
    static let MIDIKey = Notification.Name("MIDIKey")
}
