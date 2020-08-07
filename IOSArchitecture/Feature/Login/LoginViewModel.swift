//
//  LoginViewModel.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 27/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

protocol LoginViewModelProtocol {
    var isLoading: Bool { get }
}

class LoginViewModel: LoginViewModelProtocol {
    weak var loginViewModelDeleage: LoginViewModelDelegate?
    
    var isLoading: Bool = false
    
    private var loginStatus: LoginStatus
    init(loginStatus: LoginStatus = DependenciesManager.main.appStates.loginStatus) {
        self.loginStatus = loginStatus
        loginStatus.loginRefreshing.addObserver(self) { [weak self] in
            self?.update()
        }
        self.update()
    }
    
    private func update() {
        isLoading = loginStatus.loginRefreshing.value
        loginViewModelDeleage?.updateUI()
    }
}
