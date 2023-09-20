//
//  Watchlist.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import Foundation

public struct Watchlist {
    public let id: String
    public let name: String
    public var quotes: [Quote]

    public init(id: String, name: String, quotes: [Quote] = []) {
        self.id = id
        self.name = name
        self.quotes = quotes
    }
}

public struct Quote {
    public let symbol: String
    public let bid: String
    public let ask: String
    public let last: String

    public init(symbol: String, bid: String = "", ask: String = "", last: String = "") {
        self.symbol = symbol
        self.bid = bid
        self.ask = ask
        self.last = last
    }
}
