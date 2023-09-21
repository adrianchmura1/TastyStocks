//
//  WatchlistDTO.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import Foundation

struct WatchlistDTO: Codable {
    let id: String
    let name: String
    let quotes: [QuoteDTO]
}

struct QuoteDTO: Codable {
    let symbol: String
    let bid: String?
    let ask: String?
    let last: String?
}
