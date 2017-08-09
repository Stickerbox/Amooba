//
//  CAAnimation+Extension.swift
//  AnimationFramework
//
//  Created by Jordan.Dixon on 09/08/2017.
//  Copyright © 2017 Jordan Dixon. All rights reserved.
//

import UIKit

extension CAAnimation {
    
    enum KeyPath: String {
        case position
        case rotation
        case rotationX = "rotation.x"
        case rotationY = "rotation.y"
        case rotationZ = "rotation.z"
        case scale
        case scaleX = "scale.x"
        case scaleY = "scale.y"
        case scaleZ = "scale.z"
        case translation
        case translationX = "translation.x"
        case translationY = "translation.y"
        case translationZ = "translation.z"
        case transformScaleXY = "transform.scale.xy"
        case opacity
    }
    
}

extension CAKeyframeAnimation {
    
    convenience init(keyPath: KeyPath) {
        self.init(keyPath: keyPath.rawValue)
    }
}

extension CABasicAnimation {
    
    convenience init(keyPath: KeyPath) {
        self.init(keyPath: keyPath.rawValue)
    }
}
