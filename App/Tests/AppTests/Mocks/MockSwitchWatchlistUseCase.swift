//
//  MockSwitchWatchlistUseCase.swift
//  
//
//  Created by Adrian Chmura on 26/09/2023.
//

import Foundation
import WatchlistDomain

class MockSwitchWatchlistUseCase: SwitchWatchlistUseCaseProtocol {
    var switchedWatchlistId: String?
    var isCalled = false

    func execute(for id: String) {
        isCalled = true
        switchedWatchlistId = id
    }
}
