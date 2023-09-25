//
//  QuoteRestService.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import WatchlistDomain
import Foundation

protocol QuoteRestServiceProtocol: AnyObject {
    func fetchQuote(symbol: String, completion: @escaping (Result<Quote, Error>) -> Void)
}

final class QuoteRestService: QuoteRestServiceProtocol {
    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchQuote(symbol: String, completion: @escaping (Result<Quote, Error>) -> Void) {
        let queryItemToken = URLQueryItem(name: "token", value: "pk_b55956aac6534be093558f56df50d784")

        var components = URLComponents()
        components.scheme = "https"
        components.host = "cloud.iexapis.com"
        components.path = "/v1/stock/\(symbol)/quote"
        components.queryItems = [queryItemToken]

        guard let url = components.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let request = URLRequest(url: url)

        networkService.data(for: request) { (result: Result<QuoteResponse, Error>) -> Void in
            switch result {
            case .success(let responseObject):
                completion(.success(
                    QuoteResponseMapper().map(quoteResponse: responseObject)
                ))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
