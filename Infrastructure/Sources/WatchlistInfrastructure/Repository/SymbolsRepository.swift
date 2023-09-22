//
//  SymbolsRepository.swift
//  
//
//  Created by Adrian Chmura on 22/09/2023.
//

import WatchlistDomain
import Foundation

final class SymbolsRepository: SymbolsRepositoryProtocol {
    private let restService: SymbolsRestServiceProtocol

    init(restService: SymbolsRestServiceProtocol) {
        self.restService = restService
    }

    func findSymbol(text: String, completion: @escaping (Result<[WatchlistDomain.QuoteSearchResult], Error>) -> Void) {
        restService.findSymbol(text: text, completion: completion)
    }
}

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
        components.host = "api.tastyworks.com"
        components.path = "/symbols/search/\(text)"

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

struct SymbolSearchResponse: Decodable {
    let data: SymbolSearchDataResponse
}

struct SymbolSearchDataResponse: Decodable {
    let items: [SymbolSearchDataItemResponse]
}

struct SymbolSearchDataItemResponse: Decodable {
    let symbol: String
    let description: String
}
