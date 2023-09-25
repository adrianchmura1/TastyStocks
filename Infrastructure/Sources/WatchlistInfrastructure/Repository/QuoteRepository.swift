//
//  QuoteRepository.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
import WatchlistDomain

final class QuoteRepository: QuoteRepositoryProtocol {
    private let restService: QuoteRestServiceProtocol

    init(restService: QuoteRestServiceProtocol) {
        self.restService = restService
    }

    func fetchQuote(symbol: String, completion: @escaping (Result<Quote, Error>) -> Void) {
        restService.fetchQuote(symbol: symbol, completion: completion)
    }
}
