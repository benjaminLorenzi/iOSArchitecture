//
//  DiskStorage.swift
//  Amex GBT
//
//  Created by Benjamin LORENZI on 30/11/2019.
//  Copyright © 2019 KDS. All rights reserved.
//

import Foundation

enum StorageError: Error {
    case notFound
    case cantWrite(Error)
    case cantRemove(Error)
}

class DiskStorage {
    private let queue: DispatchQueue
    let fileManager: FileManager
    private let path: URL

    init(
        path: URL = URL(fileURLWithPath: NSTemporaryDirectory()),
        queue: DispatchQueue = .init(label: "DiskCache.Queue"),
        fileManager: FileManager = FileManager.default
    ) {
        self.path = path
        self.queue = queue
        self.fileManager = fileManager
    }

    func writeValue(value: Data, to url: URL) throws {
        try value.write(to: url, options: .atomic)
    }

}

// MARK: DiskStorage WritableStorage extension
extension DiskStorage: WritableStorage {
    func save(value: Data, for key: String) throws {
        let url = path.appendingPathComponent(key)
        do {
            try self.createFolders(in: url)
            try writeValue(value: value, to:url)
        } catch {
            throw StorageError.cantWrite(error)
        }
    }

    func save(value: Data, for key: String, handler: @escaping Handler<Data>) {
        queue.async {
            do {
                try self.save(value: value, for: key)
                handler(.success(value))
            } catch {
                handler(.failure(error))
            }
        }
    }

    func remove(for key: String) throws {
        let url = path.appendingPathComponent(key)
        do {
            try fileManager.removeItem(at: url)
        } catch {
            throw StorageError.cantRemove(error)
        }
    }

    func remove(value: Data, for key: String, handler: @escaping Handler<Data>) {
        queue.async {
            do {
                try self.remove(for: key)
                handler(.success(value))
            } catch {
                handler(.failure(error))
            }
        }
    }
}

extension DiskStorage {
    private func createFolders(in url: URL) throws {
        let folderUrl = url.deletingLastPathComponent()
        if !fileManager.fileExists(atPath: folderUrl.path) {
            try fileManager.createDirectory(
                at: folderUrl,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
    }
}

// MARK: DiskStorage ReadableStorage extension
extension DiskStorage: ReadableStorage {
    func fetchValue(for key: String) throws -> Data {
        let url = path.appendingPathComponent(key)
        guard let data = fileManager.contents(atPath: url.path) else {
            throw StorageError.notFound
        }
        return data
    }

    func fetchValue(for key: String, handler: @escaping Handler<Data>) {
        queue.async {
            handler(Result { try self.fetchValue(for: key) })
        }
    }
}
