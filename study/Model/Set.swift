import Foundation
import SwiftData

@Model class Set {
    var id: UUID
    var name: String
    var createdAt: Date
    var updatedAt: Date
    @Relationship(deleteRule: .cascade) var cards = [Card]()
    
    var sortedCards: [Card] {
        cards.sorted { $0.createdAt < $1.createdAt }
    }
    
    init(name: String, createdAt: Date = .now, updatedAt: Date = .now) {
        self.id = UUID()
        self.name = name
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
