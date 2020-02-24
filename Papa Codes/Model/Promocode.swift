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
            guard let index = name.firstIndex(of: "-") else { break }
            name.removeSubrange(name.startIndex...index)
        }
        
        isGiftCode = !name.contains("%")
    }
    
    init() {
        self.name = "test name"
        self.code = "test"
        self.isGiftCode = true
    }
}
