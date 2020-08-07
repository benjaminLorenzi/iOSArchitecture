//
//  BiometryWorker.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 28/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

class BiometryWorker {
    private var biometryProvider: BiometryProvider
    
    @Inject private var appStates: AppStates
    @Inject private var dispatcher: Dispatcher
    
    private var supportedBiometry: BiometryType {
        return appStates.biometryState.value.supportedBiometry ?? .none
    }
    
    init(biometryProvider: BiometryProvider) {
        self.biometryProvider = biometryProvider
    }
    
    func checkChanges() {
        let newBiometry = biometryProvider.getSupportedBiometry()
        
        if supportedBiometry != newBiometry {
            dispatcher.post(event: .biometryChanged, userInfo: ["supportedBiometry": newBiometry.rawValue])
        }
    }
}
