//
//  GetActiveWatchlistIdUseCaseProtocol.swift
//  
//
//  Created by Adrian Chmura on 23/09/2023.
//

import Foundation

public protocol GetActiveWatchlistIdUseCaseProtocol: AnyObject {
    func execute() -> String?
}

final class GetActiveWatchlistIdUseCase: GetActiveWatchlistIdUseCaseProtocol {
    private let repository: WatchlistRepositoryProtocol

    init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> String? {
        repository.activeWatchlistId
    }
}
