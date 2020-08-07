//
//  BiometryState.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 28/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

enum BiometryType: String, Codable {
    case touchId
    case faceId
    case none
}

struct BiometryModel: Codable {
    var enabled: Bool?
    var supportedBiometry: BiometryType?
    
    init(enabled: Bool = false, supportedBiometry: BiometryType = .none) {
        self.enabled = enabled
        self.supportedBiometry = supportedBiometry
    }
}

class BiometryState: DynamicValue<BiometryModel>, DynamicValueModifier {
    private var dispatcher: Dispatcher
    private var store: BiometryStore
    
    init(store: BiometryStore = UserDefaults.standard, dispatcher: Dispatcher) {
        self.store = store
        self.dispatcher = dispatcher
        super.init(BiometryModel(enabled: store.getBiometryEnabled(), supportedBiometry: store.getBiometry()))
        dispatcher.listen(self, event: .biometryChanged, selector: #selector(self.update))
    }
    
    @objc func update(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else {
            return
        }
        guard let newBiometry = try? BiometryModel.create(fromJSON: userInfo) else {
            return
        }
        if newBiometry.supportedBiometry != nil {
            store.saveBiometry(newBiometry.supportedBiometry!)
        }
        if newBiometry.enabled != nil {
            store.saveBiometryEnabled(enabled: newBiometry.enabled!)
        }
        setValue(self, value: BiometryModel(enabled: store.getBiometryEnabled(), supportedBiometry: store.getBiometry()))
    }
    
    deinit {
        self.dispatcher.stopListening(self)
    }
}
