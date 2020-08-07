//
//  LoginViewController.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 27/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    
    var loginViewModel: LoginViewModel?
    var loginActionDelegate: LoginActionDeleage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func loginTapped(_ sender: Any) {
        loginActionDelegate?.login()
    }
}

protocol LoginViewModelDelegate: class {
    func updateUI()
}

extension LoginViewController: LoginViewModelDelegate {
    func updateUI() {
        guard isViewLoaded else {
            return
        }
        guard let loginViewModel = self.loginViewModel else {
            return
        }
        self.loginButton.loadingIndicator(loginViewModel.isLoading)
    }
}


