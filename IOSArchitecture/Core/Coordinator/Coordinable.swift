//
//  Coordinable.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 07/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

protocol Coordinable {
    var coordinator: Coordinator? { get set }
    func navigate(coordinator: Coordinator)
}

class UIViewCoordinable: UIViewController, Coordinable {
    func navigate(coordinator: Coordinator) {
        present(coordinator.buildUI(), animated: true, completion: nil)
    }
    var coordinator: Coordinator?
}
