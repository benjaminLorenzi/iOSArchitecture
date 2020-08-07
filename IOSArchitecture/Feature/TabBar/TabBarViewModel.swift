//
//  TabBarViewModel.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 03/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import Foundation

enum TabType: Int {
    case Trips = 0,
    Account = 1
}

class TabBarViewModel: ViewModel {
    private(set) var currentTab: TabType = .Trips
    var uiDelegate: UIUpdatable?
    
    private var dispatcher: Dispatcher
    init(dispatcher: Dispatcher = DependenciesManager.main.dispatcher) {
        self.dispatcher = dispatcher
        self.dispatcher.listen(self, event: .tabChanged, selector: #selector(self.tabChanged(_:)))
    }
    
    @objc func tabChanged(_ notification: Notification) {
        guard let index = notification.userInfo?["index"] as? Int else {
            return
        }
        if let tabSelected = TabType.init(rawValue: index) {
            currentTab = tabSelected
            self.uiDelegate?.updateUI()
        }
    }
    
    deinit {
        self.dispatcher.stopListening(self)
    }
}
