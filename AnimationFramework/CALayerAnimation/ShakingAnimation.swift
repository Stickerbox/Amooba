//
//  ShakingTextField.swift
//  AnimationFramework
//
//  Created by Jordan.Dixon on 09/08/2017.
//  Copyright © 2017 Jordan Dixon. All rights reserved.
//

import UIKit

extension UIView {
    
    func shake() {
        
        let animation = CABasicAnimation(keyPath: .position)
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        
        self.layer.add(animation, forKey: nil)
    }
}
