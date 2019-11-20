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
    
    @Binding var clockDate: Date
    
    let periodTypes = ["AM", "PM"]
    let calendar = Calendar.current
    let formatter = DateFormatter()
    
    @Published var period: Int = 0
    
    init(date: Binding<Date>) {
        self._clockDate = date
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
