//
//  Coordinator.swift
//  
//
//  Created by Adrian Chmura on 19/09/2023.
//

import UIKit

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()}
