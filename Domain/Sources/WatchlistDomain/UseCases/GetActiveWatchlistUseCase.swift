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
    private let repository: WatchlistRepositoryProtocol
    private let createInitialWatchlistUseCase: CreateInitialWatchlistUseCaseProtocol

    init(
        repository: WatchlistRepositoryProtocol,
        createInitialWatchlistUseCase: CreateInitialWatchlistUseCaseProtocol
    ) {
        self.repository = repository
        self.createInitialWatchlistUseCase = createInitialWatchlistUseCase
    }

    func execute(completion: @escaping (Result<Watchlist?, Error>) -> Void) {
        repository.fetchActiveWatchlist { [weak self] result in
            switch result {
            case .success(let watchlist):
                if let activeWatchlist = watchlist {
                    completion(.success(activeWatchlist))
                } else {
                    self?.createInitialWatchlistUseCase.execute(completion: completion)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
