//
//  Driver.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

// get API : /trips/ ....
// combine les API calls => Worker
// authenfication => sous partie de Driver. AuthentificationDelegate ?
// AuthentificationState ..
//public typealias HandlerCompletion = (_ jsonResponse: Any?, _ error: NSError?) -> Void
public typealias HandlerCompletion<T> = (_ response: T?, _ error: NSError?) -> Void

protocol DriverProtocol {
    func logOut(completion: @escaping HandlerCompletion<Any>)
    func login(username: String, password: String, silent: Bool, completion: @escaping (Error?) -> Void)
    func getProfile(completion: @escaping HandlerCompletion<Profile>)
    func getTrips(jsonTripsList: [Any], completion: @escaping ([Trip]?, Error?) -> Void)
}

class NetworkDriver: DriverProtocol {
    func logOut(completion: @escaping HandlerCompletion<Any>) {
    }
    
    // (_ jsonResponse: Any?, _ error: NSError?) -> Void
    func login(username: String, password: String, silent: Bool = false, completion:  @escaping (Error?) -> Void) {
        GBTHandlerForLogin(username: username, password: password, driver: self) { (jsonResponse, error) in
            guard error == nil else {
                completion(error)
                return
            }

            //self.loginOK(username: username, password: password, jsonResponse: jsonResponse!)
            if !silent {
                //self.handleAfterLogin(response: completion)
            } else {
                completion(nil)
            }
        }.invoke()
    }
    
    func refreshAuthToken() {
        
    }
    
    func getProfile(completion: @escaping HandlerCompletion<Profile>) {
        let jsonProfileString = """
            {
              "id": "{{urlParam 'id'}}",
              "externalId": "2",
              "title": null,
              "firstName": "John",
              "middleName": null,
              "lastName": "Doe",
              "mozioEnabled": false,
              "bookingDotComEnabled": false,
              "chatAppId": "123232",
              "chatAccount": "12232132",
              "lastModificationDateTime": "2018-06-20T09:53:57.458042Z",
              "companyIds": []
            }
        """
        let json = try! jsonProfileString.toJSON()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(1050)) {
            let profile = try? Profile.create(fromJSON: json)
            completion(profile, nil)
        }
    }
    
    func getTrips(jsonTripsList: [Any], completion: @escaping ([Trip]?, Error?) -> Void) {
        let request = GBTHandlerForGetTripsList(force: true, driver: self) { (jsonResponse, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }

            let jsonTripsList = jsonResponse as! [Any]
            self.getTrips(jsonTripsList: jsonTripsList, completion: completion)
        }

        request.invoke()
    }
}


class DemoDriver: DriverProtocol {
    
    func logOut(completion: @escaping HandlerCompletion<Any>) {
        completion(nil, nil)
    }
    
    func login(username: String, password: String, silent: Bool = false, completion: (Error?) -> Void) {
        /*
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(1050)) {
            completion(nil)
        }*/
    }
    
    func getProfile(completion: @escaping HandlerCompletion<Profile>) {
        let jsonProfileString = """
            {
              "id": "{{urlParam 'id'}}",
              "externalId": "2",
              "title": null,
              "firstName": "John",
              "middleName": null,
              "lastName": "Doe",
              "mozioEnabled": false,
              "bookingDotComEnabled": false,
              "chatAppId": "123232",
              "chatAccount": "12232132",
              "lastModificationDateTime": "2018-06-20T09:53:57.458042Z",
              "companyIds": []
            }
        """
        let json = try! jsonProfileString.toJSON()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(1050)) {
            let profile = try? Profile.create(fromJSON: json)
            completion(profile, nil)
        }
    }
    
    func getTrips(jsonTripsList: [Any], completion: @escaping ([Trip]?, Error?) -> Void) {
        let jsonTripString = """
            [
            {
                "id": "trip1",
                "name": "Paris-NewYork",
                "segments": [
                    {
                        "id": "seg1",
                        "name": "Hotel in Paris"
                    }
                ]
            },
            {
                "id": "trip2",
                "name": "Paris-Barcelone -> Cancel :(",
                "segments": [
                    {
                        "id": "seg2",
                        "name": "Best hotel in world."
                    },
                    {
                        "id": "seg3",
                        "name": "Car rental deluxe"
                    }
                ]
            },
            {
                "id": "trip3",
                "name": "Paris-Bucarest",
                "segments": [
                    {
                        "id": "seg4",
                        "name": "Flight to Bucarest"
                    },
                    {
                        "id": "seg5",
                        "name": "Hotel in Bucarest"
                    }
                ]
            }
            ]
        """
        let jsonTrip = try! jsonTripString.toJSONArray()
        let trips = Trip.arrayOfObjects(fromJSON: jsonTrip)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(1050)) {
            completion(trips, nil)
        }
    }
}
