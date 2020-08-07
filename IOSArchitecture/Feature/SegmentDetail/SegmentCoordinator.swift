//
//  SegmentCoordinator.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

class SegmentCoordinator: Coordinator  {
    var coordinable: Coordinable? {
        return uiViewController
    }
    
    var destinations: [Destination] = []
    
    private var segment: Segment
    
    init(segment: Segment) {
        self.segment = segment
    }
    
    weak var parentCoordinator: Coordinator?
    weak var uiViewController: UIViewCoordinable?
    
    func buildUI() -> (UIViewController & Coordinable) {
        let vc = SegmentViewController()
        vc.coordinator = self 
        self.uiViewController = vc
        
        vc.segmentActionDelegate = self
        let segmentViewModel = SegmentViewModel(segment: segment)
        vc.segmentViewModel = segmentViewModel
        segmentViewModel.segmentViewModelDelegate = vc
        
        return vc
    }
}

// MARK: Action and Navigation Handling
protocol SegmentActionsDelegate: class {
    func refreshTapped()
}

extension SegmentCoordinator: SegmentActionsDelegate {
    func refreshTapped() {
        TripWorker().refresh()
    }
}
