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

Step 5 - Create

##### Step 2- ViewController Delegates 

The ViewControllers containing your UITextFields must conform to `UITextFieldDelegate` and to `CTPickerDelegate`

The conformance to CTPickerDelegate will require the addition of the `setTextField` delegate function.  See step 6 below.

```swift
    func setField(value: String, type:CTPickerType, selectedTextField: UITextField, new: Bool) {
        <#code#>
    }
```

##### Step 3 - Create an optional ctPickerDelegate variable

```swift
class ViewController: UIViewController, UITextFieldDelegate, CTPickerDelegate {
    // Required variable
    weak var cTDelegate:CTPickerDelegate?
```



##### Step 4 - Assign viewController to the cTDelegate variable

```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        // You can do this in viewDidLoad
        cTDelegate = self
    }
```

##### Step 5 - Create your UITextFields

In your ViewController, create your UITextFields either programmatically or using Interface Builder.  In each case, the assign the ViewController as the UITextField delegate.

```swift
// Must assign the text fields as the UITextFieldDelegates
    varietyTextField.delegate = self
    countryTextField.delegate = self
    wineryTextField.delegate = self
```

##### Step 6 - Implement textFieldDidBeginEditing

Now, when your users tap into the field you want to present the list of values.  The `CTPicker.presentCTPicker` function must be called within the `textFieldDidBeginEditing`: function which is a UITextField delegate function.

No matter what optional style values you choose, you **always** pass `self` as the first parameter and `textField` as the second one.

The third parameter is the array of strings.  In the example shown, I am passing `varietyArray`, `countryArray` and `wineryArray`.

The remaining parameters (except for the last one) are optional and used if you wish to custom style the navigation bar on the picker and the tint color of the action buttons for the 'add' alert or if you wish to have your own custom strings used.  You can choose to include any number of these optional parameters, or none at all.  See the **Optional parameters** section below for more detail.

The final parameter, `isAddEnabled`, defaults to **false**, which means the array is **Read Only**.  If you wish to allow your users to add to the list of options, include `isAddEnabled: true` as the final parameter.

Here is an example.

```swift
func textFieldDidBeginEditing(_ textField: UITextField) {
  // Dismiss the keyboard immediately
  textField.resignFirstResponder() 
  // Depending on the type of field tapped, pass the viewController, the textField and current array of strings to the presentPickerFunction along with any of the optional parameters
  switch textField {
  case varietyTextField:
      // Default presentation - no adding of items to the array
      CTPicker.presentCTPicker(on: self,
                    textField: textField,
                    items: varietyArray)
  case countryTextField:
      // Default presentation - but ability to add items to the array
      CTPicker.presentCTPicker(on: self,
                    textField: textField,
                    items: countryArray,
                    isAddEnabled: true)
  case wineryTextField:
    // Default presentation - but ability to add items to the array
      CTPicker.presentCTPicker(on: self,
                    textField: textField,
                    items: wineryArray,
                    isAddEnabled: true)
  default:
      break
  }
}
```

##### Step 6 - Handle the selected or added item

Once an item is selected or handled, you must deal with it using the delegate function.

```swift
func setField(value: String, selectedTextField: UITextField, new: Bool) {
  // Assign the selected or new value to the textField
  selectedTextField.text = value
  // if the value is an addition to the array, then you need to append it and update the  datasource if necessary.
  if new {
      switch selectedTextField {
      case countryTextField:
          countryArray.append(value)
      case wineryTextField:
          wineryArray.append(value)
      default:
          break
      }     
  }
}
```

### Optional Parameters

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
