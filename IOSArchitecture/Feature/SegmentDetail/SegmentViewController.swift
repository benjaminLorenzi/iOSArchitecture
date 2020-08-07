//
//  SegmentViewController.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

class SegmentViewController: UIViewCoordinable {
    @IBOutlet weak var segmentLabel: UILabel!
    
    var segmentActionDelegate: SegmentActionsDelegate?
    var segmentViewModel: SegmentViewModelProtocol? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
}

extension SegmentViewController: SegmentViewModelDelegate {
    func updateUI() {
        guard isViewLoaded else {
            return
        }
        guard let segmentViewModel = self.segmentViewModel else {
            return
        }
        segmentLabel.text = segmentViewModel.name
        navigationItem.title = "SEGMENT: \(segmentViewModel.name)"
    }
}

