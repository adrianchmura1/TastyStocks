//
//  SymbolHistoryRepository.swift
//  
//
//  Created by Adrian Chmura on 24/09/2023.
//

import WatchlistDomain
import Foundation

final class SymbolHistoryRepository: SymbolHistoryRepositoryProtocol {
    private let restService: ChartRestServiceProtocol

    init(restService: ChartRestServiceProtocol) {
        self.restService = restService
    }

    func fetchLatestPrice(for symbol: String, completion: @escaping (Result<SymbolPriceHistory, Error>) -> Void) {
        restService.fetchHistoricalData(for: symbol, completion: completion)
    }
}
