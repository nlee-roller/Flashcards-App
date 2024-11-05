//
//  EditFlashCardPage.swift
//  LeeRollerNickHW6
//
//  Created by Nick Lee-Roller on 11/3/24.
//

import SwiftUICore
import SwiftUI

struct EditFlashCardPage: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var flashcardViewModel: FlashcardViewModel
    private var flashcard: Flashcard?
    @State private var question: String = ""
    @State private var answer: String = ""
    @State private var isFavorite: Bool = false
    
    init(flashcard: Flashcard? = nil) {
        if let flashcard = flashcard {
            self.flashcard = flashcard
            _question = State(initialValue: flashcard.question)
            _answer = State(initialValue: flashcard.answer)
            _isFavorite = State(initialValue: flashcard.isFavorite)
        }
    }
    
    var body: some View {
        VStack (spacing: 24) {
            TextField("Question", text: $question)
            TextField("Answer", text: $answer)
            Toggle("Is Favorite?", isOn: $isFavorite)
            Spacer()
        }
        .padding()
        .navigationTitle(flashcard != nil ? "Edit Card" : "New Card")
        .toolbar(content: {
            Button("Save") {
                if (flashcard != nil) {
                    let newFlashcard = Flashcard(question: question, answer: answer, isFavorite: isFavorite)
                    flashcardViewModel.update(flashcard: newFlashcard, at: flashcardViewModel.getIndex(for: flashcard!)!)
                } else {
                    let newFlashcard = Flashcard(question: question, answer: answer, isFavorite: isFavorite)
                    flashcardViewModel.append(flashcard: newFlashcard)
                }
                dismiss()
            }
            .disabled(question.isEmpty || answer.isEmpty)
        })
    }
}

#Preview {
    EditFlashCardPage()
}
