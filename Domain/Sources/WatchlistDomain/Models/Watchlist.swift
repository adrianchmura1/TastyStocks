//
//  Watchlist.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import Foundation

public struct Watchlist: Equatable {
    public let id: String
    public let name: String
    public var quotes: [Quote]

    public init(id: String = UUID().uuidString, name: String, quotes: [Quote] = []) {
        self.id = id
        self.name = name
        self.quotes = quotes
    }

    public mutating func update(quotes newQuotes: [Quote]) {
        for newQuote in newQuotes {
            if let index = quotes.firstIndex(where: { $0.symbol == newQuote.symbol }) {
                quotes[index] = newQuote
            } else {
                quotes.append(newQuote)
            }
        }
    }

    public mutating func add(quote: Quote) {
        quotes.append(quote)
    }

    public mutating func remove(symbol: String) {
        quotes.removeAll(where: {
            $0.symbol == symbol
        })
    }
}
