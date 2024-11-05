//
//  ContentView.swift
//  LeeRollerNickHW6
//
//  Created by Nick Lee-Roller on 11/3/24.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var flashcardViewModel = FlashcardViewModel()
    
    var body: some View {
        MainTabView(flashcardViewModel: flashcardViewModel)
    }
}

#Preview {
    ContentView()
}
