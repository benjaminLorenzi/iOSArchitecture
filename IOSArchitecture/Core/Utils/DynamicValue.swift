//
//  DynamicValue.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 27/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation


typealias CompletionHandler = (() -> Void)

class DynamicValue<T> {
    fileprivate(set) var value : T {
        didSet {
            self.notify()
        }
    }

    private var observers = [String: CompletionHandler]()

    init(_ value: T) {
        self.value = value
    }

    public func addObserver(_ observer: AnyObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }

    private func notify() {
        observers.forEach({ $0.value() })
    }

    deinit {
        observers.removeAll()
    }
}

protocol DynamicValueModifier {
    func setValue<T>(_ dynamicValue: DynamicValue<T>, value: T)
}

extension DynamicValueModifier {
    func setValue<T>(_ dynamicValue: DynamicValue<T>, value: T) {
        dynamicValue.value = value
    }
}
