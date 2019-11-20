//
//  ContentView.swift
//  ClockPicker
//
//  Created by Ringo Wathelet on 2019/11/19.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State var date = Date()
    @State var showTime = false
    
    var body: some View {
        Group {
            Button(action: {self.showTime.toggle()} ) { Text("Show time") }
        }.sheet(isPresented: self.$showTime) {
            ClockPickerView(date: self.$date).onDisappear(perform: self.showMe)
        }
    }
    
    func showMe() {
        print("\n----> date: \(date)")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(date: Date())
    }
}
