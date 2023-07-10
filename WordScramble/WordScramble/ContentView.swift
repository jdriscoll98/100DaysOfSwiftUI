//
//  ContentView.swift
//  WordScramble
//
//  Created by Jack Driscoll on 7/6/23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0;
    
    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                                    VStack {
                                       
                        Section {
                            
                                Text(rootWord)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                               

                          
                                                        Text("Current score: \(score)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Button("Restart") {
                                startGame()
                            }.foregroundStyle(.white).fontWeight(.bold)
                            Text("Score calculated is the square of the length of each new word")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                        
                        Section {
                            TextField("Enter your word", text: $newWord)
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(10)
                                .foregroundColor(.blue)
                                .autocapitalization(.none)
                        }
                        .padding()

                                        Section {
                                            ScrollView {
                                                LazyVStack {
                                                    ForEach(usedWords, id: \.self) { word in
                                                        HStack {
                                                            Image(systemName: "\(word.count).circle")
                                                                .resizable()
                                                                .frame(width: 30, height: 30)
                                                                .foregroundColor(.purple)
                                                            
                                                        Text(word)
                                                                .font(.title2)
                                                                .fontWeight(.bold)
                                                                .foregroundColor(.white)
                                                        }
                                                        .padding()
                                                        .background(Color.white.opacity(0.2))
                                                        .cornerRadius(10)
                                                        .padding(.bottom, 5)
                                                    }
                                                }
                                            }
                                        }
                                        .padding()

                    }
                    
                    .onSubmit {
                        addNewWord()
                    }
                    .onAppear(perform: startGame)
                    .alert(errorTitle, isPresented: $showingError) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text(errorMessage)
                    }
                    
                }
                .background(Color.clear)
           
        }
    
    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        guard answer.count > 0 else { return }

        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard longEnough(word: answer) else {
            wordError(title: "Too Short", message: "Words must be at least 3 letters.")
            return
        }
        
        guard isNew(word: answer, originalWord: rootWord) else {
            wordError(title: "Same word", message: "Can't use the same word as the original!")
            return;
        }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        score += answer.count * answer.count;
        newWord = ""
    }
    
    func startGame() {
        score = 0;
        usedWords = [];
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")

                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"

                // If we are here everything has worked, so we can exit
                return
            }
        }

        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func longEnough(word: String) -> Bool {
        return word.count > 2;
    }
    
    func isNew(word: String, originalWord: String) -> Bool {
        return word != originalWord;
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
