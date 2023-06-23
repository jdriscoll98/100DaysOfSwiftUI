//
//  ContentView.swift
//  WeSplit
//
//  Created by Jack Driscoll on 6/22/23.
//

import SwiftUI



struct ContentView: View {
    @State var checkAmount = 0.0
    @State var numberOfPeople = 0
    @State var tipPercentage = 20
    let tipPercentages = [10, 15, 20, 25, 0]
    
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double {
        let totalPeople = Double(numberOfPeople + 2)
        let totalWithTip = checkAmount * (1 + Double(tipPercentage) / 100)
        return totalWithTip / totalPeople
    }
    
    var body: some View {
        NavigationView {
        Form {
            Section {
                TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
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
                Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
