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
