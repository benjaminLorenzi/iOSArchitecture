//
//  UIButton+Loading.swift
//  IOSArchitecture
//
//  Created by Benjamin LORENZI on 27/02/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import UIKit

extension UIButton {
    func loadingIndicator(_ show: Bool) {
        DispatchQueue.main.async {
            let tag = 808404
            if show {
                self.isEnabled = false
                self.alpha = 0.5
                self.titleLabel?.alpha = 0
                let indicator = UIActivityIndicatorView()
                let buttonHeight = self.bounds.size.height
                let buttonWidth = self.bounds.size.width
                indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
                indicator.tag = tag
                self.addSubview(indicator)
                indicator.startAnimating()
            } else {
                self.isEnabled = true
                self.alpha = 1.0
                self.titleLabel?.alpha = 1.0
                if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                    indicator.stopAnimating()
                    indicator.removeFromSuperview()
                }
            }
        }
    }
    func neoSetEnabled(_ enabled: Bool) {
        if enabled {
            alpha = 1
        } else {
            alpha = 0.25
        }
        isEnabled = enabled
    }
}
