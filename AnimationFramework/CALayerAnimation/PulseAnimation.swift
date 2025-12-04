//
//  PulseAnimation.swift
//  AnimationFramework
//
//  Created by Jordan.Dixon on 09/08/2017.
//  Copyright © 2017 Jordan Dixon. All rights reserved.
//

import UIKit

/// A CALayer subclass that creates a pulsing animation effect.
class Pulsing: CALayer {
    
    var animationGroup = CAAnimationGroup()
    
    var initialPulseScale: Float = 0
    var nextPulseAfter: TimeInterval = 0
    var animationDuration: TimeInterval = 1.5
    var radius: CGFloat = 200
    var numberOfPulses = Float.infinity
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Initializes a new Pulsing layer.
    ///
    /// - Parameters:
    ///   - numberOfPulses: The number of times the pulse animation should repeat. Defaults to infinity.
    ///   - radius: The radius of the pulse effect.
    ///   - position: The center position of the pulse.
    init(numberOfPulses: Float = Float.infinity, radius: CGFloat, position: CGPoint) {
        super.init()
        
        self.backgroundColor = UIColor.black.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.numberOfPulses = numberOfPulses
        self.radius = radius
        self.position = position
        
        self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        self.cornerRadius = radius
        
        DispatchQueue.global(qos: .default).async {
            
            self.setupAnimationGroup()
            
            DispatchQueue.main.async {
                
                self.add(self.animationGroup, forKey: "pulse")
            }
        }
        
    }
    
    /// Creates the scale animation for the pulse.
    var scaleAnimation: CABasicAnimation {
        
        let scaleAnimation = CABasicAnimation(keyPath: .transformScaleXY)
        scaleAnimation.fromValue = NSNumber(value: initialPulseScale)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = animationDuration
        
        return scaleAnimation
    }
    
    /// Creates the opacity animation for the pulse.
    var opacityAnimation: CAKeyframeAnimation {
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: .opacity)
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [0.4, 0.8, 0]
        opacityAnimation.keyTimes = [0, 0.2, 1]
        
        return opacityAnimation
    }
    
    /// Sets up the animation group combining scale and opacity animations.
    func setupAnimationGroup() {
        
        animationGroup = CAAnimationGroup()
        animationGroup.duration = animationDuration + nextPulseAfter
        animationGroup.repeatCount = numberOfPulses
        
        let defaultCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        animationGroup.timingFunction = defaultCurve
        
        animationGroup.animations = [scaleAnimation, opacityAnimation]
    }
    
}
