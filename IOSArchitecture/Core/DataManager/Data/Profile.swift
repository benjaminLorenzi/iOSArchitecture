//
//  Profile.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 27/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

class Profile: Codable {
    var externalId: String?
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var mozioEnabled: Bool?
    var bookingDotComEnabled: Bool?
    var chatAppId: String?
    var chatAccount: String?
    
    var username: String {
        return "\(firstName ?? "")\(lastName ?? "")"
    }
    
    enum CodingKey {
        case externalId,firstName,middleName,lastName,mozioEnabled, bookingDotComEnabled, chatAppId, chatAccount
    }
    
    init(username: String) {
        self.firstName = username
    }
}
