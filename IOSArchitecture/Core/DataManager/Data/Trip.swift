//
//  Trip.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

class Trip: Codable {
    let id: String
    let name: String
    let segments: [Segment]
    
    init(id: String, name: String, segments: [Segment]) {
        self.id = id
        self.name = name
        self.segments = segments
    }
}
