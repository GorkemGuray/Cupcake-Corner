//
//  Order.swift
//  Cupcake Corner
//
//  Created by Görkem Güray on 1.07.2024.
//

import SwiftUI

@Observable
class Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name: String
    var streetAddress: String
    var city: String
    var zip: String
    
    var hasValidAddress: Bool {
        if name.isEmpty || name.isBlank || streetAddress.isEmpty || streetAddress.isBlank || city.isEmpty || city.isBlank || zip.isEmpty || zip.isBlank {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity)*2
        
        // complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1 cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity)/2
        }
        
        return cost
    }
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    init() {
        if let dataName = UserDefaults.standard.data(forKey: "addressItems") {
            if let decodedName = try? JSONDecoder().decode([String].self, from: dataName) {
                name = decodedName[0]
                streetAddress = decodedName[1]
                city = decodedName[2]
                zip = decodedName[3]
                return
            }
        }
        
        name = ""
        streetAddress = ""
        city = ""
        zip = ""
    }
}

extension String {
    var isBlank: Bool {
        allSatisfy({$0.isWhitespace})
    }
}
