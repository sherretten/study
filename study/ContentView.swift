//
//  ContentView.swift
//  study
//
//  Created by Nordic on 10/25/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var courses: [Course]
    @State private var path = [Course]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(courses) { course in
                    NavigationLink(value: course) {
                        HStack {
                            Text(course.name).font(.headline)
                        }
                    }
                }
                .onDelete(perform: deleteCourses)
            }
            .navigationTitle("Courses")
            .navigationDestination(for: Course.self, destination: EditCourseView.init)
            .toolbar {
                Button("Add Course", systemImage: "plus", action: addCourse)
            }
        }
    }
    

    
    func addCourse() {
        let course = Course(name: "")
        modelContext.insert(course)
        path = [course]
    }
    
    func deleteCourses(_ indexSet: IndexSet) {
        for index in indexSet {
            let course = courses[index]
            modelContext.delete(course)
        }
    }
}
