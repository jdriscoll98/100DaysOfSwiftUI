//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jack Driscoll on 6/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var totalQuestions = 1
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                       .font(.largeTitle.weight(.bold))
                       .foregroundColor(.white)
                Spacer()
               
               
                VStack(spacing: 15) {
                   
                    
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                               .font(.title.bold())
                        Text(countries[correctAnswer]).foregroundStyle(.secondary).font(.largeTitle.weight(.semibold))
                    }
                  
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number]).renderingMode(.original)
                        }.clipShape(Capsule()).shadow(radius: 5)
                    }
                    
                    Spacer()
                    Spacer()
                    Text("Score: \(score) / 8")
                        .foregroundStyle(.secondary)
                        .font(.title.bold())
                    Spacer()
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20)) }.padding()
           
            Spacer()
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Spacer()
            Spacer()
            Text("Your score is \(score)")
            Spacer()
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong, that flag is \(countries[number])!"
        }
       
        if (totalQuestions == 8) {
            scoreTitle = "Done! You scored \(score) / 8"
            
        }

        showingScore = true
    }
    
    func askQuestion() {
        if (totalQuestions == 8) {
            resetGame()
        }
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)

    }
    
    func resetGame() {
        totalQuestions = 1
        score = 0
        
    }
}
  

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
