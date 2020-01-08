//
//  CTPickerView.swift
//  CTPicker_SwiftUI
//
//  Created by Stewart Lynch on 2020-01-06.
//  Copyright © 2020 CreaTECH Solutions. All rights reserved.
//

import SwiftUI

public struct CTPickerView: View {
    @Binding var presentPicker:Bool
    @Binding var pickerField:String
    @Binding var items:[String]
    var ctpColors:CTPColors?
    var ctpStrings:CTPStrings?
    var saveUpdates: (() -> Void)?
    
    public init(presentPicker: Binding<Bool>, pickerField: Binding<String>, items: Binding<[String]>, ctpColors:CTPColors? = nil, ctpStrings: CTPStrings? = nil, saveUpdates: (() -> Void)? = nil) {
        self._presentPicker = presentPicker
        self._pickerField = pickerField
        self._items = items
        self.ctpColors = ctpColors
        self.ctpStrings = ctpStrings
        self.saveUpdates = saveUpdates
    }
    
    
    @State var filterString:String = ""
    @State private var originalItems:[String] = []
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
                self.items = self.originalItems.filter{$0.lowercased().contains(self.filterString.lowercased())}
            } else {
                self.items = self.originalItems
            }
            self.getHeight(ttl: self.items.count)
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
                            self.items = self.originalItems
                        }) {
                            Text(pickerStrings.cancelBtnTitle)
                        }.padding(10)
                        Spacer()
                        Group {
                            if saveUpdates != nil {
                                Button(action: {
                                    self.items = self.originalItems
                                    if let _ = self.saveUpdates {
                                        self.items.append(self.filterString)
                                        self.saveUpdates!()
                                    }
                                    self.pickerField = self.filterString
                                    withAnimation {
                                        self.presentPicker = false
                                    }
                                }) {
                                    Image(systemName: "plus.circle")
                                }.disabled(items.count > 0 || filterString.isEmpty)
                                    .padding(10)
                            }
                        }
                    }.background(Color(headerColors.headerBackgroundColor))
                        .foregroundColor(Color(headerColors.headerTintColor))
                    Text(items.count > 0 ? pickerStrings.pickText: (saveUpdates != nil) ? pickerStrings.addText : pickerStrings.noItemText)
                        .font(.caption)
                        .padding(.horizontal,10)
                    TextField(pickerField.isEmpty ? items.count > 0 ? pickerStrings.searchPlaceHolder : pickerStrings.newEntry : pickerField, text: filterBinding)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    if items.count > 0 {
                    List {
                        ForEach(items.sorted(), id: \.self) { item in
                            Button(action: {
                                self.items = self.originalItems
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
                }
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .frame(height: frameHeight)
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            if let ctString = self.ctpStrings {
                self.pickerStrings = ctString
            }
            if let ctColors = self.ctpColors {
                self.headerColors = ctColors
            }
            self.originalItems = self.items
            self.getHeight(ttl: self.items.count)
        }
    }
    
    fileprivate func getHeight(ttl:Int) {
        withAnimation  {
            if ttl > 5 {
                frameHeight = 400
            } else if ttl == 0 {
                frameHeight = 160
            } else {
                frameHeight = CGFloat(items.count * 45 + 160)
                
            }
        }
    }
}
