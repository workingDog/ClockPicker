//
//  ClockNoHands.swift
//  ClockPicker
//
//  Created by Ringo Wathelet on 2019/11/23.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import SwiftUI

struct ClockNoHands: View {
    
    @Binding var clockDate: Date
    
    @Binding var period: Int
    @ObservedObject var options = ClockLooks()
    @Binding var handType: HandType  // hour or minute
    
    @State var hourHighlight = Array(repeating: false, count: 12)
    
    @State var minuteSet1Highlight = Array(repeating: false, count: 20)
    @State var minuteSet2Highlight = Array(repeating: false, count: 20)
    @State var minuteSet3Highlight = Array(repeating: false, count: 20)
    

    var body: some View {
        GeometryReader { geometry in
            if self.handType == .hour {
                self.hourDisplay(geometry)
            } else {
                self.minutesDisplay(geometry)
            }
        }.onAppear(perform: self.startTime)
    }
    
    private func minutesDisplay(_ geometry: GeometryProxy) -> AnyView {
        return AnyView(Group {
            // 3 sets of 20 values for 60 minutes
            ForEach(1..<4) { s in
                // the minutes circle marks
                ForEach(0..<20) { n in
                    ZStack {
                        Circle().overlay(
                            Circle().stroke(self.options.minuteDotMarkColor, lineWidth: 1)
                        ).foregroundColor(self.options.minuteDotMarkColor)
                            .frame(width: self.options.minuteDotMarkSize, height: self.options.minuteDotMarkSize)
                            .position(CGPoint(x: geometry.size.width / 2, y: self.options.minuteDotMarkSize*CGFloat(s)))
                            .onTapGesture { self.minuteTapped(n: n, set: s) }
                        
                        if self.isHighlighted(n, set: s) {
                            Circle().stroke(Color.red, lineWidth: 4)
                                .frame(width: self.options.minuteDotMarkSize, height: self.options.minuteDotMarkSize)
                                .position(CGPoint(x: geometry.size.width / 2 , y: self.options.minuteDotMarkSize*CGFloat(s)))
                        }
                        
                    }.rotationEffect(Angle(degrees: self.theAngle(n, set: s)))
                }
                // the minutes labels
                ForEach(0..<20) { n in
                    ZStack {
                        self.minuteLabels(n, set: s)
                            .position(CGPoint(x: geometry.size.width / 2, y: self.options.minuteDotMarkSize*CGFloat(s)))
                    }
                    .rotationEffect(Angle(degrees: self.theAngle(n, set: s)))
                }
            }
        })
    }
    
    private func theAngle(_ n: Int, set: Int) -> Double {
        return (Double(n) * 360 / 20) + (Double(set - 1) * 6)
    }
    
    private func isHighlighted(_ n: Int, set: Int) -> Bool {
        switch set {
        case 1:
            return minuteSet1Highlight[n]
        case 2:
            return minuteSet2Highlight[n]
        case 3:
            return minuteSet3Highlight[n]
        default:
            return false
        }
    }
    
    private func minuteLabels(_ n: Int, set: Int) -> AnyView {
        let angle = -theAngle(n, set: set)
        return AnyView(Text(self.minuteAsString(n, set)).rotationEffect(Angle(degrees: angle)))
    }
    
    private func minuteAsString(_ n: Int, _ set: Int) -> String {
        switch set {
        case 1:
            let index = n * 3
            return String(index)
        case 2:
            let index = n * 3 + 1
            return String(index)
        case 3:
            let index = n * 3 + 2
            return String(index)
        default:
            return ""
        }
    }
    
    private func hourDisplay(_ geometry: GeometryProxy) -> AnyView {
        return AnyView(Group {
            // the hours circle marks
            ForEach(0..<12) { n in
                ZStack {
                    Circle().overlay(
                        Circle().stroke(self.options.hourDotMarkColor, lineWidth: 1)
                    ).foregroundColor(self.options.hourDotMarkColor)
                        .frame(width: self.options.hourDotMarkSize, height: self.options.hourDotMarkSize)
                        .position(CGPoint(x: geometry.size.width / 2,
                                          y: CGFloat(geometry.size.width * 0.9)))
                        .onTapGesture { self.hourTapped(hour: n) }
                    
                    if self.hourHighlight[n] {
                        Circle().stroke(Color.red, lineWidth: 4)
                            .frame(width: self.options.hourDotMarkSize, height: self.options.hourDotMarkSize)
                            .position(CGPoint(x: geometry.size.width / 2,
                                              y: CGFloat(geometry.size.width * 0.9)))
                    }
                    
                }.rotationEffect(Angle(degrees: Double(n-90) * 360 / 12))
            }
            // the hours labels
            ZStack {
                ForEach(self.period == 1 ? ClockMarker.PMlabelSet() : ClockMarker.AMlabelSet(), id: \.self) { marker in
                    ClockLabelView(marker: marker,
                                   paddingValue: CGFloat(geometry.size.width * 0.8),
                                   options: self.options)
                        .position(CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                }
            }
        })
    }
    
    private func startTime() {
        setTheHour()
        setTheMinutes()
    }
    
    private func setTheMinutes() {
        let theMinute = Calendar.current.component(.minute, from: clockDate)
        // setup the sets with values
        var minuteSet1 = [Int]()
        var minuteSet2 = [Int]()
        var minuteSet3 = [Int]()
        for n in 0...20 {
            minuteSet1.append(n * 3)
            minuteSet2.append(n * 3 + 1)
            minuteSet3.append(n * 3 + 2)
        }
        // find which set the minute belongs to
        if let ndx = minuteSet1.firstIndex(of: theMinute) {
            minuteTapped(n: ndx, set: 1)
        }
        if let ndx = minuteSet2.firstIndex(of: theMinute) {
            minuteTapped(n: ndx, set: 2)
        }
        if let ndx = minuteSet3.firstIndex(of: theMinute) {
            minuteTapped(n: ndx, set: 3)
        }
    }
    
    private func setTheHour() {
        var theHour = Calendar.current.component(.hour, from: clockDate)
        // AM or PM
        period = theHour >= 12 ? 1 : 0
        if period == 1 {
            theHour = theHour == 12 ? 0 : theHour - 12
        }
        hourTapped(hour: theHour)
    }
    
    private func hourTapped(hour: Int) {
        let theHour = period == 1 ? hour+12 : hour
        let theMinutes = Calendar.current.component(.minute, from: clockDate)
        if let newDate = Calendar.current.date(bySettingHour: theHour, minute: theMinutes, second: 0, of: clockDate) {
            clockDate = newDate
        }
        // highlighting
        hourHighlight = Array(repeating: false, count: 12)
        hourHighlight[hour] = true
    }
    
    private func minuteTapped(n: Int, set: Int) {
        minuteSet1Highlight = Array(repeating: false, count: 20)
        minuteSet2Highlight = Array(repeating: false, count: 20)
        minuteSet3Highlight = Array(repeating: false, count: 20)
        var theMinutes = 0
        switch set {
        case 1:
            theMinutes = n * 3
            minuteSet1Highlight[n] = true
        case 2:
            theMinutes = n * 3 + 1
            minuteSet2Highlight[n] = true
        case 3:
            theMinutes = n * 3 + 2
            minuteSet3Highlight[n] = true
        default:
            break
        }
        let theHour = Calendar.current.component(.hour, from: clockDate)
        if let newDate = Calendar.current.date(bySettingHour: theHour, minute: theMinutes, second: 0, of: clockDate) {
            clockDate = newDate
        }
    }
    
}
