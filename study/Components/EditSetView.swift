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
    @State var currentIndex = 0;
    
    
    var body: some View {
        Form {
            TextField("Set name", text: $set.name)
            Section {
                
                Button("Shuffle") { set.cards.shuffle() }
                NavigationLink(value: set){
                    TestView(set: set)
                }
                Text(set.cards[currentIndex].term)
                
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
