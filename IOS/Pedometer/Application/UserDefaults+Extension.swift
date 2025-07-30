//
//  UserDefaults+Extension.swift
//  Pedometer
//
//  Created by Behzad on 21/12/2022.
//

import Foundation
import UIKit

extension UINavigationController {
        
    func backToViewController(viewController: Swift.AnyClass) {
        for element in viewControllers as Array {
            if element.isKind(of: viewController) {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
    
}
