//
//  LoginCoordinator.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 27/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

class LoginCoordinator: Coordinator {
    var coordinable: Coordinable? {
        return navigationController
    }
    var destinations: [Destination] = [] 
    
    weak var parentCoordinator: Coordinator?
    weak var navigationController: UINavigationCoordinable?
    
    private var isRecovery: Bool
    init(isRecovery: Bool = false) {
        self.isRecovery = isRecovery
    }
    
    func buildUI() -> (UIViewController & Coordinable) {
        guard !isRecovery else {
            return RecoveryViewController()
        }
        
        let nav = UINavigationCoordinable()
        nav.coordinator = self
        self.navigationController = nav
        
        let vc = LoginViewController()
        let vm = LoginViewModel()
        vc.loginViewModel = vm
        vm.loginViewModelDeleage = vc
        vc.loginActionDelegate = self
        navigationController?.viewControllers = [vc]
        
        return nav
    }
}


protocol LoginActionDeleage: class {
    func login()
}


extension LoginCoordinator: LoginActionDeleage {
    func login() {
        LoginWorker().logIn() { _ in
            ProfileWorker().fetchProfileOnce() { _, _ in
                TripWorker().fetchTripsOnce() {_,_ in }
            }
        }
    }
}
