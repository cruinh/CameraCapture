//
//  NSLayoutConstraints+Shorthand.swift
//  Text Detection Starter Project
//
//  Created by Matt Hayes on 2/13/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    static func centerX(forView view: UIView, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) throws -> NSLayoutConstraint {
        return try constraintMatchingSuperview(toSubview: view, attribute: .centerX, multiplier: multiplier, constant: constant)
    }
    
    static func centerY(forView view: UIView, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) throws -> NSLayoutConstraint {
        return try constraintMatchingSuperview(toSubview: view, attribute: .centerY, multiplier: multiplier, constant: constant)
    }
    
    static func constraintMatchingSuperview(toSubview view:UIView, attribute: NSLayoutAttribute, multiplier: CGFloat = 1.0, constant: CGFloat = 0) throws -> NSLayoutConstraint {
        guard let parentView = view.superview else {
            let errorMessage = "can't make centering constraint for view that doesn't have a superview"
            print(errorMessage)
            throw NSError(domain: "\(#file):\(#function):\(#line)", code: 1, userInfo: ["reason":errorMessage])
        }
        
        return NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: parentView, attribute: attribute, multiplier: multiplier, constant: constant)
    }
}
