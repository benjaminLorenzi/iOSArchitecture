//
//  TripsCollectionView.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 02/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

class TripsCollectionView: UICollectionView {
    weak var actions: TripRoute?
    var trips: [TripCellViewModel]? {
        didSet {
            reloadData()
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        buildCollectionView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildCollectionView()
    }

    private func buildCollectionView() {
        dataSource = self
        delegate = self
        delaysContentTouches = false
        registerCell(TripCollectionViewCell.self)
        contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12)
    }
}

extension TripsCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let trip = trips?[indexPath.row] as? Trip else {
            return
        }
        actions?.tapOnTrip(trip: trip)
    }
}

extension TripsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insets = collectionView.contentInset
        let width: CGFloat = collectionView.bounds.size.width - insets.left - insets.right
        return CGSize(width: width, height: 100)
    }
}

extension TripsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips?.count ?? 0 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TripCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.tripCell = trips?[indexPath.row]
        return cell
    }
}
