import Foundation
import SwiftUI
import SwiftData

struct EditSetView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var set: Set
    @State private var currentIndex = 0;
    @State private var isFlipped = false
    @Binding var navigationPath: NavigationPath
    @State var showingImport = false

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
                HStack {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 650, height: 400)
                            .foregroundStyle(Color.blue)
                            .overlay(
                                Text(set.cards[currentIndex].term).font(.title).padding().foregroundStyle(Color.white)
                            )
                            .opacity(isFlipped ? 0 : 1)
                            .rotation3DEffect(.degrees(isFlipped ? 180: 0), axis: (x: 0, y: 1, z: 0))
                            .scaledToFit()
                        
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 650, height: 400)
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
                            .rotation3DEffect(.degrees(isFlipped ? 0:  -180), axis: (x: 0, y: 1, z: 0))
                            .scaledToFit()
                    }
                    .onTapGesture {
                        withAnimation(.spring(response: 0.6)) {
                            isFlipped.toggle();
                        }
                    }
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    Button("Previous") {
                        currentIndex -= 1
                        if isFlipped {
                            isFlipped.toggle()
                        }
                    }.disabled(currentIndex == 0).padding()
                    Toggle(isOn: $set.cards[currentIndex].unknown) {
                        Image(systemName: set.cards[currentIndex].unknown ? "flag.fill" : "flag")
                    }
                    .toggleStyle(.button).padding()
                    Button("Next") {
                        currentIndex += 1
                        if isFlipped {
                            isFlipped.toggle()
                        }
                    }
                    .disabled(currentIndex == set.cards.count - 1)
                    .padding()
                    Spacer()
                }.buttonStyle(.plain)
            }
        }.toolbar {
            Button("Import", systemImage: "square.and.arrow.down") {
                showingImport.toggle()
            }
            .sheet(isPresented: $showingImport) {
                ImportSheet(set: set)
            }
        }
    }
}
