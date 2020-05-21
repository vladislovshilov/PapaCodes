//
//  Code.swift
//  Papa Codes
//
//  Created by Vlados iOS on 2/24/20.
//  Copyright © 2020 Vladislav Shilov. All rights reserved.
//

import Foundation
import SwiftUI

struct Promocode: Decodable, Hashable, Identifiable {
    var id: Int?
    
    var name: String
    var code: String
    var isGiftCode: Bool
    var price: Double
    
    private var hasImage: Bool?
    private var imageMobileStock: Bool?
    private var imageMobileShop: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name, code
        case hasImage = "image"
        case imageMobileStock = "image_mobile_stock"
        case imageMobileShop = "image_mobile_shop"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(String.self, forKey: .code)
        name = try container.decode(String.self, forKey: .name)
        for _ in 0...1 {
            guard let dashIndex = name.firstIndex(of: "-") else { break }
            let index = name.index(dashIndex, offsetBy: 1)
            name.removeSubrange(name.startIndex...index)
        }
        
        isGiftCode = !name.contains("%")
        
        if let dashIndex = name.firstIndex(of: "-") {
            let startIndex = name.index(dashIndex, offsetBy: 5)
            let endIndex = name.index(startIndex, offsetBy: 4)
            let range = startIndex...endIndex
            let priceString = name[range].replacingOccurrences(of: ",", with: ".")
            price = Double(priceString) ?? 0
        }
        else {
            price = 0
        }
        
        print(price)
    }
    
    init() {
        self.name = "test name"
        self.code = "test"
        self.isGiftCode = true
        self.price = 0
    }
}
