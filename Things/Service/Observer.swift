//
//  Observer.swift
//  homeProject
//
//  Created by SHAOBAI LI on 29.03.22.
//

import Foundation

final class Observer<T> {
    typealias Listener = (T) -> Void
    var listenr: Listener?
    var value: T {
        didSet {
            listenr?(value)
        }
    }
        
    init(value: T) {
        self.value = value
    }
    
    func bind(completion: @escaping Listener) {
        self.listenr = completion
    }
}
