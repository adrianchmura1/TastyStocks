//
//  QuoteResponseMapper.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import WatchlistDomain
import Foundation

final class QuoteResponseMapper {
    func map(quoteResponse: QuoteResponse) -> Quote {
        Quote(
            symbol: quoteResponse.symbol,
            bid: quoteResponse.bidPrice.map { String($0) },
            ask: quoteResponse.askPrice.map { String($0) },
            last: quoteResponse.latestPrice.map { String($0) }
        )
    }
}
