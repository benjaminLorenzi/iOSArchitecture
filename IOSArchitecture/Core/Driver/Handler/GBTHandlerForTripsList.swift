//
//  GBTHandlerForTripsList.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 22/07/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

//
//  GBTHandlerForGetTripsList.swift
//  Amex GBT
//
//  Created by Tiberiu Butnaru on 02/12/2019.
//  Copyright © 2019 KDS. All rights reserved.
//

class GBTHandlerForGetTripsList: ServerRequest {
    init(force: Bool, driver: DriverProtocol, completion: @escaping GBTHandlerCompletion) {
        super.init(driver: driver, completion: completion)

        var badParamsError: NSError?
        var headers: [String: String]?

        setRequestParameters(requestType: .get,
                             badParametersError: nil,
                             endpointURL: URL(string: "")!,
                             headers: headers,
                             data: nil)
    }
}
