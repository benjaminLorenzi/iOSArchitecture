//
//  Event.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

enum Event: String {
    case beginRefreshTrips
    case endRefreshTrips
    case beginLogin
    case endLogin
    case accountExpired
    case logOut
    case beginProfileFetched
    case endProfileFetched
    case tabChanged
    case biometryChanged
}

extension Event {
    var notificationName: Notification.Name {
        return Notification.Name(rawValue: self.rawValue)
    }
}
