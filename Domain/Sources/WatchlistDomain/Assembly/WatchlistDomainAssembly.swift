//
//  File.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import Foundation

public final class WatchlistDomainAssembly {
    public init() {}

    public func getActiveWatchlistUseCase(repository: WatchlistRepositoryProtocol) -> GetActiveWatchlistUseCaseProtocol {
        GetActiveWatchlistUseCase(repository: repository)
    }

    public func symbolSearchUseCase(repository: SymbolsRepositoryProtocol) -> SearchQuotesUseCaseProtocol {
        SearchQuotesUseCase(symbolsRepository: repository)
    }

    public func addSymbolUseCase(repository: WatchlistRepositoryProtocol) -> AddSymbolUseCaseProtocol {
        AddSymbolUseCase(repository: repository)
    }
}
