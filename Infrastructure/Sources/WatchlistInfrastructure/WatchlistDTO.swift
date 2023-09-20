//
//  WatchlistDTO.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import Foundation

struct WatchlistDTO: Codable {
    let id: String
    let stocks: [String]
}
