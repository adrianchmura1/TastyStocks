//
//  SwitchWatchlistUseCaseProtocol.swift
//  
//
//  Created by Adrian Chmura on 23/09/2023.
//

import Foundation

public protocol SwitchWatchlistUseCaseProtocol: AnyObject {
    func execute(for id: String)
}

final class SwitchWatchlistUseCase: SwitchWatchlistUseCaseProtocol {
    private let repository: WatchlistRepositoryProtocol

    init(repository: WatchlistRepositoryProtocol) {
        self.repository = repository
    }

    func execute(for id: String) {
        repository.setActive(id: id)
    }
}
