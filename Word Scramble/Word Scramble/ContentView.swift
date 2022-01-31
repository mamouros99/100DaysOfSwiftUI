//
//  ContentView.swift
//  Word Scramble
//
//  Created by Tiago Mamouros on 10/01/2022.
//

import SwiftUI



struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = "Banana"
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var currentScore = 0
    
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count >= 3 else{ return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word already used", message: "Be more orignal")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word is not real", message: "Get better scrub")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word is not Possible", message: "Be sure to use only and not repeat letters in \(rootWord)")
            return
        }
                
        
        addToScore(answer)
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
        
    }
    
    func addToScore(_ word: String) -> Void {
        currentScore += word.count
    }
    
    func starGame() {
        
        usedWords.removeAll()
        currentScore = 0
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let starWords = try? String(contentsOf: startWordsURL){
                let allWords = starWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load star.txt from Bundle")
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
        let misspelledRangeEnglish = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        let misspelledRangePortuguese = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "pt")

        return misspelledRangeEnglish.location == NSNotFound || misspelledRangePortuguese.location == NSNotFound
    }
    
    
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section{
                    ForEach(usedWords, id: \.self){ word in
                        HStack{
                            
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                
                        }
                    }
                }

                Section{
                    Text("Current Score \(currentScore)")
                }
            }
            .navigationTitle(rootWord)
            .onSubmit {
                addNewWord()
            }
            .onAppear {
                starGame()
            }
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel){
                    
                }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("Reset Game"){
                    starGame()
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
