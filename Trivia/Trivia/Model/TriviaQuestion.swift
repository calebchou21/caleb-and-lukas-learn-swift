import Foundation

struct TriviaResponse: Codable {
    let responseCode: Int
    let results: [TriviaQuestion]
}

struct TriviaQuestion: Codable {
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
}

enum TriviaError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

func fetchTriviaData() async throws -> TriviaResponse {
    guard let url = URL(string: "https://opentdb.com/api.php?amount=10") else {
        throw TriviaError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw TriviaError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(TriviaResponse.self, from: data)
    } catch {
        throw TriviaError.invalidData
    }
}
