//
//  Decodable+Architecture.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 27/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

extension Decodable {
    static func create(fromJSON json: [AnyHashable: Any]) throws -> Self {
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        let object = try JSONDecoder().decode(Self.self, from: data)
        return object
    }
    
    static func safeCreate(fromJSON json: [AnyHashable: Any]) -> Self? {
        var data: Self?
        do {
            data = try create(fromJSON: json)
        } catch {
           // Log.error(error: error)
        }
        return data
    }
    
    static func arrayOfObjects(fromJSON jsons: [Any]) -> [Self] {
        return jsons.map { Self.safeCreate(fromJSON: ($0 as! [AnyHashable: Any])) }.filter { $0 != nil } as? [Self] ?? []
    }
}

extension Encodable {
    static func json(fromArrayOf elements: [Self]) -> [Any] {
        return elements.map { $0.json() as Any }
    }

    func json() -> NSMutableDictionary! {
        let encodedObject = try! JSONEncoder().encode(self)
        let json = try! JSONSerialization.jsonObject(with: encodedObject, options: []) as! [String: Any]
        let dict = NSMutableDictionary()
        dict.addEntries(from: json)
        return dict
    }
}
