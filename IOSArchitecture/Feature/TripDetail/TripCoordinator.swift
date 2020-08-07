//
//  TripCoordinator.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

class TripCoordinator: Coordinator {
    var coordinable: Coordinable? {
        return self.vc
    }
    var destinations: [Destination] = [.segment, .account]
    
    private var trip: Trip
    init(trip: Trip) {
        self.trip = trip
    }
    
    weak var parentCoordinator: Coordinator?
    weak var vc: UIViewCoordinable?
    
    // Configure ViewModel, ViewCollectionView and bind them together
    func buildUI() -> (UIViewController & Coordinable) {
        let view = TripViewController()
        view.coordinator = self
        
        let tripViewModel = TripViewModel(trip: trip)
        view.tripViewModel = tripViewModel
        tripViewModel.tripViewModelDelegate = view
        view.tripActionDelegate = self
        self.vc = view
        return view
    }
}

protocol TripActionsDelegate: SegmentRoute {
}
// MARK: Action and Navigation Handling
extension TripCoordinator: TripActionsDelegate {
    func tapOnSegment(segment: Segment) {
        self.navigate(route: Route.account)
    }
}
