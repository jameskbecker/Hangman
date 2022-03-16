//
//  HangmanApp.swift
//  Hangman
//
//  Created by James Becker on 05/03/2022.
//

import SwiftUI

@main
struct HangmanApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
