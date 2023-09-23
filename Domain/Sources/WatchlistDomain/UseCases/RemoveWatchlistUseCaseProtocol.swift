//
//  RemoveWatchlistUseCaseProtocol.swift
//  
//
//  Created by Adrian Chmura on 23/09/2023.
//

import Foundation

public protocol RemoveWatchlistUseCaseProtocol: AnyObject {
    func execute(for id: String)
}

final class RemoveWatchlistUseCase: RemoveWatchlistUseCaseProtocol {
    private let repository: WatchlistRepositoryProtocol

    init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    func execute(for id: String) {
        repository.removeWatchlist(id: id)
    }
}
