//
//  Queue.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation

protocol Queue {
    func async(execute work: @escaping () -> Void)
}

final class DefaultBackgroundQueue: Queue {
    func async(execute work: @escaping () -> Void) {
        DispatchQueue.global().async {
            work()
        }
    }
}

final class DefaultMainQueue: Queue {
    func async(execute work: @escaping () -> Void) {
        DispatchQueue.main.async {
            work()
        }
    }
}
