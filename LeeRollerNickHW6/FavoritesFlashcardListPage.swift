//
//  FavoritesFlashcardListPage.swift
//  LeeRollerNickHW6
//
//  Created by Nick Lee-Roller on 11/3/24.
//

import SwiftUI

struct FavoritesFlashcardListPage: View {
    @EnvironmentObject var flashcardViewModel: FlashcardViewModel
    
    var body: some View {
        NavigationStack {
            List (flashcardViewModel.favoriteFlashcards) { flashcard in
                NavigationLink(value: flashcard) {
                    FlashcardCell(flashcard: flashcard)
                }
            }
            .navigationTitle("Favorites")
            .navigationDestination(for: Flashcard.self) { flashcard in
                EditFlashCardPage(flashcard: flashcard)
            }
        }
    }
}
