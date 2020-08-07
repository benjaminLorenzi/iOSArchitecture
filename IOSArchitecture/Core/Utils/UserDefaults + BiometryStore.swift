//
//  UserDefaults + BiometryStore.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 28/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

// MARK: BiometryStore
protocol BiometryStore {
    func bool(forKey: String) -> Bool
    func value(forKey key: String) -> Any?
    func set(_ value: Any?, forKey defaultName: String)
    func removeObject(forKey defaultName: String)
}

extension BiometryStore {
    var biometryKey: String {
        return "biometry"
    }
    
    var biometryEnabledKey: String {
        return "biometryEnabled"
    }
    
    func saveBiometry(_ value: BiometryType) {
        set(value.rawValue, forKey: biometryKey)
    }
    
    func getBiometry() -> BiometryType {
        return BiometryType(rawValue: value(forKey: biometryKey) as? String ?? "" ) ?? BiometryType.none
    }
    
    func saveBiometryEnabled(enabled: Bool) {
        set(enabled, forKey: biometryEnabledKey)
    }

    func getBiometryEnabled() -> Bool {
        return self.bool(forKey: biometryEnabledKey)
    }
    
}
extension UserDefaults: BiometryStore {}
