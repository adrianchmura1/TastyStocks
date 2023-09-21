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

    public func watchlistRepository() -> WatchlistRepositoryProtocol {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let networkService = NetworkService(decoder: decoder)

        return WatchlistRepository(
            database: WatchlistDatabase(),
            restService: WatchlistRestService(networkService: networkService)
        )
    }
}
