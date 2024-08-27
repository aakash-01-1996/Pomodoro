//
//  PomodoroTimer.swift
//  Pomodoro Timer
//
//  Created by Aakash Ambodkar
//

import Foundation
import Observation

enum PomodoroTimerState: String {
    case idle
    case running
    case paused
}

enum PomodoroTimerMode: String {
    case work
    case pause
}

@Observable
class PomodoroTimer {
    private var _mode: PomodoroTimerMode = .work
    private var _state: PomodoroTimerState = .idle
    
    private var _durationWork: TimeInterval
    private var _durationBreak: TimeInterval
    
    private var _secondsPassed: Int = 0
    private var _fractionPassed: Double = 0
    
    private var _dateStarted: Date = Date.now
    private var _secondsPassedBeforePaused: Int = 0
    
    private var _timer: Timer?
    private var _audio: PomodoroAudio = PomodoroAudio()
    
    
    
    init(workInSeconds: TimeInterval, breakInSeconds: TimeInterval) {
        _durationWork = workInSeconds
        _durationBreak = breakInSeconds
    }
    
    // MARK: Computed Properties
    var secondsPassed: Int {
        return _secondsPassed
    }
    
    var secondsPassedString: String {
        return _formatSeconds(_secondsPassed)
    }
    
    var secondsLeft: Int {
        Int(_duration) - secondsPassed
    }
    
    var secondsLeftString: String {
        return _formatSeconds(secondsLeft)
    }
    
    var fractionPassed: Double {
        return _fractionPassed
    }
    
    var fractionLeft: Double {
        1.0 - _fractionPassed
    }
    
    var state: PomodoroTimerState {
        _state
    }
    
    var mode: PomodoroTimerMode {
        _mode
    }
    
    private var _duration: TimeInterval {
        if mode == .work {
            return _durationWork
        } else {
            return _durationBreak
        }
    }
    
    // MARK: Public Methods
    func start() {
        _dateStarted = Date.now
        _secondsPassed = 0
        _fractionPassed = 0
        _state = .running
        _createTimer()
    }
    
    func resume() {
        _dateStarted = Date.now
        _state = .running
        _createTimer()
    }
    
    func pause() {
        _secondsPassedBeforePaused = _secondsPassed
        _state = .paused
        _killTimer()
    }
    
    func reset() {
        _secondsPassed = 0
        _fractionPassed = 0
        _secondsPassedBeforePaused = 0
        _state = .idle
        _killTimer()
    }
    
    func skip() {
        if self._mode == .work{
            self._mode = .pause
        } else {
            self._mode = .work
        }
    }
    
    // MARK: Private Methods
    private func _createTimer() {
        // schedule notification
        PomodoroNotification.scheduleNotification(seconds: TimeInterval(secondsLeft), title: "Timer Done", body: "Your Pomodoro timer is finished")
        // Create Timer
        _timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self._onTick()
        }
    }
    
    private func _killTimer() {
        _timer?.invalidate()
        _timer = nil
    }
    
    private func _onTick() {
        // calc seconds since start date && add seconds before pause && Calc fraction
        // When done... play sound, reset, switch mode
        let secondsSinceStartDate = Date.now.timeIntervalSince(self._dateStarted)
        self._secondsPassed = Int(secondsSinceStartDate) + self._secondsPassedBeforePaused
        self._fractionPassed = TimeInterval(self._secondsPassed) / self._duration
        // play tick sound
        _audio.play(.tick)
        
        if self.secondsLeft == 0 {
            self._fractionPassed = 0
            self.skip()     // to switch mode
            self.reset()    // to reset timer
            
            // play end sound
            _audio.play(.done)
        }
    }
    private func _formatSeconds(_ seconds: Int) -> String {
        if seconds <= 0 {
            return "00:00"
        }
        let hh: Int = seconds / 3600
        let mm: Int = (seconds % 3600) / 60
        let ss: Int = seconds % 60
        
        if hh > 0 {
            return String(format: "%02d:%02d:%02d", hh, mm, ss)
        } else {
            return String(format: "%02d:%02d", mm, ss)
        }
    }
}
