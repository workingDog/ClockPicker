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
    @Published public var withHands: Bool = true

    // clock face
    @Published public var backgroundColor: Color = Color.clear
//    @Published public var backgroundGradient = RadialGradient(gradient: Gradient(colors: [.pink, .purple]), center: .center, startRadius: 0, endRadius: 800)
//    @Published public var backgroundGradient = LinearGradient(gradient: Gradient(colors: [.clear]), startPoint: .leading, endPoint: .trailing)
    // outer rim circle
    @Published public var circleColor: Color = Color.primary
    @Published public var circleWidth: CGFloat = CGFloat(2)
    
    // hour labels
    @Published public var labelColor: Color = Color.primary
    @Published public var labelFont: Font = Font.custom("Didot-Bold", size: 30)
 
    // hours tick marks
    @Published public var hourTickMarkColor: Color = Color.primary
    @Published public var hourTickMarkWidth: CGFloat = CGFloat(4)
    
    // used in both clock with and without hands
    @Published public var minuteDotMarkColor: Color = Color.primary
    @Published public var minuteDotMarkSize: CGFloat = CGFloat(10)
    
    // for no hands clock
    @Published public var hourDotMarkSize: CGFloat = CGFloat(22)
    @Published public var hourDotMarkColor: Color = Color.primary

    // drag handles 
    @Published public var hourHandleColor: Color = Color.green
    @Published public var hourHandleRimColor: Color = Color.primary
    @Published public var minuteHandleColor: Color = Color.green
    @Published public var minuteHandleRimColor: Color = Color.primary
    @Published public var handleRimWidth: CGFloat = CGFloat(4)
    @Published public var handleSize: CGFloat = CGFloat(30)
 
    // hands
    @Published public var hourHandColor: Color = Color.primary
    @Published public var minuteHandColor: Color = Color.secondary
    @Published public var hourHandWidth: CGFloat = CGFloat(8)
    @Published public var minuteHandWidth: CGFloat = CGFloat(4)
    // length of the hands as a proportion of the clock size
    @Published public var hourRatio: CGFloat = 0.6
    @Published public var minuteRatio: CGFloat = 0.92

    // the text showing the hour and minutes at the center of the clock
    @Published public var centerTextFont: Font = Font.custom("Helvetica", size: 20)
    @Published public var centerBackgroundColor: Color = Color.primary
    @Published public var centerForegroundColor: Color = Color(UIColor.systemBackground)
    
    // AM:PM
    @Published public var ampmSelectedColor: UIColor = UIColor.white
    @Published public var ampmNormalColor: UIColor = UIColor.black
    @Published public var ampmTintColor: UIColor = UIColor.black
    // x and y offset from clock center, of the AM:PM picker as the proportion of the clock size
    @Published public var ampmPickerXoffset = CGFloat(0.0)
    @Published public var ampmPickerYoffset = CGFloat(0.06)

    @Published public var impactFeedbackOn: Bool = false
    
}
