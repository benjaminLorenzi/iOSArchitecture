//
//  SegmentViewModel.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

protocol SegmentViewModelProtocol {
    var name: String { get }
    var isRefreshing: Bool { get }
    var isRemoved: Bool { get }
}

protocol SegmentViewModelDelegate: UIUpdatable {
}

class SegmentViewModel: SegmentViewModelProtocol {
    weak var segmentViewModelDelegate: SegmentViewModelDelegate?
    
    private var segmentId: String = ""
    private weak var segment: Segment? {
        return dataManager.tripList?.flatMap({ $0.segments }).first(where: { $0.id == segmentId })
    }
    var isRemoved: Bool {
        return segment == nil
    }
    var isRefreshing: Bool {
        return tripStatus.value.isRefreshing
    }
    
    private var _name: String?
    var name: String {
        if _name != nil {
            return _name!
        }
        _name = segment?.name
        return _name ?? ""
    }
    
    // Dependencies
    private var tripStatus: TripStatus
    private var dataManager: DataManager
    
    init(segment: Segment, tripStatus: TripStatus = DependenciesManager.main.appStates.tripStatus, dataManager: DataManager = DependenciesManager.main.dataManager) {
        self.segmentId = segment.id
        self.tripStatus = tripStatus
        self.dataManager = dataManager
        
        self.tripStatus.addObserver(self) { [weak self] in
            self?.notify()
        }
    }
    
    private func notify() {
        segmentViewModelDelegate?.updateUI()
    }
}
