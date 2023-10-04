//
//  CreateInitialWatchlistUseCaseProtocol.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation

public protocol CreateInitialWatchlistUseCaseProtocol: AnyObject {
    func execute(completion: @escaping (Result<Watchlist?, Error>) -> Void)
}

final class CreateInitialWatchlistUseCase: CreateInitialWatchlistUseCaseProtocol {
    private static let initialWatchlistName = "My first list"

    private let repository: WatchlistRepositoryProtocol

    init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<Watchlist?, Error>) -> Void) {
        let quotes = [Quote(symbol: "AAPL"), Quote(symbol: "MSFT"), Quote(symbol: "GOOG")]
        let initialWatchlist = Watchlist(name: Self.initialWatchlistName, quotes: quotes)

        repository.addWatchlist(initialWatchlist)
        repository.fetchActiveWatchlist { result in
           completion(result)
        }
    }
}
