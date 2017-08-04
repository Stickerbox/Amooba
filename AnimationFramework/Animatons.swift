//
//  Animatons.swift
//  AnimationFramework
//
//  Created by Jordan.Dixon on 02/08/2017.
//  Copyright © 2017 Mubaloo. All rights reserved.
//

import UIKit

public struct Animation {
    public let duration: TimeInterval
    public let updatesConstraint: Bool
    public let closure: (UIView) -> Void
}

public extension Animation {
    
    static func fade(to alpha: CGFloat, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, updatesConstraint: false) { $0.alpha = alpha }
    }
    
    static func resize(to size: CGSize, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, updatesConstraint: false) { $0.bounds.size = size }
    }
    
    static func cornerRadius(to radius: CGFloat, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, updatesConstraint: false, closure: { $0.layer.animateCornerRadius(to: radius, duration: duration) })
    }
    
    static func wait(duration: TimeInterval) -> Animation {
        return Animation(duration: duration, updatesConstraint: false, closure: { $0.alpha = $0.alpha - 0.000001 })
    }
    
    static func move(byX x: CGFloat, y: CGFloat, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, updatesConstraint: false) {
            $0.center.x += x
            $0.center.y += y
        }
    }
    
    static func moveAndResize(to newSize: CGRect, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, updatesConstraint: false) { $0.frame = newSize }
    }
    
    static func changeColor(to newColor: UIColor, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, updatesConstraint: false) { $0.backgroundColor = newColor }
    }
    
    static func fillSuperview(duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, updatesConstraint: true) { $0.fillSuperview() }
    }
    
    static func fill(toFit view: UIView, topPadding: CGFloat, leftPadding: CGFloat, bottomPadding: CGFloat, rightPadding: CGFloat, duration: TimeInterval = 0.3) -> Animation {
        
        return Animation(duration: duration, updatesConstraint: true) { $0.fill(toFit: view, topPadding: topPadding, leftPadding: leftPadding, bottomPadding: bottomPadding, rightPadding: rightPadding) }
    }
    
    static func anchor(width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, updatesConstraint: true, closure: { $0.anchor(width: width, height: height, x: x, y: y) })
    }
}
