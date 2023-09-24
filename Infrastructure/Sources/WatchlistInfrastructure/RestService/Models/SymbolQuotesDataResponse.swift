//
//  SymbolQuotesDataResponse.swift
//  
//
//  Created by Adrian Chmura on 24/09/2023.
//

import Foundation

struct SymbolQuotesDataResponse: Decodable {
    let open: Double
    let close: Double
    let high: Double
    let low: Double
}
