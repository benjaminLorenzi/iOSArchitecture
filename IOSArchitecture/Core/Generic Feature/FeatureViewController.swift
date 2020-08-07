//
//  FeatureViewController.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 08/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

protocol UIUpdatable: class {
    func updateUI()
}

protocol FeatureViewController: UIViewController, UIUpdatable {
    associatedtype ViewModel: FeatureViewModel
    associatedtype Actions
    var actions: Actions? { get set }
    var viewModel: ViewModel? { get set }
    func updateUI(viewModel: ViewModel)
}

extension FeatureViewController {
    func updateUI() {
        guard isViewLoaded else {
            return
        }
        guard let viewModel = self.viewModel else {
            return
        }
        updateUI(viewModel: viewModel)
    }
}
