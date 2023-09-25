//
//  MockQueue.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
@testable import Watchlist

final class MockQueue: Queue {
    var asyncCalled = false

    func async(execute work: @escaping () -> Void) {
        asyncCalled = true
        work()
    }
}
