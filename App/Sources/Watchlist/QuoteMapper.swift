//
//  QuoteMapper.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
import WatchlistDomain

struct QuoteMapper {
    static func mapToQuotePresentable(quote: Quote) -> QuotePresentable {
        return QuotePresentable(
            symbol: quote.symbol,
            askPrice: quote.ask ?? "N/A",
            bidPrice: quote.bid ?? "N/A",
            lastPrice: quote.last ?? "N/A"
        )
    }
}
