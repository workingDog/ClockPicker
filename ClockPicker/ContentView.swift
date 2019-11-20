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
            Button(action: {self.showTime.toggle()} ) {
                VStack {
                    Text("Show time")
                    Text(self.getDateString())
                }
            }
        }.sheet(isPresented: self.$showTime) {
            ClockPickerView(date: self.$date)
        }
    }
    
    func getDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd h:mm a "
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        return formatter.string(from: date)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(date: Date())
    }
}
