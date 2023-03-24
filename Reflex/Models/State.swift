//
//  State.swift
//  Reflex
//
//  Created by John Kieran Palladino on 3/23/23.
//

import Foundation
import AVFoundation
/*
 
 App logic:
 
 State:
    Started:
        duration_time_remaining: Double
        interval_time_remaining: Double
    Stopped
    
    
 
 
 */

let tick = 0.1
var rng = SystemRandomNumberGenerator()

class TimerState: ObservableObject {
    @Published var isStarted: Bool = false
    @Published var isPaused: Bool = false

    @Published var durationRemaining: TimeInterval = 0
    @Published var intervalRemaining: TimeInterval = 0
    
    private var timer: Timer!
    
    private var interval: TimeInterval = 0
    private var variance: Double = 0
    
    public init() {
        timer = Timer.scheduledTimer(withTimeInterval: tick, repeats: true, block: timerTick)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    private func timerTick(timer: Timer) {
        guard isStarted else {
            return
        }
        
        if isPaused {
            return
        }
        
        durationRemaining -= tick;
        intervalRemaining -= tick;
        
        if intervalRemaining < 0 {
            // play a sound
            playSound()
            
            // rearm the interval
            rearm()
        }
        
        if durationRemaining < 0 {
            stop()
        }
    }
    
    public func start(duration: TimeInterval, interval: TimeInterval, variance: Double) {
        isStarted = true
        durationRemaining = duration
        self.interval = interval
        self.variance = variance
        
        rearm()
    }
    
    public func stop() {
        isStarted = false
    }
    
    public func resume() {
        isPaused = false
    }
    
    public func pause() {
        isPaused = true
    }
    
    func playSound() {
        let systemSoundID: SystemSoundID = 1016
        AudioServicesPlaySystemSound(systemSoundID)
    }
    
    func rearm() {
        let hiFactor = (1 + variance)
        let loFactor = 1 / (1 + variance)
        
        let rand = Double(rng.next()) / Double(UInt64.max)
        let factor = (hiFactor - loFactor) * rand + loFactor;
        
        intervalRemaining = factor * interval
    }
}
