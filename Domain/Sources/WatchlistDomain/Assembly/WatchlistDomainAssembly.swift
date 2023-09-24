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

    public func getActiveWatchlistIdUseCase(repository: WatchlistRepositoryProtocol) -> GetActiveWatchlistIdUseCaseProtocol {
        GetActiveWatchlistIdUseCase(repository: repository)
    }

    public func symbolSearchUseCase(repository: SymbolsRepositoryProtocol) -> SearchQuotesUseCaseProtocol {
        SearchQuotesUseCase(symbolsRepository: repository)
    }

    public func addSymbolUseCase(repository: WatchlistRepositoryProtocol) -> AddSymbolUseCaseProtocol {
        AddSymbolUseCase(repository: repository)
    }

    public func getWatchlistsUseCase(repository: WatchlistRepositoryProtocol) -> GetWatchlistsUseCaseProtocol {
        GetWatchlistsUseCase(repository: repository)
    }

    public func addWatchlistUseCase(repository: WatchlistRepositoryProtocol) -> AddWatchlistUseCaseProtocol {
        AddWatchlistUseCase(watchlistRepository: repository)
    }

    public func switchWatchlistUseCase(repository: WatchlistRepositoryProtocol) -> SwitchWatchlistUseCaseProtocol {
        SwitchWatchlistUseCase(repository: repository)
    }

    public func removeWatchlistUseCase(repository: WatchlistRepositoryProtocol) -> RemoveWatchlistUseCaseProtocol {
        RemoveWatchlistUseCase(repository: repository)
    }

    public func removeSymbolUseCase(repository: WatchlistRepositoryProtocol) -> RemoveSymbolUseCaseProtocol {
        RemoveSymbolUseCase(repository: repository)
    }

    public func getSymbolHistoryUseCase(repository: SymbolHistoryRepositoryProtocol) -> GetSymbolHistoryUseCaseProtocol {
        GetSymbolHistoryUseCase(repository: repository)
    }
}
