//
//  studyApp.swift
//  study
//
//  Created by Nordic on 10/25/25.
//

import SwiftUI
import SwiftData

@main
struct studyApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Course.self)
    }
}
