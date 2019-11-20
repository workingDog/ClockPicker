//
//  ClockPickerView.swift
//  Clock
//
//  Created by Ringo Wathelet on 2019/11/18.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import SwiftUI


struct ClockPickerView : View {

    @Binding var clockDate: Date
    
    @State var period: Int = 0
    let periodTypes = ["AM", "PM"]
    let formatter = DateFormatter()

    init(date: Binding<Date>) {
        self._clockDate = date
        // to control the AM:PM picker colors
        UISegmentedControl.appearance().selectedSegmentTintColor = .blue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .normal)
    }
    
    var body: some View {
        Group {
            ZStack {
                Circle().stroke(Color.blue)
                ClockFace(period: $period)
                ClockHand(clockDate: $clockDate, handType: .hour, period: $period)
                ClockHand(clockDate: $clockDate, handType: .minute, period: $period)
                Text(asText()).foregroundColor(Color(UIColor.systemBackground))
                periodPicker.offset(x: 0, y: 60)
            }
            .padding()
            .aspectRatio(1, contentMode: .fit)
        }
    }
    
    var periodPicker: some View {
        Picker(selection: $period, label: Text("")) {
            ForEach(0..<periodTypes.count) {
                Text(self.periodTypes[$0]).tag($0)
            }
        }.pickerStyle(SegmentedPickerStyle()).scaledToFit()
    }
    
    func asText() -> String {
        let theMinutes = Calendar.current.component(.minute, from: clockDate)
        var theHours = Calendar.current.component(.hour, from: clockDate)
        formatter.dateFormat = "HH:mm"
        // change the time according to the period setting
        if period == 1 {
            if theHours <= 12 {
                theHours = theHours + 12
            }
            if let newDate = Calendar.current.date(bySettingHour: theHours, minute: theMinutes, second: 0, of: clockDate) {
                clockDate = newDate
            }
        } else {
            if theHours > 12 {
                theHours = theHours - 12
            }
            if let newDate = Calendar.current.date(bySettingHour: theHours, minute: theMinutes, second: 0, of: clockDate) {
                clockDate = newDate
            }
        }
        return formatter.string(from: clockDate)
    }
    
}
