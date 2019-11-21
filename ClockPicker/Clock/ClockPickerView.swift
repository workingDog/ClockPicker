//
//  ClockPickerView.swift
//  Clock
//
//  Created by Ringo Wathelet on 2019/11/18.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import SwiftUI


enum HandType {
    case hour
    case minute
}

struct ClockPickerView : View {

    @Binding var clockDate: Date
    @ObservedObject var options = ClockLooks()
    
    @State var period: Int = 0
    let periodTypes = ["AM", "PM"]
    let formatter = DateFormatter()

    init(date: Binding<Date>, options: ClockLooks = ClockLooks()) {
        self._clockDate = date
        self.options = options
        // to control the AM:PM picker colors
        UISegmentedControl.appearance().selectedSegmentTintColor = self.options.ampmTintColor
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: self.options.ampmSelectedColor], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: self.options.ampmNormalColor], for: .normal)
    }
    
    var body: some View {
        Group {
            ZStack {
                Circle().stroke(options.circleColor, lineWidth: options.circleWidth)
                .overlay(Circle().fill(options.backgroundColor))
                ClockFace(period: $period, options: options)
                ClockHand(clockDate: $clockDate, handType: .hour, period: $period, options: options)
                ClockHand(clockDate: $clockDate, handType: .minute, period: $period, options: options)
                Text(asText()).foregroundColor(options.centerForegroundColor)
                periodPicker.offset(x: 0, y: 60)
            }
            .padding()
            .aspectRatio(1, contentMode: .fit)
        }
    }
    
    var periodPicker: some View {
        Picker(selection: Binding<Int>(
        get: { self.period }, set: { self.adjustClockDate($0) }), label: Text("")) {
            ForEach(0..<periodTypes.count) {
                Text(self.periodTypes[$0]).tag($0)
            }
        }.pickerStyle(SegmentedPickerStyle()).scaledToFit()
    }
    
    func asText() -> String {
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: clockDate)
    }
    
    // change the time according to the period setting
    func adjustClockDate(_ value: Int) {
        self.period = value
        let theMinutes = Calendar.current.component(.minute, from: clockDate)
        var theHours = Calendar.current.component(.hour, from: clockDate)
        if period == 1 {
            if theHours < 12 {
                theHours = theHours + 12
            }
            if theHours == 0 { theHours = 12 }
            if let newDate = Calendar.current.date(bySettingHour: theHours, minute: theMinutes, second: 0, of: clockDate) {
                clockDate = newDate
            }
        } else {
            if theHours == 12 { theHours = 0 }
            if theHours > 12 {
                theHours = theHours - 12
            }
            if let newDate = Calendar.current.date(bySettingHour: theHours, minute: theMinutes, second: 0, of: clockDate) {
                clockDate = newDate
            }
        }
    }
     
}
