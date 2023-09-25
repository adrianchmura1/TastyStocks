//
//  RemoveSymbolFromActiveWatchlistUseCaseProtocol.swift
//  
//
//  Created by Adrian Chmura on 23/09/2023.
//

import Foundation

public protocol RemoveSymbolUseCaseProtocol: AnyObject {
    func execute(for symbol: String)
}

final class RemoveSymbolUseCase: RemoveSymbolUseCaseProtocol {
    private let repository: WatchlistRepositoryProtocol

    init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    func execute(for symbol: String) {
        guard !symbol.isEmpty else { return }
        repository.removeFromActive(symbol: symbol)
    }
}
