//
//  SegmentCollectionViewCell.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 02/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

class SegmentCollectionViewCell: UICollectionViewCell {
    weak var segmentCell: SegmentCellProtocol? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var segmentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateUI()
    }
}

extension SegmentCollectionViewCell {
    func updateUI() {
        guard let segmentCell = self.segmentCell else {
            return
        }
        segmentLabel.text = segmentCell.name
    }
}
