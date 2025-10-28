//
//  EditCourseView.swift
//  study
//
//  Created by Nordic on 10/27/25.
//

import SwiftUI
import SwiftData

struct EditCourseView: View {
    @Bindable var course: Course
    @State private var newSetName = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $course.name)
            Section("Sets") {
                ForEach(course.sets) { set in
                    Text(set.name)
                }
                HStack {
                    TextField("Add a new set in \(course.name)", text: $newSetName)
                    Button("Add", action: addSet)
                }
            }
        }
        .navigationTitle("Edit Course")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addSet() {
        guard newSetName.isEmpty == false else { return }
        
        withAnimation {
            let set = Set(name: newSetName)
            course.sets.append(set)
            newSetName = ""
        }
    }
}

#Preview {
    do {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Course.self, configurations: configuration)
        let example = Course(name: "Testing course 1")
        return EditCourseView(course: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}
