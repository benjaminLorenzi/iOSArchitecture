//
//  ProfileWorker.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 05/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

class ProfileWorker: BaseNetWorker {
    
    func fetchProfileOnce(completion: @escaping (_ profile: Profile?, _ error: NSError?) -> Void ) {
        guard dataManager.profile == nil else {
            self.dispatcher.post(event: .endProfileFetched)
            completion(nil,nil)
            return
        }
        refreshProfile(completion: completion)
    }
    
    func refreshProfile(completion: @escaping (_ profile: Profile?, _ error: NSError?) -> Void ) {
           dispatcher.post(event: .beginProfileFetched)
           driver.getProfile() { profile, error in
               self.storeProfile(profile)
               completion(profile,error)
           }
       }
}

private extension ProfileWorker {
    func storeProfile(_ profile: Profile?) {
        guard let profile = profile else {
            return
        }
        storeManager.cache.profile = profile
        storeManager.saveCache()
        dispatcher.post(event: .endProfileFetched)
    }
}
