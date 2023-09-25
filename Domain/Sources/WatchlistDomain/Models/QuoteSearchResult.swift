//
//  QuoteSearchResult.swift
//  
//
//  Created by Adrian Chmura on 22/09/2023.
//

import Foundation

public struct QuoteSearchResult: Equatable {
    public let symbol: String
    public let name: String

    public init(symbol: String, name: String) {
        self.symbol = symbol
        self.name = name
    }
}
