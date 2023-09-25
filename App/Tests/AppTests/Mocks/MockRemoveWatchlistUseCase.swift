//
//  MockRemoveWatchlistUseCase.swift
//  
//
//  Created by Adrian Chmura on 26/09/2023.
//

import Foundation
import WatchlistDomain

class MockRemoveWatchlistUseCase: RemoveWatchlistUseCaseProtocol {
    var removedWatchlistId: String?
    var isCalled = false

    func execute(for id: String) {
        isCalled = true
        removedWatchlistId = id
    }
}
