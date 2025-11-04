//
//  ScrollingViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 24/02/25.
//

import UIKit

class ScrollingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func GoToScrollingScale(_ sender: Any) {
        let vc = UIStoryboard(name: "ScrollingScaleViewController", bundle: nil).instantiateViewController(withIdentifier: "ScrollingScale")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func GoToScrollingFade(_ sender: Any) {
        let vc = UIStoryboard(name: "ScrollingFadeViewController", bundle: nil).instantiateViewController(withIdentifier: "ScrollingFade")
        navigationController?.pushViewController(vc, animated: true)
    }
}
