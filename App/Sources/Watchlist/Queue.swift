//
//  Queue.swift
//  
//
//  Created by Adrian Chmura on 25/09/2023.
//

import Foundation

protocol Queue {
    func async(execute work: @escaping () -> Void)
    func asyncAfter(deadline: DispatchTime, execute: DispatchWorkItem)}

final class DefaultBackgroundQueue: Queue {
    func async(execute work: @escaping () -> Void) {
        DispatchQueue.global().async {
            work()
        }
    }

    func asyncAfter(deadline: DispatchTime, execute: DispatchWorkItem) {
        DispatchQueue.global().asyncAfter(deadline: deadline, execute: execute)
    }
}

final class DefaultMainQueue: Queue {
    func async(execute work: @escaping () -> Void) {
        DispatchQueue.main.async {
            work()
        }
    }

    func asyncAfter(deadline: DispatchTime, execute: DispatchWorkItem) {
        DispatchQueue.main.asyncAfter(deadline: deadline, execute: execute)
    }
}
