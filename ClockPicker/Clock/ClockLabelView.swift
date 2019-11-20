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
    
    var body: some View {
        VStack {
            Text(marker.label)
                .font(Font.custom("BradleyHandITCTT-Bold", size: 40))
                .rotationEffect(Angle(degrees: -self.marker.degrees))
                .padding(.bottom, paddingValue)
        }.rotationEffect(Angle(degrees: marker.degrees))
    }
    
    // other nice fonts
    // "BodoniSvtyTwoITCTT-BookIta"
    // "Zapfino"
    // "SnellRoundhand-Bold"
    
}
