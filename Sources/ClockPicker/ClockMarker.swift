//
//  ClockMarker.swift
//  ClockPicker
//
//  Created by Ringo Wathelet on 2019/11/18.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import Foundation


struct ClockMarker: Hashable {
    
    let degrees: Double
    let label: String
    
    init(degrees: Double, label: String) {
        self.degrees = degrees
        self.label = label
    }
    
    static func AMlabelSet() -> [ClockMarker] {
        return [
            ClockMarker(degrees: 0, label: "▼"),
            ClockMarker(degrees: 30, label: "1"),
            ClockMarker(degrees: 60, label: "2"),
            ClockMarker(degrees: 90, label: "3"),
            ClockMarker(degrees: 120, label: "4"),
            ClockMarker(degrees: 150, label: "5"),
            ClockMarker(degrees: 180, label: "6"),
            ClockMarker(degrees: 210, label: "7"),
            ClockMarker(degrees: 240, label: "8"),
            ClockMarker(degrees: 270, label: "9"),
            ClockMarker(degrees: 300, label: "10"),
            ClockMarker(degrees: 330, label: "11")
        ]
    }
    
    static func PMlabelSet() -> [ClockMarker] {
        return [
            ClockMarker(degrees: 0, label: "▼"),
            ClockMarker(degrees: 30, label: "13"),
            ClockMarker(degrees: 60, label: "14"),
            ClockMarker(degrees: 90, label: "15"),
            ClockMarker(degrees: 120, label: "16"),
            ClockMarker(degrees: 150, label: "17"),
            ClockMarker(degrees: 180, label: "18"),
            ClockMarker(degrees: 210, label: "19"),
            ClockMarker(degrees: 240, label: "20"),
            ClockMarker(degrees: 270, label: "21"),
            ClockMarker(degrees: 300, label: "22"),
            ClockMarker(degrees: 330, label: "23")
        ]
    }
    
    static func romanPMlabelSet() -> [ClockMarker] {
        return [
            ClockMarker(degrees: 0, label: "XII"),
            ClockMarker(degrees: 30, label: "XIII"),
            ClockMarker(degrees: 60, label: "XIV"),
            ClockMarker(degrees: 90, label: "XV"),
            ClockMarker(degrees: 120, label: "XVI"),
            ClockMarker(degrees: 150, label: "XVII"),
            ClockMarker(degrees: 180, label: "XVIII"),
            ClockMarker(degrees: 210, label: "XIX"),
            ClockMarker(degrees: 240, label: "XX"),
            ClockMarker(degrees: 270, label: "XXI"),
            ClockMarker(degrees: 300, label: "XXII"),
            ClockMarker(degrees: 330, label: "XXIII")
        ]
    }
    
    static func romanAMlabelSet() -> [ClockMarker] {
        return [
            ClockMarker(degrees: 0, label: "XII"),
            ClockMarker(degrees: 30, label: "I"),
            ClockMarker(degrees: 60, label: "II"),
            ClockMarker(degrees: 90, label: "III"),
            ClockMarker(degrees: 120, label: "IV"),
            ClockMarker(degrees: 150, label: "V"),
            ClockMarker(degrees: 180, label: "VI"),
            ClockMarker(degrees: 210, label: "VII"),
            ClockMarker(degrees: 240, label: "VIII"),
            ClockMarker(degrees: 270, label: "IX"),
            ClockMarker(degrees: 300, label: "X"),
            ClockMarker(degrees: 330, label: "XI")
        ]
    }

}
