//
//  ClockFace.swift
//  ClockPicker
//
//  Created by Ringo Wathelet on 2019/11/18.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import SwiftUI

struct ClockFace: View {
    
    @Binding var period: Int
    @ObservedObject var options = ClockLooks()
    
    var body: some View {
        GeometryReader { geometry in
            
            // the minutes dot marks
            ForEach(0..<60) { n in
                ZStack {
                    Circle().overlay(
                        Circle().stroke(self.options.minuteDotMarkColor, lineWidth: 1)
                    ).foregroundColor(self.options.minuteDotMarkColor)
                        .frame(width: self.options.minuteDotMarkSize, height: self.options.minuteDotMarkSize)
                    .position(CGPoint(x: geometry.size.width / 2, y: self.options.minuteDotMarkSize))
                }
                .rotationEffect(Angle(degrees: Double(n) * 360 / 60))
            }
            
            // the hour tick marks
            ForEach(0..<12) { n in
                Path { path in
                    path.move(to: CGPoint(x: geometry.size.width / 2, y: 0))
                    path.addLine(to: CGPoint(x: geometry.size.width / 2, y: 0.05 * geometry.size.height))
                }
                .stroke(self.options.hourTickMarkColor, lineWidth: self.options.hourTickMarkWidth)
                .rotationEffect(Angle(degrees: Double(n) * 360 / 12))
            }
            
            // the hour labels
            ZStack {
                 ForEach(self.period == 1 ? ClockMarker.PMlabelSet() : ClockMarker.AMlabelSet(), id: \.self) { marker in
                    ClockLabelView(marker: marker, paddingValue: CGFloat(geometry.size.width * 0.80), options: self.options)
                        .position(CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                }
            }

        }
    }

}
