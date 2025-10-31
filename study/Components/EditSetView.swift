import Foundation
import SwiftUI
import SwiftData

struct EditSetView: View {
    @Bindable var set: Set
    @State private var currentIndex = 0;
    @State private var isFlipped = false
    @Binding var navigationPath: NavigationPath

    @State private var rotation: Double = 0;
    
    var body: some View {
        Form {
            TextField("Set name", text: $set.name)
            
            HStack(spacing: 12) {
                Button("Shuffle", systemImage: "shuffle") { set.cards.shuffle() }
                Button("Export", systemImage: "square.and.arrow.up") {}
                Button(action: {navigationPath.append(Destination.editCards(set))}) {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit Cards")
                    }
                }
                Button(action: {navigationPath.append(Destination.testSet(set))}) {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Test Set")
                    }
                }
            }.buttonStyle(.plain)
            
            if set.cards.isEmpty {
                ContentUnavailableView("No cards yet", systemImage: "tray", description: Text("Add a card"))
            } else {
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 550, height: 400)
                        .foregroundStyle(Color.blue)
                        .overlay(
                            Text(set.cards[currentIndex].term).font(.title).padding().foregroundStyle(Color.white)
                        )
                        .opacity(isFlipped ? 0 : 1)
                        .rotation3DEffect(.degrees(isFlipped ? 180: 0), axis: (x: 0, y: 1, z: 0))
                        .scaledToFit()
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 550, height: 400)
                        .foregroundStyle(Color.green)
                        .overlay(
                            ScrollView {
                                Text(set.cards[currentIndex].definition)
                                    .font(.title)
                                    .padding()
                                    .foregroundStyle(Color.white)
                            }
                        )
                        .opacity(isFlipped ? 1 : 0)
                        .rotation3DEffect(.degrees(isFlipped ? 0:  -180), axis: (x: -1, y: 1, z: 0))
                        .scaledToFit()
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.6)) {
                        isFlipped.toggle();
                    }
                }
//                .frame(minWidth/*: .infinity)*/
                
                HStack {
                    Button("Previous") {
                        currentIndex -= 1
                    }.disabled(currentIndex == 0)
                    Button("Next") {
                        currentIndex += 1
                    }.disabled(currentIndex == set.cards.count - 1)
                }
            }
        }
    }
}
