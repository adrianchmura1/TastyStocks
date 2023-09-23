//
//  WatchlistPresentable.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import Foundation

struct WatchlistPresentable {
    let id: String
    let name: String
    var quotes: [QuotePresentable]

    init(id: String, name: String, quotes: [QuotePresentable] = []) {
        self.id = id
        self.name = name
        self.quotes = quotes
    }
}
