//
//  EditSetView.swift
//  study
//
//  Created by Nordic on 10/27/25.
//

import Foundation
import SwiftUI
import SwiftData

struct EditSetView: View {
    @Bindable var set: Set
    @State private var currentIndex = 0;
    @State private var isFlipped = false
    @State private var rotation: Double = 0;
    
    
    var body: some View {
        Form {
            TextField("Set name", text: $set.name)
            Section {
                
                Button("Shuffle") { set.cards.shuffle() }
                Button("Export") {}
                NavigationLink(value: set) {
                    EditCardsView(set: set)
                }                }
                NavigationLink(value: set){
                    TestView(set: set)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 300, height: 300)
                        .opacity(isFlipped ? 0 : 1)
                        .rotation3DEffect(.degrees(rotation + 180), axis: (x: 0, y: 1, z: 0))
                        .overlay(
                            Text(set.cards[currentIndex].term).font(.title).padding()
                        )
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 300, height: 300)
                        .opacity(isFlipped ? 1 : 0)
                        .rotation3DEffect(.degrees(rotation + 180), axis: (x: 0, y: 1, z: 0))
                        .overlay(
                            Text(set.cards[currentIndex].term).font(.title).padding()
                        )
                                
                    }
                .onTapGesture {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        rotation += 180
                        isFlipped.toggle();
                }
                }
                
                Button("Previous") {
                    currentIndex -= 1
                }.disabled(currentIndex == 0)
                Button("Next") {
                    currentIndex += 1
                }.disabled(currentIndex == set.cards.count - 1)
            }
        }        
}
