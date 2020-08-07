//
//  TripStatus.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

struct TripStatusModel {
    var isRefreshing: Bool
}

class TripStatus: DynamicValue<TripStatusModel>, DynamicValueModifier {
    private var dispatcher: Dispatcher
    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
        super.init(TripStatusModel(isRefreshing: false))
        dispatcher.listen(self, event: .beginRefreshTrips, selector: #selector(self.beginRefreshTrips(_:)))
        dispatcher.listen(self, event: .endRefreshTrips, selector: #selector(self.endRefreshTrips(_:)))
        dispatcher.listen(self, event: .logOut, selector: #selector(self.endRefreshTrips(_:)))
    }
    
    @objc private func beginRefreshTrips(_ notification: Notification) {
        setValue(self, value: TripStatusModel(isRefreshing: true))
    }
    
    @objc private func endRefreshTrips(_ notification: Notification) {
        setValue(self, value: TripStatusModel(isRefreshing: false))
    }
    
    deinit {
        self.dispatcher.stopListening(self)
    }
}

