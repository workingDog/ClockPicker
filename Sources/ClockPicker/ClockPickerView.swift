//
//  ClockPickerView.swift
//  ClockPicker
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
    
    @State var showHours = true
    @State var showMinutes = false
    
    @State var hand: HandType = .hour
    
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
        GeometryReader { geometry in
            ZStack {
                Circle().stroke(self.options.circleColor, lineWidth: self.options.circleWidth)
                    .overlay(Circle().fill(self.options.backgroundColor))
                
                self.options.withHands ? AnyView(self.clockWithHands) : AnyView(self.clockWithoutHands)
                
                self.periodPicker.offset(x: self.options.ampmPickerXoffset*geometry.size.width,
                                         y: self.options.ampmPickerYoffset*geometry.size.height)
            }
            .padding()
            .aspectRatio(1, contentMode: .fit)
        }
    }
    
    var clockWithHands: some View {
        Group {
            ClockFace(period: self.$period, options: self.options)
            ClockHand(clockDate: self.$clockDate, handType: .hour, period: self.$period, options: self.options)
            ClockHand(clockDate: self.$clockDate, handType: .minute, period: self.$period, options: self.options)
            Text(self.asText()).foregroundColor(self.options.centerForegroundColor).font(self.options.centerTextFont)
        }
    }
    
    var clockWithoutHands: some View {
        Group {
            ClockNoHands(clockDate: self.$clockDate, period: self.$period, options: self.options, handType: self.$hand)
            HStack {
                Button(action: {self.hand = .hour}) {Text(self.asHours())}
                Text(" : ")
                Button(action: {self.hand = .minute}) {Text(self.asMinutes())}
            }.font(self.options.labelFont)
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
    
    func asHours() -> String {
        var theHours = Calendar.current.component(.hour, from: clockDate)
        if period == 1 {
            if theHours < 12 {
                theHours = theHours + 12
            }
        }
        return String(theHours)
    }
    
    func asMinutes() -> String {
        formatter.dateFormat = "mm"
        return formatter.string(from: clockDate)
    }
    
    func asText() -> String {
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: clockDate)
    }
    
    // change the hour according to the period setting
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
