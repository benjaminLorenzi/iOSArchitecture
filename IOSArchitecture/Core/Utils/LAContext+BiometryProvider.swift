//
//  LAContext+BiometryProvider.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 28/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation
import LocalAuthentication

// MARK: BiometryProvider
protocol BiometryProvider {
    func getSupportedBiometry() -> BiometryType
}

extension LAContext: BiometryProvider {
    func getSupportedBiometry() -> BiometryType {
        let hasBiometrySensor = canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)

        if !hasBiometrySensor {
            return .none
        }

        switch biometryType {
        case .none:
            return .none
        case .touchID:
            return .touchId
        case .faceID:
            return .faceId
        default:
            return .none
        }
    }
}
