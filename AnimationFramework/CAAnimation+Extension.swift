//
//  CAAnimation+Extension.swift
//  AnimationFramework
//
//  Created by Jordan.Dixon on 09/08/2017.
//  Copyright © 2017 Jordan Dixon. All rights reserved.
//

import UIKit

extension CAAnimation {
    
    /// An enum representing common Core Animation key paths.
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
    
    /// Initializes a CAKeyframeAnimation with a type-safe KeyPath.
    ///
    /// - Parameter keyPath: The `CAAnimation.KeyPath` enum value.
    convenience init(keyPath: KeyPath) {
        self.init(keyPath: keyPath.rawValue)
    }
}

extension CABasicAnimation {
    
    /// Initializes a CABasicAnimation with a type-safe KeyPath.
    ///
    /// - Parameter keyPath: The `CAAnimation.KeyPath` enum value.
    convenience init(keyPath: KeyPath) {
        self.init(keyPath: keyPath.rawValue)
    }
}
