import SwiftUI

struct ExportSheet: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @Binding var exportedText: String
    @State private var showingCopied = false
    
    var body: some View {
        Form {
            Button(action: {
                UIPasteboard.general.string = exportedText
                showingCopied = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showingCopied = false
                }
            }) {
                HStack {
                    Image(systemName: showingCopied ? "checkmark" : "doc.on.doc")
                    Text(showingCopied ? "Copied!" : "Copy to Clipboard")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
        }
        ScrollView {
            Text(exportedText)
                .font(.system(.body, design: .monospaced))
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
        }
    }
}
