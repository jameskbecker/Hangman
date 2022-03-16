//
//  ContentView.swift
//  Hangman
//
//  Created by James Becker on 05/03/2022.
//

import SwiftUI;

let columns = [ GridItem(), GridItem(), GridItem(), GridItem() ]
let alphabet: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

struct GameView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showReset: Bool = false;
    @State private var hasWon: Bool = false;
    
    @State private var secretWord: String = "";
    @State private var maskedWord: [String] = [];
    @State private var guesses: [String] = [];
    @State private var mistakeCount = 0;
    @State private var maxMistakes = 6;
    
    func selectWord() {
        let list = modelData.wordList
        let randomWord = list.randomElement()
        secretWord = randomWord?.name ?? ""
        getHints()
    }
    
    func isMistake(letter: String) -> Bool {
        let a = secretWord.lowercased()
        let b = letter.lowercased()
        return !a.contains(b)
    }
    
    func getHints() {
        let splitWord = Array(secretWord)
        maskedWord = splitWord.map {
            guesses.contains(String($0)) ? String($0) : "_"
        }
        
        if !maskedWord.contains("_") {
            hasWon = true
            showReset = true
        }

    }
    
    func handleGuess(letter: String) {
        guesses.append(letter)
        getHints()
        
        if isMistake(letter: letter) {
            mistakeCount += 1
        }
        
        if mistakeCount == maxMistakes {
            showReset = true
        }
    }
    
    func reset() {
        showReset = false
        hasWon = false
        mistakeCount = 0
        guesses = []
        selectWord()
    }
    
    var body: some View {
        VStack() {
            Text("Hangman").font(.largeTitle).bold()
                .foregroundColor(Color.purple)
            Spacer()
            
            Text(maskedWord.joined())
                .font(.headline)
                .bold()
                .tracking(20)
            Spacer()
            
            HStack() {
                Text("Mistakes Remaining:").font(.body)
                Text(String(maxMistakes - mistakeCount)).font(.body)
                
            }
            
            
            
            LazyVGrid (columns: columns) {
                ForEach(alphabet, id: \.self) { letter in
                    Button(letter, action: {
                        handleGuess(letter: letter)
                    })
                    .disabled(guesses.contains(letter) ? true : false)
                    .padding(.all, 10.0)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(guesses.contains(letter) ? Color.gray : Color.purple)
                    )
                    
                }
            }
            
        }
        
        .padding(.horizontal, 16.0)
        .onAppear{
            selectWord()
        }
        .alert(
            isPresented: $showReset,
            content: {
                Alert(
                    title: Text(hasWon ? "Congratulations!" : "Game Over!"),
                    message: Text(hasWon ? "You won." : "You lost."),
                    dismissButton: .default(Text("Play again")) {
                        reset()
                    }
                )
            }
        )
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
