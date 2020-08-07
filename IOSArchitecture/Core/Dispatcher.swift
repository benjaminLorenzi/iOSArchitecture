//
//  Dispatcher.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

class Dispatcher {
    func post(event: Event, userInfo: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: event.notificationName, object: nil, userInfo: userInfo)
    }
    
    func listen(_ observer: Any, event: Event, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: event.notificationName, object: nil)
    }
    
    func stopListening(_ observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
}

