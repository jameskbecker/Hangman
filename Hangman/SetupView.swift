//
//  ContentView.swift
//  Hangman
//
//  Created by James Becker on 05/03/2022.
//

import SwiftUI;

struct Word: Identifiable, Hashable {
    let name: String
    let id = UUID()
}

struct SetupView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var wordInput: String = ""
    

    func handleWordInput (input: String) {
        let lastCharacter = wordInput.suffix(1)
   
        
        if lastCharacter == " " {
            let name = String(wordInput.dropLast().uppercased())
            modelData.wordList.append(Word(name: name))
            wordInput = ""
        }
    }
    
    var body: some View {
        VStack() {
            Text("Setup Game").font(.largeTitle).bold()
                .foregroundColor(Color.purple)
            
            Spacer()
            
            Text("Word List")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            List(modelData.wordList) {
                Text($0.name)
            }
            .listStyle(.plain)
            .frame(maxHeight: 500)
            
            Spacer()
         
            Text("Add word")
            TextField(
                "Press space to add to list",
                text: $wordInput
            )
            .textFieldStyle(.roundedBorder)
            .onChange(
                of: wordInput,
                perform: handleWordInput
            )
            
            Button("Clear List", action: {
                modelData.wordList.removeAll()
            })
                .padding(.all, 10.0)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.white)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.secondary)
                )
        
       
            Spacer()
            
            NavigationLink(destination: GameView()) {
                Text("Start Game")
                    .padding(.all, 10.0)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.purple)
                    )
            }
        }
        
        .padding(.horizontal, 16.0)
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView()
          
    }
}
