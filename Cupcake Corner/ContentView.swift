//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Görkem Güray on 24.06.2024.
//

import SwiftUI

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    
    var name = "Taylor"
}


struct ContentView: View {
    
    var body: some View {
        Button("Encode Taylor", action: encodeTaylor)

    } //body
    
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
    
    
} //ContentView

#Preview {
    ContentView()
}
