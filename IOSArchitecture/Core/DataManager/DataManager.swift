//
//  DataManager.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

struct ModelsStored: Codable {
    var tripList: [Trip]?
    var profile: Profile?
    
    var isIncomplete: Bool {
        return tripList == nil || profile == nil
    }
}

@dynamicMemberLookup
class DataManager {
    // Variable accessible only in a DataManagerModifier
    private var storeManager: StoreManager<ModelsStored>
    
    // give a read only access to the cache
    subscript<T>(dynamicMember keyPath: KeyPath<ModelsStored, T>) -> T {
        return self.storeManager.cache[keyPath: keyPath]
    }
   
    // storeManager can be injected for testing
    init(storeManager: StoreManager<ModelsStored> = DependenciesManager.main.storeManager) {
        self.storeManager = storeManager
        self.storeManager.loadSavedDatas()
    }
}

