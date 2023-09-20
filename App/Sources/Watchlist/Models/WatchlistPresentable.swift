//
//  WatchlistPresentable.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import Foundation

struct WatchlistPresentable {
    let id: String
    var stocks: [String]

    init(id: String, stocks: [String] = []) {
        self.id = id
        self.stocks = stocks
    }
}
