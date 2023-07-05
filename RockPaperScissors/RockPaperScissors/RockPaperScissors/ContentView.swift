//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Jack Driscoll on 7/1/23.
//

import SwiftUI

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    @State private var shouldWin = Bool.random()
    @State private var appMove = Int.random(in: 0..<3)
    @State private var userCorrect = false;
    @State private var showResult = false;
    
    var body: some View {
        VStack {
            Text(moves[appMove])
            Text(shouldWin ? "Win" : "Lose")
            HStack {
                Button {
                    chooseOption("🪨")
                } label:  {
                    Text("🪨")
                }
                Button {
                    chooseOption("📄")
                } label:  {
                    Text("📄")
                }
                Button {
                    chooseOption("✂️")
                } label:  {
                    Text("✂️")
                }
                
              
            }
        }
        .padding()
        .alert(userCorrect ? "Correct": "Incorrect!", isPresented: $showResult)
    }
    
    func chooseOption(_ option: String) {
        switch appMove {
        case 0: // rock
            if ((option == "📄" && shouldWin) || !shouldWin) {
                userCorrect = true;
            } else {
                userCorrect = false;
            }
            
        case 1: // paper
            if ((option == "✂️" && shouldWin) || !shouldWin) {
                userCorrect = true;
            } else {
                userCorrect = false;
            }
        case 2: // scissors
            if ((option == "🪨" && shouldWin) || !shouldWin) {
                userCorrect = true;
            } else {
                userCorrect = false;
            }
        default:
            userCorrect = false
        }
        showResult = true;
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
