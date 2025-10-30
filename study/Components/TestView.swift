//
//  TestView.swift
//  study
//
//  Created by Nordic on 10/28/25.
//

import SwiftData
import SwiftUI

struct CardAnswer: Identifiable {
    let id = UUID()
    var userAnswer: String = ""
    var showAnswer: Bool = false
    var isChecked: Bool = false
    var isCorrect: Bool = false
}

struct TestView: View {
    @Bindable var set: Set
    @State private var answers: [CardAnswer] = []
    
    var body: some View {
        
        ScrollView {
            ForEach(Array(set.cards.enumerated()), id: \.element.id) { index, card in
                VStack {
                    HStack {
                        Text("\(index + 1) :")
                        Text(card.term)
                    }
                    TextField("Enter definition", text: $answers[index].userAnswer)
                    
                    if answers[index].showAnswer {
                        Text(card.definition).font(.subheadline).padding(8)
                    }
                    Button(action: {
                        answers[index].showAnswer.toggle()
                    }) {
                        Text(answers[index].showAnswer ? "Hide Answer" : "Show answer")
                    }.foregroundColor(.blue)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
            }
        }
    }
}
