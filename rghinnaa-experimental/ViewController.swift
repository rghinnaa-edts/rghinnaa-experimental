//
//  ViewController.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 07/08/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var vKlikIDM: UIView!
    @IBOutlet var vPoinku: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigation()
        
    }
    
    private func setupUI() {
        vKlikIDM.layer.cornerRadius = 16
        vKlikIDM.layer.shadowColor = UIColor.black?.cgColor
        vKlikIDM.layer.shadowOffset = CGSize(width: 0, height: 2)
        vKlikIDM.layer.shadowOpacity = 0.15
        vKlikIDM.layer.shadowRadius = 3.0
        
        vPoinku.layer.cornerRadius = 16
        vPoinku.layer.shadowColor = UIColor.black?.cgColor
        vPoinku.layer.shadowOffset = CGSize(width: 0, height: 2)
        vPoinku.layer.shadowOpacity = 0.15
        vPoinku.layer.shadowRadius = 3.0
    }

    private func setupNavigation() {
        vKlikIDM.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(vKlikIDMTapped)))
        vKlikIDM.isUserInteractionEnabled = true
        
        vPoinku.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(vPoinkuTapped)))
        vPoinku.isUserInteractionEnabled = true
    }
    
    @objc func vKlikIDMTapped() {
        let vc = UIStoryboard(name: "KlikViewController", bundle: nil).instantiateViewController(withIdentifier: "KlikPage")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func vPoinkuTapped() {
        let vc = UIStoryboard(name: "PoinkuViewController", bundle: nil).instantiateViewController(withIdentifier: "PoinkuPage")
        navigationController?.pushViewController(vc, animated: true)
        
//        let vc = UIStoryboard(name: "AnimationWorkshopViewController", bundle: nil).instantiateViewController(withIdentifier: "AnimationWorkshopPage")
//        navigationController?.pushViewController(vc, animated: true)
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

