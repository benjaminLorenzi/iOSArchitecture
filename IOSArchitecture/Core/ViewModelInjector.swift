//
//  ViewModelInjector.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 08/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

enum PayloadType: String {
    case segmentViewModel, accountViewModel, tripViewModel
}

// MARK: ViewControllerTypeBuilder
enum ViewControllerTypeBuilder: String, Codable {
    case account
    
    // Bind to AccountViewController
    func getViewController() -> hasViewModel {
        // switch self case : Handle differents case here
        // TODO: Replace by GBTAccountViewController
        //return GBTAccountViewController()
        return LoginViewController()
    }
}

extension LoginViewController: hasViewModel {
    func assignViewModel(object: AnyObject) {
    }
}

// TODO: GBTAccountViewController bind to hasViewModel
/*
extension GBTAccountViewController: hasViewModel {
    func assignViewModel(object: AnyObject) {
        /*if let mock = object as? FakeAccountViewModel {
            let mockAccountViewModel = MockGBTAccountViewModel(mock: mock)
            self.viewModel = mockAccountViewModel
        }*/
    }
}*/

// MARK: hasViewModel
protocol hasViewModel: UIViewController {
    func assignViewModel(object: AnyObject)
}


class ViewModelInjector: Decodable {
    let type: String
    let payload: Any?
    let viewControllerType: ViewControllerTypeBuilder
    
    private enum CodingKeys: String, CodingKey {
         case type = "view_model_type", payload, viewControllerType = "view_controller_type"
    }
    
    static var registered: Bool = false
    static private func registerIfNeeded() {
        guard !registered else {
            return
        }
        // TODO : Bind the FakeAccountViewModel
       // ViewModelInjector.register(FakeAccountViewModel.self, for: PayloadType.accountViewModel.rawValue)
    }

    required init(from decoder: Decoder) throws {
        ViewModelInjector.registerIfNeeded()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        viewControllerType = try container.decode(ViewControllerTypeBuilder.self, forKey: .viewControllerType)

        if let decode = ViewModelInjector.decoders[type] {
            payload = try decode(container)
        } else {
            payload = nil
        }
    }

    private typealias GenericCodableWrapperDecoder = (KeyedDecodingContainer<CodingKeys>) throws -> Any
    private static var decoders: [String: GenericCodableWrapperDecoder] = [:]

    static func register<A: Codable>(_ type: A.Type, for typeName: String) {
        decoders[typeName] = { container in
            try container.decode(A.self, forKey: .payload)
        }
    }
    
    func getRootViewController() -> UIViewController {
        let viewController = UIViewController()
        // TODO: Rebind it
        //viewControllerType.getViewController()
        if payload != nil {
         //   viewController.assignViewModel(object: payload! as AnyObject)
        }
        return viewController
    }
}
