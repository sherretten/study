import SwiftUI

struct ImportSheet: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @Bindable var set: Set
    @State var ImportString: String = ""
    @FocusState var focusedInput
    
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                HStack {
                    Text("Import").font(.headline)
                    Spacer()
                    Button("Save") {
                        saveCards()
                        dismiss()
                    }.disabled(ImportString.isEmpty)
                }
                Text("Export your set with **Term and Definition** with tab, and **Between Rows** to semicolon").font(.subheadline).lineLimit(3)
                TextEditor(text: $ImportString)
                    .frame(minHeight: 100)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                    .focused($focusedInput)
                    .onAppear { DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    focusedInput = true
                }}
            }
        }
    }
    func parseCards() -> [Card] {
        let cardStrings = ImportString.components(separatedBy: ";")
        var newCards: [Card] = []
           
           for cardString in cardStrings {
               let trimmed = cardString.trimmingCharacters(in: .whitespacesAndNewlines)
               print(trimmed)
               guard !trimmed.isEmpty else { continue }
               
               let components = trimmed.components(separatedBy: "\t")
               if components.count >= 2 {
                   let term = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
                   let definition = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
                   
                   if !term.isEmpty && !definition.isEmpty {
                       newCards.append(Card(term: term, definition: definition))
                   }
               }
           }
           return newCards
    }
    
    func saveCards() {
        let cards = parseCards()
        for card in cards {
            set.cards.append(card)
        }
    }
}
