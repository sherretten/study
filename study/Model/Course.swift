//
//  Class.swift
//  study
//
//  Created by Nordic on 10/27/25.
//

import SwiftData
import Foundation

@Model final class Course {
    var updated_at: Date
    var created_at: Date
    var name: String
    var id: UUID
    @Relationship(deleteRule: .cascade) var sets = [Set]()
    
    init(updated_at: Date = .now, created_at: Date = .now, name: String) {
        self.updated_at = Date()
        self.created_at = Date()
        self.name = name
        self.id = UUID()
    }
}
