//
//  ConfigView.swift
//  Reflex
//
//  Created by John Kieran Palladino on 3/23/23.
//

import SwiftUI

struct ConfigView: View {
    @ObservedObject var config: Config
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Interval").opacity(0.5)
            
            IntervalPickerView(hours: $config.intervalHours,
                               minutes: $config.intervalMinutes,
                               seconds: $config.intervalSeconds)
                .pickerStyle(.wheel)
            
            Text("Duration").opacity(0.5)
            
            IntervalPickerView(hours: $config.durationHours,
                               minutes: $config.durationMinutes,
                               seconds: $config.durationSeconds)
            
            Text("Variance").opacity(0.5)
            
            LogarithmicSliderView(value: $config.variance)
                .foregroundColor(.black)
                .tint(Color("ActionOrange"))

            
            //Text("Alarm").opacity(0.5)
            
        }.foregroundColor(Color("ActionOrange"))
            .font(.title2)
    }
}

struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView(config: Config())
    }
}
