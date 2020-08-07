//
//  TripViewModel.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

protocol TripViewModelProtocol {
    var name: String { get }
    var isRefreshing: Bool { get }
    var segments: [SegmentCellProtocol] { get }
    var isRemoved: Bool { get }
}

protocol TripViewModelDelegate: class {
    func updateUI()
}

private extension Trip {
    func hasBeenRemoved(from trips: [Trip]) -> Bool {
        return trips.first { $0.id ==  self.id } == nil
    }
}

class TripViewModel: TripViewModelProtocol {
    // delegate
    weak var tripViewModelDelegate: TripViewModelDelegate?
    
    private var tripId: String = ""
    
    var trip: Trip? {
        let trips = (dataManager.tripList ?? []).map({ $0 })
        let newTrip = trips.first { $0.id == tripId }
        return newTrip
    }
    
    var isRemoved: Bool {
        return trip == nil
    }
    
    private var _name: String?
    var name: String {
        if _name != nil {
            return _name!
        }
        _name = trip?.name
        return _name ?? ""
    }
    
    var isRefreshing: Bool {
        return tripStatus.value.isRefreshing
    }
    
    private var _segments: [SegmentCellProtocol]?
    var segments: [SegmentCellProtocol] {
        if _segments != nil {
            return _segments!
        }
        _segments = trip?.segments
        return _segments ?? []
    }
    
    // Dependencies
    private var tripStatus: TripStatus
    private var dataManager: DataManager
    
    init(trip: Trip, tripStatus: TripStatus = DependenciesManager.main.appStates.tripStatus, dataManager: DataManager = DependenciesManager.main.dataManager) {
        self.tripStatus = tripStatus
        self.dataManager = dataManager
        self.tripId = trip.id
        update()
        
        tripStatus.addObserver(self) { [weak self] in
            self?.update()
        }
    }
    
    
    private func update() {
        tripViewModelDelegate?.updateUI()
    }
}

