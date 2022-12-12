//
//  UserDefaultsDataStore.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import Foundation

class UserDefaultsDataStore: DataStore {
    
    func getData<T: Codable>(from path: String, completion: @escaping (Result<T?, Error>) -> Void) {
        do {
            let defaults = UserDefaults.standard
            guard let data = defaults.object(forKey: path) as? Data else {
                completion(.success(nil))
                return
            }
            let decoder = JSONDecoder()
            let object = try decoder.decode(T.self, from: data)
            completion(.success(object))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func postData<T: Codable>(inside path: String, data: T, completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(data)
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: path)
            completion(.success(true))
        } catch let error {
            completion(.failure(error))
        }
    }
}
