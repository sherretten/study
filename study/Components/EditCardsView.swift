//
//  EditCardsView.swift
//  study
//
//  Created by Nordic on 10/27/25.
//

import SwiftData
import SwiftUI

struct EditCardsView: View {
    @Bindable var set: Set
    
    var body: some View {
        List {
            ForEach(set.cards) { card in
                Form {
                    TextField("Term", text: card.term)
                    TextField("Definition", text: card.definition)
                }
            }
        }
        
    }
}
