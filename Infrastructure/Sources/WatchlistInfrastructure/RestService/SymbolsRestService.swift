//
//  SymbolsRestService.swift
//  
//
//  Created by Adrian Chmura on 23/09/2023.
//

import Foundation
import WatchlistDomain
import Environment

protocol SymbolsRestServiceProtocol: AnyObject {
    func findSymbol(text: String, completion: @escaping (Result<[WatchlistDomain.QuoteSearchResult], Error>) -> Void)
}

final class SymbolsRestService: SymbolsRestServiceProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func findSymbol(text: String, completion: @escaping (Result<[WatchlistDomain.QuoteSearchResult], Error>) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = EnvironmentManager.shared.tastyHost
        components.path = EnvironmentManager.shared.tastySearchPath(text: text)

        guard let url = components.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let request = URLRequest(url: url)

        networkService.data(for: request) { (result: Result<SymbolSearchResponse, Error>) -> Void in
            switch result {
            case .success(let response):
                completion(
                    .success(response.data.items.map {
                        QuoteSearchResult(symbol: $0.symbol, name: $0.description)
                    })
                )
            case .failure:
                break
            }
        }
    }
}
