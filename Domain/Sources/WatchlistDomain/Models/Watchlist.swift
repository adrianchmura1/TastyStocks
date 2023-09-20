//
//  Watchlist.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import Foundation

public struct Watchlist {
    public let id: String
    public var stocks: [String]

    public init(id: String, stocks: [String] = []) {
        self.id = id
        self.stocks = stocks
    }
}
