//
//  Dependencies.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation
import UIKit

class DependenciesManager {
    static var main = DependenciesManager()
    fileprivate var dependencies =  Dependencies()
    
    private(set) var appStates: AppStates
    private(set) var storeManager: StoreManager<ModelsStored>
    private(set) var dataManager: DataManager
    
    private(set) var driver: DriverProtocol
    private(set) var dispatcher: Dispatcher

    init() {
        self.driver = NetworkDriver() // DemoDriver()
        self.dispatcher = Dispatcher()
        
        self.storeManager = StoreManager<ModelsStored>(storage: DiskStorage(), storageKey: "NeoDataManager.json", version: "1.10", versionKey: "DataManagerVersion", defaultValue: ModelsStored())
        self.dataManager = DataManager(storeManager: storeManager)
        self.appStates = AppStates(dispatcher: dispatcher)
        
        dependencies.addOrReplace({ self.driver as DriverProtocol })
        dependencies.addOrReplace({ self.dispatcher as Dispatcher })
        dependencies.addOrReplace({ self.dataManager as DataManager })
        dependencies.addOrReplace({ self.appStates as AppStates })
    }
}

class Dependencies {
    private var factories = [String: () -> Any]()
    
    func addOrReplace<T>(_ factory: @escaping () -> T) {
        let key = String(describing: T.self)
        factories[key] = factory
    }
    
    func resolve<T>() -> T {
        let key = String(describing: T.self)
        
        guard let component: T = factories[key]?() as? T else {
            fatalError("Dependency '\(T.self)' not resolved!")
        }
        
        return component
    }
}


@propertyWrapper
public struct Inject<Value> {
    public var wrappedValue: Value {
        DependenciesManager.main.dependencies.resolve()
    }
    public init() {}
}
