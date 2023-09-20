//
//  File.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import Foundation

public final class WatchlistDomainAssembly {
    public init() {}

    public func getActiveWatchlistUseCase(repository: WatchlistDatabaseProtocol) -> GetActiveWatchlistUseCaseProtocol {
        GetActiveWatchlistUseCase(repository: repository)
    }
}
