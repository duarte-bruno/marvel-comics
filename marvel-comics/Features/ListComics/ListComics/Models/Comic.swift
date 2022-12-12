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
    }
    
    func thumbUrl(size: ThumbSize) -> String {
        var url = path.replacingOccurrences(of: "http://", with: "https://")
        url = url + "/\(size.rawValue)." + thumbnailExtension
        return url
    }
}

// MARK: - Price
struct Price: Codable {
    let type: String
    let price: Double
}
