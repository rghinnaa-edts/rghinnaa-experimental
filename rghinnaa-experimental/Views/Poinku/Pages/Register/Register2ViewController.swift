//
//  Regsiter1ViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 11/06/25.
//

import UIKit
import Poinku_DS

class Register2ViewController: UIViewController {
    
    @IBOutlet var vStep: StepPageNav!
    @IBOutlet var btnVerif: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        vStep.title = ["Isi Data Diri", "Verifikasi", "Buat PIN"]
        vStep.currentStep = 2
        
        setupButton(isEnabled: true)
    }
    
    private func setupButton(isEnabled: Bool) {
        btnVerif.isEnabled = isEnabled
        
        if isEnabled {
            btnVerif.backgroundColor = UIColor.blue30
            btnVerif.tintColor = UIColor.blue30
        } else {
            btnVerif.backgroundColor = UIColor.grey30
            btnVerif.tintColor = UIColor.grey30
        }
        
        let attrLogin = NSAttributedString(string: "Konfirmasi", attributes: [
            .font: Font.Button.Big.font,
            .foregroundColor: UIColor.white ?? .systemYellow
        ])
        btnVerif.setAttributedTitle(attrLogin, for: .normal)
        
        btnVerif.contentEdgeInsets = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
        btnVerif.layer.cornerRadius = 8
    }
    
    @IBAction func GoToRegister3(_ sender: Any) {
        let vc = UIStoryboard(name: "Register3ViewController", bundle: nil).instantiateViewController(withIdentifier: "Register3Page")
        navigationController?.pushViewController(vc, animated: true)
    }
}
