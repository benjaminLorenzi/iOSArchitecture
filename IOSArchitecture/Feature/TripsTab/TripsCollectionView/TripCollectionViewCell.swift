//
//  TripCollectionViewCell.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 02/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

class TripCollectionViewCell: UICollectionViewCell {
    weak var tripCell: TripCellViewModel? {
        didSet {
            updateUI()
        }
    }
    @IBOutlet weak var tripLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    func updateUI() {
        guard let tripCell = self.tripCell else {
            return
        }
        tripLabel.text = tripCell.name
    }
}
