//
//  CTPOptionals.swift
//  CTPicker_SwiftUI_Master
//
//  Created by Stewart Lynch on 2020-01-07.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import UIKit

public struct CTPColors {
    // Default values
    var headerBackgroundColor: UIColor
    var headerTintColor: UIColor
    
    public init(headerBackgroundColor:UIColor, headerTintColor: UIColor) {
        self.headerBackgroundColor = UIColor.darkGray
        self.headerTintColor = UIColor.white
    }
}

public struct CTPStrings {
    // Default values
    var pickText: String
    var addText: String
    var noItemText: String
    var searchPlaceHolder: String
    var newEntry: String
    var cancelBtnTitle: String
    
    public init(pickText: String, addText: String, noItemText: String, searchPlaceHolder: String, newEntry: String, cancelBtnTitle: String) {
        self.pickText = "Tap an entry to select it, or type in new entry."
        self.addText = "Type new entry then tap '+' button to add new entry"
        self.noItemText = "No items match"
        self.searchPlaceHolder = "Filter by entering text..."
        self.newEntry = "New Entry"
        self.cancelBtnTitle =  "Cancel"
    }
}


