//
//  HttpRequest.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 09/12/22.
//

import Foundation

struct HttpParams {
    let path: String
    let queryParams: [String: String]?
}

protocol HttpRequest {
    
    init(_ configuration: AppConfiguration)
    
    func get<T: Codable>(_ params: HttpParams, completion: @escaping (Result<T, HttpError>) -> Void)
}

enum HttpError: Error, CustomStringConvertible {
    case invalidPath
    case transportError(Error?)
    case serverSideError(Int)
    case unexpected
    case serialization
    
    public var description: String {
        switch self {
        case .invalidPath:
            return "The requested path is not valid."
        case .transportError(let error):
            return "Some errors occurred while trying to request the server. Description: (\(error?.localizedDescription ?? ""))."
        case .serverSideError(let code):
            return "The request failed with the status code \(code)."
        case .unexpected:
            return "Some unexpected error ocurred."
        case .serialization:
            return "Cannot serialize response into requested object."
        }
    }
}
