//
//  Coordinator.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation
import UIKit

// MARK: Coordinator
protocol Coordinator: class {
    var coordinable: Coordinable? { get }
    var destinations: [Destination] { get }
    var parentCoordinator: Coordinator? { get set }
    func buildUI() -> (Coordinable & UIViewController)
}

extension Coordinator {
    func navigate(route: Route) {
        if destinations.contains(route.destination) {
            let coordinator = route.coordinator
            coordinable?.navigate(coordinator: coordinator)
        } else {
            self.parentCoordinator?.navigate(route: route)
        }
    }
}

