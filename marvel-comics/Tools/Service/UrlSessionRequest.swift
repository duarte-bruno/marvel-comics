//
//  UrlSessionRequest.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 09/12/22.
//

import Foundation

class UrlSessionRequest: HttpRequest {
    private let configuration: AppConfiguration
    
    required init(_ configuration: AppConfiguration) {
        self.configuration = configuration
    }
    
    func get<T: Codable>(_ params: HttpParams, completion: @escaping (Result<T, HttpError>) -> Void) {
        guard let url = createUrl(params) else {
            completion(.failure(.invalidPath))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.unexpected))
                return
            }

            guard (200..<300) ~= response.statusCode else {
                completion(.failure(.serverSideError(response.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.serialization))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(.serialization))
                return
            }
        }
        task.resume()
    }
    
    private func createUrl(_ params: HttpParams) -> URL? {
        var queryParams = [URLQueryItem]()
        
        queryParams.append(contentsOf: [
            URLQueryItem(name: "ts", value: configuration.ts),
            URLQueryItem(name: "apikey", value: configuration.publicKey),
            URLQueryItem(name: "hash", value: configuration.hash)
        ])
        
        for queryParam in params.queryParams ?? [:] {
            queryParams.append(URLQueryItem(name: queryParam.key, value: queryParam.value))
        }

        var urlComponents = URLComponents(string: configuration.baseUrl + params.path)
        urlComponents?.queryItems = queryParams
        return urlComponents?.url
    }
}
