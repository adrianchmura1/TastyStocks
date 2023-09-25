//
//  Resolver.swift
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
        let removeSymbolUseCase = WatchlistDomainAssembly().removeSymbolUseCase(repository: repository)
        let interactor = WatchlistInteractor(
            getActiveWatchlistUseCase: getActiveWatchlistUseCase,
            removeSymbolUseCase: removeSymbolUseCase
        )
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

    func quoteViewModel(symbol: String) -> QuoteViewModel {
        let infrastructureAssembly = InfrastructureAssembly()
        let symbolHistoryRepository = infrastructureAssembly.symbolHistoryRepository()
        let quoteRepository = infrastructureAssembly.quoteRepository()
        let domainAssembly = WatchlistDomainAssembly()
        let symbolHistoryUseCase = domainAssembly.getSymbolHistoryUseCase(repository: symbolHistoryRepository)
        let getQuoteUseCase = domainAssembly.getQuoteUseCase(repository: quoteRepository)

        return QuoteViewModel(
            symbol: symbol,
            interactor: QuoteInteractor(
                getSymbolHistoryUseCaseProtocol: symbolHistoryUseCase,
                getQuoteUseCase: getQuoteUseCase
            )
        )
    }
}
