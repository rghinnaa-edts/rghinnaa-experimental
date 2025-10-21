//
//  RibbonViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 21/02/25.
//

import UIKit

class RibbonViewController: UIViewController {
    
    @IBOutlet var testCard: UIView!
    @IBOutlet var testCard2: UIView!
    @IBOutlet var testCard3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ribbonView1()
        ribbonView2()
        ribbonView3()
        
    }
    
    func ribbonView1() {
        let ribbonView = RibbonView()
        ribbonView.ribbonText = "x2"
        ribbonView.triangleColor = UIColor.blue50
        ribbonView.containerColor = UIColor.blue30
        ribbonView.textColor = .white
        ribbonView.gravity = .start

        ribbonView.anchorToView(
            rootParent: view,
            targetView: testCard
        )
    }
    
    func ribbonView2() {
        let ribbonView2 = RibbonView()
        ribbonView2.ribbonText = "Baru!"
        ribbonView2.triangleColor = UIColor.orange50
        ribbonView2.containerStartColor = UIColor.yellow30
        ribbonView2.containerEndColor = UIColor.orange30
        ribbonView2.textColor = .white
        ribbonView2.gravity = .end

        ribbonView2.anchorToView(
            rootParent: view,
            targetView: testCard2,
            verticalAlignment: .center
        )
    }
    
    func ribbonView3() {
        let ribbonView3 = RibbonView()
        ribbonView3.ribbonText = "Hot Product!"
        ribbonView3.triangleColor = UIColor.red50
        ribbonView3.containerStartColor = UIColor.red20
        ribbonView3.containerEndColor = UIColor.red50
        ribbonView3.textColor = .white
        ribbonView3.gravity = .start

        ribbonView3.anchorToView(
            rootParent: view,
            targetView: testCard3,
            verticalAlignment: .center
        )
    }
}
