
//
//  TripsViewController.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 02/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

class TripsViewController: UIViewCoordinable {
    var tripsViewModel: TripsListViewModelProtocol?
    var actions: TripActions?
    @IBOutlet weak var tripsCollectionView: TripsCollectionView!
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tripsCollectionView.actions = self.actions
        tripsCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshDatas(_:)), for: .valueChanged)
        navigationItem.title = "Trips"
        updateUI()
    }
    
    @objc func refreshDatas(_ sender: Any) {
        actions?.refreshDatas()
    }
}

extension TripsViewController: UIUpdatable {
    func updateUI() {
        guard isViewLoaded else {
            return
        }
        guard let tripsViewModel = self.tripsViewModel else {
            return
        }
        tripsCollectionView.trips = tripsViewModel.trips
        
        if tripsViewModel.isRefreshing {
            self.refreshControl.beginRefreshing()
        } else {
            self.refreshControl.endRefreshing()
        }
    }
}

