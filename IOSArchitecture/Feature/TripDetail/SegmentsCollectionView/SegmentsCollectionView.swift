//
//  SegmentsCollectionView.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 02/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

class SegmentsCollectionView: UICollectionView {
    weak var actions: SegmentRoute?
    var segments: [SegmentCellProtocol]? {
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

    func buildCollectionView() {
        delegate = self
        dataSource = self
        delaysContentTouches = false
        
        registerCell(SegmentCollectionViewCell.self)
        contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12)
    }
}

extension SegmentsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segments?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SegmentCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.segmentCell = segments?[indexPath.row]
        return cell
    }
}

extension SegmentsCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let segment = segments?[indexPath.row] as? Segment else {
            return
        }
        actions?.tapOnSegment(segment: segment)
    }
}

extension SegmentsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let insets = collectionView.contentInset
           let width: CGFloat = bounds.size.width - insets.left - insets.right
           return CGSize(width: width, height: 100)
       }
}
