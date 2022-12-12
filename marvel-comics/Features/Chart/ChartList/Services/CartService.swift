//
//  CartService.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import Foundation

protocol CartServiceProtocol {
    
    init(_ dataStore: DataStore)
    
    func getCartPurchases(completion: @escaping (Result<[Comic]?, Error>) -> Void)
    func postCartPurchases(data: [Comic], completion: @escaping (Result<Bool, Error>) -> Void)
}

class CartService: CartServiceProtocol {
    private let dataStore: DataStore
    
    required init(_ dataStore: DataStore) {
        self.dataStore = dataStore
    }
    
    func getCartPurchases(completion: @escaping (Result<[Comic]?, Error>) -> Void) {
        dataStore.getData(from: "purchases", completion: completion)
    }
    
    func postCartPurchases(data: [Comic], completion: @escaping (Result<Bool, Error>) -> Void) {
        dataStore.postData(inside: "purchases", data: data, completion: completion)
    }
}
