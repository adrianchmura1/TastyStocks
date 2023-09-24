//
//  SymbolSearchResponse.swift
//  
//
//  Created by Adrian Chmura on 24/09/2023.
//

import Foundation

struct SymbolSearchResponse: Decodable {
    let data: SymbolSearchDataResponse
}

struct SymbolSearchDataResponse: Decodable {
    let items: [SymbolSearchDataItemResponse]
}

struct SymbolSearchDataItemResponse: Decodable {
    let symbol: String
    let description: String
}

