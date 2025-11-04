import SwiftData
import SwiftUI

struct EditCardsView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var set: Set
    @Binding var navigationPath: NavigationPath
    @FocusState private var focusedCardId: UUID?
    @State private var cardInsertedOrder: [UUID] = []

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView() {
                VStack(spacing: 20) {
                    ForEach(sortedCards()) { card in
                        FlashCardRow(card: card, focusedCardID: _focusedCardId, onDelete: {
                            deleteCard(card)
                        })
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                        .id(card.id)
                    }
                    
                    HStack {
                        Spacer()
                        Button("Add Card", action: addNewCard)
                        Spacer()
                    }
                    Color.clear.frame(height: 1).id("bottom")
                }
            }
            .onAppear {
                if set.cards.isEmpty {
                    addNewCard()
                }
            }
            .animation(nil, value: set.cards.count)
            .padding()
            .navigationTitle("Edit cards for \(set.name)")
            .toolbar {
                Button("Add Card", systemImage: "plus") {
                    addNewCard()
                }
            }
            .onChange(of: set.cards.count) { old, new in
                if new > old {
                        proxy.scrollTo("bottom", anchor: .bottom)
                
                }
            }
        }.background(Color(.systemGray6))
    }
    
    func sortedCards() -> [Card] {
        set.cards.sorted { card1, card2 in
            guard let index1 = cardInsertedOrder.firstIndex(of: card1.id),
                  let index2 = cardInsertedOrder.firstIndex(of: card2.id) else {
                return false
            }
            return index1 < index2
        }
    }
    
    func addNewCard() {
        let newCard = Card(term: "", definition: "")
        set.cards.append(newCard)
        cardInsertedOrder.append(newCard.id)
        focusedCardId = newCard.id
    }
    
    func deleteCard(_ card: Card) {
        if let index = set.cards.firstIndex(where: {$0.id == card.id}) {
            set.cards.remove(at: index)
        }
    }
}
