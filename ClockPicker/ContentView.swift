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
    
    @ObservedObject var options = ClockLooks()
    
    var body: some View {
        Group {
            Button(action: {self.showTime.toggle()} ) {
                VStack {
                    Text("Show time")
                    Text(self.getDateString())
                }
            }
        }.sheet(isPresented: self.$showTime) {
            ClockPickerView(date: self.$date, options: self.options)
        }
        .onAppear(perform: loadData)
    }

    func loadData() {
        options.backgroundColor = .yellow
        options.tickMarkColor = .blue
        options.hourHandColor = .blue
        options.minuteHandColor = .blue
        options.labelColor = .black
        options.labelFont = Font.custom("Didot-Bold", size: 30)
        options.circleWidth = CGFloat(20)
        options.hourHandleColor = .blue
        options.minuteHandleColor = .blue
        options.centerBackgroundColor = .blue
        options.centerTextFont = Font.custom("Helvetica", size: 20)
        options.hourHandWidth = CGFloat(10)
        options.minuteHandWidth = CGFloat(8)
        options.handleSize = CGFloat(35)
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
