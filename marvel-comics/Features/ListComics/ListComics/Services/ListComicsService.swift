//
//  ListComicsService.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 10/12/22.
//

import Foundation
import UIKit

protocol ListComicsServiceProtocol {
    
    init(_ request: HttpRequest)
    
    func getComics(completion: @escaping (Result<ComicsResult, HttpError>) -> Void)
}

class ListComicsService: ListComicsServiceProtocol {
    private let request: HttpRequest
    
    required init(_ request: HttpRequest) {
        self.request = request
    }
    
    func getComics(completion: @escaping (Result<ComicsResult, HttpError>) -> Void) {
        let params = HttpParams(path: "/v1/public/comics", queryParams: ["startYear": "2022", "limit": "100", "orderBy": "modified"])
        request.get(params, completion: completion)
    }
}
