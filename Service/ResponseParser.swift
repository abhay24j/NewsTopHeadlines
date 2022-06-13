//
//  ResponseParser.swift
//  NewsUpdate
//
//  Created by Abhay Kumar on 12/06/22.
//

import Foundation
struct ResponseParser {
    func convertJson<T: Codable>(data : Data?, type: T.Type, completion : (T?, NewsError?)->Void) {
        if let responseData = data {
            do {
                let dataArray  = try JSONDecoder().decode(T.self, from: responseData)
                completion(dataArray,nil)
            } catch let error {
                completion(nil,NewsError.jsonConversionError)
                print("Error isoccured \(error.localizedDescription)")
            }
            
        }
        else {
            completion(nil, NewsError.emptyResponseError)
        }
    }
}
