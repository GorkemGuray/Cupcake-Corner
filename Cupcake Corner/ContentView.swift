//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Görkem Güray on 24.06.2024.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable{
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack (alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            } //VStack
            
        } //List
        .task {
            await loadData()
        }
    } //body
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        } //guard let url
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        } //do-catch
        
    } //func loadData
    
} //ContentView

#Preview {
    ContentView()
}
