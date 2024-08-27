//
//  pomodoro.swift
//  Pomodoro Timer
//
//  Created by Aakash Ambodkar
//

import Foundation
import AVFoundation

enum PomodoroAudioSounds {
    case done
    case tick
    
    var resource: String {
        switch self {
        case .done:
            return "bell.wav"
        
        case .tick:
            return "tick.wav"
        }
    }
}


class PomodoroAudio {
    private var _audioPlayer: AVAudioPlayer?
    
    func play(_ sound: PomodoroAudioSounds) {
        let path = Bundle.main.path(forResource: sound.resource, ofType: nil)!
        let url = URL(filePath: path)
        do {
            _audioPlayer = try AVAudioPlayer(contentsOf: url)
            _audioPlayer?.play()
        } catch{
            print(error.localizedDescription)
        }
        
    }
    
}
