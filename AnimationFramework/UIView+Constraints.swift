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
    
    /// Removes existing constraints and anchors the view to fill its superview completely.
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
    
    /// Removes existing constraints and anchors the view to fill a target view with specified padding.
    ///
    /// - Parameters:
    ///   - view: The target view to anchor to.
    ///   - topPadding: The padding from the top edge.
    ///   - leftPadding: The padding from the left edge.
    ///   - bottomPadding: The padding from the bottom edge.
    ///   - rightPadding: The padding from the right edge.
    public func fill(toFit view: UIView, topPadding: CGFloat, leftPadding: CGFloat, bottomPadding: CGFloat, rightPadding: CGFloat) {
        
        removeConstraints()
        
        anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: topPadding, leftConstant: leftPadding, bottomConstant: bottomPadding, rightConstant: rightPadding)
    }
    
    /// Anchors the view to the specified layout anchors with constants.
    ///
    /// - Parameters:
    ///   - top: The top anchor to constraint to.
    ///   - left: The left anchor to constraint to.
    ///   - bottom: The bottom anchor to constraint to.
    ///   - right: The right anchor to constraint to.
    ///   - topConstant: The constant for the top constraint.
    ///   - leftConstant: The constant for the left constraint.
    ///   - bottomConstant: The constant for the bottom constraint.
    ///   - rightConstant: The constant for the right constraint.
    ///   - widthConstant: An optional width constant.
    ///   - heightConstant: An optional height constant.
    /// - Returns: An array of the activated `NSLayoutConstraint` objects.
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
    
    /// Anchors the view's center X to its superview's center X.
    ///
    /// - Parameter constant: The offset constant from the center. Defaults to 0.
    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        guard let anchor = superview?.centerXAnchor else { return }
        
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        
    }
    
    /// Anchors the view's center Y to its superview's center Y.
    ///
    /// - Parameter constant: The offset constant from the center. Defaults to 0.
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        guard let anchor = superview?.centerYAnchor else { return }
        
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        
    }
    
    /// Anchors the view's center to its superview's center with offsets.
    ///
    /// - Parameters:
    ///   - x: The X offset from the center. Defaults to 0.
    ///   - y: The Y offset from the center. Defaults to 0.
    public func anchorCenterToSuperview(x: CGFloat = 0, y: CGFloat = 0) {
        anchorCenterXToSuperview(constant: x)
        anchorCenterYToSuperview(constant: y)
    }
    
    /// Anchors the view with specific width, height, and center offsets relative to its superview.
    ///
    /// This method removes existing constraints before applying new ones.
    ///
    /// - Parameters:
    ///   - width: The width constant.
    ///   - height: The height constant.
    ///   - x: The X offset from the superview center.
    ///   - y: The Y offset from the superview center.
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
