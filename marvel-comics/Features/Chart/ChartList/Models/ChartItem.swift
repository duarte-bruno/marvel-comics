//
//  ChartItem.swift
//  marvel-comics
//
//  Created by Bruno Duarte on 12/12/22.
//

import Foundation

struct ChartItem: Equatable {
    let comic: Comic
    let price: Price
    
    static func == (lhs: ChartItem, rhs: ChartItem) -> Bool {
        return lhs.comic.id == rhs.comic.id
    }
}
