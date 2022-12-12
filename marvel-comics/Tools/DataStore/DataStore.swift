//
//  DataStore.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import Foundation

protocol DataStore {
    func getData<T: Codable>(from path: String, completion: @escaping (Result<T?, Error>) -> Void)
    func postData<T: Codable>(inside path: String, data: T, completion: @escaping (Result<Bool, Error>) -> Void)
}
