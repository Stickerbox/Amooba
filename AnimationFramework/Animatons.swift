//
//  Animatons.swift
//  AnimationFramework
//
//  Created by Jordan.Dixon on 02/08/2017.
//  Copyright © 2017 Jordan Dixon. All rights reserved.
//

import UIKit

/// A struct representing an animation to be performed on a UIView.
public struct Animation {
    /// The duration of the animation in seconds.
    public let duration: TimeInterval
    /// A boolean value indicating whether the animation updates constraints.
    public let updatesConstraint: Bool
    /// The closure block containing the changes to be animated on the view.
    public let closure: (UIView) -> Void
}

public extension Animation {
    
    /// Creates an animation that changes the view's alpha value.
    ///
    /// - Parameters:
    ///   - alpha: The target alpha value (0.0 to 1.0).
    ///   - duration: The duration of the animation in seconds. Defaults to 0.3.
    /// - Returns: An `Animation` object configured to fade the view.
    static func fade(to alpha: CGFloat, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, updatesConstraint: false) { $0.alpha = alpha }
    }
    
    /// Creates an animation that resizes the view's bounds.
    ///
    /// - Parameters:
    ///   - size: The new size for the view.
    ///   - duration: The duration of the animation in seconds. Defaults to 0.3.
    /// - Returns: An `Animation` object configured to resize the view.
    static func resize(to size: CGSize, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, updatesConstraint: false) { $0.bounds.size = size }
    }
    
    /// Creates an animation that changes the view layer's corner radius.
    ///
    /// - Parameters:
    ///   - radius: The target corner radius.
    ///   - duration: The duration of the animation in seconds. Defaults to 0.3.
    /// - Returns: An `Animation` object configured to animate the corner radius.
    static func cornerRadius(to radius: CGFloat, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, updatesConstraint: false) { $0.layer.animateCornerRadius(to: radius, duration: duration) }
    }
    
    /// Creates an animation that waits for a specified duration without visual changes (technically changes alpha slightly).
    ///
    /// - Parameter duration: The duration to wait in seconds.
    /// - Returns: An `Animation` object that acts as a delay.
    static func wait(duration: TimeInterval) -> Animation {
        return Animation(duration: duration, updatesConstraint: false) { $0.alpha = $0.alpha - 0.000001 }
    }
    
    /// Creates an animation that moves the view by a specified X and Y delta.
    ///
    /// - Parameters:
    ///   - x: The amount to move along the X axis.
    ///   - y: The amount to move along the Y axis.
    ///   - duration: The duration of the animation in seconds. Defaults to 0.3.
    /// - Returns: An `Animation` object configured to move the view.
    static func move(byX x: CGFloat, y: CGFloat, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, updatesConstraint: false) {
            $0.center.x += x
            $0.center.y += y
        }
    }
    
    /// Creates an animation that moves and resizes the view by setting a new frame.
    ///
    /// - Parameters:
    ///   - newSize: The new frame rectangle for the view.
    ///   - duration: The duration of the animation in seconds. Defaults to 0.3.
    /// - Returns: An `Animation` object configured to set the view's frame.
    static func moveAndResize(to newSize: CGRect, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, updatesConstraint: false) { $0.frame = newSize }
    }
    
    /// Creates an animation that changes the view's background color.
    ///
    /// - Parameters:
    ///   - newColor: The new background color.
    ///   - duration: The duration of the animation in seconds. Defaults to 0.3.
    /// - Returns: An `Animation` object configured to change the background color.
    static func changeColor(to newColor: UIColor, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, updatesConstraint: false) { $0.backgroundColor = newColor }
    }
    
    /// Creates an animation that expands the view to fill its superview.
    ///
    /// This animation updates constraints.
    ///
    /// - Parameter duration: The duration of the animation in seconds. Defaults to 0.3.
    /// - Returns: An `Animation` object configured to fill the superview.
    static func fillSuperview(duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, updatesConstraint: true) { $0.fillSuperview() }
    }
    
    /// Creates an animation that fills the view to fit another view with specified padding.
    ///
    /// This animation updates constraints.
    ///
    /// - Parameters:
    ///   - view: The view to anchor to.
    ///   - topPadding: The top padding constant.
    ///   - leftPadding: The left padding constant.
    ///   - bottomPadding: The bottom padding constant.
    ///   - rightPadding: The right padding constant.
    ///   - duration: The duration of the animation in seconds. Defaults to 0.3.
    /// - Returns: An `Animation` object configured to update constraints.
    static func fill(toFit view: UIView, topPadding: CGFloat, leftPadding: CGFloat, bottomPadding: CGFloat, rightPadding: CGFloat, duration: TimeInterval = 0.3) -> Animation {
        
        return Animation(duration: duration, updatesConstraint: true) { $0.fill(toFit: view, topPadding: topPadding, leftPadding: leftPadding, bottomPadding: bottomPadding, rightPadding: rightPadding) }
    }
    
    /// Creates an animation that sets the width, height, and center position of the view.
    ///
    /// This animation updates constraints.
    ///
    /// - Parameters:
    ///   - width: The width constant.
    ///   - height: The height constant.
    ///   - x: The center X offset from the superview center.
    ///   - y: The center Y offset from the superview center.
    ///   - duration: The duration of the animation in seconds. Defaults to 0.3.
    /// - Returns: An `Animation` object configured to update constraints.
    static func anchor(width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat, duration: TimeInterval = 0.3) -> Animation {
        return Animation(duration: duration, updatesConstraint: true) { $0.anchor(width: width, height: height, x: x, y: y) }
    }
}
