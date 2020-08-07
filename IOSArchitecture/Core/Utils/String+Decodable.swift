//
//  String+Decodable.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 27/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

extension String: Error {}

extension String {

    func toJson<T>(as: T.Type) throws -> T {
        guard let data: Data = self.data(using: .utf8) else {
            throw "Cannot convert \(self) into data using utf8 uncoding"
        }
        guard let json = (try JSONSerialization.jsonObject(with: data, options: [])) as? T else {
            throw "JsonSerialization failed"
        }
        return json
    }

    func toJSONArray() throws -> [[String: AnyObject]] {
        guard let data: Data = self.data(using: .utf8) else {
            throw "Cannot convert \(self) into data using utf8 uncoding"
        }
        guard let json = (try JSONSerialization.jsonObject(with: data, options: [])) as? [[String: AnyObject]] else {
            throw "JsonSerialization failed"
        }
        return json
    }

    func toJSON() throws -> [String: AnyObject] {
        guard let data: Data = self.data(using: .utf8) else {
            throw "Cannot convert \(self) into data using utf8 uncoding"
        }
        guard let json = (try JSONSerialization.jsonObject(with: data, options: [])) as? [String: AnyObject] else {
            throw "JsonSerialization failed"
        }
        return json
    }
}
