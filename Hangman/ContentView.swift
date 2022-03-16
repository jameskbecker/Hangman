//
//  ContentView.swift
//  Hangman
//
//  Created by James Becker on 05/03/2022.
//

import SwiftUI;

final class ModelData: ObservableObject {
    @Published var wordList: [Word] = [ ]
    @Published var showGameOver = true
    @Published var showGameWon = false
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack() {
                
                Text("Hangman")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .bold()
                    .foregroundColor(Color.purple)
                Spacer()
                NavigationLink(destination: SetupView()) {
                    Text("Play")
                        .padding(.all, 10.0)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.purple)
                        )
                }
            }
        }
        .padding(.horizontal, 24.0)

    }
       
}

struct ContentView_Previsews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
