//
//  ClockTextView.swift
//  ClockPicker
//
//  Created by Ringo Wathelet on 2019/11/18.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import SwiftUI

struct ClockLabelView: View {
    
    let marker: ClockMarker
    let paddingValue: CGFloat
    
    @ObservedObject var options = ClockLooks()
    
    var body: some View {
        VStack {
            Text(marker.label)
                .foregroundColor(options.labelColor)
                .font(options.labelFont)
                .rotationEffect(Angle(degrees: -self.marker.degrees))
                .padding(.bottom, paddingValue)
        }.rotationEffect(Angle(degrees: marker.degrees))
    }

}
