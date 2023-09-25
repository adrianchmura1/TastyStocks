//
//  SymbolHistoryRepositoryMock.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
@testable import WatchlistDomain

final class MockSymbolHistoryRepository: SymbolHistoryRepositoryProtocol {
    enum MockError: Error {
        case unknown
    }

    var mockResult: Result<SymbolPriceHistory, Error>?

    func fetchLatestPrice(for symbol: String, completion: @escaping (Result<SymbolPriceHistory, Error>) -> Void) {
        if let mockResult = mockResult {
            completion(mockResult)
        }
    }
}
