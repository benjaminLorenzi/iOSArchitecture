//
//  TabBarCoordinator.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 28/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {
    var coordinable: Coordinable? {
        return tabBarController
    }
    
    var destinations: [Destination] {
        return [.account, .trips]
    }
    
    weak var parentCoordinator: Coordinator?
    weak var tabBarController: UITabBarCoordinable?
    
    var tabs: [Tab] {
       let tabs: [Tab] = [
            Tab(coordinator: TripNavCoordinator(), id: .Trips, label: "Trips"),
            Tab(coordinator: AccountCoordinator(), id: .Account, label: "Account")
       ]
       return tabs
    }
    
    func buildUI() -> (UIViewController & Coordinable) {
        let tabBar = UITabBarCoordinable.build(coordinator: self, tabs: tabs)
        self.tabBarController = tabBar
        return tabBar
    }
}

