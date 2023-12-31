//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jack Driscoll on 6/26/23.
//

import SwiftUI

struct FlagView: View {
    var flagTapped: (_ number: Int) -> Void
    var number: Int
    var countries: [String]
    @Binding var opacity: Double
    
    @State private var rotation = 0.0
    
    var body: some View {
        Button {
            rotation += 360
            opacity = 0.25
            flagTapped(number)
        } label: {
            Image(countries[number])
                .renderingMode(.original)
                .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
                .opacity(opacity)
        }
        .clipShape(Capsule())
        .shadow(radius: 5)
        .animation(.easeInOut, value: opacity)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.secondary)
               .font(.title.bold())
    }
}


extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var totalQuestions = 1
    @State private var results: [Color] = [.black, .black, .black, .black, .black, .black, .black, .black]
    @State private var scoreScale = 1.0
    @State private var flagOpacities = [1.0, 1.0, 1.0]
    
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
                            .titleStyle()
                           
                        Text(countries[correctAnswer])
                            .titleStyle()
                    }
                  
                    
                    ForEach(0..<3) { number in
                        FlagView(flagTapped: flagTapped(_:), number: number, countries: countries, opacity: $flagOpacities[number])
                    }
                    
                    Spacer()
                    Spacer()
                    Text("Score: \(score) / 8")
                                   .foregroundStyle(.secondary)
                                   .font(.title.bold())
                                   .scaleEffect(CGFloat(scoreScale))
                                   .animation(.easeInOut, value: scoreScale)
                                   .onAppear { scoreScale = 1.0 }
                                   .onChange(of: score, perform: { value in
                                       scoreScale = 1.2
                                       DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                           scoreScale = 1.0
                                       }
                                   })
                    Spacer()
                    HStack {
                        ForEach(0..<8) { number in
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(results[number])
                        }
                       
                    }
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
            results[totalQuestions - 1] = .green
        } else {
            scoreTitle = "Wrong, that flag is \(countries[number])!"
            results[totalQuestions - 1] = .red
        }
       
        if (totalQuestions == 8) {
            scoreTitle = "Done! You scored \(score) / 8"
            
        }

        
        showingScore = true
    }
    
    func askQuestion() {
        if (totalQuestions == 8) {
            resetGame()
        } else {
            totalQuestions += 1
        }
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        flagOpacities = [1.0, 1.0, 1.0]
            
    }
    
    func resetGame() {
        totalQuestions = 1
        score = 0
        results = [.black, .black, .black, .black, .black, .black, .black, .black]
        
    }
}
  

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
