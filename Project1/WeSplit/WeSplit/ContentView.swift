//
//  ContentView.swift
//  WeSplit
//
//  Created by Jack Driscoll on 6/22/23.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    
    let students = ["Harry", "Hermoine", "Ron"]
    @State private var student = "Harry"
    var body: some View {
        NavigationView {
            Form {
                Picker("Select a student", selection: $student) {
                    ForEach(students, id: \.self) {
                        Text($0)
                    }
                }
            }
            .navigationTitle("SwiftUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
