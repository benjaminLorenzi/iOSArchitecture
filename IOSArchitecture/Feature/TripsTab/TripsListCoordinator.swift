//
//  TripsListCoordinator.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 02/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

class TripListCoordinator: Coordinator {
    var coordinable: Coordinable? {
        return vc
    }
    var destinations: [Destination] = [.segment]
    
    weak var vc: UIViewCoordinable?
    weak var parentCoordinator: Coordinator?
    
    func buildUI() -> (UIViewController & Coordinable) {
        let tripsViewModel = TripsListViewModel()
        let tripsViewController = TripsViewController()
        tripsViewModel.uiDelegate = tripsViewController
        tripsViewController.tripsViewModel = tripsViewModel
        tripsViewController.actions = self.parentCoordinator as? TripActions
        self.vc = tripsViewController
        return tripsViewController
    }
}




