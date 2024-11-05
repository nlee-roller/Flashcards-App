//
//  FlashcardCell.swift
//  LeeRollerNickHW6
//
//  Created by Nick Lee-Roller on 11/3/24.
//

import SwiftUI

struct FlashcardCell: View {
    let flashcard: Flashcard
    
    var body: some View {
        VStack (alignment: .leading, spacing: 12){
            Text(flashcard.question)
                .font(.title3)
            Text(flashcard.answer)
                .font(.subheadline)
        }
    }
}
