//
//  QuoteRepositoryMock.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
@testable import WatchlistDomain

final class QuoteRepositoryMock: QuoteRepositoryProtocol {
    enum MockError: Error {
        case unknown
    }

    var mockResult: Result<Quote, Error>?

    func fetchQuote(symbol: String, completion: @escaping (Result<Quote, Error>) -> Void) {
        if let mockResult = mockResult {
            completion(mockResult)
        }
    }
}
