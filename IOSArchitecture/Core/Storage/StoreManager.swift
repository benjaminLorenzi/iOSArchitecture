//
//  StoreManager.swift
//  Amex GBT
//
//  Created by Benjamin LORENZI on 30/11/2019.
//  Copyright © 2019 KDS. All rights reserved.
//

import Foundation

class StoreManager<T: Codable> {
    private var storageKey: String
    private var storage: StorageProtocol
    private var version: String
    private var versionKey: String
    private var userDefaults: UserDefaults
    private var diskLoadError: Bool = false
    var cache: T
    private var defaultValue: T
    var needRecovery: Bool {
        return versionChanged || diskLoadError
    }
    init(storage: StorageProtocol, storageKey: String, version: String, versionKey: String? = nil, userDefaults: UserDefaults = UserDefaults.standard, defaultValue: T) {
        self.storage = storage
        self.storageKey = storageKey
        self.version = version
        self.versionKey = versionKey ?? storageKey
        self.userDefaults = userDefaults
        self.cache = defaultValue
        self.defaultValue = cache
    }
}

extension StoreManager {
    func resetDatas() {
        cache = defaultValue
        saveCache()
    }

    func saveCache() {
        do {
            try cache.save(key: storageKey, writableStorage: self.storage)
        }
        catch {
            diskLoadError = false
            versionChanged = false
        }
    }

    func loadSavedDatas() {
        if versionChanged {
            return
        }
        do {
            cache = try T.fetch(key: storageKey, readableStorage: self.storage)
            diskLoadError = false
        } catch {
            diskLoadError = true
        }
    }
}

private extension StoreManager {
    var versionChanged: Bool {
        get {
            let savedVersion = userDefaults.string(forKey: self.versionKey)
            let dataVersionChanged = savedVersion == nil || (savedVersion != nil && savedVersion != version)
            return dataVersionChanged
        } set(newValue) {
            if newValue == false {
                userDefaults.set(version, forKey: self.versionKey)
            }
        }
    }
}
