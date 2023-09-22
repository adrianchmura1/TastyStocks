//
//  File.swift
//  
//
//  Created by Adrian Chmura on 21/09/2023.
//

import Foundation

enum NetworkError: Error {
    case httpError
    case noData
    case decodingError
    case invalidURL
}

protocol NetworkServiceProtocol: AnyObject {
    func data<ResponseObject: Decodable>(
        for request: URLRequest,
        completion: @escaping (Result<ResponseObject, Error>) -> Void
    )
}

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .init(configuration: .default), decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }

    func data<ResponseObject: Decodable>(
        for request: URLRequest,
        completion: @escaping (Result<ResponseObject, Error>) -> Void
    ) {
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                // Handle HTTP error response here if needed
                completion(.failure(NetworkError.httpError))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let responseObject = try self.decoder.decode(ResponseObject.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
