//
//  CTPickerTextView.swift
//  CTPicker_SwiftUI
//
//  Created by Stewart Lynch on 2020-08-19.
//  Updated by Florian Schweizer on 2021-11-26.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

public struct CTPickerTextView: View {
    @Binding var presentPicker: Bool
    @Binding var text: String
    var placeholder: String
    @Binding var tag: Int
    var selectedTag: Int

    public init(
        presentPicker: Binding<Bool>,
        text: Binding<String>,
        placeholder:String,
        tag: Binding<Int>,
        selectedTag: Int
    ) {
        self._presentPicker = presentPicker
        self._text = text
        self.placeholder = placeholder
        self._tag = tag
        self.selectedTag = selectedTag
    }

    public var body: some View {
        TextField(placeholder, text: $text)
            .disabled(true)
            .overlay(
                Button {
                    tag = selectedTag
                    
                    withAnimation {
                        presentPicker = true
                    }
                } label: {
                    Rectangle().foregroundColor(Color.clear)
                }
            )
    }
}
