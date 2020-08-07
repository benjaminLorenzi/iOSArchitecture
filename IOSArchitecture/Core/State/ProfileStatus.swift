//
//  ProfileStatus.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 05/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

class ProfileStatus: DynamicValue<Bool>, DynamicValueModifier {
    private var dispatcher: Dispatcher
    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
        super.init(false)
        dispatcher.listen(self, event: .beginProfileFetched, selector: #selector(self.beginUserFetched(_:)))
        dispatcher.listen(self, event: .endProfileFetched, selector: #selector(self.endUserFetched(_:)))
    }
    
    @objc private func endUserFetched(_ notification: Notification) {
        setValue(self, value: false)
    }
    
    @objc private func beginUserFetched(_ notification: Notification) {
        setValue(self, value: true)
    }
    
    deinit {
        self.dispatcher.stopListening(self)
    }
}
