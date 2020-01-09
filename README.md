# CTPicker_SwiftUI
[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)[![](http://img.shields.io/badge/language-Swift-brightgreen.svg?color=orange)](https://developer.apple.com/swift)![](https://img.shields.io/github/tag/stewartlynch/CTPicker_SwiftUI?style=flat))![](https://img.shields.io/github/last-commit/StewartLynch/CTPicker_SwiftUI)

### What is this?

If you wish to limit your user to picking from an array of strings, then one of the SwiftUI Pickers may meet your needs.  However, as the number of entries grow, these controls may not be very efficient.  With `CTPicker`  I present the user with a list of all options but with a filter text field that will filter as you type to zoom in on the preferred value.  If the value is not available, there is also the optional "add" button to allow your users to add to the data source.

### Requirements
- iOS 13.0+
- Xcode 11.0+
- SwiftUI
### YouTube Video

Watch this video to see installation and use as described below.

Coming soon

The best way to explain how to implement CTPicker is to work through an example  of how to add CTPicker to a view containing a single TextField.  The example is a TextField that asks the user to enter a food item.

```swift
struct ContentView: View {
    @State private var food:String = ""
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter food", text: $food)
                Spacer()
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 200)
            .navigationBarTitle("CTPicker Demo")
        }
    }
}
```

### Installation

1. From within Xcode 11 or later, choose **File > Swift Packages > Add Package Dependency**
2. At the next screen enter https://github.com/StewartLynch/CTPicker_SwiftUI when asked to choose a Package repository
3. Choose the latest available version.
4. Add the package to your target.

You now have the dependency installed and are ready to import CTPicker

### Set up

Setting up to use this solution on one or more of your TextFields is fairly straight forward.

##### Step 1 - Import CTPicker

In the View where you are going to implement `CTPicker` on your TextFields, import CTPicker.

```swift
import CTPicker
```

##### Step 2 - Create initial presentation @State variable

The next step is to create the presentation boolean that when set to true, will present the picker.  The initial value is set to false

```swift
@State private var presentPicker:Bool = false
```

##### Step 3 - Create String Arrays @State variables if necessary

When presenting CTPicker, you will be asked to pass in the array of strings and this array will be bound to a @Binding variable in CTPicker so that if you add to the array, it will be updated in your content view as well. (See saving data below). 

You can pass in any array of strings,  but to continue on with this example, I will just create it within the existing view

```swift
@State private var foodArray = ["Milk", "Apples", "Sugar", "Eggs"]
```

##### Step 4 - Enclose exsiting view in a ZStack

The CTPickerVew is a view that will be presented on top of the exsiting view.  To allow this, we need to surround the existing view including the navigationView if one exists within a ZStack

### ![ZStack](ReadMeImages/ZStack.gif)

##### Step 5  - Conditionally Present the CTPicker

You can now add as the second item in the ZStack, a conditional presentation of the CTPickerView.  The condition will be whenver our `presentPicker` boolean value is set to `true`.  

The CTPickerView by default requires 3 parameters which are the 3 state variables:

- the presentation boolean -  `$presentPicker`
- the textField state variable - `$food`
- The string array - `$foodArray`

```swift
 if presentPicker {
    CTPickerView(presentPicker: $presentPicker,
                 pickerField: $food,
                 items: $foodArray)
}
```

##### Step 6 - Disable Entry into the TextField and add TapGesture

To present the picker, we must first disable entry into the TextField  (`.disabled(true)`) and subsequently add an `.onTapGesture` to the TextField.

```swift
TextField("Enter food", text: $food).disabled(true)
    .onTapGesture {
            
}
```

##### Step 7 - Set the presentation state variable to true

WIthin the onTapGesture closure block we can set the presentPicker variable to true.  To make the presentation more visual, we can do this within a `withAnimation` block.

```swift
withAnimation {
   self.presentPicker = true
}
```
The final result looks like this:

![Basic](ReadMeImages/Basic.png)

If you run your app now, you will find that this is indeed a functional picker.  However, we have not yet added the ability to add items.

##### Step 8 - Enabling Adding of Items

To add items, you first need to create a function that will get executed when the picker closes.  This function accepts one parameter, a string that will be the item added.

**Note:** Since the array being passed to the CTPickerView is bound, it will be updated, but you may wish to capture that value and update your back end data store in a way that requires the actual entry.  You may, or may not need this data, but the update function requires it.  It of course, can be ignored.

Create a function like this:

Optional Parameters

As mentioned above there are additional optional parameters that you can pass to the `presentCTPicker` function.  

##### Custom Strings

The first allows you to pass a set of string values that will override  the default set used on the CTPicker navigation bar and on the add new item alert.  To create these strings, first declare an instance of the CTPicker.CTStrings class and enter your custom strings.  If you do not use this option, the default values shown will be used.

```swift
  let ctStrings = CTPicker.CTStrings(pickText: "Tap on a line to select.",
                                     addText: "Tap '+' to add a new entry.",
                                     searchPlaceHolder: "Filter by entering text...",
                                     addAlertTitle: "Add new item",
                                     addBtnTitle: "Add",
                                     cancelBtnTitle: "Cancel")
```

Once you have declared your CTStrings object, you can pass it on to the function as the 4th parameter.
```swift
CTPicker.presentCTPicker(on: self,
                    textField: textField,
                    items: wineryArray,
                    ctStrings: ctStrings,
                    isAddEnabled: true)
```

##### Custom Colors

The final 3 parameters are custom colors that you can pass to the function that will override the default colors used on the CTPicker navigation bar and on the add new item alert.

**Note:** The default colors support **dark mode** if you are using CTPicker on a device running iOS 13 or later.  If you are going to customize the colors, ensure that you include dark mode supported color sets.

These three colors are:

- **navBarBarTintColor** - the background color of the navigation bar
- **navBarTintColor** - the navigation bar button colors
- **actionTintColor** - the alert button colors

To pass these on to the function, you can add these as the 5th, 6th and 7th parameters.  Each one is optional so you may choose to leave one or more out.

Here is an example of a `CTPicker.presentCTPicker` call using all options.
```swift
 let ctStrings = CTPicker.CTStrings(pickText: "Lorem ipsum dolor sit amet.",
                                    addText: "Consectetur adipiscing elit.",
                                    searchPlaceHolder: "Vivamus ut dignissim dui...",
                                    addAlertTitle: "Excepteur sint occaecat",
                                    addBtnTitle: "Anim",
                                    cancelBtnTitle: "Sund")
 CTPicker.presentCTPicker(on: self,
                          textField: textField,
                          items: wineryArray,
                          ctStrings: ctStrings,
                          navBarBarTintColor: .red,
                          navBarTintColor: .white,
                          actionTintColor: .purple,
                          isAddEnabled: true)
```
