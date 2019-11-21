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
    
    @Published var backgroundColor: Color = Color.clear
    
    @Published var circleColor: Color = Color.blue
    @Published var circleWidth: CGFloat = CGFloat(2)
    
    @Published var tickMarkColor: Color = Color.primary
    @Published var tickMarkWidth: CGFloat = CGFloat(3)
    
    @Published var labelColor: Color = Color.primary
    @Published var labelFont: Font = Font.custom("Didot-Bold", size: 30)
    // other fonts: "BodoniSvtyTwoITCTT-BookIta" "Zapfino" "SnellRoundhand-Bold" "BradleyHandITCTT-Bold"
    
    @Published var hourHandleColor: Color = Color.green
    @Published var hourHandleRimColor: Color = Color.primary
    @Published var minuteHandleColor: Color = Color.green
    @Published var minuteHandleRimColor: Color = Color.primary
    @Published var handleRimWidth: CGFloat = CGFloat(4)
    @Published var handleSize: CGFloat = CGFloat(30)

    @Published var hourHandColor: Color = Color.primary
    @Published var minuteHandColor: Color = Color.secondary
    
    @Published var hourHandWidth: CGFloat = CGFloat(8)
    @Published var minuteHandWidth: CGFloat = CGFloat(4)
    
    @Published var hourRatio: CGFloat = 0.6
    @Published var minuteRatio: CGFloat = 0.92

    @Published var centerTextFont: Font = Font.custom("Helvetica", size: 20)
    @Published var centerBackgroundColor: Color = Color.green
    @Published var centerForegroundColor: Color = Color(UIColor.systemBackground)
    
    @Published var ampmSelectedColor: UIColor = UIColor.white
    @Published var ampmNormalColor: UIColor = UIColor.blue
    @Published var ampmTintColor: UIColor = UIColor.blue
    
}
