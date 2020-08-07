//
//  AppCoordinator.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 06/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

class HomeCoordinatorManager {
    weak var parentCoordinator: Coordinator?
    weak var prevCoordinable: UIViewController?
    private var homeViewModel: HomeViewModel
    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
        homeViewModel = HomeViewModel()
        homeViewModel.uiDelegate = self
        updateUI()
    }
}

extension HomeCoordinatorManager: UIUpdatable {
    
    var currentCoordinator: Coordinator {
        switch homeViewModel.homeStatus {
        case .loggedIn:
            return TabBarCoordinator()
        case .needRecovey:
            return LoginCoordinator(isRecovery: true)
        case .loggedOut:
            return LoginCoordinator()
        }
    }
    
    func updateUI() {
        let coordinable = currentCoordinator.buildUI()
        self.prevCoordinable = coordinable
        window.rootViewController = coordinable
        window.makeKeyAndVisible()
    }
}
