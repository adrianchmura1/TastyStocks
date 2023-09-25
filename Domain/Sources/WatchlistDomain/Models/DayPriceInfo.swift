//
//  DayPriceInfo.swift
//  
//
//  Created by Adrian Chmura on 24/09/2023.
//

import Foundation

public struct DayPriceInfo: Equatable {
    public let open: Double
    public let close: Double
    public let high: Double
    public let low: Double

    public init(open: Double, close: Double, high: Double, low: Double) {
        self.open = open
        self.close = close
        self.high = high
        self.low = low
    }
}
