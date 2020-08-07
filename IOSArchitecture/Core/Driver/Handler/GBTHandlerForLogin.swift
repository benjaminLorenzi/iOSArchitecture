//
//  GBTHandlerForLogin.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 22/07/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

//
//  GBTHandlerForLogin.swift
//  Amex GBT
//
//  Created by Tiberiu Butnaru on 02/12/2019.
//  Copyright © 2019 KDS. All rights reserved.
//

class GBTHandlerForLogin: ServerRequest {
    init(username: String!, password: String!, driver: DriverProtocol, completion: @escaping GBTHandlerCompletion) {
        super.init(driver: driver, completion: completion)

        var headers = [String: String]()
        headers["username"] = username
        headers["password"] = password
        //headers["appName"] = driver.appName
        //headers["deviceToken"] = driver.deviceToken
        //headers["deviceType"] = driver.deviceType
        //headers["channel"] = driver.channel

        setRequestParameters(requestType: .post,
                             badParametersError: nil,
                             endpointURL: URL(string: "")!,
                             headers: headers,
                             data: nil)
    }
}
