//
//  LoginState.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 27/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

enum LoginState: String {
    case loggedOut
    case loggedIn
}

class LoginStatus: DynamicValueModifier {
    var loginState: DynamicValue<LoginState> = DynamicValue(.loggedOut)
    var loginRefreshing: DynamicValue<Bool> = DynamicValue(false)
    
    private var dispatcher: Dispatcher
    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
        dispatcher.listen(self, event: .beginLogin, selector: #selector(self.beginLoginCallBack(_:)))
        dispatcher.listen(self, event: .endLogin, selector: #selector(self.endLoginCallBack))
        dispatcher.listen(self, event: .logOut, selector: #selector(self.logOut))
    }
    
    @objc func beginLoginCallBack(_ notification: Notification) {
        setValue(loginRefreshing, value: true)
    }
    
    @objc func logOut(_ notification: Notification) {
        setValue(loginRefreshing, value: false)
        setValue(loginState, value: .loggedOut)
    }
    
    @objc func endLoginCallBack(_ notification: Notification) {
        setValue(loginRefreshing, value: false)
        setValue(loginState, value: .loggedIn)
    }
    
    deinit {
        self.dispatcher.stopListening(self)
    }
    
}
