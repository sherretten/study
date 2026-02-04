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
    @Binding var navigationPath: NavigationPath
    @State var showUnknown: Bool = false
    @State var showAllAnswers: Bool = false
    
    init(set: Set, navigationPath: Binding<NavigationPath>) {
        self.set = set
        _answers  = State(initialValue: set.cards.map { _ in CardAnswer() })
        _navigationPath = navigationPath
    }
    
    private var filteredCards: [(offset: Int, element: Card)] {
        let enumerated = Array(set.sortedCards.enumerated())
        if showUnknown {
            return enumerated.filter { set.sortedCards[$0.offset].unknown }
        }
        return enumerated
    }

    var body: some View {
        List {
            ForEach(filteredCards, id: \.element.id) { offset, card in
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("\(offset + 1) :")
                        Text(card.term)
                        Spacer()
                        Toggle(isOn: $set.cards[offset].unknown) {
                            Image(systemName: set.cards[offset].unknown ? "flag.fill" : "flag")
                        }
                        .toggleStyle(.button).padding()
                    }
                    TextEditor(text: $answers[offset].userAnswer)
                        .frame(minHeight: 100)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                    
                    if answers[offset].showAnswer || showAllAnswers {
                        Text(card.definition).padding(8).foregroundStyle(Color.green).font(.title2)
                    }
                    Button(action: {
                        answers[offset].showAnswer.toggle()
                    }) {
                        Text(answers[offset].showAnswer ? "Hide Answer" : "Show answer")
                    }.foregroundColor(.blue)
                }
                .padding()
                .background(Color(.white))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                .id(card.id)
            }
        }
        .padding()
        .navigationTitle("Testing \(set.name)")
        .background(Color(.systemGray6).ignoresSafeArea())
        .toolbar {
            Toggle(isOn: $showUnknown) {
                HStack {
                    Image(systemName: showUnknown ? "flag" : "flag.fill")
                    Text(showUnknown ? "All" : "Flagged only")
                    Spacer()
                }
            }.toggleStyle(.button)
            Toggle(isOn: $showAllAnswers) {
                HStack {
                    Text(showUnknown ? "Hide Answers" : "Show answers")
                    Spacer()
                }
            }.toggleStyle(.button)
        }
    }
}
