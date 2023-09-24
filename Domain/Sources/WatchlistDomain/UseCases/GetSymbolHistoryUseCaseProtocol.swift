//
//  GetSymbolHistoryUseCaseProtocol.swift
//  
//
//  Created by Adrian Chmura on 24/09/2023.
//

import Foundation

public protocol GetSymbolHistoryUseCaseProtocol: AnyObject {
    func execute(for symbol: String, completion: @escaping (Result<SymbolPriceHistory, Error>) -> Void)
}

final class GetSymbolHistoryUseCase: GetSymbolHistoryUseCaseProtocol {
    private let repository: SymbolHistoryRepositoryProtocol

    init(repository: SymbolHistoryRepositoryProtocol) {
        self.repository = repository
    }

    func execute(for symbol: String, completion: @escaping (Result<SymbolPriceHistory, Error>) -> Void) {
        repository.fetchLatestPrice(for: symbol, completion: completion)
    }
}
