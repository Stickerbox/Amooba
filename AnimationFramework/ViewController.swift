//
//  ViewController.swift
//  AnimationFramework
//
//  Created by Jordan.Dixon on 01/08/2017.
//  Copyright © 2017 Mubaloo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var navThing: UIView!
    @IBOutlet weak var best: UIView!
    @IBOutlet weak var button: UIButton!
    
    var count = true
    
    @IBAction func go() {
        if count {
            best.animate(together:
                .fill(toFit: self.view, topPadding: 50, leftPadding: 50, bottomPadding: 50, rightPadding: 50),
                .changeColor(to: .blue))
            
            count = false
        } else {
            best.animate(together:
                .anchor(width: 150, height: 200, x: 0, y: 0),
                .changeColor(to: .black))
            
            count = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
    }
    
    func startAnimation() {
        navThing.animate(
            .anchor(width: view.frame.width, height: 90, x: 0, y: view.frame.minY))
    }
    
}
