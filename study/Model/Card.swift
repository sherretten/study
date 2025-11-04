import Foundation
import SwiftData

@Model class Card {
    var id: UUID
    var term: String
    var definition: String
    var unknown: Bool
    var createdAt: Date
    
    init(term: String, definition: String, unknown: Bool = false, createdAt: Date = .now) {
        self.id = UUID()
        self.term = term
        self.definition = definition
        self.unknown = unknown
        self.createdAt = createdAt
    }
}
