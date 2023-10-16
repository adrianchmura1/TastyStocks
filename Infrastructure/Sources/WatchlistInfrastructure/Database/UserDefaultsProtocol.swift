//
//  UserDefaultsProtocol.swift
//  
//
//  Created by Adrian Chmura on 16/10/2023.
//

import Foundation

protocol UserDefaultsProtocol: AnyObject {
    func data(forKey defaultName: String) -> Data?
    func set(_ value: Any?, forKey defaultName: String)
    func string(forKey defaultName: String) -> String?
}

extension UserDefaults: UserDefaultsProtocol {}
