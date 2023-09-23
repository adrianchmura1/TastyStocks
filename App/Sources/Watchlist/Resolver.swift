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
        let watchlistRepository = InfrastructureAssembly().watchlistRepository()
        let symbolsRepository = InfrastructureAssembly().symbolsRepository()

        let watchlistDomainAssembly = WatchlistDomainAssembly()

        let interactor = AddQuoteInteractor(
            searchQuotesUseCase: watchlistDomainAssembly.symbolSearchUseCase(repository: symbolsRepository),
            addSymbolUseCaseProtocol: watchlistDomainAssembly.addSymbolUseCase(repository: watchlistRepository)
        )

        return AddQuoteViewModel(interactor: interactor)
    }

    var editWatchlistsViewModel: WatchlistEditViewModel {
        let watchlistRepository = InfrastructureAssembly().watchlistRepository()
        let watchlistDomainAssembly = WatchlistDomainAssembly()

        return WatchlistEditViewModel(
            interactor: WatchlistEditInteractor(
                addWatchlistUseCase: watchlistDomainAssembly.addWatchlistUseCase(repository: watchlistRepository),
                getWatchlistsUseCase: watchlistDomainAssembly.getWatchlistsUseCase(repository: watchlistRepository),
                switchWatchlistUseCase: watchlistDomainAssembly.switchWatchlistUseCase(repository: watchlistRepository),
                removeWatchlistUseCase: watchlistDomainAssembly.removeWatchlistUseCase(repository: watchlistRepository),
                getActiveWatchlistIdUseCase: watchlistDomainAssembly.getActiveWatchlistIdUseCase(repository: watchlistRepository))
        )
    }
}
