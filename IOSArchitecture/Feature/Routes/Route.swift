//
//  Router.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 09/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

enum Destination: String, Equatable {
    case logOut
    case account
    case trips
    case trip
    case segment
}

enum Route {
    case logOut
    case account
    case trips
    case trip(trip: Trip)
    case segment(segment: Segment)
    
    var destination: Destination {
        switch self {
        case .logOut:
            return .logOut
        case .account:
            return .account
        case .trips:
            return .trips
        case .trip:
            return .trip
        case .segment:
            return .segment
        }
    }
    
    var coordinator: Coordinator {
        switch self {
            case .logOut:
                   return LoginCoordinator()
            case .account:
                   return AccountCoordinator()
            case .trips:
                   return TripListCoordinator()
            case .trip(let trip):
                   return TripCoordinator(trip: trip)
            case .segment(let segment):
                   return SegmentCoordinator(segment: segment)
        }
    }
}







