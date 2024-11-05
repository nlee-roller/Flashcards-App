//
//  Flashcard.swift
//  LeeRollerNickHW6
//
//  Created by Nick Lee-Roller on 11/3/24.
//

import Foundation

struct Flashcard: Hashable, Identifiable, Codable {
    var id: UUID = UUID()
    let question: String
    let answer: String
    let isFavorite: Bool
    
    static func == (lhs: Flashcard, rhs: Flashcard) -> Bool {
        return lhs.question == rhs.question && lhs.answer == rhs.answer && lhs.isFavorite == rhs.isFavorite && lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(question)
        hasher.combine(answer)
        hasher.combine(isFavorite)
    }
    
}

