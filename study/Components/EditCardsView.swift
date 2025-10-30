//
//  EditCardsView.swift
//  study
//
//  Created by Nordic on 10/27/25.
//

import SwiftData
import SwiftUI

struct EditCardsView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var set: Set

    var body: some View {
        List {
            ScrollView {
                ForEach(set.cards) { card in
                    FlashCardRow(card: card)
                }
            }.onAppear {
                if set.cards.isEmpty {
                    addNewCard()
                }
            }
        }
    }
    
    // Need to create a card if there is none
    // Need to add a card
    
    func addNewCard() {
        let newCard = Card(term: "", definition: "")
        set.cards.append(newCard)
    }
    
    func deleteCard(_ card: Card) {
        if let index = set.cards.firstIndex(where: {$0.id == card.id}) {
            set.cards.remove(at: index)
        }
    }
}
