//
//  CTPickerTextView.swift
//  CTPicker_SwiftUI
//
//  Created by Stewart Lynch on 2020-08-19.
//  Updated by Florian Schweizer on 2021-11-26.
//  Updated by Stewart Lynch on 2021-12-02.
//  Copyright © 2021 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

public struct CTPickerTextView: View {
    @Binding var presentPicker: Bool
    @Binding var fieldString: String
    var placeholder: String
    @Binding var tag: Int
    var selectedTag: Int
    public init(
        presentPicker: Binding<Bool>,
        fieldString: Binding<String>,
        placeholder: String,
        tag: Binding<Int>,
        selectedTag: Int
    ) {
        self._presentPicker = presentPicker
        self._fieldString = fieldString
        self.placeholder = placeholder
        self._tag = tag
        self.selectedTag = selectedTag
    }

    public var body: some View {
        TextField(placeholder, text: $fieldString)
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
