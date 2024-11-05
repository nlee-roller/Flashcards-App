//
//  LeeRollerNickHW6Tests.swift
//  LeeRollerNickHW6Tests
//
//  Created by Nick Lee-Roller on 11/3/24.
//

import XCTest
@testable import LeeRollerNickHW6

final class LeeRollerNickHW6Tests: XCTestCase {
    var flashcardViewModel: FlashcardViewModel = FlashcardViewModel()
    
    override func setUp() {
        flashcardViewModel = FlashcardViewModel()
    }
    
    func testNumberOfFlashcards()  {
        XCTAssertEqual(flashcardViewModel.numberOfFlashcards, 5)
    }
    
    func testFlashcards()  {
        let flashcards = flashcardViewModel.flashcards
        XCTAssertNotNil(flashcards)
    }
    
    func testCurrentIndex()  {
        XCTAssertEqual(flashcardViewModel.currentIndex, 0)
    }
    
    func testCurrentFlashcard() {
        let flashcard = flashcardViewModel.currentFlashcard
        XCTAssertNotNil(flashcard)
    }
    
    func testFavoriteFlashcards() {
        let favorites = flashcardViewModel.favoriteFlashcards
        XCTAssertEqual(favorites.count, 0)
    }
    
    func testRandomize() {
        let prev = flashcardViewModel.currentIndex
        flashcardViewModel.randomize()
        let curr = flashcardViewModel.currentIndex
        XCTAssertNotEqual(prev, curr)
    }
    
    func testNext() {
        let prev = flashcardViewModel.currentIndex
        flashcardViewModel.randomize()
        let curr = flashcardViewModel.currentIndex
        XCTAssertEqual(prev+1, curr)
    }
    
    func testPrevious() {
        let prev = flashcardViewModel.currentIndex
        flashcardViewModel.randomize()
        let curr = flashcardViewModel.currentIndex
        XCTAssertNotEqual(prev, curr)
    }
    
    func testFlashcard() {
        let flashcard = flashcardViewModel.flashcard(at:0)
        XCTAssertNotEqual(flashcard, nil)
    }
    
    func testAppend() {
        let flashcard = Flashcard(question: "question", answer: "answer", isFavorite: false)
        flashcardViewModel.append(flashcard: flashcard)
        let index = flashcardViewModel.flashcards.count - 1
        let newCard = flashcardViewModel.flashcard(at: index)
        XCTAssertEqual(flashcard, newCard)
    }
    
    func testInsert() {
        let flashcard = Flashcard(question: "question", answer: "answer", isFavorite: false)
        flashcardViewModel.insert(flashcard: flashcard, at: 0)
        let newCard = flashcardViewModel.flashcard(at: 0)
        XCTAssertEqual(flashcard, newCard)
    }
    
    func testRemoveFlashcard() {
        let prev = flashcardViewModel.numberOfFlashcards
        flashcardViewModel.removeFlashcard(at: 0)
        let curr = flashcardViewModel.numberOfFlashcards
        XCTAssertEqual(prev-1, curr)
    }
    
    func testUpdate() {
        let flashcard = Flashcard(question: "question", answer: "answer", isFavorite: false)
        flashcardViewModel.update(flashcard: flashcard, at: 0)
        XCTAssertEqual(flashcard, flashcardViewModel.flashcard(at: 0))
    }
    
    func testToggleFavorite() {
        let prev = flashcardViewModel.currentFlashcard!.isFavorite
        flashcardViewModel.toggleFavorite()
        let curr = flashcardViewModel.currentFlashcard!.isFavorite
        XCTAssertNotEqual(prev, curr)
    }
    
    func testGetIndex() {
        let prev = flashcardViewModel.flashcard(at: 0)
        let index = flashcardViewModel.getIndex(for: prev!)
        XCTAssertEqual(index, 0)
    }

}
