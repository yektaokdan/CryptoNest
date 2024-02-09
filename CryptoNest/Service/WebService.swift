//
//  WebService.swift
//  CryptoNest
//
//  Created by yekta on 9.02.2024.
//

import Foundation

enum CryptoError : Error {
    case serverError
    case parsingError
}
class WebService{
    func downloadCurrencies (url:URL, completion:@escaping (Result<[Crypto], CryptoError>) -> () ){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error{
                completion(.failure(.serverError))
            } else if let data = data {
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                }
                else{
                    completion(.failure(.parsingError))
                }
            }
            
        }.resume()
    }
}
