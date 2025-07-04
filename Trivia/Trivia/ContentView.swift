import SwiftUI

struct ContentView: View {
    @State private var speed = 50.0
    @State private var isEditing = false
    @State private var triviaQuestions: [TriviaQuestion]?
    
    var body: some View {
        VStack {
            if let questions = triviaQuestions, !questions.isEmpty {
                Text(questions[0].question.stringByDecodingHTMLEntities)
            } else {
                Text("Hello World")
            }
        }
        .task {
            do {
                triviaQuestions = try await fetchTriviaData().results
            } catch {
                print("Failed to fetch trivia")
            }
        }
        .padding()
        if let questions = triviaQuestions {
            Option(text: questions[0].correctAnswer, action: {})
            ForEach(questions[0].incorrectAnswers, id: \.self) { ans in
                Option(text: ans, action: {})
            }
        } else {
            Text("Loading")
        }
        
    }
}

#Preview {
    ContentView()
}
