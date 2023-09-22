//
//  AddQuoteUseCaseProtocol.swift
//  
//
//  Created by Adrian Chmura on 22/09/2023.
//

import Foundation

public protocol AddSymbolUseCaseProtocol: AnyObject {
    func execute(symbol: String)
}

final class AddSymbolUseCase: AddSymbolUseCaseProtocol {
    private let repository: WatchlistRepositoryProtocol

    init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    func execute(symbol: String) {
        repository.addToActiveWatchlist(symbol: symbol)
    }
}
