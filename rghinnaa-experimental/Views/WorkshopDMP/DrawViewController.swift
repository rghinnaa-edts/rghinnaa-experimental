//
//  DrawViewController.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 12/11/25.
//

import UIKit

class DrawViewController: UIViewController {
    @IBOutlet var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = DrawView()
        containerView.addSubview(view)
        
        
    }
    
    
}
