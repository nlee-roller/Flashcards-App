//
//  FlashcardPage.swift
//  LeeRollerNickHW6
//
//  Created by Nick Lee-Roller on 11/3/24.
//


import SwiftUI

struct FlashcardPage: View {
    let OFFSET_X = 450.0
    let OFFSET_Y = 900.0
    @EnvironmentObject var flashcardViewModel: FlashcardViewModel
    @State var isShowingQuestion = true
    @State var offsetX = 0.0
    @State var offsetY = 0.0
    @State var isHidden = false
    
    var isFavorite: Bool {
        return flashcardViewModel.currentFlashcard!.isFavorite
    }
    
    var title: String {
        if flashcardViewModel.currentFlashcard == nil {
            return ""
        }
        if (isShowingQuestion) {
            return flashcardViewModel.currentFlashcard!.question
        } else {
            return flashcardViewModel.currentFlashcard!.answer
        }
    }
    
    func showRandomFlashcard() {
        withAnimation (.linear(duration: 0.25)) {
            offsetY = -1000.0
            isHidden = true
        }
        withAnimation (
            .linear(duration: 0.25)
            .delay(0.25)
        ) {
            offsetY = 1000
            flashcardViewModel.randomize()
            isShowingQuestion = true
        }
        withAnimation (
            .linear(duration: 0.25)
            .delay(0.5)
        ) {
            offsetY = 0
            isHidden = false
        }
    }
    
    func toggleQuestionAnswer() {
        withAnimation (.linear(duration: 0.25)) {
            isShowingQuestion = !isShowingQuestion
        }
    }
    
    func showNextCard() {
        withAnimation (.linear(duration: 0.25)) {
            offsetX = -1000.0
            isHidden = true
        }
        withAnimation (
            .linear(duration: 0.25)
            .delay(0.25)
        ) {
            offsetX = 1000
            flashcardViewModel.next()
            isShowingQuestion = true
        }
        withAnimation (
            .linear(duration: 0.25)
            .delay(0.5)
        ) {
            offsetX = 0
            isHidden = false
        }
    }
    
    func showPreviousCard() {
        withAnimation (.linear(duration: 0.25)) {
            offsetX = 1000.0
            isHidden = true
        }
        withAnimation (
            .linear(duration: 0.25)
            .delay(0.25)
        ) {
            offsetX = -1000
            flashcardViewModel.previous()
            isShowingQuestion = true
        }
        withAnimation (
            .linear(duration: 0.25)
            .delay(0.5)
        ) {
            offsetX = 0
            isHidden = false
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(title)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(isShowingQuestion ? .black : .white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue)
            .onTapGesture (count: 2){
                toggleQuestionAnswer()
            }
            .onTapGesture {
                showRandomFlashcard()
            }
            .opacity(
                isHidden ? 0.0 : 1.0
            )
            .offset(x: offsetX, y: offsetY)
            .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                .onEnded { value in
                    print(value.translation)
                    switch(value.translation.width, value.translation.height) {
                        case (...0, -30...30):
                            showNextCard()
                        case (0..., -30...30):
                            showPreviousCard()
                        case (-100...100, ...0):
                                             print("up swipe")
                        case (-100...100, 0...):
                                                print("down swipe")
                        default:
                                            print("no clue")
                    }
                }
            )
            .padding()
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        flashcardViewModel.toggleFavorite()
                    }) {
                        Image(systemName: "star.fill")
                    }
                    .tint(flashcardViewModel.currentFlashcard!.isFavorite == true ? Color.yellow : Color.gray)
                }
                .padding()
                Spacer()
            }
            .padding()
            .font(.system(size: 48))
        }
    }
}

#Preview {
    FlashcardPage()
}
