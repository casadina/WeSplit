//
//  ContentView.swift
//  WeSplit
//
//  Created by casadina on 2021/11/27.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    @State private var zeroTip = false
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        return checkAmount + checkAmount * (Double(tipPercentage) / 100)
    }
    
    var currencyFormatter: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currencyCode ?? "USD")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormatter)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {number in
                            Text("\(number) people")
                        }
                    }
                } header: {
                    Text("Enter the bill and amount of people")
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< 101) {number in
                            Text(number, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(totalPerPerson, format: currencyFormatter)
                } header: {
                    Text("Amount per Person:")
                }
                Section {
                    Text(totalAmount, format: currencyFormatter)
                        .foregroundColor(isTip() ? .black : .red)
                } header: {
                    Text("Grand Total: Bill + Tip")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
    func isTip() -> Bool {
        return tipPercentage > 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}
