//
//  AudioPlayerDemo.swift
//  Pomodoro Timer
//
//  Created by Aakash Ambodkar 
//

import SwiftUI

struct AudioPlayerDemo: View {
    
    var audioPlayer = PomodoroAudio()
    
    
    var body: some View {
        VStack{
            Button("play done"){
                audioPlayer.play(.done)
            }
            Button("play tick"){
                audioPlayer.play(.tick)
            }
        }
        
    }
}

#Preview {
    AudioPlayerDemo()
}
