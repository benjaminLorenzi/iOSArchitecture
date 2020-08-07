//
//  TripViewController.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

class TripViewController: UIViewCoordinable {
    var tripActionDelegate: TripActionsDelegate?
    
    var tripViewModel: TripViewModelProtocol? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var segmentsCollectionView: SegmentsCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.segmentsCollectionView.actions = tripActionDelegate
        updateUI()
    }
}

extension TripViewController: TripViewModelDelegate {
    func updateUI() {
        guard isViewLoaded else {
            return
        }
        guard let tripViewModel = self.tripViewModel else {
            return
        }
        navigationItem.title = "TRIP: \(tripViewModel.name)"
        segmentsCollectionView.segments = tripViewModel.segments
    }
}
