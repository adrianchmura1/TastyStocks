//
//  MockGetActiveWatchlistIdUseCase.swift
//  
//
//  Created by Adrian Chmura on 26/09/2023.
//

import Foundation
import WatchlistDomain

class MockGetActiveWatchlistIdUseCase: GetActiveWatchlistIdUseCaseProtocol {
    var activeWatchlistId: String?
    var isCalled = false

    func execute() -> String? {
        isCalled = true
        return activeWatchlistId
    }
}
