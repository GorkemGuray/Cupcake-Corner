//
//  AdressView.swift
//  Cupcake Corner
//
//  Created by Görkem Güray on 2.07.2024.
//

import SwiftUI

struct AdressView: View {
    @Bindable var order : Order
    
    var body: some View {
        Form {
            Section{
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            } //Section-1
            
            Section{
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                } //NavigationLink
            } //Section-2
            .disabled(order.hasValidAddress == false)
        } //Form
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AdressView(order: Order())
}
