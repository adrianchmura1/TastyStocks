//
//  WatchlistRestService.swift
//  
//
//  Created by Adrian Chmura on 21/09/2023.
//

import Foundation
import WatchlistDomain
import Environment

protocol WatchlistRestServiceProtocol {
    func refresh(watchlist: Watchlist, completion: @escaping (Result<[StockDataResponse], Error>) -> Void)
}

class WatchlistRestService: WatchlistRestServiceProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func refresh(watchlist: Watchlist, completion: @escaping (Result<[StockDataResponse], Error>) -> Void) {
        let symbolsQueryItemValue = watchlist.quotes.map({ $0.symbol }).joined(separator: ",")
        let queryItemSymbols = URLQueryItem(name: "symbols", value: symbolsQueryItemValue)
        let queryItemTypes = URLQueryItem(name: "types", value: "quote")
        let queryItemToken = URLQueryItem(name: "token", value: EnvironmentManager.shared.iexToken)

        var components = URLComponents()
        components.scheme = "https"
        components.host = EnvironmentManager.shared.iexHost
        components.path = EnvironmentManager.shared.iexBatchQuotePath
        components.queryItems = [queryItemSymbols, queryItemToken, queryItemTypes]

        guard let url = components.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let request = URLRequest(url: url)

        networkService.data(for: request) { (result: Result<[String: StockDataResponse], Error>) -> Void in
            switch result {
            case .success(let responseObject):
                completion(.success(Array(responseObject.values)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
