//
//  ContentView.swift
//  BetterRest
//
//  Created by Jack Driscoll on 7/3/23.
//
import CoreML
import SwiftUI

extension Color {
    // Define your custom colors
    static let DarkRoast = Color(red: 101.0/255.0, green: 67.0/255.0, blue: 33.0/255.0)
    static let Latte = Color(red: 224.0/255.0, green: 201.0/255.0, blue: 169.0/255.0)
}


struct ContentView: View {
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var espressoCount = 1
   
    var body: some View {
       
   
        NavigationView {
            ZStack {
                RadialGradient(
                    gradient: Gradient(colors: [Color.DarkRoast, Color.Latte]),
                    center: .center,
                    startRadius: 5,
                    endRadius: 500
                )
                .edgesIgnoringSafeArea(.all)
          

            Form {
                Section {
                    Text("When do you want to wake up?")
                        .font(.headline)

                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section {
                    Text("Desired amount of sleep")
                        .font(.headline)

                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }

                Section {
                    Text("Daily espresso intake")
                        .font(.headline)

                    Stepper(espressoCount == 1 ? "1 shot" : "\(espressoCount) shots", value: $espressoCount, in: 1...20)
                }
                
                HStack {
                    Text("Bed Time")
                        .font(.headline)
                    Spacer()
                    Text("\(calculatedBedtime.formatted(.dateTime.hour().minute()))")
                        .font(.headline)
                }
                
            }
            .navigationTitle("BetterRest")
            
           .scrollContentBackground(.hidden)
        }
   
        
        }
        
        
    }
    
    var calculatedBedtime: Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            // Caffine amount measured by standard 8-ounce pours of drip coffee. 1 Espresso shot is equivalent to 1.5 cups of coffee.
            let caffineAmount = Double(espressoCount) * 1.5
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: caffineAmount)
            
            return wakeUp - prediction.actualSleep
        } catch {
            return Date.now
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
