//
//  ClockLabel.swift
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
    
    static func labelSet() -> [ClockMarker] {
        return [
            ClockMarker(degrees: 0, label: "12"),
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

}
