//
//  MockCreateInitialWatchlistUseCase.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import WatchlistDomain

final class MockCreateInitialWatchlistUseCase: CreateInitialWatchlistUseCaseProtocol {
    var isCalled = false

    private let repository: WatchlistRepositoryProtocol

    init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<Watchlist?, Error>) -> Void) {
        isCalled = true
        completion(.success(nil))
    }
    }
