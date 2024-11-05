//
//  FlashcardsViewModel.swift
//  LeeRollerNickHW6
//
//  Created by Nick Lee-Roller on 11/3/24.
//

import Foundation
import SwiftUI
import Combine

class FlashcardViewModel: ObservableObject, FlashcardsModel {
    private let flashcardsFilePath: URL
    
    var numberOfFlashcards: Int {
        return flashcards.count
    }
    
    @Published var flashcards: [Flashcard] = [] {
        didSet {
            save()
        }
    }
    
    @Published var currentIndex: Int = 0 {
        didSet {
            if currentIndex < 0 {
                currentIndex = 0
            } else if currentIndex >= flashcards.count {
                currentIndex = flashcards.count - 1
            }
        }
    }
    
    init() {
        let documentsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first!

        flashcardsFilePath = URL(string: "\(documentsDirectory)flashcards.json")!
        
        if let loadedFlashcards = load() {
            flashcards = loadedFlashcards
        } else {
            flashcards = [
                Flashcard(question: "Which school is the best ever?", answer: "USC", isFavorite: false),
                Flashcard(question: "What is USC's slogan?", answer: "Fight On!", isFavorite: false),
                Flashcard(question: "How many titles do the Lakers have?", answer: "17", isFavorite: false),
                Flashcard(question: "What school sucks?", answer: "UCLA", isFavorite: false),
                Flashcard(question: "What time is it?", answer: "Party time", isFavorite: false)
            ]
        }
    }
    
    var currentFlashcard: Flashcard? {
        if (flashcards.count == 0) {
            return nil
        } else {
            return flashcards[currentIndex]
        }
    }
    
    var favoriteFlashcards: [Flashcard] {
        flashcards.filter {
            $0.isFavorite
        }
    }
    
    func randomize() {
        var randomIndex = Int.random(in: 0..<flashcards.count)

        while randomIndex == currentIndex {
            randomIndex = Int.random(in: 0..<flashcards.count)
        }

        currentIndex = randomIndex
    }
    
    func next() {
        currentIndex = (currentIndex + 1) % flashcards.count
    }
    
    func previous() {
        if (currentIndex == 0) {
            currentIndex = flashcards.count - 1
        } else {
            currentIndex -= 1
        }
    }
    
    func flashcard(at index: Int) -> Flashcard? {
        if index < 0 || index >= flashcards.count {
            return nil
        } else {
            return flashcards[index]
        }
    }
    
    func append(flashcard: Flashcard) {
        flashcards.append(flashcard)
    }
    
    func insert(flashcard: Flashcard, at index: Int) {
        if index < 0 || index >= flashcards.count {
            append(flashcard: flashcard)
        } else {
            flashcards.insert(flashcard, at: index)
        }
    }
    
    func removeFlashcard(at index: Int) {
        if index < 0 || index >= flashcards.count {
            return
        } else {
            flashcards.remove(at: index)
        }
    }
    
    func update(flashcard: Flashcard, at index: Int) {
        var updatedFlashcards = flashcards
        updatedFlashcards[index] = flashcard
        flashcards = updatedFlashcards
    }
    
    func toggleFavorite() {
        if let currentFlashcard = currentFlashcard {
            let isFavorite = currentFlashcard.isFavorite
            let newCard = Flashcard(question: currentFlashcard.question, answer: currentFlashcard.answer, isFavorite: !isFavorite)
            update(flashcard: newCard, at: currentIndex)
        }
    }
    
    func getIndex(for flashcard: Flashcard) -> Int? {
        for i in 0..<flashcards.count {
            if flashcards[i].id == flashcard.id {
                return i
            }
        }
        return nil
    }
    
    private func load() -> [Flashcard]?{
        // Your implementation here
        do {
            let data = try Data(contentsOf: flashcardsFilePath)
//            flashcards = try JSONDecoder().decode(Array<Flashcard>.self, from: data)
            let decodedFlashcards = try JSONDecoder().decode(Array<Flashcard>.self, from: data)
            return decodedFlashcards
        } catch {
//            flashcards = [
//                Flashcard(question: "Which school is the best ever?", answer: "USC", isFavorite: false),
//                Flashcard(question: "What is USC's slogan?", answer: "Fight On!", isFavorite: false),
//                Flashcard(question: "How many titles do the Lakers have?", answer: "17", isFavorite: false),
//                Flashcard(question: "What school sucks?", answer: "UCLA", isFavorite: false),
//                Flashcard(question: "What time is it?", answer: "Party time", isFavorite: false)
//            ]
            return nil
        }
    }
    
    private func save(){
        // Your implementation here
        let data = try! JSONEncoder().encode(flashcards)
        try! data.write(to: flashcardsFilePath)
    }
    
}
