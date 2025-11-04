//
//  Regsiter1ViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 11/06/25.
//

import UIKit
import Poinku_DS

class Register3ViewController: UIViewController {
    
    @IBOutlet var vStep: StepPageNav!
    @IBOutlet var fieldPin: Textfield!
    @IBOutlet var fieldRefillPin: Textfield!
    @IBOutlet var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        vStep.title = ["Isi Data Diri", "Verifikasi", "Buat PIN"]
        vStep.currentStep = 3
        
        fieldPin.label = "Kode PIN"
        fieldPin.placeholder = "Masukkan Kode PIN"
        fieldPin.keyboardType = .default
        fieldPin.returnKeyType = .next
        
        fieldRefillPin.label = "Ulangi Kode PIN"
        fieldRefillPin.placeholder = "Masukkan Lagi Kode PIN"
        fieldRefillPin.keyboardType = .default
        fieldRefillPin.returnKeyType = .next
        
        setupButton(isEnabled: true)
    }
    
    private func setupButton(isEnabled: Bool) {
        btnLogin.isEnabled = isEnabled
        
        if isEnabled {
            btnLogin.backgroundColor = UIColor.blue30
            btnLogin.tintColor = UIColor.blue30
        } else {
            btnLogin.backgroundColor = UIColor.grey30
            btnLogin.tintColor = UIColor.grey30
        }
        
        let attrLogin = NSAttributedString(string: "Konfirmasi", attributes: [
            .font: Font.Button.Big.font,
            .foregroundColor: UIColor.white ?? .systemYellow
        ])
        btnLogin.setAttributedTitle(attrLogin, for: .normal)
        
        btnLogin.contentEdgeInsets = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
        btnLogin.layer.cornerRadius = 8
    }
    
}
