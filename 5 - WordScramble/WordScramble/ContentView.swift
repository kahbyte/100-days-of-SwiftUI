//
//  ContentView.swift
//  WordScramble
//
//  Created by Kaue Sousa on 28/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords: [String] = []
    @State private var rootWord: String = ""
    @State private var newWord: String = ""
    @State private var score: Int = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Enter your word", text: $newWord)
                    }
                    .textInputAutocapitalization(.never)
                    .onSubmit { addNewWord() }
                    .onAppear(perform: startGame)
                    .alert(errorTitle, isPresented: $showingError) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text(errorMessage)
                    }
                    
                    Section {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                }
                .navigationTitle(rootWord)
                .listStyle(.insetGrouped)
                .toolbar {
                    Button("Start Game") {
                        self.startGame()
                    }
                }
                
                Text("Score: \(score)")
                    .font(.title2)
                    .bold()
            }
        }
    }
    
    private func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !answer.isEmpty else { return }
        
        guard isBigEnough(answer) else {
            wordError(title: "Too short", message: "Try something a little bigger")
            return
        }
        
        guard isNotPrefix(answer) else {
            wordError(title: "It's a prefix", message: "Be more original")
            return
        }
        
        guard isOriginal(answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
            score += 1
        }
        
        newWord = ""
    }
    
    private func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                
                withAnimation {
                    rootWord = allWords.randomElement() ?? "silkworm"
                    usedWords = []
                    score = 0
                }

                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    private func isBigEnough(_ word: String) -> Bool {
        return word.count >= 3
    }
    
    private func isNotPrefix(_ word: String) -> Bool {
        return !rootWord.starts(with: word)
    }
    
    private func isOriginal(_ word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    private func isPossible(_ word: String) -> Bool {
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
    
    private func isReal(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )
        
        return misspelledRange.location == NSNotFound
    }
    
    private func wordError(
        title: String,
        message: String
    ) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
