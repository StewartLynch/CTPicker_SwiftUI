//
//  CTPickerView.swift
//  CTPicker_SwiftUI
//
//  Created by Stewart Lynch on 2020-01-06.
//  Updated by Florian Schweizer on 2021-11-26.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

public struct CTPickerView: View {
    public typealias OptionalStringToVoid = ((String) -> Void)?
    
    @Binding var presentPicker: Bool
    @Binding var pickerField: String
    
    @State private var text: String = ""
    @State private var filteredItems: [String] = []
    @State private var frameHeight: CGFloat = 400
    
    private var items: [String]
    private var onSaveUpdates: OptionalStringToVoid
    private var noSort: Bool?
    private var ctpColors: CTPColors?
    private var ctpStrings: CTPStrings?

    public init(
        presentPicker: Binding<Bool>,
        pickerField: Binding<String>,
        items: [String],
        noSort: Bool? = false,
        ctpColors: CTPColors? = nil,
        ctpStrings: CTPStrings? = nil,
        onSaveUpdates: OptionalStringToVoid = nil
    ) {
        self._presentPicker = presentPicker
        self._pickerField = pickerField
        self.items = items
        self.noSort = noSort
        self.ctpColors = ctpColors
        self.ctpStrings = ctpStrings
        self.onSaveUpdates = onSaveUpdates
    }
    
    private var filterBinding: Binding<String> {
        Binding<String>(
            get: {
                text
            }, set: {
                text = $0
                
                if text.isEmpty {
                    filteredItems = items
                } else {
                    filteredItems = items.filter {
                        $0.lowercased().contains(text.lowercased())
                    }
                }
                
                setHeight()
            }
        )
    }

    public var body: some View {
        ZStack {
            Color.black.opacity(0.4)
            
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Button(CTPStrings.cancelButtonTitle) {
                            withAnimation {
                                presentPicker = false
                            }
                        }
                        .padding(10)
                        
                        Spacer()
                        
                        Group {
                            if onSaveUpdates != nil {
                                Button(action: {
                                    if !items.contains(text) {
                                        onSaveUpdates!(text)
                                    }
                                    pickerField = text
                                    withAnimation {
                                        presentPicker = false
                                    }
                                }) {
                                    Image(systemName: "plus.circle")
                                        .frame(width: 44, height: 44)
                                }
                                .disabled(text.isEmpty)
                            }
                        }
                    }
                    .background(Color(CTPColors.headerBackgroundColor))
                    .foregroundColor(Color(CTPColors.headerTintColor))

                    Text((onSaveUpdates != nil) ? CTPStrings.addText : CTPStrings.pickText)
                        .font(.caption)
                        .padding(.horizontal, 10)
                    
                    TextField(CTPStrings.searchPlaceHolder, text: filterBinding)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()
                    
                    List {
                        ForEach(noSort! ? filteredItems : filteredItems.sorted(), id: \.self) { item in
                            Button(item) {
                                pickerField = item
                                withAnimation {
                                    presentPicker = false
                                }
                            }
                        }
                    }
                }
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .frame(maxWidth: 400)
                .padding(.horizontal,20)
                .frame(height: frameHeight)
                
                Spacer()
            }
            .padding(.top, 40)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            filteredItems = items
            setHeight()
        }
    }

    fileprivate func setHeight() {
        withAnimation  {
            if filteredItems.isEmpty {
                frameHeight = 160
            } else if filteredItems.count > 5 {
                frameHeight = 400
            } else {
                frameHeight = CGFloat(filteredItems.count * 45 + 160)
            }
        }
    }
}



