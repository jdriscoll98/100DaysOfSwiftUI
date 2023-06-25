//
//  ContentView.swift
//  UnitConversions
//
//  Created by Jack Driscoll on 6/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = 0.0
    @State private var fromUnit = "Fahrenheit"
    @State private var toUnit = "Fahrenheit"
    var convertedValue: Double? {
            
            let from: UnitTemperature
            let to: UnitTemperature
            
            switch fromUnit {
            case "Celsius":
                from = .celsius
            case "Fahrenheit":
                from = .fahrenheit
            case "Kelvin":
                from = .kelvin
            default:
                return nil
            }
            
            switch toUnit {
            case "Celsius":
                to = .celsius
            case "Fahrenheit":
                to = .fahrenheit
            case "Kelvin":
                to = .kelvin
            default:
                return nil
            }

            return Measurement(value: inputValue, unit: from).converted(to: to).value
        }
    
    var body: some View {
        let units = ["Fahrenheit", "Celsius", "Kelvin"]
        NavigationView {
            Form {
                Section {
                    TextField("Value", value: $inputValue, format: .number)
                }
                Section {
                    Picker("Unit", selection: $fromUnit) { ForEach(units, id: \.self) { unit in
                        Text(unit)
                    }}.pickerStyle(.segmented)
                    
                } header: {
                    Text("From")
                }
                Section {
                    Picker("Unit", selection: $toUnit) { ForEach(units, id: \.self) { unit in
                        Text(unit)
                    }}.pickerStyle(.segmented)
                } header: {
                    Text("To")
                }
                Section {
                    Text(convertedValue ?? 0, format: .number)
                } header: {
                    Text("Converted Value")
                }
            }
            .navigationTitle("Temperature Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
