//
//  FeatureModel.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 08/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation


protocol FeatureViewModel {
    associatedtype Deps
    var dependencies: Deps { get set }
    init(deps: Deps)
    associatedtype UIDelegate: UIUpdatable
    var uiDelegate: UIDelegate? { get set }
    func notify()
}

extension FeatureViewModel {
    func notify() {
        uiDelegate?.updateUI()
    }
}


// 
protocol ViewModel {
    var uiDelegate: UIUpdatable? { get set }
}

extension ViewModel {
    func notify() {
        uiDelegate?.updateUI()
    }
}




