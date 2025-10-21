//
//  CardViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 24/02/25.
//

import UIKit

class CardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func GoToCoupon(_ sender: Any) {
        let vc = UIStoryboard(name: "CouponCardViewController", bundle: nil).instantiateViewController(withIdentifier: "CouponCard")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GoToStamp(_ sender: Any) {
        let vc = UIStoryboard(name: "StampCardViewController", bundle: nil).instantiateViewController(withIdentifier: "StampCard")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GoToPoin(_ sender: Any) {
        let vc = UIStoryboard(name: "PoinCardViewController", bundle: nil).instantiateViewController(withIdentifier: "PoinCard")
        navigationController?.pushViewController(vc, animated: true)
    }
}
