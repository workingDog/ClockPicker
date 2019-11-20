//
//  ClockPickerView.swift
//  Clock
//
//  Created by Ringo Wathelet on 2019/11/18.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import SwiftUI


struct ClockPickerView : View {

    @ObservedObject var clockTime: ClockTime

    init(date: Binding<Date>) {
        self.clockTime = ClockTime(date: date)
        // to control the AM:PM picker colors
        UISegmentedControl.appearance().selectedSegmentTintColor = .blue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .normal)
    }
    
    var body: some View {
        Group {
            ZStack {
                Circle().stroke(Color.blue)
                ClockFace()
                ClockHand(clockTime: clockTime, handType: .hour)
                ClockHand(clockTime: clockTime, handType: .minute)
                Text(clockTime.asText()).foregroundColor(Color(UIColor.systemBackground))
                periodPicker.offset(x: 0, y: 60)
            }
            .padding()
            .aspectRatio(1, contentMode: .fit)
        }
    }

    var periodPicker: some View {
        Picker(selection: self.$clockTime.period, label: Text("")) {
            ForEach(0..<self.clockTime.periodTypes.count) {
                Text(self.clockTime.periodTypes[$0]).tag($0)
            }
        }.pickerStyle(SegmentedPickerStyle()).scaledToFit()
    }
 
}
