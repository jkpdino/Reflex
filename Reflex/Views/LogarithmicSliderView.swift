//
//  LogarithmicSliderView.swift
//  Reflex
//
//  Created by John Kieran Palladino on 3/23/23.
//

import SwiftUI

struct LogarithmicSliderView: View {
    let base: Double = 2.0
    
    let minimumValue: Double = 0.01
    let maximumValue: Double = 1
    
    @Binding var value: Double
    
    var body: some View {
        let binding = Binding(
            get: {
                logN(self.value, base: self.base)
            },
            set: {
                self.value = pow(self.base, $0)
            })
        
        Slider(value: binding,
               in: logN(minimumValue, base: base)...logN(maximumValue, base: base),
               minimumValueLabel: Text("0%"),
               maximumValueLabel: Text("100%"))
        {
            Text("Value")
        }
    }
    
    private func logN(_ x: Double, base: Double) -> Double {
        return log(x) / log(base)
    }
}

struct LogarithmicSliderView_Previews: PreviewProvider {
    static var previews: some View {
        LogarithmicSliderView(value: .constant(0.1))
            .padding(.all)
    }
}
