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
    
    init(set: Set, navigationPath: Binding<NavigationPath>) {
        self.set = set
        _answers  = State(initialValue: set.cards.map { _ in CardAnswer() })
        _navigationPath = navigationPath
    }

    
    var body: some View {
        Text("Hello test view").navigationTitle("Testing \(set.name)")
//        ScrollView {
//            ForEach(Array(set.cards.enumerated()), id: \.element.id) { index, card in
//                VStack {
//                    HStack {
//                        Text("\(index + 1) :")
//                        Text(card.term)
//                    }
//                    TextField("Enter definition", text: $answers[index].userAnswer)
//                    
//                    if answers[index].showAnswer {
//                        Text(card.definition).font(.subheadline).padding(8)
//                    }
//                    Button(action: {
//                        answers[index].showAnswer.toggle()
//                    }) {
//                        Text(answers[index].showAnswer ? "Hide Answer" : "Show answer")
//                    }.foregroundColor(.blue)
//                }
//                .padding()
//                .background(Color(.systemBackground))
//                .cornerRadius(12)
//                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
//            }
//        }
    }
}
