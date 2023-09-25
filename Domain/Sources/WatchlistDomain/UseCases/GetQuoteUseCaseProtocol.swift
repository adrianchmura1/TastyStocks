//
//  GetQuoteUseCaseProtocol.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation

public protocol GetQuoteUseCaseProtocol: AnyObject {
    func execute(for symbol: String, completion: @escaping (Result<Quote, Error>) -> Void)
}

final class GetQuoteUseCase: GetQuoteUseCaseProtocol {
    private let repository: QuoteRepositoryProtocol

    init(repository: QuoteRepositoryProtocol) {
        self.repository = repository
    }

    func execute(for symbol: String, completion: @escaping (Result<Quote, Error>) -> Void) {
        repository.fetchQuote(symbol: symbol, completion: completion)
    }
}
