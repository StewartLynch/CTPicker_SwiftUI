//
//  CTPOptionals.swift
//  CTPicker_SwiftUI
//
//  Created by Stewart Lynch on 2020-01-07.
//  Updated by Florian Schweizer on 2021-11-26.
//  Updated by Stewart Lynch on 2021-12-02.
//  Copyright © 2021 CreaTECH Solutions. All rights reserved.
//

import UIKit

public struct CTPColors {
    // Default values
    var headerBackgroundColor: UIColor
    var headerTintColor: UIColor
    
    public init(headerBackgroundColor:UIColor = UIColor.darkGray, headerTintColor: UIColor = UIColor.white) {
        self.headerBackgroundColor  = headerBackgroundColor
        self.headerTintColor = headerTintColor
    }
}

public struct CTPStrings {
    // Default values
    var pickText: String
    var addText: String
    var searchPlaceHolder: String
    var cancelBtnTitle: String
    
    public init(pickText: String = "Filter list then tap entry to select.",
                addText: String = "Filter list then tap entry to select, or type new entry then '+' to add.",
                searchPlaceHolder: String = "Filter by entering text...",
                cancelBtnTitle: String =  "Cancel") {
        self.pickText = pickText
        self.addText = addText
        self.searchPlaceHolder = searchPlaceHolder
        self.cancelBtnTitle = cancelBtnTitle
    }
}
