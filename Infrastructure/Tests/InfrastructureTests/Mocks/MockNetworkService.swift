//
//  MockNetworkService.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation
@testable import WatchlistInfrastructure

final class MockNetworkService: NetworkServiceProtocol {
    var expectedResult: Any?

    func data<ResponseObject: Decodable>(
        for request: URLRequest,
        completion: @escaping (Result<ResponseObject, Error>) -> Void
    ) {
        if let expectedResult = expectedResult as? Result<ResponseObject, Error> {
            completion(expectedResult)
        } else {
            fatalError("You must set the expectedResult for the MockNetworkService.")
        }
    }
}
