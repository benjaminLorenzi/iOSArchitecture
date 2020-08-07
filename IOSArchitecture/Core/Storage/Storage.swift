//
//  Storage.swift
//  Amex GBT
//
//  Created by Benjamin LORENZI on 30/11/2019.
//  Copyright © 2019 KDS. All rights reserved.
//

import Foundation

typealias Handler<T> = (Result<T, Error>) -> Void

protocol ReadableStorage {
    func fetchValue(for key: String) throws -> Data
    func fetchValue(for key: String, handler: @escaping Handler<Data>)
}

protocol WritableStorage {
    func save(value: Data, for key: String) throws
    func save(value: Data, for key: String, handler: @escaping Handler<Data>)

    func remove(for key: String) throws
    func remove(value: Data, for key: String, handler: @escaping Handler<Data>)
}

typealias StorageProtocol = ReadableStorage & WritableStorage


extension JSONDecoder {
    static var neoDecoder = JSONDecoder()
}

extension JSONEncoder {
    static var neoEncoder = JSONEncoder()
}

extension ReadableStorage {
    func fetch<T: Decodable>(for key: String, decoder: JSONDecoder = JSONDecoder.neoDecoder) throws -> T {
        let data = try fetchValue(for: key)
        return try decoder.decode(T.self, from: data)
    }
}

extension WritableStorage {
    func save<T: Encodable>(_ value: T, for key: String, encoder: JSONEncoder = JSONEncoder.neoEncoder) throws {
        let data = try encoder.encode(value)
        try save(value: data, for: key)
    }
}

extension Encodable {
    func save(key: String, writableStorage: WritableStorage = DiskStorage()) throws {
        try writableStorage.save(self, for: key)
    }

    func remove(key: String, writableStorage: WritableStorage = DiskStorage()) throws {
        try writableStorage.remove(for: key)
    }
}

extension Decodable {
    static func fetch<T: Decodable>(key: String, readableStorage: ReadableStorage = DiskStorage()) throws -> T {
        return try readableStorage.fetch(for: key)
    }
}
