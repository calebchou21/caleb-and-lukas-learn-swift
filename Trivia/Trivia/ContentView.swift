import SwiftUI

struct ContentView: View {
    @State private var speed = 50.0
    @State private var isEditing = false
    @State private var triviaQuestions: [TriviaQuestion]?
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            if let questions = triviaQuestions, !questions.isEmpty {
                Text(questions[0].question.stringByDecodingHTMLEntities)
            } else {
                Text("Hello World")
            }
            Slider(
                value: $speed,
                in: 0...100,
                onEditingChanged: { editing in
                    isEditing = editing
                }
            )
        }
        .padding()
        .task {
            do {
                triviaQuestions = try await fetchTriviaData().results
            } catch {
                print("Failed to fetch trivia")
            }
        }
    }
}

#Preview {
    ContentView()
}
