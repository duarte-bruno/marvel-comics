//
//  AppConfiguration.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 09/12/22.
//

import Foundation

protocol AppConfiguration {
    
    // MARK: - HTTP Request Properties
    
    var ts: String { get }
    var publicKey: String { get }
    var hash: String { get }
    var baseUrl: String { get }
}

class ProdAppConfig: AppConfiguration {

    static let shared = ProdAppConfig()

    // MARK: - HTTP Request Properties
    
    let ts: String = "1"
    let publicKey: String = "bbe75b87f606dd47a347fb0f373ee909"
    let hash: String = "bab9c1332d7c0967c4aa4115ee9837c3"
    let baseUrl: String = "https://gateway.marvel.com"

    // MARK: - Initialization

    private init() {
    }
}
