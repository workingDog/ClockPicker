//
//  ClockHand.swift
//  Clock
//
//  Created by Ringo Wathelet on 2019/11/18.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import SwiftUI


struct ClockHand: View {
    
    @Binding var clockDate: Date    // the date
    let handType: HandType          // hour or minute
    @Binding var period: Int

    @State private var prev = CGPoint.zero
    @State private var pos = CGPoint.zero
    @State private var handlePos = CGPoint.zero
    @State private var handleSize = CGFloat(35)
    

    var body: some View {
        
        let drag = DragGesture()
            .onChanged { value in
                self.pos = CGPoint(x: value.translation.width + self.prev.x, y: value.translation.height + self.prev.y)
        }
        .onEnded { value in
            self.pos = CGPoint(x: value.translation.width + self.prev.x, y: value.translation.height + self.prev.y)
            self.prev = self.pos
        }
        
        return GeometryReader { geometry in
            Path { path in
                let center = self.getCenter(of: geometry.size)
                let w = 0.08 * min(geometry.size.width, geometry.size.height)
                path.addRoundedRect(in: CGRect(x: center.x-w, y: center.y-w/2, width: w*2, height: w), cornerSize: CGSize(width: w/2, height: w/2))
            }.fill(self.handType.color)
            
            Path { path in
                let center = self.getCenter(of: geometry.size)
                path.move(to: center)
                let length = self.handType.ratio * self.getRadius(geometry.size)
                let theTip = self.getNewPoint(center, length)
                let handlePoint = self.getNewPoint(center, length-(length * 0.3))
                path.addLine(to: theTip)
                // tricky business
                DispatchQueue.main.async {
                    self.updateTime(center)
                    self.handlePos = handlePoint
                }
            }.stroke(style: StrokeStyle(lineWidth: self.handType.width, lineCap: .round))
            .fill(self.handType.color)
            .onAppear(perform: { self.startHandPos(geometry) })

            // the dragging handle
            self.dragHandle.position(self.handlePos).gesture(drag)
        }
    }
    
    var dragHandle: some View {
        return ZStack {
            Circle().overlay(
                Circle().stroke(Color.primary, lineWidth: 4)
            ).foregroundColor(Color.green)
            .frame(width: handleSize, height: handleSize)
        }
    }
    
    func startHandPos(_ geom: GeometryProxy) {
        let center = getCenter(of: geom.size)
        prev = CGPoint.zero
        // give the hand the start position
        switch handType {
            case .hour: pos = getDatePos(geom)
            case .minute: pos = getDatePos(geom)
        }
        updateTime(center)
        prev = pos
    }
    
    private func updateTime(_ center: CGPoint) {
        if prev != pos {
            let deg = getAngleRad(center) * 180 / .pi
            switch handType {
                case .hour: updateClockHour(deg)
                case .minute: updateClockMinute(deg)
            }
        }
    }
    
    func updateClockHour(_ angleDeg: Float) {
        // normalise to 0-360
        let theAngle = normalise(angleDeg)
        // 1 hour is 30 deg
        let timeValue = theAngle/30
        var hourValue = Int((timeValue+0.5).rounded(.down))
        // adjust for 12 oclock
        if hourValue == 0 { hourValue = 12 }
        if period == 1 {
            hourValue = hourValue + 12
            if hourValue == 12 { hourValue = 0 }
        }
        if hourValue == 24 { hourValue = 0 }
        let theMinutes = Calendar.current.component(.minute, from: clockDate)
        // update the clocktime
        if let newDate = Calendar.current.date(bySettingHour: hourValue, minute: theMinutes, second: 0, of: clockDate) {
            clockDate = newDate
        }
    }
    
    private func updateClockMinute(_ angleDeg: Float) {
        // normalise to 0-360
        let theAngle = normalise(angleDeg)
        // 1 minute is 6 deg
        let timeValue = theAngle/6
        var minuteValue = Int((timeValue+0.5).rounded(.down))
        // adjust for 12 oclock
        if minuteValue == 60 { minuteValue = 0 }
        let theHours = Calendar.current.component(.hour, from: clockDate)
        // update the clocktime
        if let newDate = Calendar.current.date(bySettingHour: theHours, minute: minuteValue, second: 0, of: clockDate) {
            clockDate = newDate
        }
    }

    private func getNewPoint(_ center: CGPoint, _ length: CGFloat) -> CGPoint {
        let newAngle = CGFloat(getAngleRad(center))
        let x = center.x + length * cos(newAngle)
        let y = center.y + length * sin(newAngle)
        return CGPoint(x: x, y: y)
    }
    
    // the drag angle in radians given the gesture position
    private func getAngleRad(_ center: CGPoint) -> Float {
        let dx = Float(pos.x - center.x)
        let dy = Float(pos.y - center.y)
        return atan2f(dy, dx)
    }

    private func getDatePos(_ geom: GeometryProxy) -> CGPoint {
        let midDay = Calendar.current.startOfDay(for: clockDate).addingTimeInterval(12*60)
        if clockDate > midDay {
            period = 1
        }
        let c = getCenter(of: geom.size)
        let degInc: Float = handType == .hour ? 30 : 6
        var value = Calendar.current.component(.hour, from: clockDate)
        if handType == .minute {
            value = Calendar.current.component(.minute, from: clockDate) 
        }
        let angleDeg = 180 - (Float(value) * degInc)
        let angleRad = Double(angleDeg) * Double.pi / 180
        let r = getRadius(geom.size)
        let x = Double(c.x) + Double(r) * sin(angleRad)
        let y = Double(c.y) + Double(r) * cos(angleRad)
        return CGPoint(x: x, y: y)
    }

    private func normalise(_ angleDeg: Float) -> Float {
        // to have 12 oclock as zero degrees
        let angl = angleDeg + 90
        // 0-360 degrees
        return ((angl.truncatingRemainder(dividingBy: 360)) + 360).truncatingRemainder(dividingBy: 360)
    }
    
    private func getCenter(of size: CGSize) -> CGPoint {
        return CGPoint(x: size.width / 2, y: size.height / 2)
    }
    
    private func getRadius(_ size: CGSize) -> CGFloat {
        return min(size.width, size.height) / 2
    }
    
}

// --------------------------------------------------------------------

enum HandType {
    
    case hour
    case minute
    
    var color: Color {
        switch self {
            case .hour: return .primary
            case .minute: return .secondary
        }
    }
    
    var ratio: CGFloat {
        if self == .hour {
            return 0.6
        } else {
            return 0.92
        }
    }
    
    var width: CGFloat {
        switch self {
            case .hour: return 8
            case .minute: return 4
        }
    }
    
}

