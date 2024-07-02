//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Görkem Güray on 24.06.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section{
                    Picker("Select your cake type", selection: $order.type){
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        } //ForEach
                    } //Picker
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                } //Section - 1
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                } //Section - 2
                
                Section {
                    NavigationLink("Delivery details") {
                        AdressView(order: order)
                    } // NavigationLink
                } //Section - 3
            } //Form
            .navigationTitle("Cupcake Corner")
        } //NavigationStack
        
    } //body
   
    
} //ContentView

#Preview {
    ContentView()
}
