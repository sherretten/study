import SwiftUI
import SwiftData

struct EditCourseView: View {
    @Bindable var course: Course
    @Binding var navigationPath: NavigationPath
    @State private var newSetName = ""
    
    var body: some View {
        Form {
            Section("Course Name") {
                TextField("Name", text: $course.name).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Section("Sets") {
                List(course.sets) { set in
                    NavigationLink(value: Destination.setItem(set)) {
                        Text(set.name)
                    }
                }
                
                HStack {
                    TextField("Add a new set in \(course.name)", text: $newSetName).textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Add", action: addSet).disabled(newSetName.isEmpty)
                }
            }
        }
        .navigationTitle(course.name)
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
