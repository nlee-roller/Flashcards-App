//
//  FlashcardListPage.swift
//  LeeRollerNickHW6
//
//  Created by Nick Lee-Roller on 11/3/24.
//

import SwiftUI

struct FlashcardListPage: View {
    @EnvironmentObject var flashcardViewModel : FlashcardViewModel
    var body: some View {
        NavigationStack {
            List($flashcardViewModel.flashcards, editActions: .delete) { $flashcard in
                NavigationLink(value: flashcard) {
                    FlashcardCell(flashcard: flashcard)
                }
            }
            .navigationTitle("Flashcards")
            .toolbar {
                NavigationLink(destination: EditFlashCardPage()) {
                    Image(systemName: "plus")
                }
            }
            .navigationDestination(for: Flashcard.self) { flashcard in
                EditFlashCardPage(flashcard: flashcard)
            }
        }
    }
}

//#Preview {
//    FlashcardListPage(flashcardViewModel: FlashcardViewModel())
//}
