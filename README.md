
# SwiftUI Clock Time Picker


 ![im01](picture1.png) 


**ClockPicker** is a SwiftUI view that displays a clock with the hours and minutes hands.
These hands can be dragged around the clock face to select the desired hour and minutes of your date.

Can be used in ios and mac catalyst applications.

The main elements are **ClockPickerView.swift** and **ClockTime.swift**, see the demo in **ContenView.swift** for how to use it in your code.

The key to using this *ClockPickerView* in your code is to create a *ClockTime* such as:

    @ObservedObject var timeObject = ClockTime(date: Date())

and pass it to the *ClockPickerView* as shown in *ContenView.swift*,

    ClockPickerView(clockTime: timeObject)
    
As the clock hands are changed, the selected time can be obtain from the *ClockTime* object.

That's it, very simple.
    
