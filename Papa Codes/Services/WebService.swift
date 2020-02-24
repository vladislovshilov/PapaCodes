//
//  WebService.swift
//  Papa Codes
//
//  Created by Vlados iOS on 2/24/20.
//  Copyright © 2020 Vladislav Shilov. All rights reserved.
//

import Foundation

enum WebError: Error {
    case badURL
    case error
    case customError(text: String)
    
    var localizedDescription: String {
        switch self {
        case .badURL:
            return "Seems like we can't construct url."
        case .customError(let text):
            return text
        default:
            return "Unknown error"
        }
    }
}

class WebService {
    func getAllCodes(queue: DispatchQueue = .main, completionHandler: @escaping (Result<[Promocode], WebError>) -> Void) {
        guard let url = URL(string: "https://www.papajohns.by/api/stock/codes") else {
            completionHandler(.failure(.badURL))
            return
        }
    
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let data = data {
                do {
                    var allCodes = try JSONDecoder().decode(Promocodes.self, from: data)
                    for index in 0..<allCodes.codes.count {
                        allCodes.codes[index].id = index
                    }
                    queue.async { completionHandler(.success(allCodes.codes)) }
                }
                catch {
                    queue.async { completionHandler(.failure(WebError.customError(text: error.localizedDescription))) }
                }
                
                return
            }
            else if let error = error {
                queue.async { completionHandler(.failure(WebError.customError(text: error.localizedDescription))) }
                return
            }
            
            queue.async { completionHandler(.failure(WebError.error)) }
            
        }.resume()
    }
}
