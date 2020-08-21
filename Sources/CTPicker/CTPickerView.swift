//
//  CTPickerView.swift
//  CTPicker_SwiftUI
//
//  Created by Stewart Lynch on 2020-01-06.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

public protocol CTPicker {
    func saveUpdates(_ newItem: String)
}

public struct CTPickerView: View {
    @Binding var presentPicker:Bool
    @Binding var pickerField:String
    var items:[String]
    var saveUpdates: ((String) -> Void)?
    var noSort:Bool?
    var ctpColors:CTPColors?
    var ctpStrings:CTPStrings?

    public init(presentPicker: Binding<Bool>, pickerField: Binding<String>, items:[String], saveUpdates: ((String) -> Void)? = nil, noSort:Bool? = false, ctpColors:CTPColors? = nil, ctpStrings: CTPStrings? = nil) {
        self._presentPicker = presentPicker
        self._pickerField = pickerField
        self.items = items
        self.noSort = noSort
        self.ctpColors = ctpColors
        self.ctpStrings = ctpStrings
        self.saveUpdates = saveUpdates
    }

    @State var filterString:String = ""
    @State private var filteredItems:[String] = []
    @State private var frameHeight:CGFloat = 400

    @State private var headerColors = CTPColors()
    @State private var pickerStrings = CTPStrings()

    public var body: some View {
        let filterBinding = Binding<String>(
            get: {
                self.filterString
        }, set: {
            self.filterString = $0
            if self.filterString != "" {
                self.filteredItems = self.items.filter{$0.lowercased().contains(self.filterString.lowercased())}
            } else {
                self.filteredItems = self.items
            }
            self.setHeight()
        })
        return  ZStack {
            Color.black.opacity(0.4)
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.presentPicker = false
                            }
                        }) {
                            Text(pickerStrings.cancelBtnTitle)
                        }.padding(10)
                        Spacer()
                        Group {
                        if saveUpdates != nil {
                            Button(action: {
                                if !self.items.contains(self.filterString) {
                                    self.saveUpdates!(self.filterString)
                                }
                                self.pickerField = self.filterString
                                withAnimation {
                                    self.presentPicker = false
                                }
                            }) {
                                Image(systemName: "plus.circle")
                                    .frame(width: 44, height: 44)
                            }
                            .disabled(filterString.isEmpty)
                        }
                        }
                    }.background(Color(headerColors.headerBackgroundColor))
                        .foregroundColor(Color(headerColors.headerTintColor))

                    Text((saveUpdates != nil) ? pickerStrings.addText : pickerStrings.pickText)
                        .font(.caption)
                        .padding(.horizontal,10)
                    TextField(pickerStrings.searchPlaceHolder, text: filterBinding)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()
                    List {
                        ForEach(noSort! ? filteredItems : filteredItems.sorted(), id: \.self) { item in
                            Button(action: {
                                self.pickerField = item
                                withAnimation {
                                    self.presentPicker = false
                                }
                            }) {
                                Text(item)
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
            if let ctString = self.ctpStrings {
                self.pickerStrings = ctString
            }
            if let ctColors = self.ctpColors {
                self.headerColors = ctColors
            }
            self.filteredItems = self.items
            self.setHeight()
        }
    }

    fileprivate func setHeight() {
        withAnimation  {
            if filteredItems.count > 5 {
                frameHeight = 400
            } else if filteredItems.count == 0 {
                frameHeight = 160
            } else {
                frameHeight = CGFloat(filteredItems.count * 45 + 160)
            }
        }
    }
}



