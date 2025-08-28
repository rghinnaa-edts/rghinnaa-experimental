//
//  ViewController.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 07/08/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func GoToPromo(_ sender: Any) {
        let vc = UIStoryboard(name: "PromoGiftViewController", bundle: nil).instantiateViewController(withIdentifier: "PromoGiftPage")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GoToCart(_ sender: Any) {
        let vc = UIStoryboard(name: "CartViewController", bundle: nil).instantiateViewController(withIdentifier: "CartPage")
        navigationController?.pushViewController(vc, animated: true)
    }
}

