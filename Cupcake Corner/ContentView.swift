//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Görkem Güray on 24.06.2024.
//

import SwiftUI


struct ContentView: View {
    
    @State private var username = ""
    @State private var email = ""
    var disableForm : Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            } //Section - 1
            
            Section {
                Button("Create account") {
                    print("Creating account...")
                } //Button
            } //Section - 2
            .disabled(disableForm)
        } //Form
    } //body
    
    
} //ContentView

#Preview {
    ContentView()
}
