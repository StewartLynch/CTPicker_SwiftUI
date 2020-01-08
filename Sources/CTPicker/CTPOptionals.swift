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
    
    public init(headerBackgroundColor:UIColor = UIColor.darkGray, headerTintColor: UIColor = UIColor.white) {
        self.headerBackgroundColor  = headerTintColor
        self.headerTintColor = headerTintColor
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
    
    public init(pickText: String = "Tap an entry to select it, or type in new entry.",
                addText: String = "Type new entry then tap '+' button to add new entry",
                noItemText: String = "No items match",
                searchPlaceHolder: String = "Filter by entering text...",
                newEntry: String = "New Entry",
                cancelBtnTitle: String =  "Cancel") {
        self.pickText = pickText
        self.addText = addText
        self.noItemText = noItemText
        self.searchPlaceHolder = searchPlaceHolder
        self.newEntry = newEntry
        self.cancelBtnTitle = cancelBtnTitle
    }
}


