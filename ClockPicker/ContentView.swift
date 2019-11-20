//
//  ContentView.swift
//  ClockPicker
//
//  Created by Ringo Wathelet on 2019/11/19.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var timeObject = ClockTime(date: Date())
    
    var body: some View {
        ClockPickerView(clockTime: timeObject)
    }
 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
