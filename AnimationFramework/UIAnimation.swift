//
//  UIAnimation.swift
//  AnimationFramework
//
//  Created by Jordan.Dixon on 01/08/2017.
//  Copyright © 2017 Mubaloo. All rights reserved.
//

import UIKit

internal enum AnimationMode {
    case inSequence
    case inParallel
}

public final class AnimationToken {
    
    private let view: UIView
    private let animations: [Animation]
    private let mode: AnimationMode
    private var isValid = true
    
    internal init(view: UIView, animations: [Animation], mode: AnimationMode) {
        self.view = view
        self.animations = animations
        self.mode = mode
    }
    
    deinit {
        perform {}
    }
    
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

public func animate(_ tokens: AnimationToken...) {
    animate(tokens)
}

public extension UIView {
    
    @discardableResult func animate(_ animations: Animation...) -> AnimationToken {
        return animate(animations)
    }
    
    @discardableResult func animate(together animations: Animation...) -> AnimationToken {
        return animate(together: animations)
    }
    
    @discardableResult private func animate(_ animations: [Animation]) -> AnimationToken {
        return AnimationToken(
            view: self,
            animations: animations,
            mode: .inSequence
        )
    }
    
    @discardableResult private func animate(together animations: [Animation]) -> AnimationToken {
        return AnimationToken(
            view: self,
            animations: animations,
            mode: .inParallel
        )
    }
}

internal extension UIView {
    
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
