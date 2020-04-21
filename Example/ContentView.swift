//
//  ContentView.swift
//  ClockPicker
//
//  Created by Ringo Wathelet on 2019/11/19.
//  Copyright © 2019 Ringo Wathelet. All rights reserved.
//

import SwiftUI
import ClockTimePicker

struct ContentView: View {
 
    @State var date = Date()
    @State var showTime = false
    @ObservedObject var options = ClockLooks()
  
//    var body: some View {
//        NavigationView {
//            NavigationLink(destination: ClockPickerView(date: self.$date, options: self.options)) {
//                VStack {
//                    Text("Show time")
//                    Text(self.getDateString())
//                }
//            }
//        }.navigationViewStyle(StackNavigationViewStyle())
//         .onAppear(perform: loadOptions)
//    }
    
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
        .onAppear(perform: loadOptions)
    }

    func loadOptions() {
        
        // for no hands must adjust some sizes and colors
//        options.withHands = false
//        options.minuteDotMarkSize = CGFloat(30)
//        options.minuteDotMarkColor = .orange
//        options.hourDotMarkSize = CGFloat(46)
//        options.hourDotMarkColor = .blue
        
        // for clock with hands
        options.backgroundColor = .yellow
        options.hourTickMarkColor = .blue
        options.hourTickMarkWidth = CGFloat(10)
        options.hourDotMarkSize = CGFloat(46)
        options.hourDotMarkColor = .blue
        options.hourHandColor = .blue
        options.minuteHandColor = .blue
        options.labelColor = .black
        options.labelFont = Font.custom("Didot-Bold", size: 30)
        options.circleWidth = CGFloat(2)
        options.hourHandleColor = .blue
        options.minuteHandleColor = .blue
        options.centerBackgroundColor = .blue
        options.centerTextFont = Font.custom("Helvetica", size: 20)
        options.hourHandWidth = CGFloat(10)
        options.minuteHandWidth = CGFloat(8)
        options.handleSize = CGFloat(35)
        options.ampmTintColor = UIColor.blue
        options.impactFeedbackOn = true
  
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
