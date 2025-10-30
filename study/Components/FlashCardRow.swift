//
//  FlashCardRow.swift
//  study
//
//  Created by Nordic on 10/30/25.
//

import SwiftUI
import SwiftData

struct FlashCardRow: View {
    @Bindable var card: Card
    
    var body: some View {
        VStack {
            VStack {
                Text("Term")
                TextField("Term", text: $card.term)
            }
            VStack {
                Text("Definition")
                TextField("Definition", text: $card.definition)
            }
        }
        
    }
}
