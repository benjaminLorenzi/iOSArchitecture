//
//  TripWorker.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//
import Foundation

class TripWorker: BaseNetWorker {
    func refresh() {
        dispatcher.post(event: .beginRefreshTrips)
        
        driver.getTrips(jsonTripsList: [], completion:{ trips, error in
            guard let trips = trips else {
                return
            }
            self.storeTrips(trips)
        })
    }
    
    private func storeTrips(_ trips: [Trip]) {
        storeManager.cache.tripList = trips
        storeManager.saveCache()
        dispatcher.post(event: .endRefreshTrips)
    }
    
    func fetchTripsOnce(completion: @escaping HandlerCompletion<Any>) {
        dispatcher.post(event: .beginRefreshTrips)
        
        guard dataManager.tripList == nil else {
            self.dispatcher.post(event: .endRefreshTrips)
            completion(nil, nil)
            return
        }
        
        driver.getTrips(jsonTripsList: [], completion: { trips, error in
            guard let trips = trips else {
                completion(nil, error as? NSError)
                return
            }
            self.storeTrips(trips)
            completion(trips, error as? NSError)
        })
    }
}
