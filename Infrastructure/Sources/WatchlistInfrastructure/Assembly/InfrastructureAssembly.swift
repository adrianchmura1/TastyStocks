//
//  InfrastructureAssembly.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import WatchlistDomain
import Foundation

public final class InfrastructureAssembly {
    public init() {}

    var networkService: NetworkService {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return NetworkService(decoder: decoder)
    }

    var watchlistRestService: WatchlistRestService {
        WatchlistRestService(networkService: networkService)
    }

    var symbolsRestService: SymbolsRestService {
        SymbolsRestService(networkService: networkService)
    }

    var chartRestService: ChartRestService {
        ChartRestService(networkService: networkService)
    }

    var quoteRestService: QuoteRestService {
        QuoteRestService(networkService: networkService)
    }

    public func watchlistRepository() -> WatchlistRepositoryProtocol {
        return WatchlistRepository(
            database: WatchlistDatabase(),
            restService: watchlistRestService
        )
    }

    public func symbolsRepository() -> SymbolsRepositoryProtocol {
        return SymbolsRepository(
            restService: symbolsRestService
        )
    }

    public func symbolHistoryRepository() -> SymbolHistoryRepositoryProtocol {
        return SymbolHistoryRepository(
            restService: chartRestService
        )
    }

    public func quoteRepository() -> QuoteRepositoryProtocol {
        return QuoteRepository(
            restService: quoteRestService
        )
    }
}
