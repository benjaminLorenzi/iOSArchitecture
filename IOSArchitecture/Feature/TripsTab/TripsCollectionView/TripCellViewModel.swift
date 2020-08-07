//
//  TripCellViewModel.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 02/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

protocol TripCellViewModel: class {
    var name: String { get }
}

extension Trip: TripCellViewModel {
}


