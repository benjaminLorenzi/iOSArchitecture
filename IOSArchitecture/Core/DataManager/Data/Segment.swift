//
//  Segment.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 26/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

class Segment: Codable {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

extension Segment: Equatable {
    public static func == (lhs: Segment, rhs: Segment) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
