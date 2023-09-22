//
//  File.swift
//  
//
//  Created by Adrian Chmura on 21/09/2023.
//

import Foundation

public protocol SearchQuotesUseCaseProtocol: AnyObject {
    func execute(text: String, completion: @escaping (Result<[QuoteSearchResult], Error>) -> Void)
}

final class SearchQuotesUseCase: SearchQuotesUseCaseProtocol {
    func execute(text: String, completion: @escaping (Result<[QuoteSearchResult], Error>) -> Void) {
        
    }
}
