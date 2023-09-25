//
//  MockChartRestService.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
import WatchlistDomain
@testable import WatchlistInfrastructure

final class MockChartRestService: ChartRestServiceProtocol {
    var fetchHistoricalDataSymbol: String?
    var fetchHistoricalDataResult: Result<SymbolPriceHistory, Error>?

    func fetchHistoricalData(for symbol: String, completion: @escaping (Result<SymbolPriceHistory, Error>) -> Void) {
        fetchHistoricalDataSymbol = symbol
        if let result = fetchHistoricalDataResult {
            completion(result)
        }
    }
}
