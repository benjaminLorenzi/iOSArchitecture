//
//  SegmentCellViewModel.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 02/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

protocol SegmentCellProtocol: class {
    var name: String { get }
}

extension Segment: SegmentCellProtocol {}
