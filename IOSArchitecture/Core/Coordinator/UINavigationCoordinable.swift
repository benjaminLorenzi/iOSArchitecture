//
//  UINavigationCoordinable.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 08/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

extension Coordinable where Self: UINavigationController {
    func navigate(to child: Coordinator, animated: Bool) {
        child.parentCoordinator = coordinator
        var vc = child.buildUI()
        vc.coordinator = coordinator
        pushViewController(vc, animated: true)
    }
    
    static func build(coordinator: Coordinator, child: Coordinator) -> Self {
        var nav = Self()
        nav.coordinator = coordinator
        child.parentCoordinator = coordinator
        let vc = child.buildUI()
        nav.viewControllers = [vc]
        return nav
    }
}

class UINavigationCoordinable: UINavigationController, Coordinable {
    func navigate(coordinator: Coordinator) {
        navigate(to: coordinator, animated: true)
    }
    var coordinator: Coordinator?
}
