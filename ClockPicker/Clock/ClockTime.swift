//
//  ClockTime.swift
//  ClockPicker
//
//  Created by Ringo Wathelet on 2019/11/19.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import Foundation
import SwiftUI


class ClockTime : ObservableObject {
    
    let periodTypes = ["AM", "PM"]
    let calendar = Calendar.current
    let formatter = DateFormatter()
    
    @Published var clockTimeString = "00:00"
    
    @Published var clockDate = Date() {
        didSet {
            self.clockTimeString = asText() // formatter.string(from: clockDate) // <--- this works
        }
    }
    
    @Published var period: Int = 0 {
        didSet {
            clockTimeString = asText() // formatter.string(from: clockDate)  // <--- this does not work
        }
    }
    
    init(date: Date = Date()) {
        self.clockDate = date
        self.formatter.dateFormat = "HH:mm"
    }
    
    func isPM() -> Bool { return period == 1 }
    
    func asText() -> String {
        var theHours = calendar.component(.hour, from: clockDate)
        if isPM() { theHours = theHours + 12 }
        let theMinutes = calendar.component(.minute, from: clockDate)
        return (theHours <= 9 ? "0" : "") + String(theHours) + ":" + (theMinutes <= 9 ? "0" : "") + String(theMinutes)
     }

}
