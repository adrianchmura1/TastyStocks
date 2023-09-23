//
//  WatchlistNamePresentable.swift
//  
//
//  Created by Adrian Chmura on 23/09/2023.
//

import Foundation

struct WatchlistNamePresentable {
    let id: String
    let name: String

    init(id: String = UUID().uuidString, name: String) {
        self.id = id
        self.name = name
    }
}
