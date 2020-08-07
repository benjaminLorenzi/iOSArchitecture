//
//  ReusableUtils.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 02/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

protocol Reusable {}

extension UICollectionViewCell: Reusable {}
extension UITableViewCell: Reusable {}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {

    func registerCell(_ Type: UICollectionViewCell.Type, ofKind elementKind: String? = nil) {
        if let elementKindSection = elementKind {
            self.register(UINib(nibName: Type.reuseIdentifier, bundle: nil),
                          forSupplementaryViewOfKind: elementKindSection,
                          withReuseIdentifier: Type.reuseIdentifier)
        } else {
            self.register(UINib(nibName: Type.reuseIdentifier, bundle: nil),
                          forCellWithReuseIdentifier: Type.reuseIdentifier)
        }
    }

    func dequeueReusableCell <Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Can not dequeue Cell :\(Cell.reuseIdentifier) at \(indexPath)")
        }
        return cell
    }

    func dequeueReusableSupplementaryView <Cell: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let header = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Can not dequeueReusableSupplementaryView Cell :\(Cell.reuseIdentifier) at \(indexPath)")
        }
        return header
    }
}


extension UITableView {
    func registerCell(_ Type: UITableViewCell.Type) {
        self.register(Type.self,
                      forCellReuseIdentifier: Type.reuseIdentifier)
    }

    func dequeueReusableCell <Cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Can not dequeue Cell :\(Cell.reuseIdentifier) at \(indexPath)")
        }
        return cell
    }
}

