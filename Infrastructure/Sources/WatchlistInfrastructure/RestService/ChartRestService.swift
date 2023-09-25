//
//  QuotesRestService.swift
//  
//
//  Created by Adrian Chmura on 23/09/2023.
//

import Foundation
import WatchlistDomain

protocol ChartRestServiceProtocol {
    func fetchHistoricalData(for symbol: String, completion: @escaping (Result<SymbolPriceHistory, Error>) -> Void)
}

final class ChartRestService: ChartRestServiceProtocol {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchHistoricalData(for symbol: String, completion: @escaping (Result<SymbolPriceHistory, Error>) -> Void) {
        let queryItemToken = URLQueryItem(name: "token", value: "pk_b55956aac6534be093558f56df50d784")

        var components = URLComponents()
        components.scheme = "https"
        components.host = "cloud.iexapis.com"
        components.path = "/v1/stock/\(symbol)/chart/1m"
        components.queryItems = [queryItemToken]

        guard let url = components.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let request = URLRequest(url: url)

        networkService.data(for: request) { (result: Result<[SymbolQuotesDataResponse], Error>) -> Void in
            switch result {
            case .success(let responseObject):
                completion(.success(SymbolPriceHistory(days: responseObject.map {
                    DayPriceInfo(open: $0.open, close: $0.close, high: $0.high, low: $0.low)
                })))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
