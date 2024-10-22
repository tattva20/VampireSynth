//
//  ADSRWidgetView.swift
//  VampireSynth
//
//  Created by Octavio Rojas on 10/21/24.
//

import SwiftUI
import AudioKitUI
import SoundpipeAudioKit

struct ADSRWidgetView: View {
    let title: String
    @Binding var env: AmplitudeEnvelope

    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .foregroundColor(.white)
            ADSRWidget { att, dec, sus, rel in
                env.attackDuration = att
                env.decayDuration = dec
                env.sustainLevel = sus
                env.releaseDuration = rel
            }
        }
    }
}
