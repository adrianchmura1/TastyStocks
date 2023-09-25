//
//  MockSymbolsRepository.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
@testable import WatchlistDomain


final class MockSymbolsRepository: SymbolsRepositoryProtocol {
    enum SearchError: Error {
        case mockError
    }

    var shouldThrowError: Bool = false

    func findSymbol(text: String, completion: @escaping (Result<[QuoteSearchResult], Error>) -> Void) {
        if shouldThrowError {
            completion(.failure(SearchError.mockError))
        } else {
            let results = [
                QuoteSearchResult(symbol: "AAPL", name: "Apple Inc."),
                QuoteSearchResult(symbol: "GOOGL", name: "Alphabet Inc."),
            ]
            completion(.success(results))
        }
    }
}
