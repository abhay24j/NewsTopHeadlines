//
//  NetworkService.swift
//  NewsUpdate
//
//  Created by Abhay Kumar on 12/06/22.
//

import Foundation

enum NewsError : Error{
    case invalidUrlError
    case networkError
    case jsonConversionError
    case invalidResponsError
    case emptyResponseError
}

class NetworkService {
    
    
    static let shared : NetworkService = NetworkService()
    func readData<T: Codable>(fromURLStr : String,type: T.Type, completion : @escaping (_ news: T?, _ error: NewsError?)->Void) {
        
        guard let url : URL = URL(string: fromURLStr) else {
            print("Unable to create url from string -->> \(fromURLStr)")
            completion(nil, NewsError.invalidUrlError)
            return
        }
        
        let urlRequest = URLRequest(url: url)

        let session = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            
            if let errorExist = error {
                print(errorExist.localizedDescription)
                completion(nil, NewsError.networkError)
                return
            }
            let jsonParser = ResponseParser()
            jsonParser.convertJson(data: data, type: T.self, completion: completion)
        }
        session.resume()
        
    }
}
