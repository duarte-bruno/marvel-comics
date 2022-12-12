//
//  Comic.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 10/12/22.
//

import Foundation

struct Comic: Codable {
    let id, digitalId: Int
    let title: String
    let issueNumber: Int
    let variantDescription: String
    let resultDescription: String?
    let pageCount: Int
    let prices: [Price]
    let thumbnail: Thumbnail
    let images: [Thumbnail]
    let creators: Creators
    
    enum CodingKeys: String, CodingKey {
        case id
        case digitalId
        case title
        case issueNumber
        case variantDescription
        case resultDescription = "description"
        case pageCount
        case prices
        case thumbnail
        case images
        case creators
    }
}

// MARK: - Creators
struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

// MARK: - CreatorsItem
struct CreatorsItem: Codable {
    let resourceURI: String
    let name: String
    let role: String
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
    
    enum ThumbSize: String {
        case portrait_uncanny
        case standard_fantastic
    }
    
    func thumbUrl(size: ThumbSize) -> String {
        var url = path.replacingOccurrences(of: "http://", with: "https://")
        url = url + "/\(size.rawValue)." + thumbnailExtension
        return url
    }
}

// MARK: - Price
struct Price: Codable {
    let type: PriceType
    let price: Double
    
    enum PriceType: String, Codable {
        case printPrice
        case digitalPrice
        
        func label() -> String {
            switch self {
            case .printPrice:
                return "Printed"
            case .digitalPrice:
                return "Digital"
            }
        }
    }
}
