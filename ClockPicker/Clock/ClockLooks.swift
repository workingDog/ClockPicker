//
//  ClockLooks.swift
//  ClockPicker
//
//  Created by Ringo Wathelet on 2019/11/21.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ClockLooks : ObservableObject {
    
    // clock type
    @Published var withHands: Bool = true

    // clock face
    @Published var backgroundColor: Color = Color.clear
    // outer rim circle
    @Published var circleColor: Color = Color.primary
    @Published var circleWidth: CGFloat = CGFloat(2)
    
    // hour labels
    @Published var labelColor: Color = Color.primary
    @Published var labelFont: Font = Font.custom("Didot-Bold", size: 30)
 
    // hours tick marks
    @Published var hourTickMarkColor: Color = Color.primary
    @Published var hourTickMarkWidth: CGFloat = CGFloat(4)
    
    // used in both clock with and without hands
    @Published var minuteDotMarkColor: Color = Color.primary
    @Published var minuteDotMarkSize: CGFloat = CGFloat(10)
    
    // for no hands clock
    @Published var hourDotMarkSize: CGFloat = CGFloat(22)
    @Published var hourDotMarkColor: Color = Color.primary

    // drag handles 
    @Published var hourHandleColor: Color = Color.green
    @Published var hourHandleRimColor: Color = Color.primary
    @Published var minuteHandleColor: Color = Color.green
    @Published var minuteHandleRimColor: Color = Color.primary
    @Published var handleRimWidth: CGFloat = CGFloat(4)
    @Published var handleSize: CGFloat = CGFloat(30)
 
    // hands
    @Published var hourHandColor: Color = Color.primary
    @Published var minuteHandColor: Color = Color.secondary
    @Published var hourHandWidth: CGFloat = CGFloat(8)
    @Published var minuteHandWidth: CGFloat = CGFloat(4)
    // length of the hands as a proportion of the clock size
    @Published var hourRatio: CGFloat = 0.6
    @Published var minuteRatio: CGFloat = 0.92

    // the text showing the hour and minutes at the center of the clock
    @Published var centerTextFont: Font = Font.custom("Helvetica", size: 20)
    @Published var centerBackgroundColor: Color = Color.primary
    @Published var centerForegroundColor: Color = Color(UIColor.systemBackground)
    
    // AM:PM
    @Published var ampmSelectedColor: UIColor = UIColor.white
    @Published var ampmNormalColor: UIColor = UIColor.black
    @Published var ampmTintColor: UIColor = UIColor.black
    // x and y offset from clock center, of the AM:PM picker as the proportion of the clock size
    @Published var ampmPickerXoffset = CGFloat(0.0)
    @Published var ampmPickerYoffset = CGFloat(0.06)

    @Published var impactFeedbackOn: Bool = false
    
}
