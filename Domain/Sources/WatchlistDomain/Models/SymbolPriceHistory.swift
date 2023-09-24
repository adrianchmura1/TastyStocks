//
//  SymbolPriceHistory.swift
//  
//
//  Created by Adrian Chmura on 24/09/2023.
//

import Foundation

public struct SymbolPriceHistory {
    public let days: [DayPriceInfo]

    public init(days: [DayPriceInfo]) {
        self.days = days
    }
}
