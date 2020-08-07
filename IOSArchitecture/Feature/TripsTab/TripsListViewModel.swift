//
//  TripsListViewModel.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 02/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

protocol TripsListViewModelProtocol: ViewModel {
    var trips: [TripCellViewModel] { get }
    var isRefreshing: Bool { get }
    var uiDelegate: UIUpdatable? { get set }
}

class TripsListViewModel: TripsListViewModelProtocol, ViewModel {
    weak var uiDelegate: UIUpdatable?
    private(set) var trips: [TripCellViewModel] = []
    private(set) var isRefreshing: Bool = false
    
    private var tripStatus: TripStatus
    private var dataManager: DataManager
    init(dataManager: DataManager = DependenciesManager.main.dataManager, tripStatus: TripStatus = DependenciesManager.main.appStates.tripStatus) {
        self.dataManager = dataManager
        self.tripStatus = tripStatus
        
        tripStatus.addObserver(self) { [weak self] in
            self?.update()
        }
        self.update()
    }
    
    private func update() {
        self.trips = dataManager.tripList ?? []
        self.isRefreshing = tripStatus.value.isRefreshing
        self.uiDelegate?.updateUI()
    }
}
