//
//  UIView+Constraints.swift
//  AnimationFramework
//
//  Created by Jordan Dixon on 22/07/2017.
//  Copyright © 2017 Jordan Dixon. All rights reserved.
//

import UIKit

extension UIView {
    
    private func removeConstraints() {
        
        NSLayoutConstraint.deactivate(self.constraints)
        
        guard let superview = superview else { return }
        self.removeFromSuperview()
        superview.addSubview(self)
    }
    
    public func fillSuperview() {
        
        removeConstraints()
        
        translatesAutoresizingMaskIntoConstraints = false
        
        guard let superview = superview else { return }
        
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ])
    }
    
    public func fill(toFit view: UIView, topPadding: CGFloat, leftPadding: CGFloat, bottomPadding: CGFloat, rightPadding: CGFloat) {
        
        removeConstraints()
        
        anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: topPadding, leftConstant: leftPadding, bottomConstant: bottomPadding, rightConstant: rightPadding)
    }
    
    @discardableResult
    public func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, topConstant: CGFloat, leftConstant: CGFloat, bottomConstant: CGFloat, rightConstant: CGFloat, widthConstant: CGFloat? = nil, heightConstant: CGFloat? = nil) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if let widthConstant = widthConstant, widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if let heightConstant = heightConstant, heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach { $0.isActive = true }
        
        return anchors
    }
    
    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        guard let anchor = superview?.centerXAnchor else { return }
        
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        
    }
    
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        guard let anchor = superview?.centerYAnchor else { return }
        
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        
    }
    
    public func anchorCenterToSuperview(x: CGFloat = 0, y: CGFloat = 0) {
        anchorCenterXToSuperview(constant: x)
        anchorCenterYToSuperview(constant: y)
    }
    
    public func anchor(width: CGFloat, height: CGFloat, x: CGFloat, y: CGFloat) {
        
        removeConstraints()
        
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
            ])
        
        anchorCenterToSuperview(x: x, y: y)
    }
}
