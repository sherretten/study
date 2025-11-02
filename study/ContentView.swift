import SwiftUI
import SwiftData

enum Destination: Hashable {
    case course(Course)
    case setItem(Set)
    case editCards(Set)
    case testSet(Set)
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var navigationPath = NavigationPath()
    @Query var courses: [Course]
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                ForEach(courses) { course in
                    NavigationLink(course.name, value: course)
                }
                .onDelete(perform: deleteCourses)
            }
            .navigationTitle("Courses")
            .navigationDestination(for: Course.self) { course in
                    EditCourseView(course: course, navigationPath: $navigationPath)
            }
            .toolbar {
                Button("Add Course", systemImage: "plus", action: addCourse)
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .course(let course):
                    EditCourseView(course: course, navigationPath: $navigationPath)
                case .setItem(let set):
                    EditSetView(set: set, navigationPath: $navigationPath)
                case .editCards(let set):
                    EditCardsView(set: set, navigationPath: $navigationPath)
                case .testSet(let set):
                    TestView(set: set, navigationPath: $navigationPath)
                }
            }
        }
    }
    
    func addCourse() {
        let course = Course(name: "")
        modelContext.insert(course)
        navigationPath.append(Destination.course(course))
    }
    
    func deleteCourses(_ indexSet: IndexSet) {
        for index in indexSet {
            let course = courses[index]
            modelContext.delete(course)
        }
    }
}
