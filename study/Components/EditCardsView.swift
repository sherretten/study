import SwiftData
import SwiftUI

struct EditCardsView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var set: Set
    @Binding var navigationPath: NavigationPath
    @FocusState private var focusedCardId: UUID?

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView() {
                VStack(spacing: 20) {
                    ForEach(set.cards) { card in
                        FlashCardRow(card: card, focusedCardID: _focusedCardId, onDelete: {
                            deleteCard(card)
                        })
                    }
                    .padding()
                    .background(Color(.white))
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                    
                    Color.clear.frame(height: 1).id("bottom")
                }
            }
            .onAppear {
                if set.cards.isEmpty {
                    addNewCard()
                }
            }
            .padding()
            .navigationTitle("Edit cards for \(set.name)")
            .toolbar {
                Button("Add Course", systemImage: "plus") {
                    addNewCard()
                }
            }
            .onChange(of: set.cards.count) { old, new in
                if new > old {
                    withAnimation {
                        proxy.scrollTo("bottom", anchor: .bottom)
                    }
                }
            }
        }.background(Color(.systemGray6))
    }
    
    func addNewCard() {
        let newCard = Card(term: "", definition: "")
        set.cards.append(newCard)
        focusedCardId = newCard.id
    }
    
    func deleteCard(_ card: Card) {
        if let index = set.cards.firstIndex(where: {$0.id == card.id}) {
            set.cards.remove(at: index)
        }
    }
}
