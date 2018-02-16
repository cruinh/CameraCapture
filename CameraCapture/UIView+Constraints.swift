//
//  UIView+Constraints.swift
//  Text Detection Starter Project
//
//  Created by Matt Hayes on 2/13/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func center(inSuperview superview: UIView, withPadding padding: CGFloat? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        superview.addSubview(self)
        
        let viewsDict = ["self":self]
        
        do {
            superview.addConstraint(try NSLayoutConstraint.centerX(forView: self))
            superview.addConstraint(try NSLayoutConstraint.centerY(forView: self))
            
            if let padding = padding {
                superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(padding)-[self]-\(padding)-|", options: [], metrics: nil, views: viewsDict))
                superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(padding)-[self]-\(padding)-|", options: [], metrics: nil, views: viewsDict))
            }
            
        } catch {
            print("[--LAYOUT ERROR--]: " + String(describing:error))
        }
    }
}
