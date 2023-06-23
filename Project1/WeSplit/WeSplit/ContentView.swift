//
//  ContentView.swift
//  WeSplit
//
//  Created by Jack Driscoll on 6/22/23.
//

import SwiftUI



struct ContentView: View {
    @State var checkAmountText = ""
    @State var numberOfPeople = 0
    @State var tipPercentage = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    let currentCurrency = Locale.current.currency?.identifier ?? "USD"
    
    @FocusState private var amountIsFocused: Bool
    
    var checkAmount: Double {
        // Try to convert the text to a Double, otherwise return 0.0
        return Double(checkAmountText) ?? 0.0
    }
    
    var totalPerPerson: Double {
        let totalPeople = Double(numberOfPeople + 2)
        let totalWithTip = checkAmount * (1 + Double(tipPercentage) / 100)
        return totalWithTip / totalPeople
    }
    
    var body: some View {
        NavigationView {
        Form {
            Section {
                TextField("Amount (\(currentCurrency))", text: $checkAmountText)
                    .keyboardType(.decimalPad)
                Picker("Number of People", selection: $numberOfPeople) {
                    ForEach(2..<100, id: \.self) {
                        Text("\($0) People")
                    }
                }
            }
            Section {
                Picker("Tip Percentages", selection: $tipPercentage) {
                    ForEach(tipPercentages, id: \.self) {
                        Text($0, format: .percent)
                    }
                }.pickerStyle(.segmented)
            } header: {
                Text("How much tip do you want to leave?")
            }
            Section {
                Text(totalPerPerson, format: .currency(code: currentCurrency))
            }
        }
        .navigationTitle("WeSplit")
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
