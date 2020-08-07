//
//  BaseNetWorker.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 05/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

class BaseNetWorker {
    var dispatcher: Dispatcher
    var driver: DriverProtocol
    var dataManager: DataManager
    var storeManager: StoreManager<ModelsStored>
    init(dispatcher: Dispatcher = DependenciesManager.main.dispatcher, driver: DriverProtocol = DependenciesManager.main.driver, dataManager: DataManager = DependenciesManager.main.dataManager, storeManager: StoreManager<ModelsStored> = DependenciesManager.main.storeManager) {
        self.dispatcher = dispatcher
        self.driver = driver
        self.dataManager = dataManager
        self.storeManager = storeManager
    }
    
    deinit {
        self.dispatcher.stopListening(self)
    }
}
