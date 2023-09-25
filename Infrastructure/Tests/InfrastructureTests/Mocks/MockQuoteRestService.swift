//
//  MockQuoteRestService.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import XCTest
@testable import WatchlistInfrastructure
import WatchlistDomain

final class MockQuoteRestService: QuoteRestServiceProtocol {
    var fetchQuoteSymbol: String?
    var fetchQuoteResult: Result<Quote, Error>?

    func fetchQuote(symbol: String, completion: @escaping (Result<Quote, Error>) -> Void) {
        fetchQuoteSymbol = symbol
        if let result = fetchQuoteResult {
            completion(result)
        }
    }
}
