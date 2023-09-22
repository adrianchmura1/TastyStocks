//
//  File.swift
//  
//
//  Created by Adrian Chmura on 21/09/2023.
//

import Foundation
import WatchlistDomain

protocol WatchlistRestServiceProtocol {
    func refresh(watchlist: Watchlist, completion: @escaping (Result<[StockDataResponse], Error>) -> Void)
}

class WatchlistRestService: WatchlistRestServiceProtocol {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func refresh(watchlist: Watchlist, completion: @escaping (Result<[StockDataResponse], Error>) -> Void) {
        let symbolsQueryItemValue = watchlist.quotes.map({ $0.symbol }).joined(separator: ",")
        let queryItemSymbols = URLQueryItem(name: "symbols", value: symbolsQueryItemValue)
        let queryItemTypes = URLQueryItem(name: "types", value: "quote")
        let queryItemToken = URLQueryItem(name: "token", value: "pk_b55956aac6534be093558f56df50d784")

        var components = URLComponents()
        components.scheme = "https"
        components.host = "cloud.iexapis.com"
        components.path = "/v1/stock/market/batch"
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

struct StockDataResponse: Decodable {
    var quote: QuoteResponse
}

struct QuoteResponse: Decodable {
    let latestPrice: Double?
    let symbol: String
    let askPrice: Double?
    let bidPrice: Double?

    enum CodingKeys: String, CodingKey {
        case latestPrice
        case symbol
        case askPrice = "iexAskPrice"
        case bidPrice = "iexBidPrice"
    }
}
