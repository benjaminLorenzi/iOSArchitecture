//
//  HomeViewModel.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 03/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

enum HomeStatus: String {
    case loggedIn
    case loggedOut
    case needRecovey
}

class HomeViewModel {
    private(set) var homeStatus: HomeStatus = .loggedOut {
        didSet {
            uiDelegate?.updateUI()
        }
    }
    weak var uiDelegate: UIUpdatable?
    
    // Dependencies
    private var loginStatus: LoginStatus
    private var profileStatus: ProfileStatus
    private var tripStatus: TripStatus
    private var dataManager: DataManager
    
    init(loginStatus: LoginStatus = DependenciesManager.main.appStates.loginStatus, profileStatus: ProfileStatus = DependenciesManager.main.appStates.profileStatus, tripStatus: TripStatus = DependenciesManager.main.appStates.tripStatus, dataManager:  DataManager = DependenciesManager.main.dataManager) {
        
        self.loginStatus = loginStatus
        self.profileStatus = profileStatus
        self.tripStatus = tripStatus
        self.dataManager = dataManager
        
        loginStatus.loginState.addObserver(self) { [weak self] in
            self?.update()
        }
        profileStatus.addObserver(self) { [weak self] in
            self?.update()
        }
        tripStatus.addObserver(self) { [weak self] in
            self?.update()
        }
        self.update()
    }
    
    private func newHomeStatus() -> HomeStatus {
        guard self.loginStatus.loginState.value != .loggedOut else {
           return .loggedOut
        }
        guard !dataManager.isIncomplete else {
           return .needRecovey
        }
        return .loggedIn
    }
    
    private func update() {
        let newHomeStatus = self.newHomeStatus()
        if newHomeStatus != self.homeStatus {
            self.homeStatus = newHomeStatus
        }
    }
}
