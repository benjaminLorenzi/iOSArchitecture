//
//  AppStates.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

class AppStates {
    var tripStatus: TripStatus
    var loginStatus: LoginStatus
    var biometryState: BiometryState
    var profileStatus: ProfileStatus
    private var dispatcher: Dispatcher
    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
        tripStatus = TripStatus(dispatcher: dispatcher)
        loginStatus = LoginStatus(dispatcher: dispatcher)
        biometryState = BiometryState(dispatcher: dispatcher)
        profileStatus = ProfileStatus(dispatcher: dispatcher)
    }
}
