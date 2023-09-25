//
//  Quote.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation

public struct Quote: Equatable {
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
