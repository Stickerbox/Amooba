//
//  PulseAnimation.swift
//  AnimationFramework
//
//  Created by Jordan.Dixon on 09/08/2017.
//  Copyright © 2017 Jordan Dixon. All rights reserved.
//

import UIKit

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
    
    var scaleAnimation: CABasicAnimation {
        
        let scaleAnimation = CABasicAnimation(keyPath: .transformScaleXY)
        scaleAnimation.fromValue = NSNumber(value: initialPulseScale)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = animationDuration
        
        return scaleAnimation
    }
    
    var opacityAnimation: CAKeyframeAnimation {
        
        let opacityAnimation = CAKeyframeAnimation(keyPath: .opacity)
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [0.4, 0.8, 0]
        opacityAnimation.keyTimes = [0, 0.2, 1]
        
        return opacityAnimation
    }
    
    func setupAnimationGroup() {
        
        animationGroup = CAAnimationGroup()
        animationGroup.duration = animationDuration + nextPulseAfter
        animationGroup.repeatCount = numberOfPulses
        
        let defaultCurve = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        animationGroup.timingFunction = defaultCurve
        
        animationGroup.animations = [scaleAnimation, opacityAnimation]
    }
    
}
