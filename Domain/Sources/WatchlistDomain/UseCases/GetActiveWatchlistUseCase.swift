//
//  GetActiveWatchlistUseCase.swift
//  
//
//  Created by Adrian Chmura on 20/09/2023.
//

import Foundation

public protocol GetActiveWatchlistUseCaseProtocol: AnyObject {
    func execute(completion: @escaping (Result<Watchlist?, Error>) -> Void)
}

final class GetActiveWatchlistUseCase: GetActiveWatchlistUseCaseProtocol {
    private static let initialWatchlistName = "My first list"

    private let repository: WatchlistRepositoryProtocol

    init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<Watchlist?, Error>) -> Void) {
        repository.fetchActiveWatchlist { [weak self] watchlist in
            if let activeWatchlist = watchlist {
                completion(.success(activeWatchlist))
            } else {
                let quotes = [Quote(symbol: "AAPL"), Quote(symbol: "MSFT"), Quote(symbol: "GOOG")]
                let initialWatchlist = Watchlist(id: UUID().uuidString, name: Self.initialWatchlistName, quotes: quotes)

                self?.repository.addWatchlist(initialWatchlist) { watchlist in
                    completion(.success(watchlist))
                }
            }
        }
    }
}
