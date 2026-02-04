import SwiftUI
import SwiftData

struct FlashCardRow: View {
    @Bindable var card: Card
    @Environment(\.modelContext) var modelContext
    @FocusState var focusedCardID: UUID?
    var onDelete: () -> Void
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Term")
                        .bold()
                    Spacer()
                    Button("Delete", systemImage: "trash") {
                        onDelete()
                    }
                }
                TextField("Term", text: $card.term, axis: .vertical)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($focusedCardID, equals: card.id)
            }
            VStack(alignment: .leading) {
                Text("Definition").bold()
                TextEditor(text: $card.definition)
                    .frame(minHeight: 30)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
            }
        }
    }
}
