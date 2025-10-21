//
//  MGMViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 23/05/25.
//

import UIKit
import Poinku_DS

class MGMViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var v1: UIView!
    @IBOutlet var v2: UIView!
    @IBOutlet var v3: UIView!
    @IBOutlet var v4: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        v1.layer.borderWidth = 1
        v1.layer.borderColor = UIColor.blue30?.cgColor
        v1.backgroundColor = UIColor.white
        v1.layer.cornerRadius = 8
        
        v2.backgroundColor = UIColor.white
        v2.layer.cornerRadius = 8
        
        v3.layer.borderWidth = 1
        v3.layer.borderColor = UIColor.blue30?.cgColor
        v3.backgroundColor = UIColor.white
        v3.layer.cornerRadius = 8
        
        v4.layer.borderWidth = 1
        v4.layer.borderColor = UIColor.blue30?.cgColor
        v4.backgroundColor = UIColor.white
        v4.layer.cornerRadius = 8
        
        DispatchQueue.main.async {
            self.v1.startAnimationGradientBorder()
            self.v2.startAnimationNeonPulse(duration: 2.0)
            self.v3.startAnimationNeonPulse()
            
            self.v4.startAnimationGradientBorder()
            self.v4.startAnimationNeonPulse()
        }
    }
}
