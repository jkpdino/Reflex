//
//  IntervalPicker.swift
//  Reflex
//
//  Created by John Kieran Palladino on 3/23/23.
//

import SwiftUI

struct IntervalPickerView: View {
    @Binding var hours: Int
    @Binding var minutes: Int
    @Binding var seconds: Int
    
    var body: some View {
        HStack {
            Picker("Hours", selection: $hours) {
                ForEach(0 ..< 24) { hour in
                    Text("\(hour)")
                }
            }
            .frame(width: 80)
            
            Text("h")
            
            Picker("Minutes", selection: $minutes) {
                ForEach(0 ..< 60) { minute in
                    Text("\(minute)")
                }
            }
            .frame(width: 80)
            
            Text("m")
            
            Picker("Seconds", selection: $seconds) {
                ForEach(0 ..< 60) { second in
                    Text("\(second)")
                }
            }
            .frame(width: 80)
            
            Text("s")
        }.foregroundColor(.black)
            .tint(Color("ActionOrange"))
    }
}

struct IntervalPicker_Previews: PreviewProvider {
    static var previews: some View {
        IntervalPickerView(hours: .constant(0),
                           minutes: .constant(0),
                           seconds: .constant(30))
    }
}
