//
//  StockDataResponse.swift
//  
//
//  Created by Adrian Chmura on 24/09/2023.
//

import Foundation

struct StockDataResponse: Decodable {
    var quote: QuoteResponse
}

struct QuoteResponse: Decodable {
    let latestPrice: Double?
    let symbol: String
    let askPrice: Double?
    let bidPrice: Double?

    enum CodingKeys: String, CodingKey {
        case latestPrice
        case symbol
        case askPrice = "iexAskPrice"
        case bidPrice = "iexBidPrice"
    }
}
