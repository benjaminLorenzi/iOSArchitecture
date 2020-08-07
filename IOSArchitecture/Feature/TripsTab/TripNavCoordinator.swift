//
//  TripNavCoordinator.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 07/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

class TripNavCoordinator: Coordinator {
    var coordinable: Coordinable? {
        return nav
    }
    var destinations: [Destination] {
        return [.trip, .segment]
    }
    weak var nav: UINavigationCoordinable?
    weak var parentCoordinator: Coordinator?
    
    func buildUI() -> (UIViewController & Coordinable) {
        let nav = UINavigationCoordinable.build(coordinator: self, child: TripListCoordinator())
        self.nav = nav
        return nav
    }
}

protocol TripActions: SegmentRoute, TripRoute {
    func refreshDatas()
}

extension TripNavCoordinator: TripActions {
    func tapOnSegment(segment: Segment) {
        navigate(route: Route.segment(segment: segment))
    }
    
    func tapOnTrip(trip: Trip) {
        navigate(route: Route.trip(trip: trip))
    }
    
    func refreshDatas() {
        TripWorker().refresh()
    }
}

