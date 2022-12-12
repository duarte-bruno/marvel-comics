//
//  Str.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 11/12/22.
//

import Foundation

enum Str: String {
    
    /// It finds the localized string in the language of the device, if not found, it returns the string from the default file.
    func l() -> String {
        var localizedString = Bundle.main.localizedString(forKey: self.rawValue, value: nil, table: nil)

        if localizedString == self.rawValue {
            localizedString = Bundle.main.localizedString(forKey: self.rawValue, value: nil, table: "Default")
        }

        return localizedString
    }
    
    // MARK: - Global
    
    case InitCoderNotImplemented
    
    case TransportErrorTitle
    case TransportErrorMessage
    
    case SystemErrorTitle
    case SystemErrorMessage
    
    // MARK: - ListComics
    
    case ListComicsTitle
}
