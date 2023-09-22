//
//  File.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import WatchlistDomain
import WatchlistInfrastructure

final class Resolver {
    var watchlistViewModel: WatchListViewModel {
        let repository = InfrastructureAssembly().watchlistRepository()
        let getActiveWatchlistUseCase = WatchlistDomainAssembly().getActiveWatchlistUseCase(repository: repository)
        let interactor = WatchlistInteractor(getActiveWatchlistUseCase: getActiveWatchlistUseCase)
        return WatchListViewModel(interactor: interactor)
    }

    var addQuoteViewModel: AddQuoteViewModel {
        let repository = InfrastructureAssembly().watchlistRepository()

        let watchlistDomainAssembly = WatchlistDomainAssembly()

        let interactor = AddQuoteInteractor(
            searchQuotesUseCase: watchlistDomainAssembly.symbolSearchUseCase(),
            addSymbolUseCaseProtocol: watchlistDomainAssembly.addSymbolUseCase(repository: repository)
        )

        return AddQuoteViewModel(interactor: interactor)
    }
}
