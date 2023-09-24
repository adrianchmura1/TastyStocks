//
//  SymbolHistoryRepository.swift
//  
//
//  Created by Adrian Chmura on 24/09/2023.
//

import WatchlistDomain
import Foundation

final class SymbolHistoryRepository: SymbolHistoryRepositoryProtocol {
    private let restService: QuotesRestServiceProtocol

    init(restService: QuotesRestServiceProtocol) {
        self.restService = restService
    }

    func fetchLatestPrice(for symbol: String, completion: @escaping (Result<SymbolPriceHistory, Error>) -> Void) {
        restService.fetchLatestPrice(for: symbol, completion: completion)
    }
}
