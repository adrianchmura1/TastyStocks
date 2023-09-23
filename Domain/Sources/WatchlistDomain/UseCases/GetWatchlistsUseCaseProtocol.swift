//
//  GetWatchlistsUseCaseProtocol.swift
//  
//
//  Created by Adrian Chmura on 23/09/2023.
//

import Foundation

public protocol GetWatchlistsUseCaseProtocol: AnyObject {
    func execute() -> [Watchlist]
}

final class GetWatchlistsUseCase: GetWatchlistsUseCaseProtocol {
    private let repository: WatchlistRepositoryProtocol

    init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> [Watchlist] {
        repository.watchlists
    }
}
