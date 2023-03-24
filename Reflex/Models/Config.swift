//
//  Config.swift
//  Reflex
//
//  Created by John Kieran Palladino on 3/24/23.
//

import Foundation

class Config: ObservableObject {
    @Published var intervalHours: Int = 0
    @Published var intervalMinutes: Int = 0
    @Published var intervalSeconds: Int = 15
    
    @Published var durationHours: Int = 0
    @Published var durationMinutes: Int = 5
    @Published var durationSeconds: Int = 0
    
    @Published var variance: Double = 0.0
}
