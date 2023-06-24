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
    let currentCurrency = Locale.current.currency?.identifier ?? "USD"
    var currencyFormat: FloatingPointFormatStyle<Double>.Currency { return .currency(code: currentCurrency) }
    
    @FocusState private var amountIsFocused: Bool
    
    var checkAmount: Double {
        // Try to convert the text to a Double, otherwise return 0.0
        return Double(checkAmountText) ?? 0.0
    }
    
    var totalWithTip: Double {
        return checkAmount * (1 + Double(tipPercentage) / 100)
    }
    
    var totalPerPerson: Double {
        let totalPeople = Double(numberOfPeople + 2)
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
                    ForEach(1..<101, id: \.self) {
                        Text($0, format: .percent)
                    }
                }.pickerStyle(.navigationLink)
            } header: {
                Text("How much tip do you want to leave?")
            }
            Section {
                Text(totalWithTip, format: currencyFormat)
            } header : {
                Text("Total with tip")
            }
            Section {
                Text(totalPerPerson, format: currencyFormat)
            } header : {
                Text("Amount per person")
            }
           
        }
        .navigationTitle("WeSplit")
        .preferredColorScheme(.dark)
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
