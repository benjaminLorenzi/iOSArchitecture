//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the DC (alias tactac kiki 🤣) Templates so
//  you can use now the benj architecture to Amex GBT project,
//  see https://gitlab.kdsneo.kds.com/blorenzi/iosarchitecture/tree/master/IOSArchitecture/Tutorial
//

import UIKit

// MARK: Dependencies
// Specify here the dependencies
protocol ___VARIABLE_featureName___DependenciesProtocol {
    // TODO : Dependencies declaration
    // here define all dependencies form the core
    //
    // see the example below
    //
    /*var profileStatus: ProfileStatus { get }
      var dataManager: DataManager { get }
      var biometryState: BiometryState { get }
    */
}
class ___VARIABLE_featureName___Dependencies: ___VARIABLE_featureName___DependenciesProtocol {
    // TODO: Use inject default core variable
    /*@Inject var dataManager: DataManager
    @Inject var appStates: AppStates
    var profileStatus: ProfileStatus {
        return appStates.profileStatus
    }
    var biometryState: BiometryState {
        return appStates.biometryState
    }*/
}

// MARK: Actions
// Specify here the actions
protocol ___VARIABLE_featureName___ActionProtocol {
    // TODO 5) Actions declaration
    // here define all managment of interaction between
    // the controller and the User action
    //
    // see the example below
    //
    // func logOut()
}
extension ___VARIABLE_featureName___Coordinator: ___VARIABLE_featureName___ActionProtocol {
    // TODO 6) Actions Implementation
    // here implement every actions you define above
    //
    // see the example below
    //
    /*
    func logOut() {
       // call what you need
       LoginWorker().logOut(completion: {_,_ in })
    }*/
}


// MARK: Coordinator
class ___VARIABLE_featureName___Coordinator: Coordinator, CoordinatorConfig {
    var coordinable: Coordinable? {
        return vc
    }
    var destinations: [Destination] = []
    
    // Configuration
    typealias Deps = ___VARIABLE_featureName___DependenciesProtocol
    typealias ViewController = ___VARIABLE_featureName___ViewController
    typealias ViewModel = ___VARIABLE_featureName___ViewModel
    typealias Actions = ___VARIABLE_featureName___ActionProtocol

    weak var parentCoordinator: Coordinator?
    weak var vc: UIViewCoordinable?

    func buildUI() -> (UIViewController & Coordinable) {
        let dependencies = ___VARIABLE_featureName___Dependencies()
        let vc = ___VARIABLE_featureName___Coordinator.configure(deps: dependencies, coordinator: self)
        vc.coordinator = self
        self.vc = vc
        return vc
    }
}

