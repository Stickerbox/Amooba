//
//  UIAnimation.swift
//  AnimationFramework
//
//  Created by Jordan.Dixon on 01/08/2017.
//  Copyright © 2017 Jordan Dixon. All rights reserved.
//

import UIKit

/// Defines the mode of execution for a set of animations.
internal enum AnimationMode {
    /// Animations are performed one after another.
    case inSequence
    /// Animations are performed simultaneously.
    case inParallel
}

/// A class representing a token that manages the execution of a sequence or group of animations.
public final class AnimationToken {
    
    private let view: UIView
    private let animations: [Animation]
    private let mode: AnimationMode
    private var isValid = true
    
    /// Initializes a new AnimationToken.
    ///
    /// - Parameters:
    ///   - view: The view on which animations will be performed.
    ///   - animations: An array of `Animation` objects to execute.
    ///   - mode: The `AnimationMode` determining if animations run sequentially or in parallel.
    internal init(view: UIView, animations: [Animation], mode: AnimationMode) {
        self.view = view
        self.animations = animations
        self.mode = mode
    }
    
    deinit {
        perform {}
    }
    
    /// Performs the animations associated with this token.
    ///
    /// - Parameter completionHandler: A closure to be executed when the animations finish.
    internal func perform(completionHandler: @escaping() -> Void) {
        
        guard isValid else { return }
        
        isValid = false
        
        switch mode {
        case .inSequence:
            view.performAnimations(animations, completionHandler: completionHandler)
        case .inParallel:
            view.performAnimationsInParallel(animations,
                                             completionHandler: completionHandler)
        }
    }
}

/// Executes a list of animation tokens sequentially.
///
/// - Parameter tokens: An array of `AnimationToken` objects to execute.
public func animate(_ tokens: [AnimationToken]) {
    guard !tokens.isEmpty else {
        return
    }
    
    var tokens = tokens
    let token = tokens.removeFirst()
    
    token.perform {
        animate(tokens)
    }
}

/// Executes a variadic list of animation tokens sequentially.
///
/// - Parameter tokens: A variadic list of `AnimationToken` objects.
public func animate(_ tokens: AnimationToken...) {
    animate(tokens)
}

public extension UIView {
    
    /// Queues a list of animations to be performed sequentially on the view.
    ///
    /// - Parameter animations: A variadic list of `Animation` objects.
    /// - Returns: An `AnimationToken` representing the queued animations.
    @discardableResult func animate(_ animations: Animation...) -> AnimationToken {
        return animate(animations)
    }
    
    /// Queues a list of animations to be performed in parallel (simultaneously) on the view.
    ///
    /// - Parameter animations: A variadic list of `Animation` objects.
    /// - Returns: An `AnimationToken` representing the queued animations.
    @discardableResult func animateTogether(_ animations: Animation...) -> AnimationToken {
        return animate(together: animations)
    }
    
    /// Internal helper to create a sequential animation token.
    ///
    /// - Parameter animations: An array of `Animation` objects.
    /// - Returns: An `AnimationToken`.
    @discardableResult private func animate(_ animations: [Animation]) -> AnimationToken {
        return AnimationToken(
            view: self,
            animations: animations,
            mode: .inSequence
        )
    }
    
    /// Internal helper to create a parallel animation token.
    ///
    /// - Parameter animations: An array of `Animation` objects.
    /// - Returns: An `AnimationToken`.
    @discardableResult private func animate(together animations: [Animation]) -> AnimationToken {
        return AnimationToken(
            view: self,
            animations: animations,
            mode: .inParallel
        )
    }
}

internal extension UIView {
    
    /// Performs a list of animations sequentially.
    ///
    /// - Parameters:
    ///   - animations: The list of animations to perform.
    ///   - completionHandler: The block to execute when all animations are finished.
    func performAnimations(_ animations: [Animation], completionHandler: @escaping () -> Void) {
        
        guard !animations.isEmpty else { return completionHandler() }
        
        var animations = animations
        let animation = animations.removeFirst()
        
        if animation.updatesConstraint {
            
            animation.closure(self)
            self.layoutIfNeeded()
            
            UIView.animate(withDuration: animation.duration, animations: {
                self.superview?.layoutIfNeeded()
            }, completion: { _ in
                self.performAnimations(animations, completionHandler: completionHandler)
            })
        } else {
            
            UIView.animate(withDuration: animation.duration, animations: {
                animation.closure(self)
            }, completion: { _ in
                self.performAnimations(animations, completionHandler: completionHandler)
            })
        }
        
    }
    
    /// Performs a list of animations in parallel.
    ///
    /// - Parameters:
    ///   - animations: The list of animations to perform.
    ///   - completionHandler: The block to execute when all animations are finished.
    func performAnimationsInParallel(_ animations: [Animation], completionHandler: @escaping () -> Void) {
        
        guard !animations.isEmpty else { return completionHandler() }
        
        // In order to call the completion handler once all animations
        // have finished, we need to keep track of these counts
        let animationCount = animations.count
        var completionCount = 0
        
        let animationCompletionHandler = {
            completionCount += 1
            
            // Once all animations have finished, we call the completion handler
            if completionCount == animationCount {
                completionHandler()
            }
        }
        
        for animation in animations {
            
            if animation.updatesConstraint {
                
                animation.closure(self)
                
                UIView.animate(withDuration: animation.duration, animations: {
                    self.superview?.layoutIfNeeded()
                }, completion: { _ in
                    animationCompletionHandler()
                })
            } else {
                
                UIView.animate(withDuration: animation.duration, animations: {
                    animation.closure(self)
                }, completion: { _ in
                    animationCompletionHandler()
                })
            }
            
        }
    }
}

public extension CALayer {
    
    /// Animates the corner radius of the layer.
    ///
    /// - Parameters:
    ///   - radius: The target corner radius.
    ///   - duration: The duration of the animation in seconds.
    func animateCornerRadius(to radius: CGFloat, duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fromValue = self.cornerRadius
        animation.toValue = radius
        animation.duration = duration
        self.add(animation, forKey: "cornerRadius")
    }
}
