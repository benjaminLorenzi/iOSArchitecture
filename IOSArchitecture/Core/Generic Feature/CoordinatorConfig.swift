//
//  FeatureConfig.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 08/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

protocol CoordinatorConfig: class {
    associatedtype ViewController: FeatureViewController where ViewController.ViewModel == ViewModel
    associatedtype ViewModel where ViewModel.UIDelegate == ViewController
    associatedtype Actions where ViewController.Actions == Actions
    associatedtype Deps where ViewModel.Deps == Deps
    static func configure(deps: Deps, coordinator: Actions) -> ViewController
}

extension CoordinatorConfig {
    static func configure(deps: Deps, coordinator: Actions) -> ViewController {
        let vc = ViewController()
        var vm = ViewModel.init(deps: deps)
        vc.viewModel = vm
        vc.actions = coordinator
        vm.uiDelegate = vc
        return vc
    }
}
