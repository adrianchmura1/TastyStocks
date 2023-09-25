//
//  MockAddSymbolUseCase.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
@testable import Watchlist
import WatchlistDomain

final class MockAddSymbolUseCase: AddSymbolUseCaseProtocol {
    var addedSymbol: String?
    var executeCalled = false

    func execute(symbol: String) {
        addedSymbol = symbol
        executeCalled = true
    }
}
