//
//  CodesViewModel.swift
//  Papa Codes
//
//  Created by Vlados iOS on 2/24/20.
//  Copyright © 2020 Vladislav Shilov. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class CodesViewModel: ObservableObject {
    @Published var promocodes = [Promocode]()
    @Published var error = ""
    
    init() {
        fetchAllCodes()
    }
    
    func fetchAllCodes() {
        WebService().getAllCodes { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let codes):
                self.promocodes = codes.sorted { $0.price < $1.price }
                                       .sorted { $0.isGiftCode && !$1.isGiftCode }
            case .failure(let error):
                self.error = error.localizedDescription
            }
        }
    }
}
