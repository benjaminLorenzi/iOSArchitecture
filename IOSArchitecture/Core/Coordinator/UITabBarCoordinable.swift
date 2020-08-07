//
//  UITabBarCoordinable.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 08/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

struct Tab {
    let coordinator: Coordinator
    let id: TabType
    let label: String?
}

extension Tab {
    var tabBarViewController: UIViewController {
        let view = coordinator.buildUI()
        view.tabBarItem.title = self.label
        return view
    }
}

class UITabBarCoordinable: UITabBarController, Coordinable {
    var tabsAccessibility: [String] = []
    
    func navigate(coordinator: Coordinator) {
        self.selectedIndex = tabsAccessibility.firstIndex(of: String(describing: coordinator)) ?? 0
    }
    
    var coordinator: Coordinator?
}

extension Coordinable where Self: UITabBarCoordinable {
    static func build(coordinator: Coordinator, tabs: [Tab]) -> Self {
        let tabBar = Self()
        tabBar.coordinator = coordinator
        for tabItem in tabs {
            tabItem.coordinator.parentCoordinator = coordinator
        }
        tabBar.viewControllers = tabs.map{ $0.tabBarViewController }
        tabBar.tabsAccessibility = tabs.map{ String(describing: $0.coordinator) }
        return tabBar
    }
}
