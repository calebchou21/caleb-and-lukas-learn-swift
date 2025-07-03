//
//  ContentView.swift
//  random-cat-facts
//
//  Created by caleb chou on 7/3/25.
//

import SwiftUI

struct CatFact: Codable {
    let fact: String
    let length: Int
}

enum CatFactError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct ContentView: View {
    @State var catFact: String?
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(catFact ?? "Press the button to get a cat fact!")
            Button(action: {
                Task {
                    catFact = try await fetchCatFact().fact
                }
            }) {
                Text("New Cat Fact")
            }
                .buttonStyle(.bordered)
                .cornerRadius(50)
        }
        .padding()
    }
    
    func fetchCatFact() async throws -> CatFact {
        guard let url = URL(string: "https://catfact.ninja/fact") else {
            throw CatFactError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw CatFactError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(CatFact.self, from: data)
        } catch {
            throw CatFactError.invalidData
        }
    }
}

#Preview {
    ContentView()
}
