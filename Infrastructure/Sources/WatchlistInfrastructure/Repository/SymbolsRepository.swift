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
