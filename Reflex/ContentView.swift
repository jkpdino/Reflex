//
//  ContentView.swift
//  Reflex
//
//  Created by John Kieran Palladino on 3/23/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @ObservedObject var state: TimerState
    @ObservedObject var config: Config = Config()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(Color("ActionOrange"))
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                Text("Reflex")
                    .font(.largeTitle)
                    .foregroundColor(Color("LightOrange"))
                
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(Color("LightOrange"))
                        .cornerRadius(20.0)
                    
                    VStack {
                        ConfigView(config: config)
                            .disabled(state.isStarted)
                            .opacity(state.isStarted ? 0.5 : 1.0)
                        
                        Spacer()
                        
                        if state.isStarted {
                            Text("\(state.durationRemaining.format())")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Button(action: startButtonPress) {
                                Image(systemName: "play.fill")
                                    .font(.system(size: 24.0))
                                    .padding(4.0)
                            }
                            .disabled(state.isStarted && !state.isPaused)
                            
                            Button(action: pauseButtonPress) {
                                Image(systemName: "pause.fill")
                                    .font(.system(size: 24.0))
                                    .padding(4.0)
                            }.disabled(!state.isStarted || state.isPaused)
                            
                            Button(action: stopButtonPress) {
                                Image(systemName: "stop.fill")
                                    .font(.system(size: 24.0))
                                    .padding(4.0)
                            }.disabled(!state.isStarted)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color("ActionOrange"))
                    }.padding()
                }
            }.padding(20.0)
        }
    }
    
    func startButtonPress() {
        if state.isPaused {
            self.state.resume()
        }
        
        if !state.isStarted {
            let duration = interval(hours: config.durationHours,
                                    minutes: config.durationMinutes,
                                    seconds: config.durationSeconds)
            
            let interval = interval(hours: config.intervalHours,
                                    minutes: config.intervalMinutes,
                                    seconds: config.intervalSeconds)
            
            let variance = config.variance
            
            self.state.start(duration: duration,
                             interval: interval,
                             variance: variance)
        }
    }
    
    func pauseButtonPress() {
        self.state.pause()
    }
    
    func stopButtonPress() {
        self.state.stop()
    }
}

func interval(hours: Int, minutes: Int, seconds: Int) -> TimeInterval {
    let hComponent = TimeInterval(hours) * 3600.0
    let mComponent = TimeInterval(minutes) * 60.0
    let sComponent = TimeInterval(seconds)
    
    return hComponent + mComponent + sComponent
}

extension TimeInterval {
    func format() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 3

        return formatter.string(from: self)!
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(state: TimerState())
        }
    }
}
