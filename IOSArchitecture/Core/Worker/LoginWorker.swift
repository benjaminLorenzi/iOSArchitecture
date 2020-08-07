//
//  LoginWorker.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 27/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//
import Foundation

class LoginWorker: BaseNetWorker {
    func logIn(completion: @escaping (Error?) -> Void) {
        dispatcher.post(event: .beginLogin)
        
        driver.login(username: "", password: "", silent: false, completion: { error in
            self.dispatcher.post(event: .endLogin)
            completion(error)
        })
    }
    
    func logOut(completion: @escaping HandlerCompletion<Any>) {
        driver.logOut() { json,error in
            self.storeManager.resetDatas()
            self.dispatcher.post(event: .logOut)
            completion(json,error)
        }
    }
}

