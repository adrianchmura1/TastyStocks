//
//  EnvironmentManager.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation

public enum Environment {
    case dev, prod
}

public final class EnvironmentManager {
    public static let shared = EnvironmentManager()

    private var currentEnvironment: Environment = .dev

    public var iexHost: String {
        "cloud.iexapis.com"
    }

    public var tastyHost: String {
        "api.tastyworks.com"
    }

    public var currentEnvironmentType: Environment {
        return currentEnvironment
    }

    public var iexToken: String {
        "pk_9b6a666f035443a294d41a4a4cfd7972"
    }

    public var iexBatchQuotePath: String {
        "/v1/stock/market/batch"
    }

    public func setEnvironment(_ environment: Environment) {
        currentEnvironment = environment
    }

    public func iexFetchQuotePath(symbol: String) -> String {
        switch currentEnvironment {
        case .dev:
            return "/v1/stock/\(symbol)/quote"
        case .prod:
            return "/v1/stock/\(symbol)/quote"
        }
    }

    public func iexHistoricalDataPath(symbol: String) -> String {
        "/v1/stock/\(symbol)/chart/1m"
    }

    public func tastySearchPath(text: String) -> String {
        "/symbols/search/\(text)"
    }
}
