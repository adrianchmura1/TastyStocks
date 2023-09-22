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

    public mutating func update(quotes newQuotes: [Quote]) {
        quotes = newQuotes
    }

    public mutating func add(quote: Quote) {
        quotes.append(quote)
    }
}

public struct Quote {
    public let symbol: String
    public let bid: String?
    public let ask: String?
    public let last: String?

    public init(symbol: String, bid: String? = nil, ask: String? = nil, last: String? = nil) {
        self.symbol = symbol
        self.bid = bid
        self.ask = ask
        self.last = last
    }
}
