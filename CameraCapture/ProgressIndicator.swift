//
//  ProgressIndicator.swift
//  Text Detection Starter Project
//
//  Created by Matt Hayes on 2/13/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import Foundation
import UIKit

class ProgressIndicator : UIView {
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)

    init() {
        super.init(frame: .zero)
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = false
        
        activityIndicator.center(inSuperview: self, withPadding: 8)
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 3.0
        backgroundColor = .darkGray
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func add(toView view: UIView) {
        view.addSubview(self)
        self.center(inSuperview: view)
    }
    
    func hide() {
        removeFromSuperview()
    }
    
}
