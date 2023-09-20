//
//  InfrastructureAssembly.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import WatchlistDomain

public final class InfrastructureAssembly {
    public init() {}

    public func watchlistRepository() -> WatchlistRepositoryProtocol {
        WatchlistRepository()
    }
}
